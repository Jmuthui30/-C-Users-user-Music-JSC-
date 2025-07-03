page 58082 "Recruitment Request New"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "Recruitment Needs";
    Caption = 'Recruitment Request';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec."Status" = Rec."Status"::Open;

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                    ShowMandatory = true;
                }

                field(Description; Rec.Description)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Vacancy Announcement"; "Vacancy Announcement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }

                field("Appointment Type"; Rec."Appointment Type")
                {
                    ToolTip = 'Specifies the value of the Appointment Type field';
                }
                field("Appointment Type Description"; Rec."Appointment Type Description")
                {
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Appointment Type Description field';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Global Dimension 1 Code field';
                }
                field("Reason for Recruitment"; Rec."Reason for Recruitment")
                {
                    MultiLine = true;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Reason for Recruitment field';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field';
                }
                field("Work Station"; "Work Station")
                {
                    ToolTip = 'Specifies the value of the Priority field';
                }
                field("Expected Reporting Date"; Rec."Expected Reporting Date")
                {
                    Caption = 'Expected vacancy announcement date';
                    ToolTip = 'Specifies the value of the Expected vacancy announcement date field';
                }
                field("Reason for Recruitment(text)"; Rec."Reason for Recruitment(text)")
                {
                    Caption = 'Reason for Recruitment';
                    MultiLine = true;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Reason for Recruitment field';
                    ShowMandatory = true;
                }
                
                field("Requested By"; Rec."Requested By")
                {
                    Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Requested By field';
                }
                field("Shortlisting Closed"; Rec."Shortlisting Closed")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Shortlisting Closed field';
                    Enabled = false;
                }
                field("Shortlisting Started"; Rec."Shortlisting Started")
                {
                    ToolTip = 'Specifies the value of the Shortlisting Started field';
                    Enabled = false;
                    Visible = false;
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Submitted To Portal field';
                    Enabled = false;
                }
                field(Status; Rec.Status)
                {
                    Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field(Approved; Rec.Approved)
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Approved field';
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Date Approved field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    // Editable = Rec.Status = Rec.Status::Released;
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    //  Editable = Rec.Status = Rec.Status::Released;
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Total Recruitment Costs"; Rec."Total Recruitment Costs")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Total Recruitment Costs field.';
                }

            }

            group("Job Title:")
            {
                field("Memo Ref No."; "Memo Ref No.")
                {
                    ApplicationArea = All;
                    Caption = 'Job Reference Number:';
                    ToolTip = 'Specifies the value of the Positions field';
                }
                field(Positions; Rec.Positions)
                {
                    ToolTip = 'Specifies the value of the Positions field';
                    Caption = 'Number of Posts:';
                }
                field("Terms of Service:"; "Terms of Service:")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Positions field';
                }
                field("Remuneration:"; "Remuneration:")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Positions field';
                }
                field(Grade; Grade)
                {
                    Caption = 'Job Grade';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Positions field';
                }

            }
            group("Job Purpose:")
            {
                field("Job Purpose"; "Job Purpose")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Positions field';
                }
            }
            group("Judge Function")
            {
                field("Judge Function Title"; "Judge Function Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the';
                }
                grid(function)
                {
                    field("Functions of the Judge"; "Functions of the Judge")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the';
                    }
                    field("Functions of the Judge1"; "Functions of the Judge1")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the';
                    }
                }

            }

            group("Constituion Requirement:")
            {
                field("Constitution Requirement"; "Constitution Requirement")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Constitution Requirement field';
                }
            }
            group("Reporting Responsibilities:")
            {
                field("Reporting Responsibilities"; "Reporting Responsibilities")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Positions field';

                }
            }
            group("Area of Deployment:")
            {
                field("Area Of Deployment"; "Area Of Deployment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Positions field';
                }

            }
            group("Key Duties and Responsibilities:")
            {
                field("Key Duties & Responsibilities:"; "Key Duties & Responsibilities:")
                {
                    Caption = 'Key Duties and Responsibilities:';
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies the value of the Positions field';

                }

            }
            group("Job Requirements: Academic and Professional Qualifications:")
            {
                part(Academics; "Job Academic Qualifications")
                {
                    Editable = Rec.Status = Rec.Status::Open;
                    SubPageLink = "Job Id" = field("Job ID");
                    ApplicationArea = All;
                }
                part(ProfessionalCertificates; "Job Professional Certs")
                {
                    Editable = Rec.Status = Rec.Status::Open;
                    SubPageLink = "Job Id" = field("Job ID");
                    ApplicationArea = All;
                }
            }
            group("Experience:")
            {
                field("Experience"; "Experience")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Experience field';
                    MultiLine = true;
                }
            }
            group("Job Core Competencies:")
            {
                part("Core Compitencies"; "Job Compitencies")
                {
                    Editable = Rec.Status = Rec.Status::Open;
                    SubPageLink = "Job Id" = field("Job ID");
                    ApplicationArea = All;
                }

            }
            group("Terms and Conditions:")
            {

                field("Terms and Conditions"; "Terms and Conditions")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Positions field';

                }
                field("Terms and Conditions 2"; "Terms and Conditions 2")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Positions field';

                }
                field("Terms and Conditions 3"; "Terms and Conditions 3")
                {
                    MultiLine = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Terms field';

                }
            }
            part(RecruitmentCosts; "Recruitment Costs")
            {
                Caption = 'Recruitment Costs';
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = "Need Code" = field("No.");
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send For Approval action';
                Enabled = not OpenApprovalEntriesExist;

                trigger OnAction()
                begin
                    if Confirm('Do you want to send this Request for approval?', false) then begin
                        Rec.TestField(Rec."Job ID");
                        Rec.TestField(Rec.Positions);
                        //  Rec.TestField(Rec."Reason for Recruitment(text)");

                        if ApprovalMgt.CheckRecruitmentRequestWorkflowEnabled(Rec) then
                            ApprovalMgt.OnSendRecruitmentApprovalRequest(Rec);
                    end;

                    CurrPage.Close();
                end;
            }
            action("Cancel Approval")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval action';
                Enabled = CanCancelApprovalForRecord;

                trigger OnAction()
                begin
                    ApprovalMgt.OnCancelRecruitmentApprovalRequest(Rec);
                end;
            }
            action("View Approvals")
            {
                Caption = 'Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Executes the Approvals action';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run();
                end;
            }
            action("Job Recruitment")
            {
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Image = RemoveContacts;
                ToolTip = 'Executes the Remove from Portal action';
                Caption = 'Job Recruitment Report';
                trigger OnAction()
                var
                    RecruitmentNeeds: Record "Recruitment Needs";
                begin
                    RecruitmentNeeds.Reset();
                    RecruitmentNeeds.SetRange(RecruitmentNeeds."No.", "No.");
                    if RecruitmentNeeds.Find('-') then
                        Report.Run(53000, true, false, RecruitmentNeeds);

                end;
            }
            action("THE COURT OF APPEAL")
            {
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Image = RemoveContacts;
                ToolTip = 'Executes the Remove from Portal action';
                Caption = 'THE COURT OF APPEAL';
                trigger OnAction()
                var
                    RecruitmentNeeds: Record "Recruitment Needs";
                begin
                    RecruitmentNeeds.Reset();
                    RecruitmentNeeds.SetRange(RecruitmentNeeds."No.", "No.");
                    if RecruitmentNeeds.Find('-') then
                        Report.Run(53010, true, false, RecruitmentNeeds);

                end;
            }
            action("OFFICE OF JUDGE")
            {
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                Image = RemoveContacts;
                ToolTip = 'Executes the Remove from Portal action';
                Caption = 'OFFICE OF JUDGE ';
                trigger OnAction()
                var
                    RecruitmentNeeds: Record "Recruitment Needs";
                begin
                    RecruitmentNeeds.Reset();
                    RecruitmentNeeds.SetRange(RecruitmentNeeds."No.", "No.");
                    if RecruitmentNeeds.Find('-') then
                        Report.Run(53011, true, false, RecruitmentNeeds);

                end;
            }

        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditable();
    end;

    trigger OnAfterGetRecord()
    begin
        SetEditable();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        SetEditable();
    end;

    trigger OnOpenPage()
    begin

        SetEditable();
    end;

    var
        ApprovalMgt: Codeunit "Approval Mgt HR Ext";
        CanCancelApprovalForRecord: Boolean;
        NOTEditable: Boolean;
        OpenApprovalEntriesExist: Boolean;

    local procedure SetEditable()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        if Rec.Status = Rec.Status::Released then
            NOTEditable := false
        else
            NOTEditable := true;

        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmt.HasApprovalEntries(Rec.RecordId) //TRUE
        else
            OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId); //FALSE

        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;
}





