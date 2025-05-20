page 51972 "Rules & Regulations"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Rules & Regulations";

    layout
    {
        area(content)
        {
            repeater(Control8)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Rules & Regulations"; Rec."Rules & Regulations")
                {
                    ApplicationArea = All;
                }
                field("Document Link"; Rec."Document Link")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Language Code (Default)"; Rec."Language Code (Default)")
                {
                    ApplicationArea = All;
                }
                field(Attachement; Rec.Attachement)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
