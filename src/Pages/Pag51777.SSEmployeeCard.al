page 51777 "SS Employee Card"
{
    // version THL- HRM 1.0
    Caption = 'Employee Card';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies a number for the employee.';

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit()then CurrPage.Update;
                    end;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    Caption = 'Middle Name/Initials';
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s address.';
                }
                field("Address 2"; Rec."Address 2")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies another line of the address.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the postal code of the address.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the city of the address.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country/region code.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
            }
            group(Communication)
            {
                Caption = 'Communication';

                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s telephone extension.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s mobile telephone number.';
                }
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s email address.';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                }
            }
            group(Administration)
            {
                Caption = 'Administration';

                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employment status of the employee.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a resource number for the employee, if the employee is a resource in Resources Planning.';
                }
            }
            group(Personal)
            {
                Caption = 'Personal';

                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s gender.';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = Basic, Suite;
                Editable = false;
                SubPageLink = "No."=FIELD("No.");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Employee Disciplinary Cases")
            {
                ApplicationArea = All;
                Caption = 'Employee Disciplinary Cases';
                Image = Alerts;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Employee Displine Card";
                RunPageLink = "No."=FIELD("No.");
            }
        }
        area(reporting)
        {
            action("My Payslip")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    OurEmp.Reset;
                    OurEmp.SetRange("No.", Rec."No.");
                    REPORT.Run(51442, true, false, OurEmp);
                end;
            }
            action("My P9 Report")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    OurEmp.Reset;
                    OurEmp.SetRange("No.", Rec."No.");
                    REPORT.Run(51443, true, false, OurEmp);
                end;
            }
            action("My Leave Balance")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    NAVEmp.Reset;
                    NAVEmp.SetRange("No.", Rec."No.");
                    REPORT.Run(51617, true, false, NAVEmp);
                end;
            }
            action("My Next of Kin")
            {
                ApplicationArea = All;
                Caption = 'My Next of Kin';
                Image = Relatives;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Employee Relatives";
                RunPageLink = "Employee No."=FIELD("No.");
            }
            action("Career Planning")
            {
                ApplicationArea = All;
                Caption = 'Career Planning';
                Image = Alerts;
                Promoted = true;
                RunObject = Page "Employee Career Plan Card";
                RunPageLink = "No."=FIELD("No.");
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if UserSetup.Get(UserId)then Rec.SetRange("No.", UserSetup."Employee No.")
        else
            Error('Your login has not been mapped to your employee profile. Kindly contact the Administrator.');
    end;
    trigger OnInit()
    begin
        if UserSetup.Get(UserId)then Rec.SetRange("No.", UserSetup."Employee No.")
        else
            Error('Your login has not been mapped to your employee profile. Kindly contact the Administrator.');
    end;
    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId)then Rec.SetRange("No.", UserSetup."Employee No.")
        else
            Error('Your login has not been mapped to your employee profile. Kindly contact the Administrator.');
    end;
    var UserSetup: Record "User Setup";
    OurEmp: Record "Employee Master";
    NAVEmp: Record Employee;
}
