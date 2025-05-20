table 51815 "Driver"
{
    // version THL- PRM 1.0
    DrillDownPageID = "Driver List";
    LookupPageID = "Driver List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        //TableRelation = Employee;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if Emp.Get("Employee No.")then begin
                    "Global Dimension 1 Code":=Emp."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=Emp."Global Dimension 2 Code";
                end;
                if NAVemp.Get("Employee No.")then Name:=NAVemp.FullName;
                "Job Title":=NAVEmp."Job Title";
                "Phone No.":=NAVEmp."Phone No.";
            end;
        }
        field(3; Name; Text[100])
        {
        }
        field(4; "Job Title"; Text[30])
        {
        }
        field(5; Address; Text[150])
        {
        }
        field(6; "Phone No."; Code[15])
        {
        }
        field(7; "Driver License No."; Code[20])
        {
        }
        field(8; "License Class"; Code[5])
        {
        }
        field(9; "License Issue Date"; Date)
        {
        }
        field(10; "License Expiry Date"; Date)
        {
        }
        field(11; Status; Option)
        {
            OptionCaption = 'Available,Unavailable,Exited';
            OptionMembers = Available, Unavailable, Exited;
        }
        field(12; Picture; BLOB)
        {
            SubType = Bitmap;
        }
        field(13; "License Image"; BLOB)
        {
            SubType = Bitmap;
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(16; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(17; "Raised By"; code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(18; AssistEdit; Boolean)
        {
            DataClassification = CustomerContent;
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
        if("No." = '')then begin
            MotorSetup.Get;
            MotorSetup.TestField("Driver Nos");
            NoSeriesMgt.InitSeries(MotorSetup."Driver Nos", xRec."No.", 0D, "No.", "No. Series");
        end;
        "Raised By":=UserId;
    end;
    var Emp: Record "Employee Master";
    NAVEmp: Record Employee;
    MotorSetup: Record "Motorpool Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    procedure AssitEdit(): Boolean begin
        MotorSetup.Get;
        MotorSetup.TestField("Driver Nos");
        if NoSeriesMgt.SelectSeries(MotorSetup."Driver Nos", xRec."No. Series", "No. Series")then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;
}
