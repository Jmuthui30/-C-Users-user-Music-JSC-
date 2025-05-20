table 51512 "HR_Employee Last Roles"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Role ID"; Code[20])
        {
            Caption = 'Role ID';
            DataClassification = ToBeClassified;
            TableRelation = Positions;

            trigger OnValidate()
            begin
                Jobs.Get("Role ID");
                Description:=Jobs.Description;
            end;
        }
        field(4; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
        }
        key(Key2; "Role ID")
        {
        }
    }
    fieldgroups
    {
    }
    var Jobs: Record Positions;
    Employee: Record Employee;
}
