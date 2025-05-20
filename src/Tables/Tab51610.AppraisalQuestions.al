table 51610 "Appraisal Questions"
{
    // version THL- HRM 1.0
    DrillDownPageID = "Appraisal Questions";
    LookupPageID = "Appraisal Questions";

    fields
    {
        field(1; "No."; Code[10])
        {
        }
        field(2; Question; Text[250])
        {
        }
        field(3; "Further Explanation"; Text[250])
        {
        }
        field(4; "Question Type"; Option)
        {
            OptionCaption = 'Single Question,Has Sub-Questions';
            OptionMembers = "Single Question", "Has Sub-Questions";

            trigger OnValidate()
            begin
                if(xRec."Question Type" <> "Question Type") and ("Question Type" = "Question Type"::"Has Sub-Questions")then begin
                end
                else if(xRec."Question Type" <> "Question Type") and ("Question Type" <> "Question Type"::"Single Question")then begin
                    end;
            end;
        }
        field(5; "Sub-Question Instructions"; Text[250])
        {
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    var SubQ: Record "Appraisal Sub-Questions";
    SubQ2: Record "Appraisal Sub-Questions";
}
