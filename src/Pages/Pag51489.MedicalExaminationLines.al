page 51489 "Medical Examination Lines"
{
    PageType = ListPart;
    SourceTable = "Medical Examination";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Examiner; Rec.Examiner)
                {
                    ApplicationArea = All;
                }
                field("Examiner Name"; Rec."Examiner Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Passed; Rec.Passed)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Request For Examination")
            {
                ApplicationArea = All;
                Caption = 'Request For Examination';
                Image = SendAsPDF;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Message('Work on Progress');
                end;
            }
        }
    }
}
