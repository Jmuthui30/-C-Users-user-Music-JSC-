page 51773 "Section D Responses"
{
    // version THL- HRM 1.0
    Caption = 'New Appraisal Form';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Performance Appraisal";
    SourceTableView = WHERE(Status=CONST(Open));

    layout
    {
        area(content)
        {
            group("Appraisee Details")
            {
                Editable = false;

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
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
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
                field(Manager; Rec.Manager)
                {
                    ApplicationArea = All;
                }
                field("Manager's Name"; Rec."Manager's Name")
                {
                    ApplicationArea = All;
                }
            }
            group("Appraisal Details")
            {
                Editable = false;

                field("Review Start Date"; Rec."Review Start Date")
                {
                    ApplicationArea = All;
                }
                field("Review End Date"; Rec."Review End Date")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Review)
            {
                field("1st Quarter Score"; Rec."1st Quarter Score")
                {
                    ApplicationArea = All;
                }
                field("2nd Quarter Score"; Rec."2nd Quarter Score")
                {
                    ApplicationArea = All;
                }
                field(Total; Rec.Total)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Grade Score"; Rec."Grade Score")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control18; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Fetch Deliverables")
            {
                ApplicationArea = All;
                Image = Suggest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Qualitative.Reset;
                    Qualitative.SetFilter("Global Dimension 1 Code", '%1|%2', Rec."Global Dimension 1 Code", '');
                    Qualitative.SetFilter("Global Dimension 2 Code", '%1|%2', Rec."Global Dimension 2 Code", '');
                    Qualitative.SetFilter("Global Dimension 3 Code", '%1|%2', Rec."Global Dimension 3 Code", '');
                    if Qualitative.FindSet then begin
                        repeat QualitativeResponse.Init;
                            QualitativeResponse."Employee No":=Rec."Employee No";
                            QualitativeResponse."Review Start Date":=Rec."Review Start Date";
                            QualitativeResponse."Review End Date":=Rec."Review End Date";
                            QualitativeResponse."No.":=Qualitative."No.";
                            QualitativeResponse."Focus Area":=Qualitative."Focus Area";
                            QualitativeResponse.Deliverable:=Qualitative.Description;
                            QualitativeResponse.Section:=Qualitative.Section::C;
                            if not QualitativeResponse.Get(Rec."Employee No", Rec."Review Start Date", Rec."Review End Date", Qualitative."No.")then QualitativeResponse.Insert;
                        until Qualitative.Next = 0;
                    end;
                    Message('Complete');
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        PerformanceMgt.InitializeQuestions(Rec);
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange("Created By", UserId);
    end;
    var PerformanceMgt: Codeunit "Performance Management";
    Text000: Label 'You are about to give your responses to the appraisal questions. Kindly note that you cannot abort this process once you start. Do you wish to continue?';
    Text001: Label 'Aborted Successfully';
    ApprovalsMgt: Codeunit "Approvals Mgmt.";
    Qualitative: Record "Qualitative Deliverables";
    QualitativeResponse: Record "Appraisal Qualitative Details";
}
