page 51459 "Client Bracket Tables"
{
    // version THL- Client Payroll 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Client Bracket Table";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bracket Code"; Rec."Bracket Code")
                {
                    ApplicationArea = All;
                }
                field("Bracket Description"; Rec."Bracket Description")
                {
                    ApplicationArea = All;
                }
                field(Annual; Rec.Annual)
                {
                    ApplicationArea = All;
                }
                field("Effective Start Date"; Rec."Effective Start Date")
                {
                    ApplicationArea = All;
                }
                field("Effective End Date"; Rec."Effective End Date")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Brackets)
            {
                ApplicationArea = All;
                Image = ConfidentialOverview;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Client Bracket";
                RunPageLink = "Table Code"=FIELD("Bracket Code");
            }
        }
    }
}
