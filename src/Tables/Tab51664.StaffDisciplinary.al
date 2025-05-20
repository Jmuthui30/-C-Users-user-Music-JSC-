table 51664 "Staff Disciplinary"
{
    Caption = 'Staff Disciplinary & Misconduct';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
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
            Editable = false;
        }
        field(4; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(5; "Job Title"; Text[50])
        {
            Editable = false;
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            Editable = false;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            Editable = false;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(8; "Global Dimension 3 Code"; Code[20])
        {
            Editable = false;
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(9; Manager; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                if NAVemp.Get("Global Dimension 3 Code")then Manager:=NAVemp."First Name" + ' ' + NAVemp."Last Name";
            end;
        }
        field(10; "Manager's Name"; Text[100])
        {
            Editable = false;
        }
        field(11; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(12; "Mobile No"; Text[20])
        {
            Editable = false;
        }
        field(13; "Employment Date"; Date)
        {
            Editable = false;
        }
        field(15; Status;Enum "Disciplinary Status")
        {
            Editable = false;

            trigger OnValidate()
            begin
                EmployeeCases.Reset();
                EmployeeCases.SetRange("Refference No", "No.");
                if EmployeeCases.FindSet()then begin
                    repeat EmployeeCases.Status:=Status;
                        EmployeeCases.Modify(true);
                    until EmployeeCases.Next() = 0;
                end;
            end;
        }
        field(16; "Remarks HR"; Text[250])
        {
            Caption = 'HR Remarks';
        }
        field(17; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(18; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(19; "Staff Response/Defense"; Text[250])
        {
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
            HRSetup.Get;
            HRSetup.TestField("Staff Displinary Nos");
            NoSeriesMgt.InitSeries(HRSetup."Staff Displinary Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Date:=Today;
        if UserSetup.Get(UserId)then begin
            "Employee No":=UserSetup."Employee No.";
            Validate("Employee No");
        end;
        "Created By":=UserId;
        if EmpRec.Get("Employee No")then begin
            "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
            "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
            "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
            Validate(Manager, EmpRec."Appraisal Supervisor");
        end;
        if NAVemp.Get("Employee No")then begin
            "Job Title":=NAVemp."Job Title";
            "Employee Name":=NAVemp."First Name" + ' ' + NAVemp."Last Name";
            "Mobile No":=NAVemp."Mobile Phone No.";
        end;
    end;
    var UserSetup: Record "User Setup";
    Text000: Label 'Your are not mapped to an employee account. Kindly contact the system administrator.';
    NAVemp: Record Employee;
    EmpRec: Record "Employee Master";
    HRSetup: Record "QuantumJumps HR Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    EmployeeCases: Record "Employee Disciplinary Cases";
}
