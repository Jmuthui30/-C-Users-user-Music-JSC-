page 51976 "Leave Recalls_Approved"
{
    CardPageID = "Leave Recall_ Approved";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Employee Off/Holidays";
    SourceTableView = WHERE(Recalled=CONST(true));

    layout
    {
        area(content)
        {
            repeater(Control8)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Recall Date"; Rec."Recall Date")
                {
                    ApplicationArea = All;
                }
                field("Recalled By"; Rec."Recalled By")
                {
                    ApplicationArea = All;
                }
                field("Reason for Recall"; Rec."Reason for Recall")
                {
                    ApplicationArea = All;
                }
                field("Recalled From"; Rec."Recalled From")
                {
                    ApplicationArea = All;
                }
                field("No. of Off Days"; Rec."No. of Off Days")
                {
                    ApplicationArea = All;
                }
                field("Recalled To"; Rec."Recalled To")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
