pageextension 50100 SalesQuote extends "Sales Quote"
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

    actions
    {
        addfirst(Create)
        {
            action(D365CloseQuote)
            {
                ApplicationArea = All;
                Caption = 'Close Quote';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    QuoteStatusMgt: Codeunit "Quote Status Mgt.";
                begin
                    if Page.RunModal(Page::"Close Quote", Rec) = Action::LookupOK then
                        QuoteStatusMgt.CloseQuote(Rec);
                end;
            }
        }
    }
}
