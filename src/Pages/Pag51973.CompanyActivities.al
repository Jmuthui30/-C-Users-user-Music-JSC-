page 51973 "Company Activities"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Company Activities";

    layout
    {
        area(content)
        {
            repeater(Control15)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Day; Rec.Day)
                {
                    ApplicationArea = All;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field(Responsibility; Rec.Responsibility)
                {
                    ApplicationArea = All;
                }
                field(Costs; Rec.Costs)
                {
                    ApplicationArea = All;
                }
                field("G/L Account No"; Rec."G/L Account No")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Bal. Account No"; Rec."Bal. Account No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Post; Rec.Post)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Attachment No."; Rec."Attachment No.")
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
