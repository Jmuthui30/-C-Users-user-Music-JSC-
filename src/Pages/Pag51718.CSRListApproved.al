page 51718 "CSR List - Approved"
{
    // version THL- HRM 1.0
    Caption = 'Approved CSR';
    CardPageID = "CSR Card - Approved";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Staff CSR";
    SourceTableView = WHERE(Status=CONST(Released));

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
