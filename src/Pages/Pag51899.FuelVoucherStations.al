page 51899 "Fuel Voucher Stations"
{
    // version THL- PRM 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Fuel Voucher Stations";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                field("Bulk Fuel Voucher Nos."; Rec."Bulk Fuel Voucher Nos.")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Fuel Voucher Nos."; Rec."Vehicle Fuel Voucher Nos.")
                {
                    ApplicationArea = All;
                }
                field("Motorcycle Fuel Voucher Nos."; Rec."Motorcycle Fuel Voucher Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control11; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
