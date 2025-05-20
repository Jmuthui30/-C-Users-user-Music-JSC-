table 51878 "Applicants Qualification"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Applicant."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = ToBeClassified;
        }
        field(3; "Qualification Code"; Code[20])
        {
            Caption = 'Qualification Code';
            DataClassification = ToBeClassified;
            NotBlank = true;
            //TableRelation = HR_Qualifications.Code WHERE("Qualification Type" = FIELD("Qualification Type"));
            TableRelation = Qualification.Code WHERE("Qualification Type" = FIELD("Qualification Type"));

            trigger OnValidate()
            begin
                Qualifications.Reset;
                Qualifications.SetRange(Qualifications.Code, "Qualification Code");
                if Qualifications.Find('-') then
                    Qualification := Qualifications.Description;
            end;
        }
        field(4; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                If (("From Date" <> 0D) and ("To Date" <> 0D)) then Duration := Dates.DetermineDatesDiffrence("From Date", "To Date");
            end;
        }
        field(5; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
                // if "To Date" <= "From Date" then
                //     Error(Error001, "To Date", "From Date");
            end;
        }
        field(6; Type; Enum ApplicantQualificationType)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
        }
        field(7; Description; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(8; "Institution/Company"; Text[1000])
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
        field(10; "Grade/Class"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }
        field(11; "Employee Status"; Option)
        {
            Caption = 'Employee Status';
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active,Inactive,Terminated;
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name" = CONST("Employee Qualification"), "No." = FIELD("Employee No."), "Table Line No." = FIELD("Line No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
            DataClassification = ToBeClassified;
        }
        field(50000; "Qualification Type"; Enum QUalificationType)
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(50001; Qualification; Text[2000])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(50003; "Score ID"; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Score Setup"."Score ID";
        }
        field(50004; Address; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Email; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Mobile Number"; Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Attachment Link"; Text[1250])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Gross Salary(KSH)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50009; "Expected Salary(KSH)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(50010; "Terms of Service"; Enum TermsOfService)
        {
            DataClassification = CustomerContent;
        }
        field(50011; "Terms of Service Specification"; Text[1250])
        {
            DataClassification = CustomerContent;
        }
        field(50012; "Area of Specialization"; Text[1250])
        {
            DataClassification = CustomerContent;
        }
        field(50013; "Duration"; Text[500])
        {
        }


        field(51003; Score; Decimal)
        {
            Caption = 'Score';
        }
        field(51004; Grade; Text[400])
        {
            Caption = 'Grade';
        }
        field(51005; No; Code[200])
        {
            Caption = 'No';
        }
        field(51006; Qualified; Boolean)
        {
            Caption = 'Qualified';
        }
    }
    keys
    {
        key(Key1; "Employee No.", "Qualification Type", "Qualification Code")
        {
            SumIndexFields = "Score ID";
        }
        key(Key2; "Qualification Code")
        {
        }
    }
    fieldgroups
    {
    }
    var
        Qualifications: Record Qualification; //HR_Qualifications;
        Applicant: Record Applicant;
        Position: Code[20];
        JobReq: Record "Job Requirements";
        Dates: Codeunit "HR Dates Mgt";
}
