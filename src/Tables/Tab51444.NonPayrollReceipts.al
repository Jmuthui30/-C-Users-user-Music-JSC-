table 51444 "Non Payroll Receipts"
{
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            TableRelation = "Loan Application"."Loan No";
        }
        field(2; "Receipt Date"; Date)
        {
            NotBlank = true;
        }
        field(3; "Received From"; Text[40])
        {
        }
        field(4; "Cheque No"; Code[20])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Reference No"; Code[20])
        {
        }
    }
    keys
    {
        key(Key1; "Loan No", "Receipt Date")
        {
        }
    }
    fieldgroups
    {
    }
}
