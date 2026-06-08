page 52391 "Appraisal Card"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Review';
    SourceTable = "Employee Appraisal";
    Caption = 'Appraisal Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Caption = 'Appraisal No';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraisal No field';
                }
                field("BSC Planning No."; Rec."BSC Planning No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    // Legacy BSC link hidden; employee appraisal is the primary document.
                    ToolTip = 'Specifies the linked BSC planning document.';
                }
                field("BSC Appraisal No."; Rec."BSC Appraisal No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                    // Legacy BSC link hidden; employee appraisal is the primary document.
                    ToolTip = 'Specifies the linked BSC appraisal document used for quarterly review.';
                }
                label("Period Under Review:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Period Start"; Rec."Period Start")
                {
                    Caption = 'From';
                    ToolTip = 'Specifies the value of the From field';
                }
                field("Period End"; Rec."Period End")
                {
                    Caption = 'To';
                    ToolTip = 'Specifies the value of the To field';
                }
                field("Current Review Period Code"; Rec."Current Review Period Code")
                {
                    ApplicationArea = All;
                    Caption = 'Review Period';
                    ToolTip = 'Specifies the current quarterly review period.';
                }
                field("Review Start Date"; Rec."Review Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Review From';
                    Editable = false;
                    ToolTip = 'Specifies the start date of the selected review period.';
                }
                field("Review End Date"; Rec."Review End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Review To';
                    Editable = false;
                    ToolTip = 'Specifies the end date of the selected review period.';
                }
                label("PERSONAL PARTICULARS:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Employee No"; Rec."Employee No")
                {
                    Caption = 'Appraisee No';
                    ToolTip = 'Specifies the value of the Appraisee No field';
                }
                field("Appraisee Name"; Rec."Appraisee Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraisee Name field';
                }
                field("Appraisee's Job Title"; Rec."Appraisee's Job Title")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraisee''s Job Title field';
                }
                field("Job Grade"; Rec."Job Group")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Job Group field';
                }
                field("Directorate Code"; Rec."Directorate Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the employee directorate captured for this appraisal.';
                }
                field("Directorate Name"; Rec."Directorate Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the employee directorate name captured for this appraisal.';
                }
                label("Appraiser:")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ToolTip = 'Specifies the value of the Appraisal Type field';
                }
                field("Appraiser ID"; Rec."Appraiser ID")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraiser ID field';
                }
                field("Appraiser No"; Rec."Appraiser No")
                {
                    ToolTip = 'Specifies the value of the Appraiser No field';
                }
                field("Appraisers Name"; Rec."Appraisers Name")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraisers Name field';
                }
                field("Appraiser's Job Title"; Rec."Appraiser's Job Title")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraiser''s Job Title field';
                }
                label("Performance Score")
                {
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Values Total"; Rec."Values Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Values Total field';
                }
                field("Values Mean"; Rec."Values Mean")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Values Mean field';
                }
                field("Competences Total"; Rec."Competences Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Competences Total field';
                }
                field("Competences Mean"; Rec."Competences Mean")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Competences Mean field';
                }
                field("Curriculum Total"; Rec."Curriculum Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Curriculum Total field';
                }
                field("Curriculum Mean"; Rec."Curriculum Mean")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Curriculum Mean field';
                }
                field("Research Total"; Rec."Research Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Research Total field';
                }
                field("Research Mean"; Rec."Research Mean")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Research Mean field';
                }
                field("Initiative Total"; Rec."Initiative Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Initiative Total field';
                }
                field("Initiative Mean"; Rec."Initiative Mean")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Initiative Mean field';
                }
                field("Managerial Total"; Rec."Managerial Total")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Managerial Total field';
                }
                field("Managerial  Mean"; Rec."Managerial  Mean")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Managerial  Mean field';
                }
                label("Performance Targets:")
                {
                    Caption = 'Performance Targets';
                    Style = Strong;
                    StyleExpr = true;
                    Visible = false;
                }
                field("Target Score"; Rec."Target Score")
                {
                    Caption = 'Total Score';
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Total Score field';
                }
                field("Target Avg"; Rec."Target Avg")
                {
                    Caption = 'Mean Score';
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Mean Score field';
                }
                field("Current Review Score"; Rec."Current Review Score")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the calculated score for the current review period.';
                }
                field("Total Review Score"; Rec."Total Review Score")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the total score across appraisal review lines.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
            }
            part("Performance Rating"; "Performance Plan")
            {
                Caption = 'Performance Rating';
                Editable = (Rec."Appraisal Status" = Rec."Appraisal Status"::Setting) or (Rec."Appraisal Status" = Rec."Appraisal Status"::Review);
                Enabled = (Rec."Appraisal Status" = Rec."Appraisal Status"::Setting) or (Rec."Appraisal Status" = Rec."Appraisal Status"::Review);
                SubPageLink = "Appraisal No" = field("Appraisal No");
            }
            part(Control13; "Appraiser & Appraisee Comments")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No");
                Visible = false;
            }
            label("Value/Core Competencies:")
            {
                Style = Strong;
                StyleExpr = true;
            }
            part("<Values>"; "Appraisal Values")
            {
                Caption = '<Values>';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where("Value/Core Competence" = filter(Values));
            }
            part("Core Competences"; "Appraisal Core Competences")
            {
                Caption = 'Core Competences';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where("Value/Core Competence" = filter("Core Competences"));
            }
            part("Curriculum Delivery"; "Appraisal Curriculum Delivery")
            {
                Caption = 'Curriculum Delivery';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where("Value/Core Competence" = filter("Curriculum Delivery"));
            }
            part(Research; "Appraisal Research")
            {
                Caption = 'Research';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where("Value/Core Competence" = filter(Research));
            }
            part("Initiative & Willingness"; "Initiative & Willingness")
            {
                Caption = 'Initiative & Willingness';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where("Value/Core Competence" = filter("Initiative & Willingness"));
            }
            part("Managerial & Supervisory"; "Managerial & Supervisory")
            {
                Caption = 'Managerial & Supervisory';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where("Value/Core Competence" = filter("Managerial & Supervisory"));
            }
            label("Appraisal Comments:")
            {
                Style = Strong;
                StyleExpr = true;
            }
            part(Control37; "Appraisee's Appraisal Comments")
            {
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter(Appraisee));
            }
            part("Comments by Second Supervisor"; "Second Supervisor Comments")
            {
                Caption = 'Comments by Second Supervisor';
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Second Supervisor"));
            }
            part(Control39; "HR Appraisal Comments")
            {
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter(HR));
            }
            part("Appraisal Outcomes"; "Appraisal Outcome Part")
            {
                ApplicationArea = All;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                UpdatePropagation = Both;
            }
        }
        area(factboxes)
        {

            part(CommentsFactBox; "Approval Comments FactBox")
            {
                SubPageLink = "Document No." = field("Appraisal No");
            }
            part(Attachments; "Doc. Attachment List Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Employee Appraisals"),
                              "No." = FIELD("Appraisal No");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Preview)
            {
                Caption = 'Preview';
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ToolTip = 'Executes the Preview action';

                trigger OnAction()
                begin
                    /*
                    EmployeeApp.Reset();
                    EmployeeApp.SetRange("Appraisal No","Appraisal No");
                      if EmployeeApp.Find('-') then
                        Report.RunModal(000000,true,false,EmployeeApp);
                    */

                end;
            }
            action("Create Commendation Letter")
            {
                ApplicationArea = All;
                Caption = 'Create Commendation Letter';
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Outcome: Record "Appraisal Outcome";
                    OutcomeMgt: Codeunit "Appraisal Outcome Mgt.";
                begin
                    Outcome := OutcomeMgt.CreateOutcome(Rec, Enum::"Appraisal Outcome Type"::Commendation);
                    CurrPage.Update(false);
                    Commit();
                    Page.Run(Page::"Appraisal Outcome Card", Outcome);
                end;
            }
            action("Create Warning Letter")
            {
                ApplicationArea = All;
                Caption = 'Create Warning Letter';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Outcome: Record "Appraisal Outcome";
                    OutcomeMgt: Codeunit "Appraisal Outcome Mgt.";
                begin
                    Outcome := OutcomeMgt.CreateOutcome(Rec, Enum::"Appraisal Outcome Type"::Warning);
                    CurrPage.Update(false);
                    Commit();
                    Page.Run(Page::"Appraisal Outcome Card", Outcome);
                end;
            }
            action("Create Outcome Memo")
            {
                ApplicationArea = All;
                Caption = 'Create Outcome Memo';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Outcome: Record "Appraisal Outcome";
                    OutcomeMgt: Codeunit "Appraisal Outcome Mgt.";
                begin
                    Outcome := OutcomeMgt.CreateOutcome(Rec, Enum::"Appraisal Outcome Type"::Memo);
                    CurrPage.Update(false);
                    Commit();
                    Page.Run(Page::"Appraisal Outcome Card", Outcome);
                end;
            }
            action("Open BSC Appraisal")
            {
                ApplicationArea = All;
                Caption = 'Open BSC Appraisal';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                // Legacy BSC document drilldown hidden from the unified appraisal process.

                trigger OnAction()
                var
                    BSCHeader: Record "Bal Score Card Header";
                begin
                    Rec.TestField("BSC Appraisal No.");
                    BSCHeader.Get(Rec."BSC Appraisal No.");
                    Page.Run(Page::"Bal Appraisal Score Card", BSCHeader);
                end;
            }
            action("Send For Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Send For Approval action';

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckEmployeeAppraisalWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendEmployeeAppraisalRequestforApproval(Rec);
                end;
            }
            action("Cancel Approval Request")
            {
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelEmployeeAppraisalApprovalRequest(Rec);
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Approvals action';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Enum "Approval Document Type";
                begin

                    DocumentType := DocumentType::"Employee Appraisal";
                    ApprovalEntries.SetRecordfilters(Database::"Employee Appraisal", DocumentType, Rec."Appraisal No");
                    ApprovalEntries.Run();
                end;
            }
            action("Lock Performance")
            {
                Image = CheckJournal;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Lock Performance action';

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Set;

                    Message('Performance Locked');
                end;
            }
            action("Review Targets")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Review Targets action';

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Review;

                    Message('Appraisal has been opened for Review');
                end;
            }
            action("Move to Next Review Period")
            {
                ApplicationArea = All;
                Caption = 'Move to Next Review Period';
                Image = Change;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Moves this appraisal from the current quarterly review period to the next one and copies the objective lines forward.';

                trigger OnAction()
                var
                    AppraisalProcessMgt: Codeunit "Appraisal Process Mgt.";
                begin
                    if Confirm('Move appraisal %1 from %2 to the next review period?', true, Rec."Appraisal No", Rec."Current Review Period Code") then begin
                        AppraisalProcessMgt.MoveToNextReviewPeriod(Rec);
                        CurrPage.Update(false);
                    end;
                end;
            }
            action("View Review History")
            {
                ApplicationArea = All;
                Caption = 'View Review History';
                Image = History;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Shows all quarterly objective and scoring lines for this appraisal.';

                trigger OnAction()
                var
                    AppraisalLine: Record "Appraisal Lines";
                begin
                    AppraisalLine.SetRange("Appraisal No", Rec."Appraisal No");
                    Commit();
                    Page.RunModal(Page::"Appraisal Review History", AppraisalLine);
                end;
            }
            action("View Comment History")
            {
                ApplicationArea = All;
                Caption = 'View Comment History';
                Image = History;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Shows period-specific and final appraisal comments for this appraisal.';

                trigger OnAction()
                var
                    AppraisalComment: Record "Appraisal Comments";
                begin
                    AppraisalComment.SetRange("Appraisal No.", Rec."Appraisal No");
                    Commit();
                    Page.RunModal(Page::"Appraisal Comment History", AppraisalComment);
                end;
            }
            action("Related Grievances")
            {
                ApplicationArea = All;
                Caption = 'Related Grievances';
                Image = List;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Shows incidence and grievance records for this appraisee during the current review period.';

                trigger OnAction()
                var
                    AppraisalRelatedHRMgt: Codeunit "Appraisal Related HR Mgt.";
                begin
                    Commit();
                    AppraisalRelatedHRMgt.OpenRelatedGrievances(Rec);
                end;
            }
            action("Related Disciplinary Cases")
            {
                ApplicationArea = All;
                Caption = 'Related Disciplinary Cases';
                Image = List;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Shows staff disciplinary and misconduct records for this appraisee during the current review period.';

                trigger OnAction()
                var
                    AppraisalRelatedHRMgt: Codeunit "Appraisal Related HR Mgt.";
                begin
                    Commit();
                    AppraisalRelatedHRMgt.OpenRelatedDisciplinaryCases(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if Rec.EnsureEmployeeJobTitles() then
            Rec.Modify(false);

        HRManagement.UpdateAppraisalScores(Rec."Appraisal No", Rec."Employee No");
        CurrPage.Update();
    end;

    trigger OnOpenPage()
    begin
        HRManagement.UpdateAppraisalScores(Rec."Appraisal No", Rec."Employee No");
        CurrPage.Update();
    end;

    var
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
        HRManagement: Codeunit "HR Management";
}





