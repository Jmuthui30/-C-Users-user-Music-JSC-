page 51437 "Salary Scales"
{
    // version THL- Payroll 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Salary Scale";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Scale; Rec.Scale)
                {
                    ApplicationArea = All;
                }
                field("Minimum Level"; Rec."Minimum Pointer")
                {
                    ApplicationArea = All;
                }
                field("Maximum Level"; Rec."Maximum Pointer")
                {
                    ApplicationArea = All;
                }
                field("Inpatient Limit"; Rec."In Patient Limit")
                {
                    ApplicationArea = All;
                }
                field("Outpatient Limit"; Rec."Out Patient Limit")
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
