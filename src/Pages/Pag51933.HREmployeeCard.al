page 51933 "HR Employee Card"
{
    // version NAVW113.02
    Caption = 'Employee Card';
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
                    Importance = Standard;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Visible = NoFieldVisible;

                    trigger OnAssistEdit()
                    begin
                        Rec.AssistEdit;
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ShowMandatory = true;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("Job Id"; Rec."Job Id")
                {
                    ApplicationArea = all;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = BasicHR;
                    Editable = false;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies an alternate name that you can use to search for the record in question when you cannot remember the value in the Name field.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s gender.';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Has Special Needs"; Rec."Has Special Needs")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if the the Employeee falls under PLWD.';
                    ShowMandatory = true;
                }
                field("Disability Description"; Rec."Disability Description")
                {
                    ApplicationArea = All;
                    ShowMandatory = Rec."Has Special Needs" = true;
                }
                field("Phone No.2"; Rec."Phone No.")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Company Phone No.';
                    ToolTip = 'Specifies the employee''s telephone number.';
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = BasicHR;
                    ExtendedDatatype = EMail;
                    ToolTip = 'Specifies the employee''s email address at the company.';
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies when this record was last modified.';
                }
                field("Privacy Blocked"; Rec."Privacy Blocked")
                {
                    ApplicationArea = BasicHR;
                    Importance = Additional;
                    ToolTip = 'Specifies whether to limit access to data for the data subject during daily operations. This is useful, for example, when protecting data from changes while it is under privacy review.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }

                field("User ID"; "User ID")
                {
                    ApplicationArea = all;
                }
                field("Imprest Account"; "Imprest Account")
                {
                    ApplicationArea = all;
                }
                field("Base Calendar"; "Base Calendar")
                {
                    ApplicationArea = all;
                }
                field(Religion; Religion)
                {
                    ApplicationArea = All;
                }
                field("Ethnic Origin"; "Ethnic Origin")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Ethnic Name"; "Ethnic Name")
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; "Marital Status")
                {
                    ApplicationArea = All;
                }

            }
            group("Important Dates")
            {
                Caption = 'Important Dates';

                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Date of Birth';
                    Importance = Promoted;
                    ShowMandatory = true;
                    NotBlank = true;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("Employee Age"; Rec."Employee Age")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Age';
                    Editable = false;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Date of Appointment';
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                    trigger OnValidate()
                    begin
                        if Rec."Employment Date" <> 0D then
                            "Days to Retirement" := HRDates.DetermineDatesDiffrence(Today, "Retirement Date");
                    end;
                }
                field(LengthOfService; LengthOfService)
                {
                    ApplicationArea = All;
                    Caption = 'Length Of Service';
                    Editable = false;
                }
                field("Retirement Date"; "Retirement Date")
                {
                    ApplicationArea = All;
                    Caption = 'Retirement Date';
                    Editable = false;

                    trigger OnValidate()
                    begin
                        if (Rec."Birth Date" <> 0D) then begin
                            if Emp."Has Special Needs" = false then D := CalcDate('<+60Y>', Rec."Birth Date");
                            "Retirement Date" := D;
                            If (Rec."Birth Date" <> 0D) then begin
                                if Emp."Has Special Needs" = true then D := CalcDate('<+65Y>', Rec."Birth Date");
                                "Retirement Date" := D;
                            end;
                        end;
                    end;
                }
                field("Days to Retirement"; "Days to Retirement")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("SuccessionPlanning")
            {
                Caption = 'Succession Planning';

                field("Position To Succeed"; Rec."Position To Succeed")
                {
                    ApplicationArea = All;
                }
            }
            group("Address & Contact")
            {
                Caption = 'Address & Contact';

                group(Control13)
                {
                    ShowCaption = false;

                    field(Address; Rec.Address)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the employee''s address.';
                    }
                    field("Address 2"; Rec."Address 2")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies additional address information.';
                    }
                    field(City; Rec.City)
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the city of the address.';
                    }
                    group(Control31)
                    {
                        ShowCaption = false;
                        Visible = IsCountyVisible;

                        field(County; Rec.County)
                        {
                            ApplicationArea = BasicHR;
                            ToolTip = 'Specifies the county of the employee.';
                        }
                    }
                    field("Post Code"; Rec."Post Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the postal code.';
                    }
                    field("Country/Region Code"; Rec."Country/Region Code")
                    {
                        ApplicationArea = BasicHR;
                        ToolTip = 'Specifies the country/region of the address.';

                        trigger OnValidate()
                        begin
                            IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
                        end;
                    }
                    field(ShowMap; ShowMapLbl)
                    {
                        ApplicationArea = BasicHR;
                        Editable = false;
                        ShowCaption = false;
                        Style = StrongAccent;
                        StyleExpr = TRUE;
                        ToolTip = 'Specifies the employee''s address on your preferred online map.';

                        trigger OnDrillDown()
                        begin
                            CurrPage.Update(true);
                            Rec.DisplayMap;
                        end;
                    }
                }
                group(Control7)
                {
                    ShowCaption = false;

                    field("Mobile Phone No."; Rec."Mobile Phone No.")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private telephone number.';
                    }
                    field(Pager; Rec.Pager)
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the employee''s pager number.';
                    }
                    field(Extension; Rec.Extension)
                    {
                        ApplicationArea = BasicHR;
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone extension.';
                    }
                    field("Phone No."; Rec."Phone No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Direct Phone No.';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s telephone number.';
                    }
                    field("E-Mail"; Rec."E-Mail")
                    {
                        ApplicationArea = BasicHR;
                        Caption = 'Private Email';
                        Importance = Promoted;
                        ToolTip = 'Specifies the employee''s private email address.';
                    }
                    field("Alt. Address Code"; Rec."Alt. Address Code")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies a code for an alternate address.';
                    }
                    field("Alt. Address Start Date"; Rec."Alt. Address Start Date")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the starting date when the alternate address is valid.';
                    }
                    field("Alt. Address End Date"; Rec."Alt. Address End Date")
                    {
                        ApplicationArea = Basic, Suite;
                        ToolTip = 'Specifies the last day when the alternate address is valid.';
                    }
                }
            }
            group(Administration)
            {
                Caption = 'Administration';

                field("Inactive Date"; Rec."Inactive Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date when the employee became inactive, due to disability or maternity leave, for example.';
                }
                field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a code for the cause of inactivity by the employee.';
                }
                field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employment contract code for the employee.';
                }
                field("Statistics Group Code"; Rec."Statistics Group Code")
                {
                    ApplicationArea = Suite;
                    ToolTip = 'Specifies a statistics group code to assign to the employee for statistical purposes.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies a resource number for the employee.';
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a salesperson or purchaser code for the employee.';
                }
            }
            group(Personal)
            {
                Caption = 'Personal';

                field("Social Security No."; Rec."Social Security No.")
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the social security number of the employee.';
                }
                field("Union Code"; Rec."Union Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s labor union membership code.';
                }
                field("Union Membership No."; Rec."Union Membership No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the employee''s labor union membership number.';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';

                field("Employee Posting Group"; Rec."Employee Posting Group")
                {
                    ApplicationArea = BasicHR;
                    LookupPageID = "Employee Posting Groups";
                    ToolTip = 'Specifies the employee''s type to link business transactions made for the employee with the appropriate account in the general ledger.';
                }
                field("Application Method"; Rec."Application Method")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies how to apply payments to entries for this employee.';
                }
                field("Bank Branch No."; Rec."Bank Branch No.")
                {
                    ApplicationArea = BasicHR;
                    ShowMandatory = true;
                    NotBlank = true;
                    ToolTip = 'Specifies a number of the bank branch.';
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the number used by the bank for the bank account.';
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field(IBAN; Rec.IBAN)
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the bank account''s international bank account number.';
                }
                field("SWIFT Code"; Rec."SWIFT Code")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the SWIFT code (international bank identifier code) of the bank where the employee has the account.';
                }
            }
            group(ALSeparation)
            {
                Caption = 'Separation';

                field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies a termination code for the employee who has been terminated.';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the date when the employee was terminated, due to retirement or dismissal, for example.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = BasicHR;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employment status of the employee.';
                }
            }
            group("Previous Employment")
            {
                Caption = 'Previous Employment';

                field(lastEmployer; Rec."Last Employer")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the name of the employee''s last employer.';
                }
                field("Last Employer Contact"; "Last Employer Contact")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the date when the employee last worked for the company.';
                }
                field("Last Position Held"; "Last Position Held")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the position that the employee held at the last employment.';
                }
                field("Last Date Salary"; "Last Date Salary")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the date when the employee last received a salary from the last employer.';
                }

                field("Last joining Date"; "Last joining Date")
                {
                    ApplicationArea = BasicHR;
                    ToolTip = 'Specifies the date when the employee last joined the company.';
                }

            }
        }
        area(factboxes)
        {
            part(Control3; "Employee Picture")
            {
                ApplicationArea = BasicHR;
                SubPageLink = "No." = FIELD("No.");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(5200), "No." = FIELD("No.");
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
            action("Employee Card")
            {
                ApplicationArea = All;
                Image = PersonInCharge;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "HR Employee Card";
                RunPageLink = "No." = FIELD("No.");
            }
            action("Payroll Information")
            {
                ApplicationArea = All;
                Image = PayrollStatistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                //RunObject = Page "Payroll Infromation";
                RunObject = Page "Client Payroll Infromation";
                RunPageLink = "No." = FIELD("No.");
            }
            action("Admin Infromation")
            {
                ApplicationArea = All;
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Admin Infromation";
                RunPageLink = "No." = FIELD("No.");
            }
            action("Separation Infromation")
            {
                ApplicationArea = All;
                Image = Undo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Exit Information";
                RunPageLink = "No." = FIELD("No.");
            }
        }
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                Image = Employee;

                action("Co&mments")
                {
                    ApplicationArea = Comments;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name" = CONST(Employee), "No." = FIELD("No.");
                    ToolTip = 'View or add comments for the record.';
                }
                action(Dimensions)
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5200), "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action("&Picture")
                {
                    ApplicationArea = BasicHR;
                    Caption = '&Picture';
                    Image = Picture;
                    RunObject = Page "Employee Picture";
                    RunPageLink = "No." = FIELD("No.");
                    ToolTip = 'View or add a picture of the employee or, for example, the company''s logo.';
                }
                action(AlternativeAddresses)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Alternate Addresses';
                    Image = Addresses;
                    RunObject = Page "Alternative Address List";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of addresses that are registered for the employee.';
                }
                action("&Relatives")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Relatives';
                    Image = Relatives;
                    RunObject = Page "Employee Relatives";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of relatives that are registered for the employee.';
                }
                action("Mi&sc. Article Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Mi&sc. Article Information';
                    Image = Filed;
                    RunObject = Page "Misc. Article Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of miscellaneous articles that are registered for the employee.';
                }
                action("&Confidential Information")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Confidential Information';
                    Image = Lock;
                    RunObject = Page "Confidential Information";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of any confidential information that is registered for the employee.';
                }
                action("Q&ualifications")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Q&ualifications';
                    Image = Certificate;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'Open the list of qualifications that are registered for the employee.';
                }
                action("A&bsences")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'A&bsences';
                    Image = Absence;
                    RunObject = Page "Employee Absences";
                    RunPageLink = "Employee No." = FIELD("No.");
                    ToolTip = 'View absence information for the employee.';
                }
                separator(Separator23)
                {
                }
                action("Absences by Ca&tegories")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Absences by Ca&tegories';
                    Image = AbsenceCategory;
                    RunObject = Page "Empl. Absences by Categories";
                    RunPageLink = "No." = FIELD("No."), "Employee No. Filter" = FIELD("No.");
                    ToolTip = 'View categorized absence information for the employee.';
                }
                action("Misc. Articles &Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Misc. Articles &Overview';
                    Image = FiledOverview;
                    RunObject = Page "Misc. Articles Overview";
                    ToolTip = 'View miscellaneous articles that are registered for the employee.';
                }
                action("Co&nfidential Info. Overview")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Co&nfidential Info. Overview';
                    Image = ConfidentialOverview;
                    RunObject = Page "Confidential Info. Overview";
                    ToolTip = 'View confidential information that is registered for the employee.';
                }
                separator(Separator61)
                {
                }
                action("Ledger E&ntries")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Ledger E&ntries';
                    Image = VendorLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = FIELD("No.");
                    RunPageView = SORTING("Employee No.") ORDER(Descending);
                    ShortCutKey = 'Ctrl+F7';
                    ToolTip = 'View the history of transactions that have been posted for the selected record.';
                }
                action(Attachments)
                {
                    ApplicationArea = All;
                    Caption = 'Attachments';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;
                    begin
                        RecRef.GetTable(Rec);
                        DocumentAttachmentDetails.OpenForRecRef(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
                action(PayEmployee)
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Pay Employee';
                    Image = SuggestVendorPayments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Employee Ledger Entries";
                    RunPageLink = "Employee No." = FIELD("No."), "Remaining Amount" = FILTER(< 0), "Applies-to ID" = FILTER('');
                    ToolTip = 'View employee ledger entries for the record with remaining amount that have not been paid yet.';
                }
            }
            group(ActionGroup35)
            {
                action("Employee Leaves")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Leaves';
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee Leaves Card";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Absence Registration")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Absence Registration';
                    Image = Absence;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Absence Registration";
                    ToolTip = 'Register absence for the employee.';
                }

                action("Employee Assets")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employee Assets';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = FixedAssets;
                    RunObject = page "Fixed Asset List";
                    RunPageLink = "Responsible Employee" = field("No.");
                }

                action("Employee Disciplinary Cases")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Disciplinary Cases';
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee Displine Card";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Employee Next Of Kin")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Next Of Kin';
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee Kins Card";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Employee Dependants")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Dependants';
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee Dependants Card";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Employee Qualifications")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Qualifications';
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee Qualification Card";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Promotion History")
                {
                    ApplicationArea = All;
                    Caption = 'Promotion History';
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Emp Promotion History Card";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Employment History")
                {
                    ApplicationArea = All;
                    Caption = 'Employment History';
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employment History Card";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Succession Planning")
                {
                    ApplicationArea = All;
                    Caption = 'Succession Planning';
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Emp Succession Planning Card";
                    RunPageLink = "No." = FIELD("No.");
                }
                action("Career Planning")
                {
                    ApplicationArea = All;
                    Caption = 'Career Planning';
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee Career Plan Card";
                    RunPageLink = "No." = FIELD("No.");
                }
                action(Separation)
                {
                    ApplicationArea = All;
                    Caption = 'Separation';
                    Image = Alerts;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee Separation Card";
                    RunPageLink = "No." = FIELD("No.");
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Age := '';
        LengthOfService := '';
        RetirementDate := '';
        //Recalculate Important Dates
        if (Rec."Termination Date" = 0D) then begin
            if (Rec."Birth Date" <> 0D) then Age := Dates.DetermineAge(Rec."Birth Date", Today);
            if (Rec."Employment Date" <> 0D) then LengthOfService := Dates.DetermineAge(Rec."Employment Date", Today);
            if (Rec."Birth Date" <> 0D) then begin
                if Emp."Has Special Needs" = false then D := CalcDate('<+60Y>', Rec."Birth Date");
                RetirementDate := Format(D);
                If (Rec."Birth Date" <> 0D) then begin
                    if Emp."Has Special Needs" = true then D := CalcDate('<+65Y>', Rec."Birth Date");
                    RetirementDate := Format(D);
                end;
            end;
            "Employee Age" := Dates.DetermineAge(Rec."Birth Date", Today);
            if (Rec."Birth Date" <> 0D) then begin
                if Emp."Has Special Needs" = false then D := CalcDate('<+60Y>', Rec."Birth Date");
                "Retirement Date" := D;
                If (Rec."Birth Date" <> 0D) then begin
                    if Emp."Has Special Needs" = true then D := CalcDate('<+65Y>', Rec."Birth Date");
                    "Retirement Date" := D;
                end;
            end;
            "Days to Retirement" := HRDates.DetermineDatesDiffrence(Today, "Retirement Date")
        end;
    end;

    trigger OnOpenPage()
    begin
        SetNoFieldVisible;
        IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
        Age := '';
        LengthOfService := '';
        RetirementDate := '';
        //Recalculate Important Dates
        if (Rec."Termination Date" = 0D) then begin
            if (Rec."Birth Date" <> 0D) then Age := Dates.DetermineAge(Rec."Birth Date", Today);
            if (Rec."Employment Date" <> 0D) then LengthOfService := Dates.DetermineAge(Rec."Employment Date", Today);
            if (Rec."Birth Date" <> 0D) then begin
                if Emp."Has Special Needs" = false then D := CalcDate('<+60Y>', Rec."Birth Date");
                RetirementDate := Format(D);
                If (Rec."Birth Date" <> 0D) then begin
                    if Emp."Has Special Needs" = true then D := CalcDate('<+65Y>', Rec."Birth Date");
                    RetirementDate := Format(D);
                end;
                "Employee Age" := Dates.DetermineAge(Rec."Birth Date", Today);
                if (Rec."Birth Date" <> 0D) then begin
                    if Emp."Has Special Needs" = false then D := CalcDate('<+60Y>', Rec."Birth Date");
                    "Retirement Date" := D;
                    If (Rec."Birth Date" <> 0D) then begin
                        if Emp."Has Special Needs" = true then D := CalcDate('<+65Y>', Rec."Birth Date");
                        "Retirement Date" := D;
                    end;
                end;
            end;
        end;
    end;

    trigger OnClosePage()
    begin
        SetNoFieldVisible;
        IsCountyVisible := FormatAddress.UseCounty(Rec."Country/Region Code");
        Age := '';
        LengthOfService := '';
        RetirementDate := '';
        //Recalculate Important Dates
        if (Rec."Termination Date" = 0D) then begin
            if (Rec."Birth Date" <> 0D) then Age := Dates.DetermineAge(Rec."Birth Date", Today);
            if (Rec."Employment Date" <> 0D) then LengthOfService := Dates.DetermineAge(Rec."Employment Date", Today);
            if (Rec."Birth Date" <> 0D) then begin
                if Emp."Has Special Needs" = false then D := CalcDate('<+60Y>', Rec."Birth Date");
                RetirementDate := Format(D);
                If (Rec."Birth Date" <> 0D) then begin
                    if Emp."Has Special Needs" = true then D := CalcDate('<+65Y>', Rec."Birth Date");
                    RetirementDate := Format(D);
                end;
            end;
        end;
    end;

    var
        ShowMapLbl: Label 'Show on Map';
        FormatAddress: Codeunit 365;
        NoFieldVisible: Boolean;
        IsCountyVisible: Boolean;
        Dates: Codeunit "HR Dates";
        HRDates: Codeunit "HR Dates Mgt";
        Age: Text[100];
        LengthOfService: Text[100];
        RetirementDate: Text[100];
        D: Date;
        EmployeeMaster: Record "Client Employee Master";
        Emp: Record Employee;

    local procedure SetNoFieldVisible()
    var
        DocumentNoVisibility: Codeunit DocumentNoVisibility;
    begin
        NoFieldVisible := DocumentNoVisibility.EmployeeNoIsVisible;
    end;
}
