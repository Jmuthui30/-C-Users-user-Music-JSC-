page 51653 "Internal Memo - Self Service"
{
    // version THL- HRM 1.0
    Caption = 'Internal Memo';
    PageType = Card;
    SourceTable = "Internal Memo";
    SourceTableView = WHERE(Posted=CONST(true), Archived=CONST(false));

    layout
    {
        area(content)
        {
            group("Internal Memo")
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
                grid(Control15)
                {
                    GridLayout = Rows;
                    ShowCaption = false;

                    group("To,Group,Email")
                    {
                        Caption = 'To,Group,Email';

                        field("To"; Rec."To")
                        {
                            ApplicationArea = All;
                            ShowCaption = false;
                        }
                        field("Group Name"; Rec."Group Name")
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Group Email"; Rec."Group Email")
                        {
                            ApplicationArea = All;
                            Editable = false;
                            ShowCaption = false;
                        }
                    }
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Memo; Rec.Memo)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part(Control6; "SS Memo Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51619);
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
