table 51638 "Staff Coaching Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Counsellor No."; Code[20])
        {
            Caption = 'Coach';

            trigger OnValidate()
            begin
                if NAVemp.Get("Counsellor No.")then begin
                    "Mobile No":=NAVemp."Mobile Phone No.";
                    "Counsellor Name":=NAVemp."Last Name" + ' ' + NAVemp."First Name" + ' ' + NAVemp."Middle Name";
                    "Job Title":=NAVemp."Job Title";
                    Validate("Counsellee No.", NAVemp."Manager No.");
                end;
            end;
        }
        field(3; Date; Date)
        {
        }
        field(4; "Counsellor Name"; Text[100])
        {
            Caption = 'Coach Name';
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
        field(9; "Counsellee No."; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Employee No';

            trigger OnValidate()
            begin
                if NAVemp.Get("Counsellee No.")then "Counsellee's Name":=NAVemp."First Name" + ' ' + NAVemp."Last Name";
                if EmpRec.Get("Counsellee No.")then begin
                    "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                end;
            end;
        }
        field(10; "Counsellee's Name"; Text[100])
        {
            Caption = 'Employee Name';
        }
        field(11; "Created By"; Code[50])
        {
        }
        field(12; "Mobile No"; Text[20])
        {
        }
        field(13; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(14; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(15; "Reason for Coaching"; Option)
        {
            OptionCaption = 'Performance Based Issue,Personnal Issue';
            OptionMembers = "Performance Based Issue", "Personnal Issue";
        }
        field(16; "Staff Free to Express Self"; Option)
        {
            Caption = 'Was the staff free to express his/her self?';
            OptionCaption = 'Yes,No';
            OptionMembers = Yes, No;
        }
        field(17; "Staff Comfortable"; Option)
        {
            Caption = 'Did the body language of the staff express that he/she was comfortable with your Coaching?';
            OptionCaption = 'Yes,No';
            OptionMembers = Yes, No;
        }
        field(18; "More Notes"; Text[250])
        {
            Caption = 'Please throw more light on the issues discussed, and make appropriate recommendation(s) to HR department';
        }
        field(19; "Issues Affect Performance"; Option)
        {
            Caption = 'Can the issues discussed, affect the performance of the staff leading to negative impact on the Company''s overall productivity?';
            OptionCaption = 'Yes,No';
            OptionMembers = Yes, No;
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
        end;
        Date:=Today;
        if UserSetup.Get(UserId)then begin
            "Counsellor No.":=UserSetup."Employee No.";
            Validate("Counsellor No.");
        end;
        "Created By":=UserId;
        if EmpRec.Get("Counsellor No.")then begin
            "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
            "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
            "Global Dimension 3 Code":="Global Dimension 3 Code";
        end;
        if NAVemp.Get("Counsellor No.")then begin
            "Job Title":=NAVemp."Job Title";
            "Counsellor Name":=NAVemp."First Name" + ' ' + NAVemp."Last Name";
        end;
    end;
    var UserSetup: Record "User Setup";
    Text000: Label 'Your are not mapped to an employee account. Kindly contact the system administrator.';
    NAVemp: Record Employee;
    EmpRec: Record "Employee Master";
    TrainingSetup: Record "QuantumJumps HR Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
