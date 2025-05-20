page 51623 "Appraisal Sub Question Card"
{
    // version THL- HRM 1.0
    PageType = Card;
    SourceTable = "Appraisal Sub-Questions";

    layout
    {
        area(content)
        {
            group("Sub Questions")
            {
                field("Sub-Question No."; Rec."Sub-Question No.")
                {
                    ApplicationArea = All;
                }
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Further Explanation"; Rec."Further Explanation")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Question Type"; Rec."Question Type")
                {
                    ApplicationArea = All;

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
                }
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
                RunObject = Page "Appraisal Sub-Sub Questions";
                RunPageLink = "Main Question No."=FIELD("Main Question No."), "Sub-Question No."=FIELD("Sub-Question No.");
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
    var ShowSubQuestions: Boolean;
}
