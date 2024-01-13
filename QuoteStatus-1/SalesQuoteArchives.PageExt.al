pageextension 50103 SalesQuoteArchives extends "Sales Quote Archives"
{
    layout
    {
        addlast(Control1)
        {
            field("Won/Lost Quote Status"; Rec."Won/Lost Quote Status")
            {
                ApplicationArea = all;
            }
            field("Won/Lost Date"; Rec."Won/Lost Date")
            {
                ApplicationArea = all;
            }
            field("Won/Lost Reason Code"; Rec."Won/Lost Reason Code")
            {
                ApplicationArea = All;
            }
            field("Won/Lost Reason Desc."; Rec."Won/Lost Reason Desc.")
            {
                ApplicationArea = All;
            }
            field("Won/Lost Remarks"; Rec."Won/Lost Remarks")
            {
                ApplicationArea = All;
            }
        }
    }
}
