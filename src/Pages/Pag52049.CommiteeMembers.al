page 52049 "Commitee Members"
{
    PageType = ListPart;
    SourceTable = "Commitee Members";

    layout
    {
        area(content)
        {
            repeater(Control4)
            {
                ShowCaption = false;

                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Chair; Rec.Chair)
                {
                    ApplicationArea = All;
                }
                field(Secretary; Rec.Secretary)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
