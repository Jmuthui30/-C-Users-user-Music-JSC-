page 51884 "Monthly Cost Analyses - Open"
{
    // version THL- PRM 1.0
    Caption = 'New Monthly Cost Analysis';
    CardPageID = "Monthly Cost Analysis - Open";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Motorpool Cost Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field("Period Name"; Rec."Period Name")
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
