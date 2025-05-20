table 51620 "Mail Distribution Lists"
{
    // version THL- HRM 1.0
    DrillDownPageID = "Mail Distribution Lists";
    LookupPageID = "Mail Distribution Lists";

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; Email; Text[80])
        {
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
