codeunit 50100 "Quote Status Mgt."
{
    procedure CloseQuote(var SalesHeader: Record "Sales Header")
    begin
        ArchiveSalesQuote(SalesHeader);
    end;

    local procedure CheckAndRunCloseQuote(var SalesHeader: Record "Sales Header")
    var
        QuoteStatusMgt: Codeunit "Quote Status Mgt.";
        NotCompletedErr: Label 'Quote is not completed';
    begin
        if SalesHeader."Won/Lost Quote Status" IN [SalesHeader."Won/Lost Quote Status"::Won, SalesHeader."Won/Lost Quote Status"::Lost] then
            exit;
        if Page.RunModal(Page::"Close Quote", SalesHeader) <> Action::LookupOK then
            Error(NotCompletedErr);
    end;

    local procedure ArchiveSalesQuote(var SalesHeader: Record "Sales Header")
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin
        SalesReceivablesSetup.Get();

        case SalesReceivablesSetup."Archive Quotes" of
            SalesReceivablesSetup."Archive Quotes"::Always:
                ArchiveManagement.ArchSalesDocumentNoConfirm(SalesHeader);

            SalesReceivablesSetup."Archive Quotes"::Question:
                ArchiveManagement.ArchiveSalesDocument(SalesHeader);
        end;
    end;

    procedure GetSalesPersonForLoggedInUser(): Code[20]
    var
        User: Record User;
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        if not User.Get(UserSecurityId()) then
            exit('');

        SalespersonPurchaser.SetRange("E-Mail", User."Contact Email");
        if SalespersonPurchaser.FindFirst() then
            exit(SalespersonPurchaser.Code);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeArchiveSalesDocument', '', false, false)]
    local procedure OnBeforeArchiveSalesDocument(var SalesHeader: Record "Sales Header")
    begin
        CheckAndRunCloseQuote(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Quote to Order (Yes/No)", 'OnBeforeConfirmConvertToOrder', '', false, false)]
    local procedure OnBeforeConfirmConvertToOrder(SalesHeader: Record "Sales Header")
    begin
        CheckAndRunCloseQuote(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ArchiveManagement, 'OnBeforeSalesHeaderArchiveInsert', '', false, false)]
    local procedure OnBeforeSalesHeaderArchiveInsert(SalesHeader: Record "Sales Header"; var SalesHeaderArchive: Record "Sales Header Archive")
    begin
        SalesHeaderArchive."Won/Lost Date" := SalesHeader."Won/Lost Date";
        SalesHeaderArchive."Won/Lost Quote Status" := SalesHeader."Won/Lost Quote Status";
        SalesHeaderArchive."Won/Lost Reason Code" := SalesHeader."Won/Lost Reason Code";
        SalesHeaderArchive."Won/Lost Reason Desc." := SalesHeader."Won/Lost Reason Desc.";
        SalesHeaderArchive."Won/Lost Remarks" := SalesHeader."Won/Lost Remarks";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Conf./Personalization Mgt.", 'OnRoleCenterOpen', '', false, false)]
    local procedure OnRoleCenterOpen()
    var
        SalesPersonCode: Code[20];
        SalesHeader: Record "Sales Header";
        QuoteStatus: Notification;
        LostQuoteStatusMsg: Label 'You Lost %1 quote(s) the last 5 days';
    begin
        SalesPersonCode := GetSalesPersonForLoggedInUser();
        if SalesPersonCode = '' then
            exit;

        GetQuoteRecords("Won/Lost Status"::Won, SalesPersonCode);
        GetQuoteRecords("Won/Lost Status"::Lost, SalesPersonCode);
    end;

    procedure GetQuoteRecords(WonLostStatus: Enum "Won/Lost Status"; SalesPerson: Code[20])
    var
        SalesHeader: Record "Sales Header";
        NoOfRecords: Integer;
    begin
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Quote);
        SalesHeader.SetRange("Salesperson Code", SalesPerson);
        SalesHeader.SetRange("Won/Lost Quote Status", WonLostStatus);
        SalesHeader.SetRange("Won/Lost Date", AddDaysToDateTime(CurrentDateTime(), -5), CurrentDateTime);
        NoOfRecords := SalesHeader.Count;

        if NoOfRecords <> 0 then
            SendNoOfQuoteNotification(SalesHeader.Count, WonLostStatus, SalesPerson);
    end;

    procedure AddDaysToDateTime(SourceDateTime: DateTime; NoofDays: Integer): DateTime
    begin
        exit(SourceDateTime + (NoofDays * 86400000));
    end;

    local procedure SendNoOfQuoteNotification(NoOfQuotes: Integer; WonLostStatus: Enum "Won/Lost Status"; SalesPerson: Code[20])
    var
        QuoteNotification: Notification;
        YouWonLostQuotesMsg: Label 'You %1 ''%2''quote(s), during the last 5 days';
        ShowQuotesLbl: Label 'Show %1 Quotes';
    begin
        QuoteNotification.Message := StrSubstNo(YouWonLostQuotesMsg, WonLostStatus, NoOfQuotes);
        QuoteNotification.SetData('SalesPersonCode', SalesPerson);
        QuoteNotification.SetData('WonLostStatus', Format(WonLostStatus.AsInteger()));
        QuoteNotification.AddAction(StrSubstNo(ShowQuotesLbl, WonLostStatus), codeunit::QuoteStatusNotificationMgt, 'OpenQuotes');
        QuoteNotification.Send();
    end;

    var
        ArchiveManagement: Codeunit ArchiveManagement;
}