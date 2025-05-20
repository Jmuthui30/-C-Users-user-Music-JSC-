table 50040 "Recruitment Plan"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Recruitment Plans";
    DrillDownPageId = "Recruitment Plans";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Description; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Editable = true;
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                DimValue: Record "Dimension Value";
            begin
                Clear("Department Name");
                GenLedSetup.Get;
                if DimValue.Get(GenLedSetup."Global Dimension 1 Code", "Global Dimension 1 Code") then "Department Name" := DimValue.Name;
            end;
        }
        field(4; "Global Dimension 2 Code"; Code[20])
        {
            Editable = true;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            //TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            trigger OnValidate()
            var
                DimValue: Record "Dimension Value";
            begin
                Clear("Programme Name");
                GenLedSetup.Get;
                if DimValue.Get(GenLedSetup."Global Dimension 2 Code", "Global Dimension 2 Code") then "Programme Name" := DimValue.Name;
            end;
        }
        field(5; "Department Name"; Text[1000])
        {
            Editable = false;
        }
        field(6; "Fiscal Year"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status; Enum "Document Status")
        {
            // Editable = false;
        }
        field(10; Consolidated; Boolean)
        {
            Editable = false;
        }
        field(11; "Created By"; code[50])
        {
            Editable = false;
        }
        field(12; AssistEdit; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(13; "Programme Name"; Text[200])
        {
            Editable = false;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var
        GenLedSetup: Record "General Ledger Setup";
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Usersetup: Record "User Setup";
        Employee: Record Employee;
        User: Record "User Setup";
        ErrorTxt: Label 'Kindly contact Admin for setup to be done';

    trigger OnInsert()
    begin
        "Document Date" := today;
        "Created By" := UserId;
        Validate("Created By", "Created By");
        Status := 1;
        Validate(Status);
        if not Usersetup.Get(UserId) then begin
            if UserId = '' then Error(ErrorTxt)
        end;
        //else begin
        begin
            if not Employee.Get(User."Employee No.") then begin
                //Message('Employee %1', User."Employee No.");
                //Error(ErrorTxt) else begin
                "Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                Validate("Global Dimension 1 Code", Employee."Global Dimension 1 Code");
                "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                Status := 1;
                Validate(Status);
            end;
        end;
        IF "No." = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Recruitment Plan Nos");
            NoSeriesMgt.InitSeries(HRSetup."Recruitment Plan Nos", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        FindFiscalDate;
    end;

    trigger OnDelete()
    begin
        TestField(Status, Status::Open);
    end;

    procedure FindFiscalDate()
    var
        AccPeriod: Record "Accounting Period";
    begin
        AccPeriod.Reset;
        // AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+') then begin
            "Fiscal Year" := AccPeriod."Starting Date";
        end;
    end;
}
