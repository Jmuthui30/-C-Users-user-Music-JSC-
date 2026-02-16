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
        field(17; Current; Boolean)
        {
            Caption = 'Current';

            trigger OnValidate()
            var
                EmpHistory: Record "Employment History";
                Text000: Label 'You can''t have more than one current job \ %1  from %2 to %3 is current';
            begin

                EmpHistory.Reset();
                EmpHistory.SetRange("Employee No.", "Employee No.");
                if EmpHistory.Find('-') then
                    repeat
                        if (EmpHistory.From <> From) or (EmpHistory."To" <> "To") or
                           (EmpHistory."Company Name" <> "Company Name") then
                            if EmpHistory.Current then
                                Error(Text000, EmpHistory."Company Name", EmpHistory.From, EmpHistory."To");
                    until EmpHistory.Next() = 0;
            end;
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
