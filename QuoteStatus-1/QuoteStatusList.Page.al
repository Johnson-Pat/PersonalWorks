page 50101 "Quote Status List"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Sales Header";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Won/Lost Date"; Rec."Won/Lost Date")
                {
                    ApplicationArea = All;
                }
                field("Won/Lost Reason Desc."; Rec."Won/Lost Reason Desc.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }


    trigger OnOpenPage()
    begin
        GetQuotesForCurrentUser();
    end;

    local procedure GetQuotesForCurrentUser()
    var
        QuoteStatusMgt: Codeunit "Quote Status Mgt.";
        SalesPersonCode: Code[20];
    begin
        SalesPersonCode := QuoteStatusMgt.GetSalesPersonForLoggedInUser();
        Rec.FilterGroup(2);
        Rec.SetRange("Salesperson Code", SalesPersonCode);
        Rec.FilterGroup(0);
    end;
}