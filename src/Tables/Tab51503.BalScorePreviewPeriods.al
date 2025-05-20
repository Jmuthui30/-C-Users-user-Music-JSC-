table 51503 "Bal Score Preview Periods"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Bal Score Preview Periods";
    LookupPageId = "Bal Score Preview Periods";
    Caption = 'Bal Score Card Progress Preview Periods';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Preview Period Type"; Option)
        {
            OptionMembers = " ", "First Period Appraisal", "Full Period Appraisal";
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Name, "Preview Period Type")
        {
        }
        fieldgroup(Brick; Code, Name, "Preview Period Type")
        {
        }
    }
}
