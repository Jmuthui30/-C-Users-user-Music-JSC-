page 52194 "Staff Organization Mapping"
{
    PageType = Card;
    SourceTable = "Staff Organization Mapping";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = false;

                field("Staff ID"; Rec."Staff ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
            }
            part(Control; "Staff Based Budget Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Staff No."=field("Staff ID");
            }
        }
    }
}
