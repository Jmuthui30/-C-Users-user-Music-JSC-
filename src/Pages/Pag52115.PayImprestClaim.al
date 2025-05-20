page 52115 "Pay Imprest Claim"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Pay ITO Claim';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Imprest Header";

    layout
    {
        area(content)
        {
            group("Receive Imprest Refund")
            {
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Surrender Date"; Rec."Surrender Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Net Refund (Net Claim)"; Rec."Net Refund (Net Claim)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Claim Pay Mode"; Rec."Claim Pay Mode")
                {
                    ApplicationArea = All;
                }
                field("Claim Payment Tx No"; Rec."Claim Payment Tx No")
                {
                    ApplicationArea = All;
                }
                field("Claim Paying Account"; Rec."Claim Paying Account")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnClosePage()
    begin
        Rec.TestField("Claim Paying Account");
    end;
}
