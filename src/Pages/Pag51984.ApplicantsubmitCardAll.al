page 58984 "Applicant submitedCard-All"
{
    // version THL- HRM 1.0
    Caption = 'Applicant submit-Card';
    Editable = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = Applicant;

    layout
    {
        area(content)
        {
            group("A: VACANCY DETAILS")
            {
                Caption = 'A: VACANCY DETAILS';

                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies a number for the employee.';
                    //Enabled = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then CurrPage.Update;
                    end;
                }
                field("Position Applied For"; Rec."Position Applied For")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies a position applied for.';
                    Enabled = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then CurrPage.Update;
                    end;
                }
                field("Vacancy No."; Rec."Vacancy No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s first name.';
                    //Enabled = false;
                    Enabled = false;
                }
                field("Created Date"; "Created Date")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s last name.';
                    Enabled = false;
                }
                // field(LinkedIn; Rec.LinkedIn)
                // {
                //     ApplicationArea = All;
                // }
                // field(Address; Rec."Postal Address")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the employee''s address.';
                // }
                // field("Address 2"; Rec."Physical Address")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies another line of the address.';
                // }
                // field("Post Code"; Rec."Post Code")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the postal code of the address.';
                // }
                // field(City; Rec.City)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the city of the address.';
                // // }
                // field("Country/Region Code"; Rec."Country/Region Code")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the country/region code.';
                // }
                // field("Phone No."; Rec."Mobile Phone No.")
                // {
                //     ApplicationArea = All;
                //     Importance = Promoted;
                //     ToolTip = 'Specifies the employee''s telephone number.';
                // }
                // field("Search Name"; Rec."Search Name")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies a search name for the employee.';
                // }
                // field("Ethnic Group"; Rec."Ethnic Group")
                // {
                //     ApplicationArea = All;
                // }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the last day this entry was modified.';
                }
            }
            group("B: PERSONAL DETAILS")
            {
                field("Personal Title"; "Personal Title")
                {
                    ApplicationArea = all;
                    Caption = 'Title';
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    ToolTip = 'Specifies the applicant No.';
                    Visible = false;
                }

                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field(FullName; FullName) { Editable = true; Enabled = false; ApplicationArea = all; }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field(Age; Rec.Age)
                {
                    ApplicationArea = All;
                    Enabled = false;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Nationality Specification"; Rec."Nationality Specification")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                    // Visible = Rec.Nationality = Rec.Nationality::Others;
                    // Enabled = Rec.Nationality = Rec.Nationality::Others;
                }
                field("Nationality Name"; "Nationality Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                    Caption = 'National ID No.';
                    // Visible = Rec.Nationality = Rec.Nationality::Others;
                    // Enabled = Rec.Nationality = Rec.Nationality::Others;

                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                    Caption = 'National ID No.';
                    // Visible = Rec.Nationality = Rec.Nationality::Kenyan;
                    // Enabled = Rec.Nationality = Rec.Nationality::Kenyan;
                }

                field("Home County"; Rec."Home County")
                {
                    ApplicationArea = All;
                    // Visible = Rec.Nationality = Rec.Nationality::Kenyan;
                    // Enabled = Rec.Nationality = Rec.Nationality::Kenyan;
                }
                field("Ethnic Group"; Rec."Ethnic Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                    // Visible = Rec.Nationality = Rec.Nationality::Kenyan;
                    // Enabled = Rec.Nationality = Rec.Nationality::Kenyan;
                }
                field("Sub Ethnic Group"; "Sub Ethnic Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field(Disability; Rec.Disability)
                {
                    ApplicationArea = All;
                    Caption = 'Disability';
                }
                group("Persons Abled Differently")
                {
                    Caption = 'Persons Disability';
                    Visible = Rec.Disability = true;

                    field("NCPWD Certificate No."; Rec."NCPWD Certificate No.")
                    {
                        ApplicationArea = All;
                        ShowMandatory = Rec.Disability = true;
                    }
                    field("Disability Description"; Rec."Disability Description")
                    {
                        ApplicationArea = All;
                        ShowMandatory = Rec.Disability = true;
                    }
                }
                field(Profession; Rec.Profession)
                {
                    ApplicationArea = All;
                }
                field("Highest Level Of Education"; Rec."Highest Level Of Education")
                {
                    ApplicationArea = All;
                }
                group("Passport Details")
                {
                    field("Passport No."; Rec."Passport No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Passport Issue Date"; Rec."Passport Issue Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Passport Expiry Date"; Rec."Passport Expiry Date")
                    {
                        ApplicationArea = All;
                    }
                }
                group("Entry Permit(For Non Kenyans living in Kenya)")
                {
                    field("Permit No."; Rec."Permit No.")
                    {
                        ApplicationArea = All;
                    }
                    field("Permit Issue Date"; Rec."Permit Issue Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Permit Validity Period"; Rec."Permit Validity Period")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group("C: PRESENT ADDRESS")
            {
                field("Postal Address new"; "Postal Address new")
                {
                    ApplicationArea = All;
                    Caption = 'Address';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Post Code';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Caption = 'City';
                }
                field("Physical Address"; Rec."Physical Address")
                {
                    ApplicationArea = All;
                    Caption = 'Physical Address';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Mobile Phone No.';
                }
                field("Alternative Phone No."; Rec."Alternative Phone No.")
                {
                    ApplicationArea = All;
                    Caption = 'Alternative Phone No.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    Caption = 'E-Mail';
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                    Caption = 'Portal ID';
                    Enabled = false;
                }
            }
            group("D: LANGUANGES SPOKEN & WRITTEN")
            {
                part(Languages; "Applicant Languages")
                {
                    ApplicationArea = All;
                    SubPageLink = "Applicant No." = FIELD("No.");
                }
            }
            group("E: SALARY & YEARS OF EXPERIENCE")
            {
                field("Years Of Experience"; Rec."Years Of Experience")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    //ToolTip = 'Specifies the employee''s telephone extension.';
                }
                field("Current Salary"; Rec."Current Salary")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    //ToolTip = 'Specifies the employee''s telephone extension.';
                }
                field("Expected Salary"; Rec."Expected Salary")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    //ToolTip = 'Specifies the employee''s telephone extension.';
                }
            }
            group("F: CURRENT EMPLOYMENT DETAILS(Where Applicable)")
            {
                part(ApplicantCurrentEmployment; "Applicant Current Employment")
                {
                    ApplicationArea = All;
                    SubPageLink = "Applicant No." = field("No."), "Currently Employment" = filter(true);
                }
            }
            group("G: ACADEMIC QUALIFICATIONS(Starting with the highest)")
            {
                part(ApplicantQualifications; "Applicant Qualification")
                {
                    ApplicationArea = All;
                    SubPageLink = "Employee No." = field("No."), "Qualification Type" = filter(Academic);
                }
            }
            group("H: PROFESSIONAL/TECHNICAL QUALIFICATIONS(Starting with the highest)")
            {
                part(ApplicantProfQualifications; "Applicant Qualification")
                {
                    ApplicationArea = All;
                    SubPageLink = "Employee No." = field("No."), "Qualification Type" = filter(Professional);
                }
            }
            group("I: REGISTRATION/MEMBERSHIP TO PROFESSIONAL BODIES(Where Applicable)")
            {
                part(ApplicantProfBodies; "Applicant Professional Bodies")
                {
                    ApplicationArea = All;
                    SubPageLink = "Applicant No." = field("No.");
                }
            }
            group("J: RELEVANT COURSES & TRAININGS ATTENDED NOT LESS THAN ONE (1) WEEK")
            {
                Caption = 'J: RELEVANT COURSES & TRAININGS ATTENDED NOT LESS THAN ONE (1) WEEK(Starting with the lastest excluding certificate of participation & Attendance)';

                part(ReleventCourses; "Relevant Course & Trainings")
                {
                    ApplicationArea = All;
                    SubPageLink = "Source No" = field("No.");
                }
            }
            group("K:EMPLOYMENT DETAILS - WHERE APPLICABLE(Starting with the current or most recent)")
            {
                /*part(ApplicantEmploymentHistory; "Applicant Employment History")
                {
                    ApplicationArea = All;
                    SubPageLink = "Applicant No." = field("No."), "Currently Employment" = filter(false);
                }*/
                part(ApplicantEMploymentDetails; "Applicant Current Employment")
                {
                    ApplicationArea = All;
                    SubPageLink = "Applicant No." = field("No."), "Currently Employment" = filter(false);
                }
            }
            group("L:OTHER PERSONAL DETAILS")
            {
                field("Criminal Declaration"; Rec."Criminal Declaration")
                {
                    ApplicationArea = All;
                    Caption = 'Have you ever been convicted of /or cautioned for, any criminal offense or have any other proceedings pending against you?';
                }
                field("Criminal Declaration Specification"; Rec."Criminal Decl. Specification")
                {
                    ApplicationArea = All;
                    Visible = Rec."Criminal Declaration" = true;
                    Caption = 'Please Give Details';
                }
                field("Dismissal Declaration"; Rec."Dismissal Declaration")
                {
                    ApplicationArea = All;
                    Caption = 'Have you ever been dismissed or otherwise removed from the Judicial Service, Public service or other engagement?';
                }
                field("Dismissal Declaration Specification"; Rec."Dismissal Decl. Specification")
                {
                    ApplicationArea = All;
                    Visible = Rec."Dismissal Declaration" = true;
                    Caption = 'Please Give details';
                    MultiLine = true;
                }
            }
            group("M:OTHER ATTACHMENTS")
            {
                field("Application Letter"; Rec."Application Letter")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                    Enabled = false;
                }
                field("Curriculum Vitae"; Rec."Curriculum Vitae")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                    Enabled = false;
                }
                field("Identification Document"; Rec."Identification Document")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                    Enabled = false;
                }
                field("Passport Photo"; Rec."Passport Photo")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                    Enabled = false;
                }
            }
            group("N:TITLES OF SAMPLE WRITING(Where Applicable)")
            {
                part(TitlesOfSampleWriting; "Titles of Sample Writings")
                {
                    ApplicationArea = All;
                    SubPageLink = "Source No" = field("No.");
                }
            }
            group("O:FINAL DECLARATION & SIGNATURE")
            {
                field("Final Declaration"; Rec."Final Declaration")
                {
                    ApplicationArea = All;
                }
                field("Declaration Date"; Rec."Declaration Date")
                {
                    ApplicationArea = All;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                }
            }
            // group("Application Job Details")
            // {
            //     // field("Applicant Type"; Rec."Applicant Type")
            //     // {
            //     //     ApplicationArea = All;
            //     // }
            //     // field("Vacancy No."; Rec."Vacancy No.")
            //     // {
            //     //     ApplicationArea = All;
            //     // }
            //     // field("Position Applied For"; Rec."Position Applied For")
            //     // {
            //     //     ApplicationArea = All;
            //     //     Enabled = false;
            //     // }
            // }
            // group(Communication)
            // {
            //     Caption = 'Communication';
            //     field(Extension; Rec.Extension)
            //     {
            //         ApplicationArea = All;
            //         Importance = Promoted;
            //         ToolTip = 'Specifies the employee''s telephone extension.';
            //     }
            //     // field("Mobile Phone No."; Rec."Mobile Phone No.")
            //     // {
            //     //     ApplicationArea = All;
            //     //     Importance = Promoted;
            //     //     ToolTip = 'Specifies the employee''s mobile telephone number.';
            //     // }
            //     field(Pager; Rec.Pager)
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the employee''s pager number.';
            //     }
            //     field("Phone No.2"; Rec."Mobile Phone No.")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the employee''s telephone number.';
            //     }
            //     // field("E-Mail"; Rec."E-Mail")
            //     // {
            //     //     ApplicationArea = All;
            //     //     Importance = Promoted;
            //     //     ToolTip = 'Specifies the employee''s email address.';
            //     // }
            //     field("Company E-Mail"; Rec."Company E-Mail")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the employee''s email address at the company.';
            //     }
            //     field("Alt. Address Code"; Rec."Alt. Address Code")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies a code for an alternate address.';
            //     }
            //     field("Alt. Address Start Date"; Rec."Alt. Address Start Date")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the starting date when the alternate address is valid.';
            //     }
            //     field("Alt. Address End Date"; Rec."Alt. Address End Date")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the last day when the alternate address is valid.';
            //     }
            // }
            // group(Administration)
            // {
            //     Caption = 'Administration';
            //     // field(Status; Rec.Status)
            //     // {
            //     //     ApplicationArea = All;
            //     //     Importance = Promoted;
            //     //     ToolTip = 'Specifies the employment status of the employee.';
            //     // }
            //     field("Inactive Date"; Rec."Inactive Date")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the date when the employee became inactive, due to disability or maternity leave, for example.';
            //     }
            //     field("Cause of Inactivity Code"; Rec."Cause of Inactivity Code")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies a code for the cause of inactivity by the employee.';
            //     }
            //     field("Termination Date"; Rec."Termination Date")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the date when the employee was terminated, due to retirement or dismissal, for example.';
            //     }
            //     field("Grounds for Term. Code"; Rec."Grounds for Term. Code")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies a termination code for the employee who has been terminated.';
            //     }
            //     field("Emplymt. Contract Code"; Rec."Emplymt. Contract Code")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the employment contract code for the employee.';
            //     }
            //     field("Statistics Group Code"; Rec."Statistics Group Code")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies a statistics group code to assign to the employee for statistical purposes.';
            //     }
            //     field("Resource No."; Rec."Resource No.")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies a resource number for the employee, if the employee is a resource in Resources Planning.';
            //     }
            //     field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies a salesperson or purchaser code for the employee, if the employee is a salesperson or purchaser in the company.';
            //     }
            // }
            // group(Personal)
            // {
            //     Caption = 'Personal';
            //     // field("Birth Date"; Rec."Birth Date")
            //     // {
            //     //     ApplicationArea = All;
            //     //     Importance = Promoted;
            //     //     ToolTip = 'Specifies the employee''s date of birth.';
            //     // }
            //     // field("National ID"; Rec."National ID")
            //     // {
            //     //     ApplicationArea = All;
            //     // }
            //     field("Social Security No."; Rec."Social Security No.")
            //     {
            //         ApplicationArea = All;
            //         Importance = Promoted;
            //         ToolTip = 'Specifies the Social Security number of the employee.';
            //     }
            //     field("Union Code"; Rec."Union Code")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the employee''s labor union membership code.';
            //     }
            //     field("Union Membership No."; Rec."Union Membership No.")
            //     {
            //         ApplicationArea = All;
            //         ToolTip = 'Specifies the employee''s labor union membership number.';
            //     }
            // }
            // group("Offer Details")
            // {
            //     Caption = 'Offer Details';
            //     field("Job Title"; Rec."Position Applied For")
            //     {
            //         ApplicationArea = All;
            //         Importance = Promoted;
            //         ToolTip = 'Specifies the employee''s job title.';
            //     }
            //     field("Employment Date"; Rec."Employment Date")
            //     {
            //         ApplicationArea = All;
            //         Importance = Promoted;
            //         ToolTip = 'Specifies the date when the employee began to work for the company.';
            //     }
            //     field("Office Location"; Rec."Office Location")
            //     {
            //         ApplicationArea = All;
            //         Importance = Promoted;
            //         ToolTip = 'Specifies the employee''s date of birth.';
            //     }
            //     field("Probation Period"; Rec."Probation Period")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Probation Termination Notice"; Rec."Probation Termination Notice")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Annual Leave Days"; Rec."Annual Leave Days")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Leave Notice Period"; Rec."Leave Notice Period")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Contract Termination Notice"; Rec."Contract Termination Notice")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Hours Worked Per Week"; Rec."Hours Worked Per Week")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Days Worked Per Week"; Rec."Days Worked Per Week")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Reporting Time"; Rec."Reporting Time")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Closing Time"; Rec."Closing Time")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Lunch Break Duration"; Rec."Lunch Break Duration")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Lunch Start Time"; Rec."Lunch Start Time")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Lunch End Time"; Rec."Lunch End Time")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Week Start Day"; Rec."Week Start Day")
            //     {
            //         ApplicationArea = All;
            //     }
            //     field("Week End Day"; Rec."Week End Day")
            //     {
            //         ApplicationArea = All;
            //     }
            // }
            // group("Offer Lines")
            // {
            //     part(Control15; "Applicant Offers")
            //     {
            //         ApplicationArea = All;
            //         SubPageLink = "Applicant No." = FIELD("No.");
            //     }
            // }
            // group(Qualification)
            // {
            //     part("Applicant Qualification"; "Applicant Qualification")
            //     {
            //         ApplicationArea = All;
            //         SubPageLink = "Employee No." = FIELD("No.");
            //     }
            // }
        }
        area(factboxes)
        {
            part(Control3; "Applicant Picture")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
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

            action(Submit)
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                // PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Submit action';

                trigger OnAction()
                begin
                    if Confirm('Do you want to submit your application?') = true then begin
                        Rec.TestField("E-Mail");
                        HRMgt.SubmitApplication(Rec."No.");
                    end;

                    CurrPage.Close();
                end;
            }


            action("Offer of Employment")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(Report::"Offer of Employment", true, false, Rec);
                end;
            }
            action("Offer Made")
            {
                ApplicationArea = All;
                Image = Confirm;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    OnboardingMgt.MakeOffer(Rec);
                end;
            }
            action("Invite for Interview")
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;

                // Visible = false;
                trigger OnAction()
                begin
                    OnboardingMgt.InvitationEmail(Rec);
                end;
            }
            action("Send Rejection Email")
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedIsBig = true;

                // Visible = false;
                trigger OnAction()
                begin
                    OnboardingMgt.RejectionEmail(Rec);
                end;
            }
            action("Invite for Medical Test")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;

                // Visible = false;
                trigger OnAction()
                begin
                    OnboardingMgt.MedicalTestInvite(Rec);
                end;
            }
            action("Attachments Portal")
            {
                ApplicationArea = Basic;
                Ellipsis = true;
                Image = Attachments;
                Promoted = true;
                Visible = true;
                PromotedCategory = Category5;
                RunObject = page "Portal Uploads";
                RunPageLink = "Document No" = field("No.");
            }



        }

        area(Reporting)
        {
            action("Candidate Profile")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(Report::"Applicant Form", true, false, Rec);
                end;
            }
        }
    }
    var
        OnboardingMgt: Codeunit "Onboarding Management";
        HRMgt: Codeunit "HR Management";
}
