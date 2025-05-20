table 51612 "Appraisal Sub-Sub-Questions"
{
    // version THL- HRM 1.0
    DrillDownPageID = "Appraisal Sub-Sub Questions";
    LookupPageID = "Appraisal Sub-Sub Questions";

    fields
    {
        field(1; "Main Question No."; Code[10])
        {
        }
        field(2; "Sub-Question No."; Code[10])
        {
        }
        field(3; "Sub-Sub Question No."; Code[10])
        {
        }
        field(4; Question; Text[250])
        {
        }
        field(5; "Further Explanation"; Text[250])
        {
        }
    }
    keys
    {
        key(Key1; "Main Question No.", "Sub-Question No.", "Sub-Sub Question No.")
        {
        }
    }
    fieldgroups
    {
    }
}
