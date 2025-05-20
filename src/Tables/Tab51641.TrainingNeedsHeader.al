table 51641 "Training Needs Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Employee No"; Code[20])
        {
            trigger OnValidate()
            begin
                if EmpRec.Get("Employee No")then begin
                    "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                end;
                if NAVemp.Get("Employee No")then begin
                    "Mobile No":=NAVemp."Mobile Phone No.";
                    "Employment Date":=NAVemp."Employment Date";
                    "Employee Name":=NAVemp."Last Name" + ' ' + NAVemp."First Name" + ' ' + NAVemp."Middle Name";
                    "Job Title":=NAVemp."Job Title";
                    Validate(Manager, NAVemp."Manager No.");
                end;
            end;
        }
        field(3; Date; Date)
        {
        }
        field(4; "Employee Name"; Text[100])
        {
        }
        field(5; "Job Title"; Text[50])
        {
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(8; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(9; Manager; Code[20])
        {
            trigger OnValidate()
            begin
                if NAVemp.Get("Global Dimension 3 Code")then Manager:=NAVemp."First Name" + ' ' + NAVemp."Last Name";
            end;
        }
        field(10; "Manager's Name"; Text[100])
        {
        }
        field(11; "Created By"; Code[50])
        {
        }
        field(12; "Mobile No"; Text[20])
        {
        }
        field(13; "Employment Date"; Date)
        {
        }
        field(14; "Due Date"; Date)
        {
        }
        field(15; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(16; "Required Hours"; Integer)
        {
        }
        field(17; "Hours Achieved"; Integer)
        {
            CalcFormula = Sum("Staff CSR"."Hours Served" WHERE(Status=CONST(Released), "Date of Visit"=FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(18; "Hours Served"; Integer)
        {
        }
        field(19; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(20; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(21; "Year Start Date"; Date)
        {
        }
        field(22; "Year End Date"; Date)
        {
        }
        field(23; "Fiscal Year"; Integer)
        {
        }
        field(24; Gender; Option)
        {
            OptionCaption = 'Male,Female,Other';
            OptionMembers = Male, Female, Other;
        }
        field(25; "Comfirmation Status"; Option)
        {
            OptionCaption = 'Confirmed,Unconfirmed';
            OptionMembers = Confirmed, Unconfirmed;
        }
        field(26; "Grade Level"; Text[30])
        {
        }
        field(27; "Date of Last Training"; Date)
        {
        }
        field(28; "No of Months/Years in Job"; Text[30])
        {
            Caption = 'No of Months/Years in Current Job';
        }
        field(29; "Job Function"; Text[250])
        {
            Caption = 'Brief Description of Job Function/Role:';
        }
        field(30; "Current Employee Skills"; Text[250])
        {
            Caption = 'Current Employee Skills (Strength)';
        }
        field(31; "Missing Competencies"; Text[250])
        {
            Caption = 'Missing/Deficient Competencies (Weakness):';
        }
        field(32; "Required Skills"; Text[250])
        {
            Caption = 'Required Skills to Address the Missing Competencies (Weakness):';
        }
        field(33; Comments1; Text[250])
        {
            Caption = 'Comments by Departmental Head';
        }
        field(34; Comments2; Text[250])
        {
            Caption = 'Comments by HR Manager';
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            TrainingSetup.Get;
            TrainingSetup.TestField("Training Nos.");
            NoSeriesMgt.InitSeries(TrainingSetup."Training Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            "Required Hours":=TrainingSetup."Training Hours per Year";
        end;
        Date:=Today;
        Status:=Status::Open;
        if UserSetup.Get(UserId)then begin
            "Employee No":=UserSetup."Employee No.";
            Validate("Employee No");
        end;
        "Created By":=UserId;
        if EmpRec.Get("Employee No")then begin
            "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
            "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
            "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
        end;
        if NAVemp.Get("Employee No")then begin
            "Job Title":=NAVemp."Job Title";
            "Employee Name":=NAVemp."First Name" + ' ' + NAVemp."Last Name";
        end;
    end;
    var UserSetup: Record "User Setup";
    Text000: Label 'Your are not mapped to an employee account. Kindly contact the system administrator.';
    NAVemp: Record Employee;
    EmpRec: Record "Employee Master";
    TrainingSetup: Record "QuantumJumps HR Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
