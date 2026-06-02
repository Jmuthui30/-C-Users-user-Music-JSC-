page 57898 JSCStaff
{
    ApplicationArea = All;
    Caption = 'JSCStaff';
    PageType = List;
    SourceTable = JscStaff;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Pf No."; Rec."Pf No.")
                {
                    ToolTip = 'Specifies the value of the Pf No. field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field.', Comment = '%';
                }
            }
        }
    }
}
