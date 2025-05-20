page 51734 "Company Documents Card"
{
    // version THL- HRM 1.0
    Caption = 'Company Documents';
    PageType = Card;
    SourceTable = "Company Documents";

    layout
    {
        area(content)
        {
            group(Group)
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
            part(Control8; "Company Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51636);
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
