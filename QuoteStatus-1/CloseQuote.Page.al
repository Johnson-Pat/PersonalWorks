page 50100 "Close Quote"
{
    Caption = 'Close Quote';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Sales Header";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Won/Lost Quote Status"; Rec."Won/Lost Quote Status")
                {
                    ApplicationArea = All;
                }
                field("Won/Lost Date"; Rec."Won/Lost Date")
                {
                    ApplicationArea = All;
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


    trigger OnOpenPage()
    begin
        if Rec."Won/Lost Quote Status" = Rec."Won/Lost Quote Status"::Won then
            CurrPage.Editable := false;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = Action::LookupOK then
            FinishWizard();
    end;

    local procedure FinishWizard()
    var
        ReasonCodeErr: Label '%1 is mandatory';
    begin
        if Rec."Won/Lost Quote Status" in [Rec."Won/Lost Quote Status"::Won, Rec."Won/Lost Quote Status"::Lost] then
            if Rec."Won/Lost Reason Code" = '' then
                Error(ReasonCodeErr, Rec.FieldCaption("Won/Lost Reason Code"));

        Rec.modify();
    end;
}