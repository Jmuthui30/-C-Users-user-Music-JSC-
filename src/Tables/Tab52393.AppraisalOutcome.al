table 52393 "Appraisal Outcome"
{
    Caption = 'Appraisal Outcome';
    DataClassification = CustomerContent;
    DrillDownPageId = "Appraisal Outcome List";
    LookupPageId = "Appraisal Outcome List";

    fields
    {
        field(1; "Appraisal No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Employee Appraisal"."Appraisal No";
        }
        field(2; "Outcome Type"; Enum "Appraisal Outcome Type")
        {
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(4; "Employee No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = Employee."No.";
        }
        field(5; "Employee Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Job Title"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; "Department Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Appraisal Period"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Appraisal Periods".Period;
        }
        field(9; "Appraisal Type"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(10; Rating; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(11; Grade; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(12; Subject; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Letter Body"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(14; "Issued By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Issue Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Draft,Issued,Archived';
            OptionMembers = Draft,Issued,Archived;
        }
        field(17; "Linked Internal Memo No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            TableRelation = "Internal Memo"."No.";
        }
        field(18; "Outcome No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Appraisal No.", "Outcome Type", "Line No.")
        {
            Clustered = true;
        }
        key(EmployeePeriod; "Employee No.", "Appraisal Period", "Outcome Type")
        {
        }
        key(OutcomeNo; "Outcome No.")
        {
        }
    }

    trigger OnInsert()
    var
        EmployeeAppraisal: Record "Employee Appraisal";
    begin
        if EmployeeAppraisal.Get("Appraisal No.") then begin
            "Employee No." := EmployeeAppraisal."Employee No";
            "Employee Name" := EmployeeAppraisal."Appraisee Name";
            "Job Title" := EmployeeAppraisal."Appraisee's Job Title";
            "Department Code" := EmployeeAppraisal."Department Code";
            "Appraisal Period" := EmployeeAppraisal."Appraisal Period";
            "Appraisal Type" := Format(EmployeeAppraisal.AppraisalType);
            EmployeeAppraisal.CalcFields("Total FY Rating");
            Rating := EmployeeAppraisal."Total FY Rating";
            Grade := EmployeeAppraisal."Grade final year rating";
        end;
    end;

    procedure MarkIssued()
    begin
        Status := Status::Issued;
        "Issue Date" := Today;
        "Issued By" := UserId;
        Modify(true);
    end;
}
