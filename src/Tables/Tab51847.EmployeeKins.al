table 51847 "Employee Kins"
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
        }
        field(4; "Other Names"; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(5; "ID No/Passport No"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;
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
    }
    keys
    {
        key(Key1; "Employee Code", SurName, "Other Names")
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
