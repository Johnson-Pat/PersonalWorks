tableextension 50100 "Sales Header" extends "Sales Header"
{
    fields
    {
        field(50100; "Won/Lost Quote Status"; Enum "Won/Lost Status")
        {
            Caption = 'Won/Lost Quote Status';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Won/Lost Date" = 0DT then
                    "Won/Lost Date" := CurrentDateTime;
            end;
        }
        field(50101; "Won/Lost Date"; DateTime)
        {
            Caption = 'Won/Lost Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50102; "Won/Lost Reason Code"; Code[10])
        {
            Caption = 'Won/Lost Reason Code';
            DataClassification = CustomerContent;
            TableRelation = if ("Won/Lost Quote Status" = const(Won)) "Close Opportunity Code".Code where(Type = const(Won))
            else
            if ("Won/Lost Quote Status" = const(Lost)) "Close Opportunity Code".Code where(Type = const(Lost));
        }
        field(50103; "Won/Lost Reason Desc."; Text[100])
        {
            Caption = 'Won/Lost Reason Desc.';
            FieldClass = FlowField;
            CalcFormula = lookup("Close Opportunity Code".Description where(Code = field("Won/Lost Reason Code")));
            Editable = false;
        }
        field(50104; "Won/Lost Remarks"; Text[2048])
        {
            Caption = 'Won/Lost Remarks';
            DataClassification = CustomerContent;
        }
    }
}