page 51949 "Referees"
{
    PageType = ListPart;
    SourceTable = Referees;

    layout
    {
        area(content)
        {
            repeater(Control8)
            {
                ShowCaption = false;

                field(Names; Rec.Names)
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field(Select; Rec.Select)
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
