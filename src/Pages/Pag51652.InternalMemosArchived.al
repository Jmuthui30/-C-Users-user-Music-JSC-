page 51652 "Internal Memos - Archived"
{
    // version THL- HRM 1.0
    Caption = 'Archived Internal Memos';
    CardPageID = "Internal Memo - Archived";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Internal Memo";
    SourceTableView = WHERE(Posted=CONST(true), Archived=CONST(true));

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
