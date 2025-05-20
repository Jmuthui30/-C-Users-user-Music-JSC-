table 51903 "Appraisal Lines"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(2; "Appraisal Category"; Code[20])
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
            NotBlank = true;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
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
            AutoIncrement = false;
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
            OptionCaption = ' ,Objectives,Core Values,Core Competencies,Managerial and Supervisory,Mid-year Appraisal,Annual Appraisal,Training Needs';
            OptionMembers = " ", Objectives, "Core Values", "Core Competencies", "Managerial and Supervisory", "Mid-year Appraisal", "Annual Appraisal", "Training Needs";

            trigger OnValidate()
            begin
                if "Appraisal Heading Type" = "Appraisal Heading Type"::"Mid-year Appraisal" then "Appraisal Type":='Mid Year'
                else if "Appraisal Heading Type" = "Appraisal Heading Type"::"Annual Appraisal" then "Appraisal Type":='Annual';
            end;
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
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(21; "Appraisal Type"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Appraisal No", "Line No")
        {
        }
        key(Key2; "Employee No", "Appraisal Category", "Appraisal Period", "Line No")
        {
        }
        key(Key3; "No.")
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
    var Appraisalines: Record "Appraisal Lines";
    procedure GetNextLine()NxtLine: Integer var
        AppraisalLine: Record "Appraisal Lines";
    begin
        AppraisalLine.Reset;
        AppraisalLine.SetRange(AppraisalLine."Appraisal No", "Appraisal No");
        if AppraisalLine.Find('+')then NxtLine:=AppraisalLine."Line No" + 1;
    end;
}
