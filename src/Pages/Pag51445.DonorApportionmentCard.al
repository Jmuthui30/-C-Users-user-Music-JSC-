page 51445 "Donor Apportionment Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Payroll Matrix";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control10; "Payroll Apportionment")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No."=FIELD("Employee No"), "Payroll Period"=FIELD("Payroll Period"), Type=FIELD(Type), "ED Code"=FIELD(Code);
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
