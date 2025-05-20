page 51947 "Succession Requirements"
{
    PageType = ListPart;
    SourceTable = "HR Company or Other Training";

    layout
    {
        area(content)
        {
            repeater(Control4)
            {
                ShowCaption = false;

                field("Course Title"; Rec."Course Title")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
    }
}
