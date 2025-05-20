page 51716 "CSR List - Approval"
{
    // version THL- HRM 1.0
    Caption = 'CSR Pending Approval';
    CardPageID = "CSR Card - Approval";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Staff CSR";
    SourceTableView = WHERE(Status=CONST("Pending Approval"));

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
}
