table 51655 "Recruitment Request"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if NAVemp.Get("Employee No")then begin
                    "Employee Name":=Format(NAVemp.Title) + ' ' + NAVemp."First Name" + ' ' + NAVemp."Middle Name" + ' ' + NAVemp."Last Name";
                end;
                if EmpRec.Get("Employee No")then begin
                    "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                end;
            end;
        }
        field(5; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Reason; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(8; "Raised by"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; Rejected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(13; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(14; Advertised; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Closed By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Closed Date"; Date)
        {
            DataClassification = ToBeClassified;
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
            QuantumJumpsHRSetup.Get;
            QuantumJumpsHRSetup.TestField("Recruitment Request");
            NoSeriesMgt.InitSeries(QuantumJumpsHRSetup."Recruitment Request", xRec."No. Series", 0D, "No.", "No. Series");
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
            "Employee Name":=NAVemp."First Name" + ' ' + NAVemp."Last Name";
        end;
    end;
    var NAVemp: Record Employee;
    EmpRec: Record "Employee Master";
    TrainingSetup: Record "QuantumJumps HR Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    QuantumJumpsHRSetup: Record "QuantumJumps HR Setup";
}
