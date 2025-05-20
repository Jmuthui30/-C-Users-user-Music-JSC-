page 51905 "Fuel Cards"
{
    // version THL- PRM 1.0
    DeleteAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Fuel Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Card No."; Rec."Card No.")
                {
                    ApplicationArea = All;
                }
                field("Card Name"; Rec."Card Name")
                {
                    ApplicationArea = All;
                }
                field("Issuer Name"; Rec."Issuer Name")
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Expiry Date"; Rec."Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Credit Balance"; Rec."Credit Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control11; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Top Up")
            {
                ApplicationArea = All;
                Image = Payment;
                Promoted = true;
                PromotedIsBig = true;

                //RunPageMode = Edit;
                trigger OnAction()
                begin
                    TopUp.Get;
                    TopUp."Card No.":=Rec."Card No.";
                    TopUp."Card Name":=Rec."Card Name";
                    TopUp."Top Up Date":=0D;
                    TopUp.Amount:=0;
                    TopUp.Modify;
                    PAGE.Run(51907, TopUp);
                end;
            }
        }
    }
    var TopUp: Record "Fuel Card Top Up";
}
