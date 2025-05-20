page 51935 "Employee Leave Assignment"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    Editable = true;
    PageType = ListPart;
    SourceTable = "Employee Leaves";

    layout
    {
        area(content)
        {
            repeater(Control8)
            {
                ShowCaption = false;

                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;
                }
                field(Entitlement; Rec.Entitlement)
                {
                    ApplicationArea = All;
                }
                field("Total Days Taken"; Rec."Total Days Taken")
                {
                    ApplicationArea = All;
                }
                field("Balance Brought Forward"; Rec."Balance Brought Forward")
                {
                    ApplicationArea = All;
                }
                field("Recalled Days"; Rec."Recalled Days")
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
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
