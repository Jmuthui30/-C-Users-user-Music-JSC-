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
    actions
    {

        area(Processing)
        {
            action(TDYRates)
            {
                Caption = 'TDY Rates';
                Image = Rates;
                ToolTip = 'View or set per diem rates for this location.';

                trigger OnAction()
                var
                    TDYLocation: Record "AEA Listing"; // use actual table name
                begin
                    TDYLocation.SetRange(Location, Rec.Code);
                    Page.Run(Page::"TDY Locations", TDYLocation);
                end;
            }
        }
    }

}
