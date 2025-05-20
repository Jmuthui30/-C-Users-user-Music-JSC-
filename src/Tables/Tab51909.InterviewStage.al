table 51909 "Interview Stage"
{
    fields
    {
        field(1; "Vacancy No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = true;
            TableRelation = "Recruitment Needs"."No.";
        }
        field(20; "Applicant No"; Code[20])
        {
            Caption = 'Applicant No';
        }
        field(2; "Stage Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = true;
            TableRelation = "Recruitment Stages"."Recruitement Stage";
        }
        field(3; Applicant; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = true;
            TableRelation = Applicant."No.";
        }
        field(4; "Stage Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Qualified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "First Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Middle Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Last Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; "ID No"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; Gender; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'Male,Female';
            OptionMembers = Male,Female;
        }
        field(11; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(12; "Manual Change"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(13; "Give Offer"; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Qualify For the Next Stage';

            trigger OnValidate()
            begin
                Applicants.Reset;
                Applicants.SetRange("No.", Applicant);
                if Applicants.Find('-') then begin
                    if Applicants."Offer Status" <> Applicants."Offer Status"::Applicant then
                        Error('%1 was Already given the Offer', Applicant)
                    else if Confirm(Text000, true) = true then begin
                        Applicants.Interview := Applicants.Interview::Passed;
                        Applicants.Modify;
                    end;
                end;
            end;
        }
        field(14; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Position; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Reporting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Marks Awarded"; Decimal)
        {
            Caption = 'Marks Awarded';
            trigger OnValidate()
            begin
                if "Marks Awarded" > "Maximum Marks" then
                    Error('Marks Awaraded can not be greater than Maximum Set Mark');
            end;
        }
        field(18; "Maximum Marks"; Decimal)
        {
            Editable = false;
            Caption = 'Maximum Marks';
        }
        field(19; "Interview Type"; Option)
        {
            OptionCaption = ' ,Oral,Practical';
            OptionMembers = " ",Oral,Practical;
            Caption = 'Interview Type';
        }
        field(21; "Panel Member Name"; Text[250])
        {
            CalcFormula = lookup("Interview Panel Members"."Panel Member Name" where("Panel Member Code" = field(Panel)));
            Caption = 'Panel Member Name';
            Editable = false;
            FieldClass = FlowField;
        }
         field(23; Panel; Code[20])
        {
            TableRelation = "Interview Panel Members"."Panel Member Code";
            Caption = 'Panel';
        }
         field(26; "Test Parameter"; Code[20])
        {
            TableRelation = "Interview Setup".Code;
            Caption = 'Test Parameter';

            trigger OnValidate()
            begin
                InterviewSetup.Get("Test Parameter");
                InterviewSetup.TestField("Maximum Marks");
                Description := InterviewSetup.Description;
                "Interview Type" := InterviewSetup.Type;
                "Maximum Marks" := InterviewSetup."Maximum Marks";
                "Pass Mark" := InterviewSetup."Pass Mark";
            end;
        }
          field(31; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(28; "Pass Mark"; Decimal)
        {
            Editable = false;
            Caption = 'Pass Mark';
        }
         field(24; Remarks; Text[250])
        {
            Caption = 'Remarks';
        }
    }
    keys
    {
        key(Key1; "Vacancy No.", "Stage Code", Applicant)
        {
        }
    }
    fieldgroups
    {
    }
    var
     InterviewSetup: Record "Interview Setup";
        Employee: Record Employee;
        Applicants: Record Applicant;
        EmpQualifications: Record "HR_Employee Qualifications";
        AppQualifications: Record "Applicants Qualification";
        RNeeds: Record "Recruitment Needs";
        Text000: Label 'Are you offering this applicant a Job?';
}
