page 51730 "Company Documents"
{
    // version THL- HRM 1.0
    Caption = 'Company Documents';
    CardPageID = "Company Documents Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Company Documents";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Name"; Rec."Document Name")
                {
                    ApplicationArea = All;
                }
                field("Visible To"; Rec."Visible To")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control7; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
