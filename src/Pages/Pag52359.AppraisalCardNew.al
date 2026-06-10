page 52359 "Appraisal Card-New"
{
    ApplicationArea = All;
    Caption = 'Appraisal Card New II';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Review,Approvals';
    SourceTable = "Employee Appraisal";
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not OpenApprovalEntriesExist;
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Caption = 'Appraisal No';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Appraisal No field';
                }
                group("Period Under Review:")
                {
                    field("Appraisal Period"; Rec."Appraisal Period")
                    {
                        ToolTip = 'Specifies the value of the Appraisal Period field';
                    }
                    field("Period Start"; Rec."Period Start")
                    {
                        Caption = 'From';
                        Editable = false;
                        ToolTip = 'Specifies the value of the From field';
                    }
                    field("Period End"; Rec."Period End")
                    {
                        Caption = 'To';
                        Editable = false;
                        ToolTip = 'Specifies the value of the To field';
                    }
                    field(AppraisalType; Rec.AppraisalType)
                    {
                        ToolTip = 'Specifies the value of the Appraisal Type field';
                        Visible = false;

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

                }
                group("Personal Details")
                {
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
                    field("Responsibilty Center"; Rec."Responsibilty Center")
                    {
                        ToolTip = 'Specifies the value of the Responsibilty Center field.';
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
                }
                group("Appraiser:")
                {
                    field("Appraiser No"; Rec."Appraiser No")
                    {
                        ToolTip = 'Specifies the value of the Appraiser No field';
                    }
                    field("Appraiser ID"; Rec."Appraiser ID")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraiser ID field';
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
                }
                group("Performance Score")
                {
                    field("Total Weighting"; Rec."Total Weighting")
                    {
                        ToolTip = 'Specifies the value of the Total Weighting field';
                    }
                    field("Current Review Score"; Rec."Current Review Score")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the calculated score for the current review period.';
                    }
                    field("Total Review Score"; Rec."Total Review Score")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the total score across appraisal review lines.';
                    }
                    /*group(Control39)
                    {
                        ShowCaption = false;
                        Visible = "Type" = "Type"::"Mid-Year";
                        field("Total Mid-Year"; "Total Mid-Year")
                        {
                        }
                    }
                    group(Control44)
                    {
                        ShowCaption = false;
                        Visible = "Type" = "Type"::"Final Year";
                        field("Total Final Self"; "Total Final Self")
                        {
                        }
                        field("Total Final Rating"; "Total Final Rating")
                        {
                        }
                    }
                    */
                    field(Status; Rec.Status)
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Status field';

                        trigger OnValidate()
                        begin
                            //SetControlAppearance;
                        end;
                    }
                    field("Appraisal Status"; Rec."Appraisal Status")
                    {
                        Visible = false;
                        ToolTip = 'Specifies the value of the Appraisal Status field';

                        trigger OnValidate()
                        begin
                            //SetControlAppearance;
                        end;
                    }
                }
            }
            part(Control12; "Appraisal Goals")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No"),
                              "Review Period Code" = field("Current Review Period Code");
                UpdatePropagation = Both;
            }
            part(Control13; "Appraisal Goals Self")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No");
                UpdatePropagation = Both;
                Visible = false;
            }
            part("Substantial Achievements"; "Second Supervisor Comments")
            {
                Caption = '1';
                Editable = not UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No"),
                              "Review Period Code" = field("Current Review Period Code");
                SubPageView = where(Person = const("Substantial Achievements"));
                Visible = UnderReview;
            }
            part("Significant issues that affected Performance during the period (positive)"; "Second Supervisor Comments")
            {
                Caption = '2';
                Editable = not UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No"),
                              "Review Period Code" = field("Current Review Period Code");
                SubPageView = where(Person = const("Significant Positive Issues"));
                Visible = UnderReview;
            }
            part("Significant issues that affected Performance during the period (negative)"; "Second Supervisor Comments")
            {
                Caption = '3';
                Editable = not UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No"),
                              "Review Period Code" = field("Current Review Period Code");
                SubPageView = where(Person = const("Significant Negative Issues"));
                Visible = UnderReview;
            }

            part("Appraisee's Appraisal Comments On The Performance Appraisal"; "Appraisee's Appraisal Comments")
            {
                Caption = 'Appraisee''s Appraisal Comments On The Performance Appraisal';
                //Editable = not UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter(Appraisee));
                Visible = FinalReviewVisible;
            }
            part("Appraiser's Comments On The Performance Appraisal"; "Second Supervisor Comments")
            {
                Caption = 'Appraiser''s Comments On The Performance Appraisal';
                //Editable = not UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter(Appraiser));
                Visible = FinalReviewVisible;
            }
            part("Departmental Head's Comments (If not the APPRAISER)"; "Second Supervisor Comments")
            {
                Caption = 'Departmental Head''s Comments (If not the APPRAISER)';
                //Editable = not OpenApprovalEntriesExist;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Second Supervisor"));
                Visible = FinalReviewVisible;
            }
            part("Trust Secretary's Comments"; "Second Supervisor Comments")
            {
                Caption = 'CEO''s Comments';
                Enabled = not OpenApprovalEntriesExist;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Trust Secretary"));
                Visible = FinalReviewVisible;
            }
            part("Developmental Action To Be Taken"; "Second Supervisor Comments")
            {
                Caption = 'Developmental Action To Be Taken';
                Enabled = not OpenApprovalEntriesExist;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Dev Action"));
                Visible = FinalReviewVisible;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Print Objectives")
            {
                Visible = false;
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Print Objectives action';

                trigger OnAction()
                begin
                    Clear(EmployeeObjectives);
                    EmployeeApp.Reset();
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    EmployeeObjectives.SetTableView(EmployeeApp);
                    Commit();
                    EmployeeObjectives.RunModal();
                end;
            }
            action("Print Score Card")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Print Objectives action';

                trigger OnAction()
                begin
                    Clear(AppraisalScoreCard);
                    EmployeeApp.Reset();
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    AppraisalScoreCard.SetTableView(EmployeeApp);
                    Commit();
                    AppraisalScoreCard.RunModal();
                end;
            }
            separator(Action34)
            {
            }
            action("Send For Approval")
            {
                Caption = 'Submit for Review';
                Enabled = not OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Submits the appraisal for review.';

                trigger OnAction()
                begin
                    // Ensure required fields are set
                    AppraisalProcessMgt.ValidateAppraiseeSubmission(Rec);

                    // Check if workflow is enabled and initiate approval
                    if ApprovalsMgmt.CheckNewEmpAppraisalWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendNewEmpAppraisalRequestforApproval(Rec);

                    // Refresh Rec from the DB to avoid stale record error
                    if not Rec.Get(Rec."Appraisal No") then
                        Error('The appraisal record %1 no longer exists.', Rec."Appraisal No");

                    // now Rec is fresh, you can safely update fields or modify
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Set;
                    Commit();
                    Rec.Modify();
                    Message('Appraisal sent for review successfully');
                    CurrPage.Close();
                end;

            }

            // action("Send For Approval")
            // {
            //     Caption = 'Send For Review';
            //     Enabled = not OpenApprovalEntriesExist;
            //     Image = SendApprovalRequest;
            //     Promoted = true;
            //     PromotedCategory = Category5;
            //     PromotedIsBig = true;
            //     ToolTip = 'Executes the Send For Review action';

            //     trigger OnAction()
            //     begin
            //         //CalcFields("Total Final Self", "Total Mid-Year", "Total Weighting");
            //         /*IF (("Total Final Self" <= 0) OR ("Total Mid-Year" <= 0) OR ("Total Weighting" <= 0)) THEN
            //           ERROR('Kindly define appraisal goals');*/

            //         Rec.TestField("Appraisal Period");
            //         Rec.TestField("Employee No");
            //         Rec.TestField("Appraiser No");

            //         if ApprovalsMgmt.CheckNewEmpAppraisalWorkflowEnabled(Rec) then
            //             ApprovalsMgmt.OnSendNewEmpAppraisalRequestforApproval(Rec);
            //         Rec."Appraisal Status" := Rec."Appraisal Status"::Review;
            //         // WorkflowResponses.ReleaseEmployeeAppraisalRequest(Rec);
            //         // Message('Approved Successfully');
            //         if Rec.Status = Rec.Status::Released then
            //             Rec."Appraisal Status" := Rec."Appraisal Status"::Completed;

            //         Commit();
            //         //CurrPage.Close();

            //     end;
            // }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Review Request';
                Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Review Request action';

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelNewEmpAppraisalRequestApproval(Rec);
                    Commit();
                    CurrPage.Close();
                end;
            }
            action(ViewApprovals)
            {
                Visible = false;
                Caption = 'View Review Approvals';
                Image = Approval;
                Promoted = true;
                PromotedCategory = Category5;
                ToolTip = 'Shows review approval entries for this appraisal.';

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    ApprovalEntries: Page "Approval Entries";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetCurrentKey("Document No.");
                    ApprovalEntry.SetRange("Document No.", Rec."Appraisal No");
                    ApprovalEntries.SetTableView(ApprovalEntry);
                    ApprovalEntries.LookupMode(true);
                    ApprovalEntries.Run();
                end;
            }
            separator(Action35)
            {
            }
            action("Lock Performance")
            {
                Image = CheckJournal;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;
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
                Visible = false;
                ToolTip = 'Executes the Review Targets action';

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Review;

                    Message('Appraisal has been opened for Review');
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
                    AppraisalRelatedHRMgt.OpenRelatedDisciplinaryCases(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // HRManagement.UpdateAppraisalScores("Appraisal No","Employee No");
        // CurrPage.UPDATE;
        if Rec.EnsureEmployeeJobTitles() then
            Rec.Modify(false);

        SetControlAppearance();
    end;

    trigger OnOpenPage()
    begin
        //HRManagement.UpdateAppraisalScores("Appraisal No","Employee No");
        //CurrPage.UPDATE;
        SetControlAppearance();
    end;

    var
        EmployeeApp: Record "Employee Appraisal";
        EmployeeAppraisals: Report "Employee Appraisal - New";
        AppraisalScoreCard: Report "Employee Appraisal Scorecard";
        EmployeeObjectives: Report "Employee Objectives - New";
        AppraisalProcessMgt: Codeunit "Appraisal Process Mgt.";
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
        CanCancelApprovalForRecord: Boolean;
        DocReleased: Boolean;
        FinalReviewVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        UnderReview: Boolean;

    local procedure SetControlAppearance()
    var
        App2: Codeunit "Approvals Mgmt.";

    begin
        FinalReviewVisible := IsCurrentFinalReviewPeriod();

        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := App2.CanCancelApprovalForRecord(Rec.RecordId);

        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;

        if Rec."Appraisal Status" = Rec."Appraisal Status"::Review then
            UnderReview := true
        else
            UnderReview := false;
    end;

    local procedure IsCurrentFinalReviewPeriod(): Boolean
    var
        ReviewPeriod: Record "Bal Score Preview Periods";
    begin
        if Rec."Current Review Period Code" = '' then
            exit(false);

        if not ReviewPeriod.Get(Rec."Current Review Period Code") then
            exit(false);

        exit(ReviewPeriod."Final Review Period");
    end;
}
