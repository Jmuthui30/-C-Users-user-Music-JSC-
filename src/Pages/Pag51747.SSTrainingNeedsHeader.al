page 51747 "SS Training Needs Header"
{
    // version THL- HRM 1.0
    Caption = 'New Training Needs Assesment';
    PageType = Card;
    SourceTable = "Training Needs Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Comfirmation Status"; Rec."Comfirmation Status")
                {
                    ApplicationArea = All;
                }
                field("Grade Level"; Rec."Grade Level")
                {
                    ApplicationArea = All;
                }
                field("Date of Last Training"; Rec."Date of Last Training")
                {
                    ApplicationArea = All;
                }
                field("No of Months/Years in Job"; Rec."No of Months/Years in Job")
                {
                    ApplicationArea = All;
                }
                field("Brief Description of Job Function:"; '')
                {
                    ApplicationArea = All;
                    Caption = 'Brief Description of Job Function:';
                }
                field("Job Function"; Rec."Job Function")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                }
                field("Current Employee Skills (Strength):"; '')
                {
                    ApplicationArea = All;
                    Caption = 'Current Employee Skills (Strength):';
                }
                field("Current Employee Skills"; Rec."Current Employee Skills")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                }
                field("Missing/Deficient Competencies (Weakness):"; '')
                {
                    ApplicationArea = All;
                    Caption = 'Missing/Deficient Competencies (Weakness):';
                }
                field("Missing Competencies"; Rec."Missing Competencies")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                }
                field("Required Skills to Address the Missing Competencies (Weakness):"; '')
                {
                    ApplicationArea = All;
                    Caption = 'Required Skills to Address the Missing Competencies (Weakness):';
                }
                field("Required Skills"; Rec."Required Skills")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                }
                field("Comments by Departmental Head"; '')
                {
                    ApplicationArea = All;
                    Caption = 'Comments by Departmental Head';
                }
                field(Comments1; Rec.Comments1)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                }
            }
            part(Control25; "Training Needs Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No." = FIELD("Employee No");
            }
            field("Comments by HR Manager:"; '')
            {
                ApplicationArea = All;
                Caption = 'Comments by HR Manager:';
            }
            field(Comments2; Rec.Comments2)
            {
                ApplicationArea = All;
                MultiLine = true;
                ShowCaption = false;
            }
        }
        area(factboxes)
        {
            systempart(Control24; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Needs Assesment Form")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(51608, true, false, Rec);
                end;
            }

            action("Send For Approval")
            {
                // Enabled = not OpenApprovalEntriesExist;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Send For Approval action';

                trigger OnAction()
                begin

                    if ApprovalsMgmt.CheckTrainingRequestWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendTrainingRequestforApproval(Rec);
                        Commit();
                end;
            }
            action("Cancel Approval Request")
            {
                // Enabled = CanCancelApprovalForRecord;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    // ApprovalsMgmt.OnCancelTrainingRequestApproval(Rec);
                end;
            }
            // action("View Approvals")
            // {
            //     Image = Approvals;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     ToolTip = 'Executes the View Approvals action';

            //     trigger OnAction()
            //     var
            //         ApprovalEntries: Page "Approval Entries";
            //         DocumentType: Enum "Approval Document Type";
            //     begin

            //         DocumentType := DocumentType::TrainingRequest;
            //         ApprovalEntries.SetRecordFilters(Database::"Training Request", DocumentType, Rec."Request No.");
            //         ApprovalEntries.Run();
            //     end;
            // }

        }
    }
    var
    ApprovalsMgmt:Codeunit "Approval Mgt HR Ext";
}