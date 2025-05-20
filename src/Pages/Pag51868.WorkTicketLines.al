page 51868 "Work Ticket Lines"
{
    // version THL- PRM 1.0
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Work Ticket Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Driver; Rec.Driver)
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Details; Rec.Details)
                {
                    ApplicationArea = All;
                }
                field("Time Out"; Rec."Time Out")
                {
                    ApplicationArea = All;
                }
                field("Time In"; Rec."Time In")
                {
                    ApplicationArea = All;
                }
                field("Odometer Reading at Start (KM)"; Rec."Odometer Reading at Start (KM)")
                {
                    ApplicationArea = All;
                }
                field("Odometer Reading at End (KM)"; Rec."Odometer Reading at End (KM)")
                {
                    ApplicationArea = All;
                }
                field("Distance Covered (KM)"; Rec."Distance Covered (KM)")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
