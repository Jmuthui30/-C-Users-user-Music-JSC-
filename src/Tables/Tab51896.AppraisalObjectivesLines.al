table 51896 "Appraisal Objectives Lines"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(2; "Appraisal Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Appraisal Period"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Key Responsibility"; Text[120])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(6; "Key Indicators"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Agreed Target Date"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Weighting; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Results Achieved Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Score/Points"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Jobs"."Job ID";
        }
        field(12; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(13; "Appraiser's Comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Appraisee's comments"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Description; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Appraisal Heading Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Objectives, "Core Values", "Core Competencies", "Managerial and Supervisory", "Mid-year Appraisal", "Annual Appraisal";
        }
        field(17; "Appraisal Header"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Appraisal Format Header";
        }
        field(18; Bold; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Appraisal No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "New No."; Integer)
        {
            AutoIncrement = false;
            DataClassification = ToBeClassified;
        }
        field(21; Dropped; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No", "Appraisal Period", "Appraisal Type", "Appraisal No", "Line No")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        "Line No":=GetNextLine;
    end;
    var Appraisalines: Record "Appraisal Objectives Lines";
    procedure GetNextLine()NxtLine: Integer var
        AppraisalLine: Record "Appraisal Objectives Lines";
    begin
        AppraisalLine.Reset;
        AppraisalLine.SetRange(AppraisalLine."Appraisal No", "Appraisal No");
        if AppraisalLine.Find('+')then NxtLine:=AppraisalLine."Line No" + 1;
    end;
}
