page 52077 "Interview Stage"
{
    PageType = ListPart;
    SourceTable = "Interview Stage";
    SourceTableView = WHERE(Qualified=CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Applicant; Rec.Applicant)
                {
                    ApplicationArea = All;
                }
                field("Applicant's Name"; FullName)
                {
                    ApplicationArea = All;
                }
                field("Stage Score"; Rec."Stage Score")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Give Offer"; Rec."Give Offer")
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
        FullName:=Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
    end;
    trigger OnOpenPage()
    begin
        FullName:=Rec."First Name" + ' ' + Rec."Middle Name" + ' ' + Rec."Last Name";
    end;
    var FullName: Text[50];
}
