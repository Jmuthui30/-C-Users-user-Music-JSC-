page 51747 "SS Training Needs Header"
{
    // version THL- HRM 1.0
    Caption = 'New Training Needs Assesment';
    PageType = Card;
    SourceTable = "Training Needs Header";
    ApplicationArea = all;

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
                field("Need Source"; Rec."Need Source")
                {
                    ApplicationArea = All;
                    //Editable = false;
                    ToolTip = 'Specifies where this training needs assessment originated.';
                }
                field("Source Document No"; Rec."Source Document No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the source document, such as the appraisal number that created this assessment.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SaveHeaderAndSetLinesContext();
                    end;
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
                    visible = false;
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

                    trigger OnValidate()
                    begin
                        SaveHeaderAndSetLinesContext();
                    end;
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

                    trigger OnValidate()
                    begin
                        SaveHeaderAndSetLinesContext();
                    end;
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

                    trigger OnValidate()
                    begin
                        SaveHeaderAndSetLinesContext();
                    end;
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

                    trigger OnValidate()
                    begin
                        SaveHeaderAndSetLinesContext();
                    end;
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

                    trigger OnValidate()
                    begin
                        SaveHeaderAndSetLinesContext();
                    end;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
            part(Control25; "Training Needs Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."),
                              "Employee No." = FIELD("Employee No");
                UpdatePropagation = Both;
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

                trigger OnValidate()
                begin
                    SaveHeaderAndSetLinesContext();
                end;
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
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                var
                    TrainingNeedsHeader: Record "Training Needs Header";
                begin
                    CurrPage.SaveRecord();
                    TrainingNeedsHeader.SetRange("No.", Rec."No.");
                    Report.Run(Report::"Training Needs Form", true, false, TrainingNeedsHeader);
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
                ApplicationArea = All;

                trigger OnAction()
                begin
                    CurrPage.Update(true);
                    EnsureTrainingNeedLinesExist();
                    // if ApprovalsMgmt.checktr(Rec) then
                    ApprovalsMgmt.OnSendTrainingNeedsForApproval(Rec);
                    Commit();
                    message('Training Needs Assessment has been sent for approval successfully.');
                    CurrPage.Close();
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
        ApprovalsMgmt: Codeunit "Approvals Mgmt. Ext";

    trigger OnAfterGetCurrRecord()
    begin
        SetLinesHeaderContext();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status := Rec.Status::Open;
        Rec.Date := Today;
        SetLinesHeaderContext();
    end;

    local procedure SetLinesHeaderContext()
    begin
        CurrPage.Control25.Page.SetHeaderContext(Rec."No.", Rec."Employee No");
    end;

    local procedure EnsureTrainingNeedLinesExist()
    var
        EmployeeTrainingNeeds: Record "Employee Training Needs";
    begin
        Rec.TestField("No.");
        Rec.TestField("Employee No");

        LinkUnassignedTrainingNeedLines();

        EmployeeTrainingNeeds.SetRange("Document No.", Rec."No.");
        EmployeeTrainingNeeds.SetRange("Employee No.", Rec."Employee No");
        if EmployeeTrainingNeeds.IsEmpty then
            Error('Add at least one training need line before sending this assessment for approval.');
    end;

    local procedure LinkUnassignedTrainingNeedLines()
    var
        EmployeeTrainingNeeds: Record "Employee Training Needs";
    begin
        EmployeeTrainingNeeds.SetRange("Employee No.", Rec."Employee No");
        EmployeeTrainingNeeds.SetRange("Document No.", '');
        if EmployeeTrainingNeeds.FindSet(true) then
            repeat
                EmployeeTrainingNeeds."Document No." := Rec."No.";
                EmployeeTrainingNeeds.Modify(true);
            until EmployeeTrainingNeeds.Next() = 0;
    end;

    local procedure SaveHeaderAndSetLinesContext()
    begin
        CurrPage.Update(true);
        SetLinesHeaderContext();
    end;
}
