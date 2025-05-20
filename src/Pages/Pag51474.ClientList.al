page 51474 "Client List"
{
    // version THL- Client Payroll 1.0
    CardPageID = "Client Card";
    DeleteAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Client Company Information";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Client No."; Rec."Client No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = All;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = All;
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control22; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Payroll Setup")
            {
                ApplicationArea = All;
                Caption = 'Payroll Setup';
                Image = PayrollStatistics;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Client Payroll Setup";
                RunPageLink = Client=FIELD("Client No.");
            }
            action(Departments)
            {
                ApplicationArea = All;
                Image = Dimensions;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Client Departments";
                RunPageLink = Client=FIELD("Client No.");
            }
            action("Cost Centers")
            {
                ApplicationArea = All;
                Image = CostCenter;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Client Cost Centers";
                RunPageLink = Client=FIELD("Client No.");
            }
            action("Employee Contract Types")
            {
                ApplicationArea = All;
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Client Employee Contract Types";
                RunPageLink = Client=FIELD("Client No.");
            }
            action("Salary Scales")
            {
                ApplicationArea = All;
                Image = ResourceCosts;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Client Salary Scales";
                RunPageLink = Client=FIELD("Client No.");
            }
            action("Salary Levels")
            {
                ApplicationArea = All;
                Image = Allocations;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Client Salary Levels";
                RunPageLink = Client=FIELD("Client No.");
            }
            action("Scale Benefits")
            {
                ApplicationArea = All;
                RunObject = Page "Client Scale Benefits";
                RunPageLink = Client=FIELD("Client No.");
            }
            action(Earnings)
            {
                ApplicationArea = All;
                Image = ElectronicPayment;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Client Earnings";
                RunPageLink = Company=FIELD("Client No.");
            }
            action(Deductions)
            {
                ApplicationArea = All;
                Image = DepositSlip;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Client Deductions";
                RunPageLink = Company=FIELD("Client No.");
            }
        }
    }
}
