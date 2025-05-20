table 51671 "Counties"
{
    DrillDownPageId = "Counties List";
    LookupPageId = "Counties List";

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Name"; Text[100])
        {
        }
        field(3; "Total Sub Counties"; Integer)
        {
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Sub Counties" where("County Code"=field(code)));
        }
        field(4; "Headquarters"; text[100])
        {
        }
    }
    keys
    {
        key(Key1; "Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Name)
        {
        }
    }
}
