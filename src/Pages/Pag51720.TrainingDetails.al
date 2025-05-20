page 51720 "Training Details"
{
    // version THL- HRM 1.0
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Training Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Type of Training"; Rec."Type of Training")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Total Hours"; Rec."Total Hours")
                {
                    ApplicationArea = All;
                }
                field(Achievement; Rec.Achievement)
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
