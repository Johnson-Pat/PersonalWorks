codeunit 50101 QuoteStatusNotificationMgt
{
    procedure OpenQuotes(QuoteNotitification: Notification)
    var
        SalesHeader: Record "Sales Header";
        WonLostStatus: Enum "Won/Lost Status";
        SalesPerson: Code[20];
        WonLostStatusInteger: Integer;
        QuoteStatusMgt: Codeunit "Quote Status Mgt.";
    begin
        SalesPerson := CopyStr(QuoteNotitification.GetData('SalesPerson'), 1, MaxStrLen(SalesPerson));
        Evaluate(WonLostStatusInteger, QuoteNotitification.GetData('WonLostStatus'));
        WonLostStatus := "Won/Lost Status".FromInteger(WonLostStatusInteger);

        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type");
        SalesHeader.SetRange("Salesperson Code", SalesPerson);
        SalesHeader.SetRange("Won/Lost Quote Status", WonLostStatus);
        SalesHeader.SetRange("Won/Lost Date", QuoteStatusMgt.AddDaysToDateTime(CurrentDateTime(), -5), CurrentDateTime());
        if SalesHeader.FindSet() then
            Page.Run(Page::"Sales Quotes", SalesHeader);
    end;
}