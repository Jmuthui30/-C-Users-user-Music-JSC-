page 51950 "HR_Qualifications"
{
    PageType = List;
    SourceTable = HR_Qualifications;

    layout
    {
        area(content)
        {
            repeater(Control7)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = All;
                }
                field("Qualified Employees"; Rec."Qualified Employees")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control2; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1; Notes)
            {
                ApplicationArea = All;
                Visible = false;
            }
        }
    }
    actions
    {
    }
}
