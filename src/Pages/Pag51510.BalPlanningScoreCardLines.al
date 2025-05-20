page 51510 "Bal Planning Score Card Lines"
{
    PageType = ListPart;
    SourceTable = "Bal Score Card Lines";
    SourceTableView = where("Document Type"=const(Planning));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Percepective; Rec.Percepective)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Expected Max Score"; Rec."Expected Max Score")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
