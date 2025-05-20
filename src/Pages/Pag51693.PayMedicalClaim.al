page 51693 "Pay Medical Claim"
{
    // version THL- HRM 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Medical Claim";

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
                field("Claim Amount"; Rec."Claim Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Settled Date"; Rec."Settled Date")
                {
                    ApplicationArea = All;
                }
                field("Claim Pay Mode"; Rec."Claim Pay Mode")
                {
                    ApplicationArea = All;
                }
                field("Payment Tx. No. (Cheque No.)"; Rec."Payment Tx. No. (Cheque No.)")
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
