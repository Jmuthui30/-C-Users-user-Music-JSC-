page 51700 "Applicant Card-Offer Made"
{
    // version THL- HRM 1.0
    Caption = 'Offer Made';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Applicant;
    SourceTableView = WHERE("Offer Status"=CONST("Offer Made"), Shortlisting=CONST(Passed));

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
                        if Rec.AssistEdit(xRec)then CurrPage.Update;
                    end;
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
                field(Address; Rec."Postal Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s address.';
                }
                field("Address 2"; Rec."Physical Address")
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
                field("Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a search name for the employee.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s gender.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the last day this entry was modified.';
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
                field(Pager; Rec.Pager)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s pager number.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s email address.';
                }
                field("Phone No.2"; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                }
                field("Alt. Address Code"; Rec."Alt. Address Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for an alternate address.';
                }
                field("Alt. Address Start Date"; Rec."Alt. Address Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the starting date when the alternate address is valid.';
                }
                field("Alt. Address End Date"; Rec."Alt. Address End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last day when the alternate address is valid.';
                }
            }
            group(Administration)
            {
                Caption = 'Administration';

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employment status of the employee.';
                }
                field("Inactive Date"; Rec."Inactive Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the employee became inactive, due to disability or maternity leave, for example.';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for the cause of inactivity by the employee.';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the employee was terminated, due to retirement or dismissal, for example.';
                }
                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a termination code for the employee who has been terminated.';
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employment contract code for the employee.';
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a statistics group code to assign to the employee for statistical purposes.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a resource number for the employee, if the employee is a resource in Resources Planning.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a salesperson or purchaser code for the employee, if the employee is a salesperson or purchaser in the company.';
                }
            }
            group(Personal)
            {
                Caption = 'Personal';

                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Social Security No."; Rec."Social Security No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Social Security number of the employee.';
                }
                field("Union Code"; Rec."Union Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s labor union membership code.';
                }
                field("Union Membership No."; Rec."Union Membership No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s labor union membership number.';
                }
            }
            group("Offer Details")
            {
                Caption = 'Offer Details';

                field("Job Title"; Rec."Position Applied For")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                field("Office Location"; Rec."Office Location")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Probation Period"; Rec."Probation Period")
                {
                    ApplicationArea = All;
                }
                field("Probation Termination Notice"; Rec."Probation Termination Notice")
                {
                    ApplicationArea = All;
                }
                field("Annual Leave Days"; Rec."Annual Leave Days")
                {
                    ApplicationArea = All;
                }
                field("Leave Notice Period"; Rec."Leave Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Contract Termination Notice"; Rec."Contract Termination Notice")
                {
                    ApplicationArea = All;
                }
                field("Hours Worked Per Week"; Rec."Hours Worked Per Week")
                {
                    ApplicationArea = All;
                }
                field("Days Worked Per Week"; Rec."Days Worked Per Week")
                {
                    ApplicationArea = All;
                }
                field("Reporting Time"; Rec."Reporting Time")
                {
                    ApplicationArea = All;
                }
                field("Closing Time"; Rec."Closing Time")
                {
                    ApplicationArea = All;
                }
                field("Lunch Break Duration"; Rec."Lunch Break Duration")
                {
                    ApplicationArea = All;
                }
                field("Lunch Start Time"; Rec."Lunch Start Time")
                {
                    ApplicationArea = All;
                }
                field("Lunch End Time"; Rec."Lunch End Time")
                {
                    ApplicationArea = All;
                }
                field("Week Start Day"; Rec."Week Start Day")
                {
                    ApplicationArea = All;
                }
                field("Week End Day"; Rec."Week End Day")
                {
                    ApplicationArea = All;
                }
                field("Annual Gross Salary"; Rec."Annual Gross Salary")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
            part(Control15; "Applicant Offers")
            {
                ApplicationArea = All;
                SubPageLink = "Applicant No."=FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(Control3; "Applicant Picture")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No."=FIELD("No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Offer of Employment")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Annual Gross Salary");
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(Report::"Offer of Employment", true, false, Rec);
                end;
            }
            action("Offer Accepted")
            {
                ApplicationArea = All;
                Image = Confirm;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    OnboardingMgt.OfferAccepted(Rec);
                end;
            }
            action("Offer Rejected")
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    OnboardingMgt.OfferRejected(Rec);
                end;
            }
        }
    }
    var OnboardingMgt: Codeunit "Onboarding Management";
}
