page 51970 "Committees"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Committees;

    layout
    {
        area(content)
        {
            repeater(Control4)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                }
                field(Interview; Rec.Interview)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Committee)
            {
                Caption = 'Committee';

                action(Members)
                {
                    ApplicationArea = All;
                    Caption = 'Members';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Committee Board Of Directors";
                    RunPageLink = Committee=FIELD(Code);
                }
            }
        }
    }
}
