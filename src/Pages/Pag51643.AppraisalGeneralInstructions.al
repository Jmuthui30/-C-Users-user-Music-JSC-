page 51643 "Appraisal General Instructions"
{
    // version THL- HRM 1.0
    DeleteAllowed = false;
    MultipleNewLines = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Appraisal General Instructions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Instruction One"; Rec."Instruction One")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Instruction Two"; Rec."Instruction Two")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Instruction Three"; Rec."Instruction Three")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {
    }
}
