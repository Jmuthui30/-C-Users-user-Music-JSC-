page 51901 "Fuel Voucher Lines"
{
    // version THL- PRM 1.0
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Fuel Voucher Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Type of Voucher"; Rec."Type of Voucher")
                {
                    ApplicationArea = All;
                }
                field(Station; Rec.Station)
                {
                    ApplicationArea = All;
                }
                field("Station Name"; Rec."Station Name")
                {
                    ApplicationArea = All;
                }
                field("Voucher No."; Rec."Voucher No.")
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
