page 51517 "Bal Score Preview Periods"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bal Score Preview Periods";
    Caption = 'Bal Score Card Progress Preview Periods';

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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Preview Period Type"; Rec."Preview Period Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
