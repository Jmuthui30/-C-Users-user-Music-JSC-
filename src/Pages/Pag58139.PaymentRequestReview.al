page 58139 "Payment Request Review"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    QueryCategory = 'Posted Purchase Invoices';
    RefreshOnActivate = true;
    SourceTable = "Purch. Inv. Header";
    SourceTableView = SORTING("Posting Date")ORDER(Descending)where("Payment Requested"=const(false));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Decision; Rec.Decision)
                {
                    ApplicationArea = All;
                }
                field(Target; Rec.Target)
                {
                    Editable = Rec.Decision = Rec.Decision::"Append";
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Description"; Rec."Posting Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount Remaining To Request"; Rec."Amount Remaining To Request")
                {
                    ApplicationArea = All;
                }
                field("Amount To Request"; Rec."Amount To Request")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Execute)
            {
                ApplicationArea = All;
                Promoted = true;
                Image = ExecuteAndPostBatch;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    PaymentMngt.ExecutePaymentRequestReview(false, '');
                end;
            }
        }
    }
    var PaymentMngt: Codeunit "Payment Management";
    trigger OnAfterGetRecord()
    begin
        if((Rec."Amount Remaining To Request" = 0) and (Rec."Payment Requested" = false))then begin
            Rec.CalcFields(Amount);
            Rec."Amount Remaining To Request":=Rec.Amount;
        end;
    end;
}
