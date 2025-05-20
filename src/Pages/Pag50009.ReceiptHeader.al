page 50009 "Receipt Header"
{
    // version THL-Basic Fin 1.0
    PageType = Card;
    SourceTable = "Receipts Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                }
                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Amount(LCY)"; Rec."Amount(LCY)")
                {
                    ApplicationArea = All;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Received From"; Rec."Received From")
                {
                    ApplicationArea = All;
                }
                field("On Behalf Of"; Rec."On Behalf Of")
                {
                    ApplicationArea = All;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                }
                field("Posted Time"; Rec."Posted Time")
                {
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(Control24; "Receipt Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Receipt No."=FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control23; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action("Print Receipt")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                Visible = Rec.Posted;

                trigger OnAction()
                begin
                    if Rec.Posted = false then Error('Receipt No %1 has not been posted', Rec."No.");
                    Rec.Reset;
                    BankLedgerEntry.SetRange(BankLedgerEntry."Document No.", Rec."No.");
                    REPORT.Run(Report::Receipt, true, true, BankLedgerEntry);
                    Rec.Reset;
                end;
            }
        }
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.TestField(Description);
                    Rec.TestField("Global Dimension 1 Code");
                    ReceiptLines.Reset;
                    ReceiptLines.SetRange("Receipt No.", Rec."No.");
                    if ReceiptLines.FindSet then repeat begin
                            if ReceiptLines."Receipt Type" = ReceiptLines."Receipt Type"::Advance then ReceiptLines.TestField("Advance Loan No.");
                        end;
                        until ReceiptLines.Next = 0;
                    FinMgt.PostReceipt(Rec);
                end;
            }
        }
    }
    var FinMgt: Codeunit "Finance Management";
    ReceiptLines: Record "Receipt Lines";
    BankLedgerEntry: Record "Bank Account Ledger Entry";
}
