page 50062 "Travel Locations"
{
    ApplicationArea = All;
    Caption = 'Travel Locations';
    PageType = List;
    SourceTable = "Travel Locations";
    UsageCategory = Lists;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                }
                field(International; Rec.International)
                {
                }
            }
        }
    }
}
