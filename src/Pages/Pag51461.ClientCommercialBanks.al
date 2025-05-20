page 51461 "Client Commercial Banks"
{
    // version THL- Client Payroll 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Client Commercial Banks";

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
                RunObject = Page "Client Bank Branches";
                RunPageLink = "Bank Code"=FIELD(Code);
            }
        }
    }
}
