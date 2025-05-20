page 50002 "Payment Voucher Lines"
{
    // version THL-Basic Fin 1.0
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "PV Lines";
    SourceTableView = SORTING(No, "Line No");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Cost Centre"; Rec."Cost Centre")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Applies to Doc. No"; Rec."Applies to Doc. No")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Gross Amount';
                }
                field("VAT Code"; Rec."VAT Code")
                {
                    ApplicationArea = All;
                }
                field("W/Tax Code"; Rec."W/Tax Code")
                {
                    ApplicationArea = All;
                }
                field("Stamp Duty Code"; Rec."Stamp Duty Code")
                {
                    ApplicationArea = All;
                }
                field("Stamp Duty Flat Amount"; Rec."Stamp Duty Flat Amount")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.TestField("Stamp Duty Code");
                        CurrPage.Update(true);
                        Rec."Stamp Duty Amount":=0;
                    end;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = All;
                }
                field("W/Tax Amount"; Rec."W/Tax Amount")
                {
                    ApplicationArea = All;
                }
                field("Stamp Duty Amount"; Rec."Stamp Duty Amount")
                {
                    ApplicationArea = All;
                    Editable = Rec."Stamp Duty Flat Amount";
                }
                field("Net Amount"; Rec."Net Amount")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var BeneficiaryBanks: Record "Payee Bank Details";
}
