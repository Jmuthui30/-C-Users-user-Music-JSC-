page 51622 "Appraisal Question Card"
{
    // version THL- HRM 1.0
    Caption = 'Appraisal Question';
    PageType = Card;
    SourceTable = "Appraisal Questions";

    layout
    {
        area(content)
        {
            group("Appraisal Question")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'This is the question number or code.';
                }
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Type the main appraisal question to the appraisee here';
                }
                field("Further Explanation"; Rec."Further Explanation")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'If the space on Question is not sufficient, continue typing on this space';
                }
                field("Question Type"; Rec."Question Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Does this question has sub-parts like a), b), c)? The choose ''Has Sub-Questions" optiion';

                    trigger OnValidate()
                    begin
                        if Rec."Question Type" = Rec."Question Type"::"Has Sub-Questions" then ShowSubQuestions:=true
                        else
                            ShowSubQuestions:=false;
                        CurrPage.Update(true);
                    end;
                }
                field("Sub-Question Instructions"; Rec."Sub-Question Instructions")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Enter special instructions that guides the appraise in answering the sub questions';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Sub-Questions")
            {
                ApplicationArea = All;
                Image = Add;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Appraisal Sub-Questions";
                RunPageLink = "Main Question No."=FIELD("No.");
                Visible = ShowSubQuestions;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."Question Type" = Rec."Question Type"::"Has Sub-Questions" then ShowSubQuestions:=true
        else
            ShowSubQuestions:=false;
        CurrPage.Update(true);
    end;
    trigger OnInit()
    begin
        ShowSubQuestions:=false;
    end;
    trigger OnOpenPage()
    begin
        Rec.Validate("Question Type");
    end;
    var ShowSubQuestions: Boolean;
}
