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
                    TrainingNeed.Description := GetTrainingNeedDescription();
                    TrainingNeed."Training Objectives" := GetTrainingNeedObjectives();
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

    local procedure GetTrainingNeedDescription(): Text[200]
    var
        EmployeeTrainingNeeds: Record "Employee Training Needs";
        DescriptionText: Text;
    begin
        DescriptionText := Rec."Required Skills";
        if DescriptionText = '' then
            DescriptionText := Rec."Missing Competencies";

        if DescriptionText = '' then begin
            EmployeeTrainingNeeds.SetRange("Document No.", Rec."No.");
            EmployeeTrainingNeeds.SetRange("Employee No.", Rec."Employee No");
            if EmployeeTrainingNeeds.FindFirst() then
                DescriptionText := EmployeeTrainingNeeds.Description;
        end;

        if DescriptionText = '' then
            DescriptionText := 'Training need for ' + Rec."Employee Name";

        exit(CopyStr(DescriptionText, 1, 200));
    end;

    local procedure GetTrainingNeedObjectives(): Text[250]
    var
        EmployeeTrainingNeeds: Record "Employee Training Needs";
        Summary: Text;
    begin
        AddSummaryPart(Summary, 'Required skills', Rec."Required Skills");
        AddSummaryPart(Summary, 'Missing competencies', Rec."Missing Competencies");
        AddSummaryPart(Summary, 'Job function', Rec."Job Function");
        AddSummaryPart(Summary, 'Current skills', Rec."Current Employee Skills");
        AddSummaryPart(Summary, 'HOD comments', Rec.Comments1);
        AddSummaryPart(Summary, 'HR comments', Rec.Comments2);

        EmployeeTrainingNeeds.SetRange("Document No.", Rec."No.");
        EmployeeTrainingNeeds.SetRange("Employee No.", Rec."Employee No");
        if EmployeeTrainingNeeds.FindSet() then
            repeat
                AddSummaryPart(Summary, 'Assessment line', EmployeeTrainingNeeds.Description);
            until EmployeeTrainingNeeds.Next() = 0;

        exit(CopyStr(Summary, 1, 250));
    end;

    local procedure AddSummaryPart(var Summary: Text; Caption: Text; Value: Text)
    begin
        if Value = '' then
            exit;

        if Summary <> '' then
            Summary += ' | ';

        Summary += Caption + ': ' + Value;
    end;
}
