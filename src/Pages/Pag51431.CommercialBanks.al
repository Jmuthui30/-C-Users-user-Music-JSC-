page 51431 "Commercial Banks"
{
    // version THL- Payroll 1.0
    DeleteAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Commercial Banks";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Swift Code"; Rec."Swift Code")
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
            action(Branches)
            {
                ApplicationArea = All;
                Image = Bank;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Bank Branches";
                RunPageLink = "Bank Code"=FIELD(Code);
            }
        }
    }
}
