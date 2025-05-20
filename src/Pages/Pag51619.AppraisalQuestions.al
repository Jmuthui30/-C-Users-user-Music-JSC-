page 51619 "Appraisal Questions"
{
    // version THL- HRM 1.0
    CardPageID = "Appraisal Question Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Appraisal Questions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                }
                field("Further Explanation"; Rec."Further Explanation")
                {
                    ApplicationArea = All;
                }
                field("Question Type"; Rec."Question Type")
                {
                    ApplicationArea = All;
                }
                field("Sub-Question Instructions"; Rec."Sub-Question Instructions")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetCurrRecord()
    begin
        Rec.Validate("Question Type");
    end;
    trigger OnInit()
    begin
        ShowSubQuestions:=false;
    end;
    trigger OnOpenPage()
    begin
        ShowSubQuestions:=false;
    end;
    var ShowSubQuestions: Boolean;
}
