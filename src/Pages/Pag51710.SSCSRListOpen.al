page 51710 "SS CSR List - Open"
{
    // version THL- HRM 1.0
    Caption = 'New CSR Activity';
    CardPageID = "SS CSR Card - Open";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Staff CSR";
    SourceTableView = WHERE(Status=CONST(Open));

    layout
    {
        area(content)
        {
            repeater("Employee Details")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Institution Visited"; Rec."Institution Visited")
                {
                    ApplicationArea = All;
                }
                field("Date of Visit"; Rec."Date of Visit")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control26; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Created By", UserId);
    end;
}
