table 51642 "Employee Training Needs"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Code"; Code[10])
        {
            TableRelation = "Training Needs";

            trigger OnValidate()
            begin
                if Needs.Get(Code)then Description:=Needs.Description;
            end;
        }
        field(4; Description; Text[100])
        {
        }
        field(5; Status; Option)
        {
            OptionCaption = 'Pending,On-going,Complete';
            OptionMembers = Pending, "On-going", Complete;
        }
        field(6; "Reference No."; Code[20])
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
        }
    }
    fieldgroups
    {
    }
    var Needs: Record "Training Needs";
}
