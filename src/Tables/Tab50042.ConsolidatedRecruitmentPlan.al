table 50042 "Consolidated Recruitment Plan"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Consolidated Recruitment Plans";
    LookupPageId = "Consolidated Recruitment Plans";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Fiscal Year"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                ConsolidatedPlan: Record "Consolidated Recruitment Plan";
            begin
                ConsolidatedPlan.Reset();
                ConsolidatedPlan.SetRange("Fiscal Year", "Fiscal Year");
                if ConsolidatedPlan.FindFirst()then Error('You have already consolidated for this year, Select another period.');
            end;
        }
        field(5; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No. Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Status;Enum "Document Status")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Created By"; Code[50])
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
    trigger OnInsert()
    var
        HRSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        "Document Date":=today;
        "Created By":=UserId;
        Status:=Status::Open;
        IF "No." = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Cons. Recruitment Plan Nos");
            NoSeriesMgt.InitSeries(HRSetup."Cons. Recruitment Plan Nos", xRec."No. Series", 0D, "No.", "No. Series");
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
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+')then begin
            "Fiscal Year":=AccPeriod."Starting Date";
        end;
    end;
}
