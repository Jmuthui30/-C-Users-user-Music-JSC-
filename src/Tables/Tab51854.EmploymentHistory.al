table 51854 "Employment History"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Employee."No.";
        }
        field(2; From; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "To"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(4; "Company Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(5; "Postal Address"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Address 2"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Job Title"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Key Experience"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Salary On Leaving"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Reason For Leaving"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Comment; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50000; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No.", "Company Name")
        {
        }
    }
    fieldgroups
    {
    }
}
