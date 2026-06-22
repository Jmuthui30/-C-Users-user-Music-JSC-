table 52396 "Appraisal Snapshot Comment"
{
    Caption = 'Appraisal Snapshot Comment';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Appraisal No."; Code[20])
        {
            Caption = 'Appraisal No.';
            TableRelation = "Appraisal Review Snapshot"."Appraisal No.";
        }
        field(2; "Review Period Code"; Code[20])
        {
            Caption = 'Review Period';
            TableRelation = "Bal Score Preview Periods".Code;
        }
        field(3; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(4; Section; Text[50])
        {
            Caption = 'Section';
        }
        field(5; "Appraisee / Section Comment"; Text[250])
        {
            Caption = 'Appraisee / Section Comment';
        }
        field(6; "Appraiser Comment"; Text[250])
        {
            Caption = 'Appraiser Comment';
        }
        field(7; "Developmental Action"; Code[50])
        {
            Caption = 'Developmental Action';
        }
        field(8; Date; Date)
        {
            Caption = 'Date';
        }
    }

    keys
    {
        key(PK; "Appraisal No.", "Review Period Code", "Entry No.")
        {
            Clustered = true;
        }
    }
}
