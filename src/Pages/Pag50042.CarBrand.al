page 50042 "Car Brand"
{
    ApplicationArea = All;
    Caption = 'Car Brand';
    PageType = List;
    SourceTable = "Car Brand";
    UsageCategory = Lists;

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
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
