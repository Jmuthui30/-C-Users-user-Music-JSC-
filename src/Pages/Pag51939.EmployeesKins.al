page 51939 "Employees Kins"
{
    PageType = ListPart;
    SourceTable = "Employee Kins";

    layout
    {
        area(content)
        {
            repeater(Control11)
            {
                ShowCaption = false;

                field(SurName; Rec.SurName)
                {
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = All;
                }
                field(Relationship; Rec.Relationship)
                {
                    ApplicationArea = All;
                }
                field("ID No/Passport No"; Rec."ID No/Passport No")
                {
                    ApplicationArea = All;
                }
                field("Date Of Birth"; Rec."Date Of Birth")
                {
                    ApplicationArea = All;
                }
                field(Occupation; Rec.Occupation)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Office Tel No"; Rec."Office Tel No")
                {
                    ApplicationArea = All;
                }
                field("Home Tel No"; Rec."Home Tel No")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
