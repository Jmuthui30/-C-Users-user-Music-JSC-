table 51639 "Coaching Performance Lines"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Code"; Code[10])
        {
            TableRelation = "Performance Issues";

            trigger OnValidate()
            begin
                if Issues.Get(Code)then Description:=Issues.Description;
            end;
        }
        field(4; Description; Text[60])
        {
        }
    }
    keys
    {
        key(Key1; "No.", "Line No.")
        {
        }
    }
    fieldgroups
    {
    }
    var Issues: Record "Performance Issues";
}
