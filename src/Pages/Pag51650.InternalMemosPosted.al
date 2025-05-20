page 51650 "Internal Memos - Posted"
{
    // version THL- HRM 1.0
    Caption = 'Posted Internal Memos';
    CardPageID = "Internal Memo - Posted";
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
    trigger OnOpenPage()
    begin
        Rec.SetRange("Created By", UserId);
    end;
}
