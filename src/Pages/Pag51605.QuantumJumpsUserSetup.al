page 51605 "QuantumJumps User Setup"
{
    // version THL- HRM 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "QuantumJumps User Setup";
    InsertAllowed = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Immediate Supervisor"; Rec."Immediate Supervisor")
                {
                    ApplicationArea = All;
                }
                field("In Management"; Rec."In Management")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
