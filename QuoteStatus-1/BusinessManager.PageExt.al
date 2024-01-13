pageextension 50104 "Business Manager Role Center" extends "Business Manager Role Center"
{
    layout
    {
        addafter("Favorite Accounts")
        {
            part(WonSalesQuote; "Quote Status List")
            {
                Caption = 'Won Quotes';
                ApplicationArea = All;
                SubPageView = where("Won/Lost Quote Status" = const("Won"));
            }
            part(LostSalesQuote; "Quote Status List")
            {
                Caption = 'Lost Quotes';
                ApplicationArea = All;
                SubPageView = where("Won/Lost Quote Status" = const("Lost"));
            }
        }
    }
}