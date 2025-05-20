page 52431 "Client Loan Product Type"
{
    ApplicationArea = All;
    Caption = 'Client Loan Product Type';
    PageType = Card;
    SourceTable = "Client Loan Product";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Interest Calculation Method field.';
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ToolTip = 'Specifies the value of the Interest Rate field.';
                }
                field("No of Instalment"; Rec."No of Instalment")
                {
                    ToolTip = 'Specifies the value of the No of Instalment field.';
                }
                field("Calculate On"; Rec."Calculate On")
                {
                    ToolTip = 'Specifies the value of the Calculate On field.';
                }
                field("Loan No Series"; Rec."Loan No Series")
                {
                    ToolTip = 'Specifies the value of the Loan No Series field.';
                }
                field(Rounding; Rec.Rounding)
                {
                    ToolTip = 'Specifies the value of the Rounding field.';
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ToolTip = 'Specifies the value of the Rounding Precision field.';
                }
                field("Loan Category"; Rec."Loan Category")
                {
                    ToolTip = 'Specifies the value of the Loan Category field.';
                }
                field("Deduction Code"; Rec."Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Deduction Code field.';
                }
                field("Fringe Benefit Code"; Rec."Fringe Benefit Code")
                {
                    ToolTip = 'Specifies the value of the Fringe Benefit Code field.';
                }
                field("Interest Deduction Code"; Rec."Interest Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Interest Deduction Code field.';
                }
                field("Internal"; Rec."Internal")
                {
                    ToolTip = 'Specifies the value of the Internal field.';
                }
                field("Principal Deduction Code"; Rec."Principal Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Principal Deduction Code field.';
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Client Loan")
            {
                Caption = 'Client Loan';

                action(Application)
                {
                    ApplicationArea = All;
                    Caption = 'Application';
                    Image = Agreement;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Client Loan Application Form";
                    RunPageLink = "Client Loan Product Type"=FIELD(Code);
                    RunPageMode = Create;
                }
                action("Bulk Issue")
                {
                    ApplicationArea = All;
                    Caption = 'Bulk Issue';
                    Image = Agreement;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Client Loan Application Grid";
                    RunPageLink = "Client Loan Product Type"=FIELD(Code), "Loan Status"=FILTER(<>Issued);
                }
            }
        }
    }
}
