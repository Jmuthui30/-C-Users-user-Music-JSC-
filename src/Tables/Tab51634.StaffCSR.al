table 51634 "Staff CSR"
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
        field(16; Closed; Boolean)
        {
            trigger OnValidate()
            begin
            /*"Closed By" := USERID;
                "Closed Date" := TODAY;*/
            end;
        }
        field(17; "Closed By"; Code[50])
        {
        }
        field(18; "Closed Date"; Date)
        {
        }
        field(19; "Institution Visited"; Text[50])
        {
        }
        field(20; "Date of Visit"; Date)
        {
            trigger OnValidate()
            begin
                "Year Start Date":=DMY2Date(1, 1, Date2DMY("Date of Visit", 3));
                "Year End Date":=DMY2Date(31, 12, Date2DMY("Date of Visit", 3));
                "Fiscal Year":=Date2DMY("Date of Visit", 3);
            end;
        }
        field(21; Activity; Text[250])
        {
        }
        field(22; "Contact Person"; Text[100])
        {
        }
        field(23; Address; Text[250])
        {
        }
        field(24; "Contact Phone"; Text[30])
        {
        }
        field(25; "Contact Email"; Text[80])
        {
        }
        field(26; "Required Hours"; Integer)
        {
        }
        field(27; "Hours Achieved"; Integer)
        {
            CalcFormula = Sum("Staff CSR"."Hours Served" WHERE(Status=CONST(Released), "Date of Visit"=FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(28; "Hours Served"; Integer)
        {
        }
        field(29; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(30; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(31; "Year Start Date"; Date)
        {
        }
        field(32; "Year End Date"; Date)
        {
        }
        field(33; "Fiscal Year"; Integer)
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
            CSRSetup.Get;
            CSRSetup.TestField("CSR Nos.");
            NoSeriesMgt.InitSeries(CSRSetup."CSR Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            "Required Hours":=CSRSetup."CSR Hours per Year";
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
    CSRSetup: Record "QuantumJumps HR Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
