page 51425 "Exit Information"
{
    // version THL- Payroll 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Employee Master";

    layout
    {
        area(content)
        {
            group("Exit Infromation")
            {
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                }
                field("Served Notice Period"; Rec."Served Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    ApplicationArea = All;
                }
                field("Exit Interview Done By"; Rec."Exit Interview Done By")
                {
                    ApplicationArea = All;
                }
                field("Allow Re-Employment in Future"; Rec."Allow Re-Employment in Future")
                {
                    ApplicationArea = All;
                }
                field("Termination Category"; Rec."Termination Category")
                {
                    ApplicationArea = All;
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
