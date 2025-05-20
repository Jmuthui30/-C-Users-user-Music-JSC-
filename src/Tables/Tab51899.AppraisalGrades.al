table 51899 "Appraisal Grades"
{
    DrillDownPageID = "Grade Matrix";
    LookupPageID = "Grade Matrix";

    fields
    {
        field(1; Grade; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Points; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Grade)
        {
        }
        key(Key2; Points)
        {
        }
    }
    fieldgroups
    {
    }
}
