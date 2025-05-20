page 50007 "Cash Management Setup List"
{
    // version THL-Basic Fin 1.0
    CardPageID = "Cash Management Setup Card";
    Caption = 'Cash Management Setup';
    DeleteAllowed = false;
    Editable = false;
    // InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cash Management Setup";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Payment Voucher Template"; Rec."Payment Voucher Template")
                {
                    ApplicationArea = All;
                }
                field("Receipt Template"; Rec."Receipt Template")
                {
                    ApplicationArea = All;
                }
                field("Post VAT"; Rec."Post VAT")
                {
                    ApplicationArea = All;
                }
                field("Rounding Type"; Rec."Rounding Type")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control22; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
