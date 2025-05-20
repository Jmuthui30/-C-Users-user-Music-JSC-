page 52116 "Receive Imprest Refund"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Receive ITO Refund';
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
                field("Receipt Mode"; Rec."Receipt Mode")
                {
                    ApplicationArea = All;
                }
                field("Receipt Tx No.(Cheque No.)"; Rec."Receipt Tx No.(Cheque No.)")
                {
                    ApplicationArea = All;
                }
                field("Receiving Account"; Rec."Receiving Account")
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
        Rec.TestField("Receiving Account");
    end;
}
