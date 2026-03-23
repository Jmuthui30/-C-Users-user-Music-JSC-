page 52109 "DSA Rates"
{
    ApplicationArea = All;
    Caption = 'DSA Rates';
    PageType = List;
    SourceTable = "DSA Rates";
    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Job Group"; Rec."Job Group")
                {
                    ToolTip = 'Specifies the value of the Job Group field.', Comment = '%';
                }
                field(Rates; Rec.Rates)
                {
                    ToolTip = 'Specifies the value of the Rates field.', Comment = '%';
                }
            }
        }
    }
}
