page 51995 "Stage Shortlist"
{
    PageType = ListPart;
    SourceTable = "Stage Shortlist";
    SourceTableView = SORTING("Stage Score")ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Control14)
            {
                ShowCaption = false;

                field(Applicant; Rec.Applicant)
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Stage Score"; Rec."Stage Score")
                {
                    ApplicationArea = All;
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec."Manual Change":=true;
                        Rec.Modify;
                    end;
                }
                field("Manual Change"; Rec."Manual Change")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field(Shortlist; Rec.Shortlist)
                {
                    ApplicationArea = All;
                }
                field("Reporting Date"; Rec."Reporting Date")
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
