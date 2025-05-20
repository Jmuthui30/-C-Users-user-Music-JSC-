table 51501 "Bal Score Card Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(2; DocNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Percepective; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bal Score Percipectives";
        }
        field(5; "Planning Assumption"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Planning Assumptions / Comments';
        }
        field(6; "Progress Review Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bal Score Preview Periods";

            trigger OnValidate()
            begin
                PreviewPeriod.Reset();
                PreviewPeriod.SetRange(Code, "Progress Review Period");
                PreviewPeriod.SetRange("Preview Period Type", PreviewPeriod."Preview Period Type"::"Full Period Appraisal");
                if PreviewPeriod.FindFirst()then "Full Period Appraisal":=true;
            end;
        }
        field(7; "Document Type"; Option)
        {
            OptionMembers = Planning, Appraisal;
            Editable = false;
        }
        field(8; "Self Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bal Score Card Rating";
            MaxValue = 5;
        }
        field(9; "Joint Rating"; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bal Score Card Rating";
            MaxValue = 5;

            trigger OnValidate()
            begin
                TestField("Self Rating");
                //  if "Full Period Appraisal" = true then
                Score:="Expected Max Score" * ("Joint Rating" / 5);
            end;
        }
        field(10; Score; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(11; "Achievements ToDate"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Emphasis"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Emphasis / Correction Actions';
        }
        field(13; "Full Period Appraisal"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; Reviewed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Expected Max Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            MinValue = 1;
            Editable = false;
        }
        field(16; Type; Option)
        {
            Caption = 'Perspective Type';
            OptionMembers = " ", Global, Sales, None_Sales;
        }
    }
    keys
    {
        key(key1; LineNo, DocNo)
        {
            Clustered = true;
        }
        key(key2; DocNo, LineNo, "Progress Review Period", "Document Type")
        {
        }
    }
    var PreviewPeriod: Record "Bal Score Preview Periods";
}
