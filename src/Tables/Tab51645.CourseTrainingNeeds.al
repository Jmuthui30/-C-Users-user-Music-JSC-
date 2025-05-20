table 51645 "Course Training Needs"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Code"; Code[10])
        {
            TableRelation = "Training Needs";

            trigger OnValidate()
            begin
                if Needs.Get(Code)then "Training Need Covered":=Needs.Description;
            end;
        }
        field(3; "Training Need Covered"; Text[100])
        {
        }
    }
    keys
    {
        key(Key1; "No.", "Code")
        {
        }
    }
    fieldgroups
    {
    }
    var Needs: Record "Training Needs";
}
