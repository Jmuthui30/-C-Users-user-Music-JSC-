page 52430 "Client Loan Product Type list"
{
    CardPageID = "Client Loan Product Type";
    ApplicationArea = All;
    Caption = 'Client Loan Product Type list';
    PageType = List;
    SourceTable = "Client Loan Product";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Calculate Interest"; Rec."Calculate Interest")
                {
                    ToolTip = 'Specifies the value of the Calculate Interest field.';
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ToolTip = 'Specifies the value of the Interest Calculation Method field.';
                }
                field("Interest Deduction Code"; Rec."Interest Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Interest Deduction Code field.';
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ToolTip = 'Specifies the value of the Interest Rate field.';
                }
                field("Calculate On"; Rec."Calculate On")
                {
                    ToolTip = 'Specifies the value of the Calculate On field.';
                }
                field("Deduction Code"; Rec."Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Deduction Code field.';
                }
                field("Fringe Benefit Code"; Rec."Fringe Benefit Code")
                {
                    ToolTip = 'Specifies the value of the Fringe Benefit Code field.';
                }
                field("Internal"; Rec."Internal")
                {
                    ToolTip = 'Specifies the value of the Internal field.';
                }
                field("Loan Category"; Rec."Loan Category")
                {
                    ToolTip = 'Specifies the value of the Loan Category field.';
                }
                field("Loan No Series"; Rec."Loan No Series")
                {
                    ToolTip = 'Specifies the value of the Loan No Series field.';
                }
                field("No of Instalment"; Rec."No of Instalment")
                {
                    ToolTip = 'Specifies the value of the No of Instalment field.';
                }
                field("Principal Deduction Code"; Rec."Principal Deduction Code")
                {
                    ToolTip = 'Specifies the value of the Principal Deduction Code field.';
                }
            }
        }
    }
}
