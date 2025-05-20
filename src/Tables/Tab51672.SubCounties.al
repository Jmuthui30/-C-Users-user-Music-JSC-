table 51672 "Sub Counties"
{
    DrillDownPageId = "Sub Counties List";
    LookupPageId = "Sub Counties List";
    DataCaptionFields = "County Code", "Sub County Code", "Sub County Name";

    fields
    {
        field(1; "County Code"; Code[20])
        {
            TableRelation = Counties."Code";

            trigger OnValidate()
            begin
                Clear("County Name");
                if Counties.Get("County Code")then "County Name":=Counties."Name";
            end;
        }
        field(2; "County Name"; code[100])
        {
            Editable = false;
        }
        field(3; "Sub County Code"; Code[20])
        {
        }
        field(4; "Sub County Name"; Text[100])
        {
        }
    }
    keys
    {
        key(Key1; "County Code", "Sub County Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Counties: Record Counties;
}
