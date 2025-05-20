page 51882 "Monthly Cost Analysis - Open"
{
    // version THL- PRM 1.0
    Caption = 'New Monthly Cost Analysis';
    PageType = Card;
    SourceTable = "Motorpool Cost Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = All;
                }
                field("Total Monthly Expenses"; Rec."Total Monthly Expenses")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Amount Distributed"; Rec."Total Amount Distributed")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control9; "Cost Analysis Matrix")
            {
                ApplicationArea = All;
                SubPageLink = "Global Dimension 2 Code"=FIELD("Global Dimension 2 Code"), Period=FIELD(Period);
            }
        }
        area(factboxes)
        {
            part(Control12; "Cost Analysis FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Global Dimension 1 Code"=FIELD("Global Dimension 1 Code"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Code"), Period=FIELD(Period);
            }
            systempart(Control8; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Apportion Costs")
            {
                ApplicationArea = All;
                Image = Add;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Cost Appointment";
                RunPageLink = "Global Dimension 1 Code"=FIELD("Global Dimension 1 Code"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Code"), Period=FIELD(Period);
                RunPageMode = Edit;
            }
            action("Suggest Cost Distribution")
            {
                ApplicationArea = All;
                Image = Suggest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    MotorpoolMgt.SuggestCostAnalysis(Rec);
                end;
            }
        }
    }
    var MotorpoolMgt: Codeunit "Motorpool Management";
}
