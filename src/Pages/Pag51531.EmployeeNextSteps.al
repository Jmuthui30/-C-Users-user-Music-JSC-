page 51531 "Employee Next Steps"
{
    AutoSplitKey = true;
    Caption = 'Possible Next Steps';
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "HR_Employee Next Steps";

    layout
    {
        area(content)
        {
            repeater(Control15)
            {
                ShowCaption = false;

                field("Role ID"; Rec."Role ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
    end;
}
