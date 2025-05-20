table 50468 "Imprest Procurement Decision"
{
    Caption = 'Imprest Procurement Decision';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Memo No."; Code[20])
        {
            Caption = 'Memo No.';
        }
        field(2; "Expense Code"; Code[50])
        {
            Caption = 'Expense Code';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(4; Decision; Option)
        {
            OptionCaption = 'Order from Service Provider,Pay Cash to Traveller,Reject,Process to Payroll';
            OptionMembers = "Order from Service Provider", "Pay Cash to Traveller", Reject, "Process to Payroll";
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            Caption = 'Global Dimanion 1 Code';
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
        }
        field(7; Currency; Code[10])
        {
            Caption = 'Currency';
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(9; "Procurement Doc No."; Code[20])
        {
            Caption = 'Procurement Doc No.';
        }
        field(10; "Payroll Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if(Decision=const("Process to Payroll"))"Client Earnings";
        }
    }
    keys
    {
        key(PK; "Memo No.", "Expense Code")
        {
            Clustered = true;
        }
    }
}
