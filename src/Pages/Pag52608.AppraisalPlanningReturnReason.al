page 52608 "Appr. Planning Return Reason"
{
    ApplicationArea = All;
    Caption = 'Return Appraisal Planning';
    PageType = StandardDialog;
    SourceTable = "Appraisal Planning Review";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;
                Caption = 'Return Reason';
                MultiLine = true;
                ToolTip = 'Specifies why the appraisal planning document is being returned.';
            }
        }
    }
}
