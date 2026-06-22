page 52358 "Appraisal Card-Review"
{
    ApplicationArea = All;
    DelayedInsert = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Review,Approvals';
    SourceTable = "Employee Appraisal";
    Caption = 'Appraisal Card-Review';
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not OpenApprovalEntriesExist;
                Caption = 'General';
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
                group("Period Under Review:")
                {
                    Caption = 'Period Under Review:';
                    field("Appraisal Period"; Rec."Appraisal Period")
                    {
                        ToolTip = 'Specifies the value of the Appraisal Period field';
                        Caption = 'Appraisal Period';
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
                    field("Appraisal Type"; Rec.AppraisalType)
                    {
                        ToolTip = 'Specifies the value of the Appraisal Type field';
                        Caption = 'Appraisal Type';
                        Visible = false;
                    }
                    field("Appraisal Type Description"; Rec."Appraisal Type Description")
                    {
                        ToolTip = 'Specifies the value of the Appraisal Type Description field';
                        Caption = 'Appraisal Type Description';
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
                    Caption = 'Personal Details';
                    field("Employee No"; Rec."Employee No")
                    {
                        Caption = 'Appraisee No';
                        ToolTip = 'Specifies the value of the Appraisee No field';
                    }
                    field("Appraisee Name"; Rec."Appraisee Name")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraisee Name field';
                        Caption = 'Appraisee Name';
                    }
                    field("Appraisee's Job Title"; Rec."Appraisee's Job Title")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraisee''s Job Title field';
                        Caption = 'Appraisee''s Job Title';
                    }
                    field("Job Grade"; Rec."Job Group")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Job Group field';
                        Caption = 'Job Group';
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
                    Caption = 'Appraiser:';
                    field("Appraiser No"; Rec."Appraiser No")
                    {
                        ToolTip = 'Specifies the value of the Appraiser No field';
                        Caption = 'Appraiser No / Reporting To';
                    }
                    field("Appraiser ID"; Rec."Appraiser ID")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraiser ID field';
                        Caption = 'Appraiser ID';
                    }
                    field("Appraisers Name"; Rec."Appraisers Name")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraisers Name field';
                        Caption = 'Appraisers Name';
                    }
                    field("Appraiser's Job Title"; Rec."Appraiser's Job Title")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraiser''s Job Title field';
                        Caption = 'Appraiser''s Job Title';
                    }
                }
                group("Performance Score")
                {
                    Caption = 'Performance Score';
                    field("Total Weighting"; Rec."Total Weighting")
                    {
                        ToolTip = 'Specifies the value of the Total Weighting field';
                        Caption = 'Total Weighting';
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
                    group(Control46)
                    {
                        ShowCaption = false;
                        // Caption = 'Control46';
                        // field("Total Mid-Year Rating"; Rec."Total Mid-Year")
                        // {
                        //     ToolTip = 'Specifies the value of the Total Mid-Year field';
                        //     Caption = 'Total Mid-Year';
                        // }
                        field("Total Final Year Rating"; Rec."Total FY Rating")
                        {
                            Visible = FinalVisible;
                            ToolTip = 'Specifies the value of the Total FY Rating field';
                            Caption = 'Total Rating';
                        }
                        field("Final Year Percentage Score"; Rec."Total Percentage FY Rating")
                        {
                            Visible = FinalVisible;
                            ToolTip = 'Specifies the value of the Total percentage score field';
                            Caption = 'Total percentage score';
                        }
                        field("Final Year Grade"; Rec."Grade final year rating")
                        {
                            Visible = FinalVisible;
                            ToolTip = 'Specifies the value of the Perfomance grade field';
                            Caption = 'Perfomance grade';
                        }
                        field("Total score(Appraisal goals + Attributes"; Rec."Total score")
                        {
                            Visible = FinalVisible;
                            ToolTip = 'Specifies the value of the Total score field';
                            Caption = 'Total score';
                        }
                    }
                    /*group(Control12)
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
                        Caption = 'Status';

                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                        end;
                    }
                    field("Appraisal Status"; Rec."Appraisal Status")
                    {
                        Editable = false;
                        ToolTip = 'Specifies the value of the Appraisal Status field';
                        Caption = 'Appraisal Status';

                        trigger OnValidate()
                        begin
                            SetControlAppearance();
                        end;
                    }
                }
            }
            group("Do We Agree?")
            {
                field("Appraisee Agreed"; Rec."Appraisee Agreed")
                {
                    ApplicationArea = All;
                    Editable = ReviewActionsEnabled;
                    ToolTip = 'Specifies the value of the Appraisee Agreed field.';
                }
                field("Appraiser Agreed"; Rec."Appraiser Agreed")
                {
                    ApplicationArea = All;
                    Editable = ReviewActionsEnabled;
                    ToolTip = 'Specifies the value of the Appraiser Agreed field.';
                }
            }
            part(Control8; "Appraisal Goals")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No"),
                              "Review Period Code" = field("Current Review Period Code");
                UpdatePropagation = Both;
                Caption = 'Appraisal Goals';

            }
            part(Control9; "Appraisal Goals Self")
            {
                SubPageLink = "Appraisal No" = field("Appraisal No");
                UpdatePropagation = Both;
                Visible = false;
                Caption = 'Appraisal Goals Self';
            }
            part("Substantial Achievements"; "Appraisee's Appraisal Comments")
            {
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No"),
                              "Review Period Code" = field("Current Review Period Code");
                SubPageView = where(Person = const("Substantial Achievements"));

                Caption = 'Substantial Achievements';
            }
            part("Significant issues that affected Performance during the period (positive)"; "Appraisee's Appraisal Comments")
            {
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No"),
                              "Review Period Code" = field("Current Review Period Code");
                SubPageView = where(Person = const("Significant Positive Issues"));

                Visible = true;
                Caption = 'Significant issues that affected Performance during the period (positive)';
            }
            part("Significant issues that affected Performance during the period (negative)"; "Appraisee's Appraisal Comments")
            {
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No"),
                              "Review Period Code" = field("Current Review Period Code");
                SubPageView = where(Person = const("Significant Negative Issues"));

                Visible = true;
                Caption = 'Significant issues that affected Performance during the period (negative)';
            }
            part("WorkRelatedAttributes"; "Appraisal work related attr")
            {
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                Visible = FinalVisible;
                UpdatePropagation = both;
                Caption = 'Work Related Attributes';
            }
            field("Total Rating"; Rec."Total FY Attributes")
            {
                Visible = FinalVisible;
                ToolTip = 'Specifies the value of the Total rating field';
                Caption = 'Total rating';
            }
            field("Expected Rating"; Rec."Expected TR -attributes")
            {
                Visible = FinalVisible;
                ToolTip = 'Specifies the value of the Expected TR -attributes field';
                Caption = 'Expected TR -attributes';
            }
            field("Total Percentage Score"; Rec."Total Percentage-Attributes")
            {
                Visible = FinalVisible;
                ToolTip = 'Specifies the value of the Total percentage score field';
                Caption = 'Total percentage score';
            }
            field("Grade"; Rec."Grade-Attributes")
            {
                Visible = FinalVisible;
                ToolTip = 'Specifies the value of the Perfomance grade field';
                Caption = 'Perfomance grade';
            }

            label("SECTION V:  PERFORMANCE IMPROVEMENT PLAN/PROGRAMME")
            {
                Style = Strong;
                StyleExpr = true;
                Visible = FinalVisible;
                Caption = 'SECTION V:  PERFORMANCE IMPROVEMENT PLAN/PROGRAMME';
            }
            part("PerfomanceImprovement"; "Second Supervisor Comments")
            {
                Caption = 'To be completed jointly, by the Appraisee and the Appraiser at the end of the appraisal period (Comment on appropriate performance improvement plan e.g. training, job rotation, appropriate placement, counselling, etc)';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = const("Perfomance Improvement Plan"));

                Visible = FinalVisible;
            }
            label("SECTION VI:  STAFF TRAINING AND DEVELOPMENT NEEDS")
            {
                Style = Strong;
                StyleExpr = true;
                Visible = FinalVisible;
                Caption = 'SECTION VI:  STAFF TRAINING AND DEVELOPMENT NEEDS';
            }
            part("StaffTraining"; "Second Supervisor Comments")
            {
                Caption = 'Appraisee Training and Development needs in order of priority as identified by appraisee and supervisor based on performance gaps to be completed jointly at the end of the appraisal period.';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = const("Staff Training and Dev Needs"));

                Visible = FinalVisible;
            }
            part("Appraisee's Appraisal Comments On The Performance Appraisal"; "Appraisee's Appraisal Comments")
            {
                Caption = 'Appraisee''s Appraisal Comments On The Performance Appraisal';
                //Editable = NOT UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter(Appraisee));

                Visible = FinalVisible;
            }
            part("Appraiser's Comments On The Performance Appraisal"; "HR Appraisal Comments")
            {
                Caption = 'Appraiser''s Comments On The Performance Appraisal';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter(Appraiser));

                Visible = FinalVisible;
            }
            label("SECTION VI:  COMMENTS BY THE HEAD OF DEPARTMENT")
            {
                Style = Strong;
                StyleExpr = true;
                Visible = FinalVisible;
                Caption = 'SECTION VI:  COMMENTS BY THE HEAD OF DEPARTMENT';
            }
            label("Please comment appropriately:")
            {
                Style = None;
                StyleExpr = false;
                Visible = FinalVisible;
                Caption = 'Please comment appropriately:';
            }
            part("HOD"; "HR Appraisal Comments")
            {
                Caption = 'HOD';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Second Supervisor"));

                Visible = FinalVisible;
            }
            label("SECTION VII:  HUMAN RESOURCES DEPARTMENT ")
            {
                Style = Strong;
                StyleExpr = true;
                Visible = FinalVisible;
                Caption = 'SECTION VII:  HUMAN RESOURCES DEPARTMENT ';
            }
            part("Other recommended interventions"; "HR Appraisal Comments")
            {
                Caption = 'Other recommended interventions';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("HR"));

                Visible = FinalVisible;
            }
            part("Recommendations"; "HR Appraisal Comments")
            {
                Caption = 'Recommendations';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Other interventions"));

                Visible = FinalVisible;
            }
            part("Mitigating Factors"; "HR Appraisal Comments")
            {
                Caption = 'Mitigating Factors';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Mitigating Factors"));

                Visible = FinalVisible;
            }
            part("Developmental Action To Be Taken"; "HR Appraisal Dev Actions")
            {
                Caption = 'Developmental Action To Be Taken';
                //Editable = UnderReview;
                SubPageLink = "Appraisal No." = field("Appraisal No");
                SubPageView = where(Person = filter("Dev Action"));

                Visible = FinalVisible;
            }
            part("Appraisal Outcomes"; "Appraisal Outcome Part")
            {
                ApplicationArea = All;
                SubPageLink = "Appraisal No." = field("Appraisal No"),
                              "Review Period Code" = field("Current Review Period Code");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Create a training need")
            {
                Caption = 'Create a Training need';
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Create a Training need action';
                trigger OnAction()
                var
                    TrainingNeedRequest: Record "Training Needs Header";
                begin
                    TrainingNeedRequest.SetRange("Source Document No", Rec."Appraisal No");
                    if TrainingNeedRequest.FindFirst() then begin
                        if TrainingNeedRequest."Employee No" <> Rec."Employee No" then begin
                            TrainingNeedRequest.Rename(TrainingNeedRequest."No.", TrainingNeedRequest."Source Document No", TrainingNeedRequest."Need Source", Rec."Employee No");
                            TrainingNeedRequest.Validate("Employee No");
                            TrainingNeedRequest.Modify(true);
                        end;
                        PAGE.RUN(page::"SS Training Needs Header", TrainingNeedRequest)
                    end else begin
                        TrainingNeedRequest.Reset();
                        TrainingNeedRequest.Init();
                        TrainingNeedRequest."No." := '';
                        TrainingNeedRequest."Source Document No" := Rec."Appraisal No";
                        TrainingNeedRequest."Need Source" := TrainingNeedRequest."Need Source"::Appraisal;
                        TrainingNeedRequest.Insert(true);
                        if TrainingNeedRequest."Employee No" <> Rec."Employee No" then
                            TrainingNeedRequest.Rename(TrainingNeedRequest."No.", TrainingNeedRequest."Source Document No", TrainingNeedRequest."Need Source", Rec."Employee No");
                        TrainingNeedRequest.Validate("Employee No");
                        TrainingNeedRequest."Source Document No" := Rec."Appraisal No";
                        TrainingNeedRequest."Need Source" := TrainingNeedRequest."Need Source"::Appraisal;
                        TrainingNeedRequest.Modify(true);
                        TrainingNeedRequest.SetRange("Source Document No", Rec."Appraisal No");
                        if TrainingNeedRequest.FindFirst() then
                            PAGE.RUN(page::"SS Training Needs Header", TrainingNeedRequest);
                    end;
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
            // action("Assign Bonus")
            // {
            //     Caption = 'Assign bonus';
            //     Image = SuggestCustomerBill;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     ToolTip = 'Executes the Assign bonus action';

            //     trigger OnAction()
            //     begin
            //         if Confirm('Are you sure?', false) = false then
            //             exit;

            //         AssignmentMatrixX.Reset();
            //         AssignmentMatrixX.SetRange("Employee No", Rec."Employee No");
            //         AssignmentMatrixX.SetRange(Type, AssignmentMatrixX.Type::Earning);
            //         AssignmentMatrixX.SetRange(Closed, false);
            //         Earnings.SetTableView(AssignmentMatrixX);
            //         Earnings.RunModal();
            //     end;
            // }
            action("Print Objectives")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Print Objectives action';
                Caption = 'Print Objectives';

                trigger OnAction()
                begin
                    Clear(EmployeeObjectives);
                    EmployeeApp.Reset();
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    EmployeeObjectives.SetTableView(EmployeeApp);
                    Commit();
                    EmployeeObjectives.RunModal();
                    //mjk
                end;
            }
            action("Print Appraisal Report")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Print Appraisal Report action';
                Caption = 'Print Appraisal Report';

                trigger OnAction()
                begin
                    Clear(EmployeeAppraisals);
                    EmployeeApp.Reset();
                    EmployeeApp.SetRange("Appraisal No", Rec."Appraisal No");
                    EmployeeAppraisals.SetTableView(EmployeeApp);
                    Commit();
                    EmployeeAppraisals.RunModal();
                end;
            }
            action("Print Score Card")
            {
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                ToolTip = 'Executes the Print Objectives action';
                Caption = 'Print Score Card';

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
                Caption = 'Request Further Review';
                Enabled = DocReleased;
                Visible = false;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Requests a further review for this appraisal.';

                trigger OnAction()
                begin
                    // if Status = Status::"Pending Approval" then
                    //     Error('Document already pending approval');

                    // if Status = Status::Completed then
                    //     Error('Appraisal is already complete');

                    // if ApprovalsMgmt.CheckNewEmpAppraisalWorkflowEnabled(Rec) then
                    //     ApprovalsMgmt.OnSendNewEmpAppraisalRequestforApproval(Rec);
                    Rec."Appraisal Status" := Rec."Appraisal Status"::"Further review";
                    Commit();
                    CurrPage.Close();
                end;
            }
            action("Return for review")
            {
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = (Rec."Appraisal Status" = Rec."Appraisal Status"::Completed) and (Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review");
                ToolTip = 'Executes the Return for review action';
                Caption = 'Return for review';

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Review;
                    Message('Appraisal has been returned to Review');
                end;
            }
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
                    ApprovalsMgmt.OnCancelEmployeeAppraisalApprovalRequest(Rec);
                    Commit();
                    CurrPage.Close();
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approval Entries';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ToolTip = 'Shows all approval entries for this appraisal.';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocumentType: Enum "Approval Document Type";
                begin

                    DocumentType := DocumentType::"Employee Appraisal";
                    ApprovalEntries.SetRecordFilters(DATABASE::"Employee Appraisal", DocumentType, Rec."Appraisal No");
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
                Caption = 'Lock Performance';

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
                Caption = 'Review Targets';

                trigger OnAction()
                begin
                    Rec."Appraisal Status" := Rec."Appraisal Status"::Review;

                    Message('Appraisal has been opened for Review');
                end;
            }
            action("Complete Appraisal")
            {
                Image = CompleteLine;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = FinalVisible;
                Enabled = ReviewActionsEnabled;
                ToolTip = 'Executes the Complete Appraisal action';
                Caption = 'Complete Appraisal';

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to complete this appraisal?', true) then begin
                        AppraisalProcessMgt.ValidateAppraiserCompletion(Rec);
                        AppraisalProcessMgt.CreateCurrentReviewSnapshot(Rec);
                        Rec."Appraisal Status" := Rec."Appraisal Status"::Completed;
                        Rec.Modify();
                    end;
                    CurrPage.Close();
                end;
            }
            action("Move to Next Review Period")
            {
                ApplicationArea = All;
                Caption = 'Move to Next Review Period';
                Image = Change;
                Promoted = true;
                PromotedCategory = Category4;
                Enabled = ReviewActionsEnabled;
                ToolTip = 'Moves this appraisal from the current quarterly review period to the next one and copies the objective lines forward.';

                trigger OnAction()
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
                ToolTip = 'Shows read-only snapshots for closed review periods on this appraisal.';

                trigger OnAction()
                begin
                    AppraisalProcessMgt.OpenReviewSnapshots(Rec);
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
            // action("Send to final year")
            // {
            //     Image = ChangePaymentTolerance;
            //     Promoted = true;
            //     PromotedCategory = Category4;
            //     PromotedIsBig = true;
            //     PromotedOnly = true;
            //     Visible = MidVisible;
            //     ToolTip = 'Executes the Send to final year action';
            //     Caption = 'Send to final year';
            //     trigger OnAction()
            //     begin
            //         if Rec.AppraisalType = Rec.AppraisalType::"Mid-Year" then HRManagement.SendToFinalYear(Rec);
            //         // IF AppraisalType = AppraisalType::Q2 THEN HRManagement.SendToQ3(Rec);
            //         // IF AppraisalType = AppraisalType::Q3 THEN HRManagement.SendToQ4(Rec);
            //     end;

            // }
            action(SendToFinal)
            {
                Caption = 'Send To Final Year Review';
                Enabled = UnderReview and MidVisible;
                Image = ChangePaymentTolerance;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;
                ToolTip = 'Executes the Send To Final Year Review action';

                trigger OnAction()
                begin
                    HRManagement.SendToFinalYearAppraisal(Rec);
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

        AppraisalProcessMgt.StampCurrentReviewCommentsForCurrentPeriod(Rec);
        SetControlAppearance();
        HRManagement.GetTotalRating(Rec);
    end;

    trigger OnOpenPage()
    begin
        //HRManagement.UpdateAppraisalScores("Appraisal No","Employee No");
        //CurrPage.UPDATE;
        AppraisalProcessMgt.StampCurrentReviewCommentsForCurrentPeriod(Rec);
        SetControlAppearance();
    end;

    var
        AssignmentMatrixX: Record "Client Payroll Matrix";
        EmployeeApp: Record "Employee Appraisal";
        EmployeeAppraisals: Report "Employee Appraisal - New";
        AppraisalScoreCard: Report "Employee Appraisal Scorecard";
        EmployeeObjectives: Report "Employee Objectives - New";
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
        AppraisalProcessMgt: Codeunit "Appraisal Process Mgt.";
        HRManagement: Codeunit "HR Management";
        Earnings: Page "Client Earnings";
        CanCancelApprovalForRecord: Boolean;
        DocReleased: Boolean;
        FinalVisible: Boolean;
        MidVisible: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ReviewActionsEnabled: Boolean;
        UnderReview: Boolean;

    local procedure SetControlAppearance()
    var
        App2: Codeunit "Approvals Mgmt.";

    begin
        FinalVisible := IsCurrentFinalReviewPeriod();
        ReviewActionsEnabled :=
            (Rec.Status = Rec.Status::Released) and
            ((Rec."Appraisal Status" = Rec."Appraisal Status"::Review) or
             (Rec."Appraisal Status" = Rec."Appraisal Status"::"Further review"));
        UnderReview := ReviewActionsEnabled;
        MidVisible := true;

        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := App2.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := App2.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := App2.CanCancelApprovalForRecord(Rec.RecordId);

        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;

        /*  if Rec."Appraisal Status" = Rec."Appraisal Status"::Review then
             UnderReview := true
         else
             UnderReview := false;

         if Rec."Appraisal Status" = Rec."Appraisal Status"::Completed then
             Completed := true
         else
             Completed := false;

         if Rec.AppraisalType = Rec.AppraisalType::"Final Year" then
             FinalVisible := true
         else
             FinalVisible := false;

         if Rec.AppraisalType = Rec.AppraisalType::"Mid-Year" then
             MidVisible := true
         else
             MidVisible := false; */

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
















