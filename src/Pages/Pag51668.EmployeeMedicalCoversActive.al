page 51668 "Employee Medical Covers-Active"
{
    // version THL- HRM 1.0
    Caption = 'Active Employee Medical Covers';
    CardPageID = "Employee Medical Cover-Active";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Medical Cover";

    layout
    {
        area(content)
        {
            repeater("Employee Medical Cover")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Cover Type"; Rec."Cover Type")
                {
                    ApplicationArea = All;
                }
                field(Cover; Rec.Cover)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Policy Start Date"; Rec."Policy Start Date")
                {
                    ApplicationArea = All;
                }
                field("Policy End Date"; Rec."Policy End Date")
                {
                    ApplicationArea = All;
                }
                field("Cover Status"; Rec."Cover Status")
                {
                    ApplicationArea = All;
                }
                field("Cover Amount"; Rec."Cover Amount")
                {
                    ApplicationArea = All;
                }
                field(Expenditure; Rec.Expenditure)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control17; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
