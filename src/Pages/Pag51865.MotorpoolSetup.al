page 51865 "Motorpool Setup"
{
    // version THL- PRM 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Motorpool Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Driver Nos"; Rec."Driver Nos")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Nos."; Rec."Vehicle Nos.")
                {
                    ApplicationArea = All;
                }
                field("Work Ticket Nos"; Rec."Work Ticket Nos")
                {
                    ApplicationArea = All;
                }
                field("Fuel Card Nos."; Rec."Fuel Card Nos.")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Service Nos."; Rec."Vehicle Service Nos.")
                {
                    ApplicationArea = All;
                }
                field("Fuel Voucher Nos."; Rec."Fuel Voucher Nos.")
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
