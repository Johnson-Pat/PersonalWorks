pageextension 50102 SalesQuoteArchive extends "Sales Quote Archive"
{
    layout
    {
        addlast(General)
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
