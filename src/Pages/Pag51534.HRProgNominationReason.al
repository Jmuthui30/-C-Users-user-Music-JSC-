page 51534 "HR_Prog Nomination Reason"
{
    Caption = 'Progression Nomination Reason';
    PageType = List;
    SourceTable = "HR_Prog Nomination Reason";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Cause for Nomination"; Rec."Cause for Nomination")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
    end;
}
