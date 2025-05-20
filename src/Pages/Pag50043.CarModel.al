page 50043 "Car Model"
{
    ApplicationArea = All;
    Caption = 'Car Model';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Car Model";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Brand Id"; Rec."Brand Id")
                {
                    ApplicationArea = All;
                }
                field(Power; Rec.Power)
                {
                    ApplicationArea = All;
                }
                field("Fuel Type"; Rec."Fuel Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
