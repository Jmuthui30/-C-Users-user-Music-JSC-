page 51514 "Bal Score Card Rating"
{
    Caption = 'Appraisal Rating Scale';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Bal Score Card Rating";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the numeric appraisal rating percentage threshold, for example 60, 70, 80, or 90.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Specifies the description for this appraisal rating score.';
                }
            }
        }
    }
}
