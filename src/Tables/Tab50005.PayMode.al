table 50005 "Pay Mode"
{
    // version THL-Basic Fin 1.0
    DrillDownPageID = "Pay Mode";
    LookupPageID = "Pay Mode";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; Description; Text[50])
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
