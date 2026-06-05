page 51754 "Training Needs List-Approved"
{
    // version THL- HRM 1.0
    Caption = 'Reviewed Training Needs';
    CardPageID = "Training Needs Header Approved";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Training Needs Header";
    SourceTableView = where(Status = const(Released));

    layout
    {
        area(content)
        {
            repeater(General)
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
                field("Need Source"; Rec."Need Source")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies where this training needs assessment originated.';
                }
                field("Source Document No"; Rec."Source Document No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the source document, such as the appraisal number that created this assessment.';
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the approval status of the training needs assessment.';
                }
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
            action("Create Training Need")
            {
                ApplicationArea = All;
                Caption = 'Create Training Need';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Create the master training need used for planning, budgeting, scheduling, and applications.';

                trigger OnAction()
                var
                    TrainingNeed: Record "Training Need";
                begin
                    TrainingNeed.SetRange("Source Assessment No.", Rec."No.");
                    if TrainingNeed.FindFirst() then begin
                        Page.Run(Page::"Training Need", TrainingNeed);
                        exit;
                    end;

                    TrainingNeed.Init();
                    TrainingNeed.Description := CopyStr(Rec."Required Skills", 1, MaxStrLen(TrainingNeed.Description));
                    if TrainingNeed.Description = '' then
                        TrainingNeed.Description := CopyStr(Rec."Missing Competencies", 1, MaxStrLen(TrainingNeed.Description));
                    if TrainingNeed.Description = '' then
                        TrainingNeed.Description := CopyStr('Training need for ' + Rec."Employee Name", 1, MaxStrLen(TrainingNeed.Description));
                    TrainingNeed."Training Objectives" := CopyStr(Rec."Required Skills", 1, MaxStrLen(TrainingNeed."Training Objectives"));
                    if TrainingNeed."Training Objectives" = '' then
                        TrainingNeed."Training Objectives" := CopyStr(Rec."Missing Competencies", 1, MaxStrLen(TrainingNeed."Training Objectives"));
                    TrainingNeed."Need Source" := Rec."Need Source";
                    TrainingNeed."Shortcut Dimension 1 Code" := Rec."Global Dimension 1 Code";
                    TrainingNeed."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                    TrainingNeed."Source Assessment No." := Rec."No.";
                    TrainingNeed."Applicant Type" := TrainingNeed."Applicant Type"::Individual;
                    TrainingNeed.Status := TrainingNeed.Status::Open;
                    TrainingNeed.Insert(true);
                    Page.Run(Page::"Training Need", TrainingNeed);
                end;
            }
        }
    }
}
