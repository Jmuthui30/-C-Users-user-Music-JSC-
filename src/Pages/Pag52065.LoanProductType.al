page 52065 "Loan Product Type"
{
    Editable = true;
    PageType = Card;
    SourceTable = "Loan Product";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = All;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                }
                field("No of Instalment"; Rec."No of Instalment")
                {
                    ApplicationArea = All;
                }
                field("Loan No Series"; Rec."Loan No Series")
                {
                    ApplicationArea = All;
                }
                field(Rounding; Rec.Rounding)
                {
                    ApplicationArea = All;
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ApplicationArea = All;
                }
                field("Loan Category"; Rec."Loan Category")
                {
                    ApplicationArea = All;
                }
                field("Deduction Code"; Rec."Deduction Code")
                {
                    ApplicationArea = All;
                }
                field("Interest Deduction Code"; Rec."Interest Deduction Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';

                action(Application)
                {
                    ApplicationArea = All;
                    Caption = 'Application';
                    Image = Agreement;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Loan Application Form";
                    RunPageLink = "Loan Product Type"=FIELD(Code);
                    RunPageMode = Create;
                }
                action("Bulk Issue")
                {
                    ApplicationArea = All;
                    Caption = 'Bulk Issue';
                    Image = Agreement;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Loan Application Grid";
                    RunPageLink = "Loan Product Type"=FIELD(Code), "Loan Status"=FILTER(<>Issued);
                }
            }
        }
    }
}
