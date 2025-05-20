table 51857 "HR_Qualifications"
{
    DrillDownPageID = HR_Qualifications;
    LookupPageID = HR_Qualifications;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Qualified Employees"; Boolean)
        {
            CalcFormula = Exist("Employee Qualification" WHERE("Qualification Code"=FIELD(Code), "Employee Status"=CONST(Active)));
            Caption = 'Qualified Employees';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50000; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Qualification, "Job Grade";
        }
        field(50001; "Qualification Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ", Academic, Professional, Technical, Experience, "Personal Attributes";
        }
    }
    keys
    {
        key(Key1; "Code")
        {
        }
    }
    fieldgroups
    {
    }
}
