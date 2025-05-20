table 51870 "Board Of Directors"
{
    DrillDownPageID = "Board Of Directors";
    LookupPageID = "Board Of Directors";

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; SurName; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Other Names"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Category; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Management, Board';
            OptionMembers = " ", Management, " Board";
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
