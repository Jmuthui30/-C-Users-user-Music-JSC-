table 51459 "Client Bank Branches"
{
    fields
    {
        field(1; "Bank Code"; Code[10])
        {
            TableRelation = "Commercial Banks";

            trigger OnValidate()
            begin
                if Banks.Get("Bank Code")then "Bank Name":=Banks.Name;
            end;
        }
        field(2; "Branch Code"; Code[10])
        {
        }
        field(3; "Bank Name"; Text[50])
        {
            Editable = false;
        }
        field(4; "Branch Name"; Text[50])
        {
        }
    }
    keys
    {
        key(Key1; "Bank Code", "Branch Code")
        {
        }
    }
    fieldgroups
    {
    }
    var Banks: Record "Client Commercial Banks";
}
