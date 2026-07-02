page 52608 "Appr. Planning Return Reason"
{
    ApplicationArea = All;
    Caption = 'Return Appraisal Planning';
    PageType = StandardDialog;
    SourceTable = "Appraisal Planning Review";
    SourceTableTemporary = true;
    Editable = true;
    InsertAllowed = true;
    modifyAllowed = true;


    layout
    {
        area(content)
        {
            field(Comment; Rec.Comment)
            {
                ApplicationArea = All;
                Caption = 'Return Reason';
                MultiLine = true;
                editable = true;
                ToolTip = 'Specifies why the appraisal planning document is being returned.';
            }
        }
    }
}
