table 51637 "User Grievances"
{
    // version THL- HRM 1.0
    Caption = 'Incidences/Grievances';

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
        field(14; "Due Date"; Date)
        {
            Editable = false;
        }
        field(15; Status;Enum "Incidence Status")
        {
            Editable = false;
        }
        field(16; Closed; Boolean)
        {
            trigger OnValidate()
            begin
                "Closed By":=USERID;
                "Closed Date":=TODAY;
            end;
        }
        field(17; "Closed By"; Code[50])
        {
            Editable = false;
        }
        field(18; "Closed Date"; Date)
        {
            Editable = false;
        }
        field(19; "Incident Description"; Text[50])
        {
        }
        field(20; "Incident Date"; Date)
        {
            Caption = 'Date';
            Editable = false;
        }
        field(21; "Incident Location"; Text[50])
        {
            Caption = 'Location';
        }
        field(22; "Incidence Outcome"; Option)
        {
            Caption = 'Outcome';
            OptionCaption = '  ,Dangerous,Serious bodily injury,Work caused illness,Serious electrical incident,Dangerous electrical event,MajorAccident under the OSHA Act,Others';
            OptionMembers = "  ", Dangerous, "Serious bodily injury", "Work caused illness", "Serious electrical incident", "Dangerous electrical event", "MajorAccident under the OSHA Act", Others;
        }
        field(23; "Incident Time"; Time)
        {
            Caption = 'Time';
        }
        field(24; "Work place Controller"; Code[50])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                NAVemp.Get("Work place Controller");
                "Work place Controller Name":=NAVemp."First Name" + ' ' + NAVemp."Last Name";
            end;
        }
        field(25; "Work place Controller Name"; Text[100])
        {
            Editable = false;
        }
        field(26; "Remarks HR"; Text[250])
        {
        }
        field(27; Category; Option)
        {
            OptionCaption = ' ,Incident,Maintenance,Grievance';
            OptionMembers = " ", Incident, Maintenance, Grievance;
        }
        field(29; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(30; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
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
            HRSetup.TestField("User Incidence Nos.");
            NoSeriesMgt.InitSeries(HRSetup."User Incidence Nos.", xRec."No. Series", 0D, "No.", "No. Series");
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
}
