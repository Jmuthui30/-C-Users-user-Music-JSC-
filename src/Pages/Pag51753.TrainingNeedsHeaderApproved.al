page 51753 "Training Needs Header Approved"
{
    // version THL- HRM 1.0
    Caption = 'Reviewed Training Needs';
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
                field("Need Source"; Rec."Need Source")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Brief Description of Job Function:";'')
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
                field("Current Employee Skills (Strength):";'')
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
                field("Missing/Deficient Competencies (Weakness):";'')
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
                field("Required Skills to Address the Missing Competencies (Weakness):";'')
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
                field("Comments by Departmental Head";'')
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
                SubPageLink = "Document No." = FIELD("No."),
                              "Employee No." = FIELD("Employee No");
                UpdatePropagation = Both;
            }
            field("Comments by HR Manager:";'')
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
                    Rec.SetRange(Rec."No.", Rec."No.");
                    REPORT.Run(51608, true, false, Rec);
                end;
            }
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
                    CreateOriginatingParticipant(TrainingNeed.Code);
                    Page.Run(Page::"Training Need", TrainingNeed);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.Control25.Page.SetHeaderContext(Rec."No.", Rec."Employee No");
    end;

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

    local procedure CreateOriginatingParticipant(TrainingNeedCode: Code[20])
    var
        TrainingParticipant: Record "Training Participants";
    begin
        if Rec."Employee No" = '' then
            exit;

        TrainingParticipant.SetRange("Training Need", TrainingNeedCode);
        TrainingParticipant.SetRange("Employee No", Rec."Employee No");
        if TrainingParticipant.FindFirst() then
            exit;

        TrainingParticipant.Init();
        TrainingParticipant."Training Need" := TrainingNeedCode;
        TrainingParticipant.Code := CopyStr(Rec."Employee No", 1, MaxStrLen(TrainingParticipant.Code));
        TrainingParticipant.Validate("Employee No", Rec."Employee No");
        TrainingParticipant.Insert(true);
    end;
}
