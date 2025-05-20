page 52069 "Loan Product Type list"
{
    CardPageID = "Loan Product Type";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Loan Product";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
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
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = All;
                }
                field("No Series"; Rec."No Series")
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
            }
        }
    }
    actions
    {
    }
}
