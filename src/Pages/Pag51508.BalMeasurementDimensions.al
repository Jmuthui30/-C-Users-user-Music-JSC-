page 51508 "Bal Measurement Dimensions"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bal Measurement Dimensions";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Percepective; Rec.Percepective)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
