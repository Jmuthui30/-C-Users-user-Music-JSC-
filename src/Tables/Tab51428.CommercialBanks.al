table 51428 "Commercial Banks"
{
    // version THL- Payroll 1.0
    DrillDownPageID = "Commercial Banks";
    LookupPageID = "Commercial Banks";

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(3; "Swift Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
        }
    }
    fieldgroups
    {
    }
}
