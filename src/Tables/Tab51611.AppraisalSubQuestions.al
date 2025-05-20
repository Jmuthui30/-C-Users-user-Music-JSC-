table 51611 "Appraisal Sub-Questions"
{
    // version THL- HRM 1.0
    DrillDownPageID = "Appraisal Sub-Questions";
    LookupPageID = "Appraisal Sub-Questions";

    fields
    {
        field(1; "Main Question No."; Code[10])
        {
        }
        field(2; "Sub-Question No."; Code[10])
        {
        }
        field(3; Question; Text[250])
        {
        }
        field(4; "Further Explanation"; Text[250])
        {
        }
        field(5; "Question Type"; Option)
        {
            OptionCaption = 'Single Question,Has Sub-Questions';
            OptionMembers = "Single Question", "Has Sub-Questions";
        }
        field(6; "Sub-Question Instructions"; Text[250])
        {
        }
    }
    keys
    {
        key(Key1; "Main Question No.", "Sub-Question No.")
        {
        }
    }
    fieldgroups
    {
    }
}
