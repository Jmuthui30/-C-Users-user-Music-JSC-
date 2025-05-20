page 52171 "Patterns"
{
    PageType = List;
    SourceTable = "RegEx Pattern";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(rep)
            {
                field(RegEx; Rec.RegEx)
                {
                    ApplicationArea = All;
                    Width = 5;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                //MultiLine = true;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        rec.create();
    end;
}
