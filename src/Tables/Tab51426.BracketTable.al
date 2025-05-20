table 51426 "Bracket Table"
{
    // version THL- Payroll 1.0
    DrillDownPageID = "Bracket Tables";
    LookupPageID = "Bracket Tables";

    fields
    {
        field(1; "Bracket Code"; Code[10])
        {
        }
        field(2; "Bracket Description"; Text[30])
        {
        }
        field(3; Annual; Boolean)
        {
        }
        field(4; "Effective Start Date"; Date)
        {
        }
        field(5; "Effective End Date"; Date)
        {
        }
        field(6; Type; Option)
        {
            OptionCaption = 'Fixed,Graduating Scale';
            OptionMembers = "Fixed", "Graduating Scale";
        }
    }
    keys
    {
        key(Key1; "Bracket Code")
        {
        }
    }
    fieldgroups
    {
    }
}
