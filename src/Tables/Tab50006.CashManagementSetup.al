table 50006 "Cash Management Setup"
{
    // version THL-Basic Fin 1.0
    DrillDownPageID = "Cash Management Setup List";
    LookupPageID = "Cash Management Setup List";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            NotBlank = false;
        }
        field(2; "Payment Voucher Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(3; "Cash/Claim  Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(4; "Imprest Surrender Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(5; "Petty Cash Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(6; "Receipt Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(7; "Post VAT"; Boolean)
        {
        }
        field(8; "Rounding Type"; Option)
        {
            OptionCaption = 'Up,Nearest,Down';
            OptionMembers = Up, Nearest, Down;
        }
        field(9; "Rounding Precision"; Decimal)
        {
        }
        field(10; "Imprest Limit"; Decimal)
        {
        }
        field(11; "Imprest Due Date"; DateFormula)
        {
        }
        field(12; "PV Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13; "Imprest Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(14; "Petty Cash Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(15; "Receipt Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(16; "Current Budget"; Code[20])
        {
            TableRelation = "G/L Budget Name".Name;
        }
        field(17; "Current Budget Start Date"; Date)
        {
        }
        field(18; "Current Budget End Date"; Date)
        {
        }
        field(22; "EFT Files Path"; Text[250])
        {
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }
    fieldgroups
    {
    }
}
