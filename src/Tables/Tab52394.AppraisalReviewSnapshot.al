table 52394 "Appraisal Review Snapshot"
{
    Caption = 'Appraisal Review Snapshot';
    DataClassification = CustomerContent;
    DrillDownPageId = "Appraisal Review Snapshots";
    LookupPageId = "Appraisal Review Snapshots";

    fields
    {
        field(1; "Appraisal No."; Code[20])
        {
            Caption = 'Appraisal No.';
            TableRelation = "Employee Appraisal"."Appraisal No";
        }
        field(2; "Review Period Code"; Code[20])
        {
            Caption = 'Review Period';
            TableRelation = "Bal Score Preview Periods".Code;
        }
        field(3; "Review Period Name"; Text[100])
        {
            Caption = 'Review Period Name';
        }
        field(4; "Snapshot Date-Time"; DateTime)
        {
            Caption = 'Snapshot Date-Time';
        }
        field(5; "Snapshot By"; Code[50])
        {
            Caption = 'Snapshot By';
        }
        field(6; "Appraisal Period"; Code[20])
        {
            Caption = 'Appraisal Period';
            TableRelation = "Appraisal Periods".Period;
        }
        field(7; "Period Start"; Date)
        {
            Caption = 'Period Start';
        }
        field(8; "Period End"; Date)
        {
            Caption = 'Period End';
        }
        field(9; "Review Start Date"; Date)
        {
            Caption = 'Review From';
        }
        field(10; "Review End Date"; Date)
        {
            Caption = 'Review To';
        }
        field(11; "Final Review Period"; Boolean)
        {
            Caption = 'Final Review Period';
        }
        field(12; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            TableRelation = Employee."No.";
        }
        field(13; "Appraisee Name"; Text[100])
        {
            Caption = 'Appraisee Name';
        }
        field(14; "Appraisee Job Title"; Text[100])
        {
            Caption = 'Appraisee Job Title';
        }
        field(15; "Job Group"; Code[20])
        {
            Caption = 'Job Group';
        }
        field(16; "Directorate Code"; Code[20])
        {
            Caption = 'Directorate Code';
        }
        field(17; "Directorate Name"; Text[100])
        {
            Caption = 'Directorate Name';
        }
        field(18; "Appraiser No."; Code[20])
        {
            Caption = 'Appraiser No.';
            TableRelation = Employee."No.";
        }
        field(19; "Appraiser ID"; Code[30])
        {
            Caption = 'Appraiser ID';
        }
        field(20; "Appraiser Name"; Text[100])
        {
            Caption = 'Appraiser Name';
        }
        field(21; "Appraiser Job Title"; Text[100])
        {
            Caption = 'Appraiser Job Title';
        }
        field(22; "Source Status"; Text[50])
        {
            Caption = 'Source Status';
        }
        field(23; "Source Appraisal Status"; Text[50])
        {
            Caption = 'Source Appraisal Status';
        }
        field(24; "Total Weighting"; Decimal)
        {
            Caption = 'Total Weighting';
        }
        field(25; "Current Review Score"; Decimal)
        {
            Caption = 'Current Review Score';
        }
        field(26; "Total Review Score"; Decimal)
        {
            Caption = 'Total Review Score';
        }
        field(27; "Total Rating"; Decimal)
        {
            Caption = 'Total Rating';
        }
        field(28; "Total Percentage Score"; Decimal)
        {
            Caption = 'Total Percentage Score';
        }
        field(29; "Performance Grade"; Text[50])
        {
            Caption = 'Performance Grade';
        }
        field(30; "Attribute Total Rating"; Decimal)
        {
            Caption = 'Attribute Total Rating';
        }
        field(31; "Attribute Expected Rating"; Decimal)
        {
            Caption = 'Attribute Expected Rating';
        }
        field(32; "Attribute Percentage Score"; Decimal)
        {
            Caption = 'Attribute Percentage Score';
        }
        field(33; "Attribute Grade"; Text[50])
        {
            Caption = 'Attribute Grade';
        }
        field(34; "Appraisee Agreed"; Boolean)
        {
            Caption = 'Appraisee Agreed';
        }
        field(35; "Appraiser Agreed"; Boolean)
        {
            Caption = 'Appraiser Agreed';
        }
    }

    keys
    {
        key(PK; "Appraisal No.", "Review Period Code")
        {
            Clustered = true;
        }
        key(EmployeePeriod; "Employee No.", "Appraisal Period", "Review Period Code")
        {
        }
    }
}
