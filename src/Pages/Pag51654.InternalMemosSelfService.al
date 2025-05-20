page 51654 "Internal Memos - Self Service"
{
    // version THL- HRM 1.0
    Caption = 'Internal Memos';
    CardPageID = "Internal Memo - Self Service";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Internal Memo";
    SourceTableView = WHERE(Posted=CONST(true), Archived=CONST(false));

    layout
    {
        area(content)
        {
            repeater("Internal Memo")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(From; Rec.From)
                {
                    ApplicationArea = All;
                }
                field("To"; Rec."To")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Memo; Rec.Memo)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control10; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
