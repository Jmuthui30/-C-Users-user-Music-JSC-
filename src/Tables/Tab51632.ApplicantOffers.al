table 51632 "Applicant Offers"
{
    fields
    {
        field(1; "Applicant No."; Code[20])
        {
        }
        field(2; "Earning Code"; Code[10])
        {
            TableRelation = Earnings;
        }
        field(3; Amount; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; "Applicant No.", "Earning Code")
        {
        }
    }
    fieldgroups
    {
    }
}
