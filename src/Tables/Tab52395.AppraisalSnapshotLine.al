table 52395 "Appraisal Snapshot Line"
{
    Caption = 'Appraisal Snapshot Line';
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
        field(4; "Objective Code"; Code[20])
        {
            Caption = 'Objective Code';
        }
        field(5; Objective; Text[250])
        {
            Caption = 'Objective';
        }
        field(6; "Performance Measure"; Code[50])
        {
            Caption = 'Performance Measure';
        }
        field(7; "Perf. Measure Description"; Text[250])
        {
            Caption = 'Performance Measure Description';
        }
        field(8; "Initiative Code"; Code[50])
        {
            Caption = 'Initiative Code';
        }
        field(9; "Initiative Description"; Text[250])
        {
            Caption = 'Initiative Description';
        }
        field(10; Target; Decimal)
        {
            Caption = 'Target';
        }
        field(11; Actual; Decimal)
        {
            Caption = 'Actual';
        }
        field(12; "Achieved (%)"; Decimal)
        {
            Caption = 'Achieved (%)';
        }
        field(13; Weighting; Decimal)
        {
            Caption = 'Weighting (%)';
        }
        field(14; "Self Rating"; Decimal)
        {
            Caption = 'Self Rating';
        }
        field(15; "Appraisee Comments"; Text[250])
        {
            Caption = 'Appraisee Comments';
        }
        field(16; "Appraiser Rating"; Decimal)
        {
            Caption = 'Appraiser Rating';
        }
        field(17; "Appraiser Comments"; Text[250])
        {
            Caption = 'Appraiser Comments';
        }
        field(18; "Quarter Score"; Decimal)
        {
            Caption = 'Quarter Score';
        }
        field(19; "Achievement Notes"; Text[250])
        {
            Caption = 'Achievement Notes';
        }
        field(20; "Corrective Action"; Text[250])
        {
            Caption = 'Corrective Action';
        }
        field(21; Reviewed; Boolean)
        {
            Caption = 'Reviewed';
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
