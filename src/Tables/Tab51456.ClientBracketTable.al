table 51456 "Client Bracket Table"
{
    // version THL- Client Payroll 1.0
    DrillDownPageID = "Client Bracket Tables";
    LookupPageID = "Client Bracket Tables";

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
