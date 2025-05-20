table 51849 "Employees Dependants"
{
    fields
    {
        field(1; "Employee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Employee."No.";
        }
        field(2; Relationship; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Relative.Code;
        }
        field(3; SurName; Text[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
            /*MedicalHeader.RESET;
                MedicalHeader.SETRANGE(MedicalHeader."Employee No","Employee Code");
                IF MedicalHeader.FIND('+') THEN
                MedicalHeader."Employee No":="Employee Code";
                MedicalHeader.VALIDATE(MedicalHeader."Employee No");
                */
            end;
        }
        field(4; "Other Names"; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
            //VALIDATE(SurName);
            end;
        }
        field(5; "ID No/Passport No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            //VALIDATE(SurName);
            end;
        }
        field(7; Occupation; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Address; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Office Tel No"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Home Tel No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Distribution %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Gender"; Option)
        {
            OptionCaption = ',Female,Male,Others';
            OptionMembers = "Female", "Others";
            DataClassification = ToBeClassified;
            Editable = true;
        }
    }
    keys
    {
        key(Key1; "Employee Code", Relationship, SurName, "Other Names")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        HRCommentLine: Record "Human Resource Comment Line";
    begin
        HRCommentLine.SetRange("Table Name", HRCommentLine."Table Name"::"Employee Relative");
        HRCommentLine.SetRange("No.", "Employee Code");
        HRCommentLine.DeleteAll;
    end;
}
