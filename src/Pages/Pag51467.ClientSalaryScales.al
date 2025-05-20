page 51467 "Client Salary Scales"
{
    // version THL- Client Payroll 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Client Salary Scale";

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
                field("Minimum Level"; Rec."Minimum Level")
                {
                    ApplicationArea = All;
                }
                field("Maximum Level"; Rec."Maximum Level")
                {
                    ApplicationArea = All;
                }
                field("Inpatient Limit"; Rec."Inpatient Limit")
                {
                    ApplicationArea = All;
                }
                field("Outpatient Limit"; Rec."Outpatient Limit")
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
