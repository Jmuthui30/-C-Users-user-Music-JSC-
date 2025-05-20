page 50022 "Applicant Languages"
{
    ApplicationArea = All;
    Caption = 'Applicant Languages';
    PageType = ListPart;
    SourceTable = "Applicant Language";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
