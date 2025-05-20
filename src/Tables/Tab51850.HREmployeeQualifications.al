table 51850 "HR_Employee Qualifications"
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
        field(3; "Qualification Code"; Code[20])
        {
            Caption = 'Qualification Code';
            DataClassification = ToBeClassified;
            TableRelation = HR_Qualifications where("Qualification Type"=field("Qualification Type"));

            trigger OnValidate()
            begin
                Qualification.Get("Qualification Code");
                Description:=Qualification.Description;
            end;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Internal,External,Previous Position';
            OptionMembers = " ", Internal, External, "Previous Position";
        }
        field(7; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(8; "Institution/Company"; Text[50])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }
        field(9; Cost; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Cost';
            DataClassification = ToBeClassified;
        }
        field(10; "Course Grade"; Text[50])
        {
            Caption = 'Course Grade';
            DataClassification = ToBeClassified;
        }
        field(11; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active, Inactive, Terminated;
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name"=CONST("Employee Qualification"), "No."=FIELD("Employee No."), "Table Line No."=FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = ToBeClassified;
        }
        field(50000; "Qualification Type"; Option)
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            OptionMembers = " ", Academic, Professional, Technical, Experience, "Personal Attributes";
        }
        field(50001; CourseType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Short Course", "Long Course";
        }
        field(50002; Weight; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Score ID"; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Score Setup";
        }
        field(50004; "Grad. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Address; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "City/State"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Zip/Postal Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Job Template"; Code[30])
        {
            NotBlank = true;
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Employee No.", "Line No.")
        {
        }
        key(Key2; "Qualification Code")
        {
        }
    }
    fieldgroups
    {
    }
    var Qualification: Record HR_Qualifications;
    Employee: Record Employee;
}
