page 51966 "Emp Leave Plan List-Approved"
{
    CardPageID = "Employee Leave Plan-Approved";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Employee Leave Plan Header";
    SourceTableView = WHERE(Status=CONST(Released), "HOD Created"=CONST(false));

    layout
    {
        area(content)
        {
            repeater(Control22)
            {
                ShowCaption = false;

                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    ApplicationArea = All;
                }
                field("Fiscal Start Date"; Rec."Fiscal Start Date")
                {
                    ApplicationArea = All;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Leave Entitlement"; Rec."Leave Entitlement")
                {
                    ApplicationArea = All;
                }
                field("Date Of Joining Company"; Rec."Date Of Joining Company")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("No. series"; Rec."No. series")
                {
                    ApplicationArea = All;
                }
                field("Days in Plan"; Rec."Days in Plan")
                {
                    ApplicationArea = All;
                }
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    ApplicationArea = All;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Recalled Days"; Rec."Recalled Days")
                {
                    ApplicationArea = All;
                }
                field("Off Days"; Rec."Off Days")
                {
                    ApplicationArea = All;
                }
                field("Total Leave Days"; Rec."Total Leave Days")
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
