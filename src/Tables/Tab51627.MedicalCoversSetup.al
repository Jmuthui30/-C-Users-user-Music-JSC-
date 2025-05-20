table 51627 "Medical Covers Setup"
{
    // version THL- HRM 1.0
    DrillDownPageID = "Medical Covers Setup";
    LookupPageID = "Medical Covers Setup";

    fields
    {
        field(1; "Primary Key"; Integer)
        {
        }
        field(2; "Cover Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Claim Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(4; "Claims Payroll Code"; Code[10])
        {
            TableRelation = Earnings;
        }
        field(5; "Claims Gen. Journal Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
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
