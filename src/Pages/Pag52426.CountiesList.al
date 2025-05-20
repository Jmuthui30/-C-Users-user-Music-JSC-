page 52426 "Counties List"
{
    PageType = List;
    PromotedActionCategories = 'New,Process,Report,Sub Counties';
    SourceTable = Counties;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(CountyCode; Rec."Code")
                {
                    ApplicationArea = Basic;
                }
                field(CountyName; Rec."Name")
                {
                    ApplicationArea = Basic;
                }
                field(Headquarters; Rec.Headquarters)
                {
                    ApplicationArea = all;
                }
                field("Total Sub Counties"; Rec."Total Sub Counties")
                {
                    ApplicationArea = all;
                    Enabled = false;
                    BlankZero = true;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("SubCounties")
            {
                ApplicationArea = Basic;
                Image = AddToHome;
                Caption = 'Sub Counties';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                RunObject = Page "Sub Counties List";
                RunPageLink = "County Code"=field("Code");
            }
        }
    }
}
