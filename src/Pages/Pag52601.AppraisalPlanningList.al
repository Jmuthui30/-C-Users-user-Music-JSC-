page 52601 "Appraisal Planning List"
{
    ApplicationArea = All;
    CardPageId = "Appraisal Planning Card";
    Caption = 'Appraisal Planning';
    PageType = List;
    SourceTable = "Appraisal Planning Header";
    SourceTableView = where("Planning Status" = filter("Returned for Changes" | Open));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the planning number.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee number.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee name.';
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisal period.';
                }
                field("Appraiser No."; Rec."Appraiser No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraiser number.';
                }
                field("Appraiser Name"; Rec."Appraiser Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraiser name.';
                }
                field("Planning Status"; Rec."Planning Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the planning status.';
                }
                field("Actual Appraisal No."; Rec."Actual Appraisal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the created actual appraisal number.';
                }
            }
        }
    }
}
