table 52397 "Appraisal Snapshot Outcome"
{
    Caption = 'Appraisal Snapshot Outcome';
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
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(4; "Outcome No."; Code[20])
        {
            Caption = 'Outcome No.';
        }
        field(5; "Outcome Type"; Enum "Appraisal Outcome Type")
        {
            Caption = 'Outcome Type';
        }
        field(6; Subject; Text[100])
        {
            Caption = 'Subject';
        }
        field(7; "Letter Body"; Text[2048])
        {
            Caption = 'Letter Body';
        }
        field(8; "Issue Date"; Date)
        {
            Caption = 'Issue Date';
        }
        field(9; "Issued By"; Code[50])
        {
            Caption = 'Issued By';
        }
        field(10; Status; Text[30])
        {
            Caption = 'Status';
        }
        field(11; Rating; Decimal)
        {
            Caption = 'Rating';
        }
        field(12; Grade; Text[50])
        {
            Caption = 'Grade';
        }
    }

    keys
    {
        key(PK; "Appraisal No.", "Review Period Code", "Line No.")
        {
            Clustered = true;
        }
    }
}
