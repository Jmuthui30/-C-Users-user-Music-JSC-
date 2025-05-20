page 51482 "Employee Import Lines"
{
    // version THL- Client Payroll 1.0
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Employee Import Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll No."; Rec."Payroll No.")
                {
                    ApplicationArea = All;
                }
                field("System No."; Rec."System No.")
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field("Passport Number"; Rec."Passport Number")
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Departture Date"; Rec."Departture Date")
                {
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                }
                field("PIN No."; Rec."PIN No.")
                {
                    ApplicationArea = All;
                }
                field("SHIF No."; Rec."SHIF No.")
                {
                    ApplicationArea = All;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = All;
                }
                field("Pension Number"; Rec."Pension Number")
                {
                    ApplicationArea = All;
                }
                field("HELB No."; Rec."HELB No.")
                {
                    ApplicationArea = All;
                }
                field("Sacco Number"; Rec."Sacco Number")
                {
                    ApplicationArea = All;
                }
                field("Basic Salary"; Rec."Basic Salary")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Account Number"; Rec."Account Number")
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
