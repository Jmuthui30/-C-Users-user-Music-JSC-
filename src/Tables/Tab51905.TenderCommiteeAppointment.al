table 51905 "Tender Commitee Appointment"
{
    DrillDownPageID = "Appointment List";
    LookupPageID = "Appointment List";

    fields
    {
        field(1; "Tender/Quotation No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request";

            trigger OnValidate()
            begin
                if TenderRec.Get("Tender/Quotation No")then begin
                    Title:=TenderRec.Title;
                end;
            end;
        }
        field(2; "Committee ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Commitee";

            trigger OnValidate()
            begin
                if ProcurementComittee.Get("Committee ID")then begin
                    "Committee Name":=ProcurementComittee.Description;
                end;
            end;
        }
        field(3; "Committee Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; Title; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Appointment No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(50000; "Deadline For Report Submission"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Appointment No")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        TestField(Status, Status::Open);
    end;
    trigger OnInsert()
    begin
        PurchSetup.Get;
        PurchSetup.TestField(PurchSetup."Appointment Nos.");
        NoSeriesMgt.InitSeries(PurchSetup."Appointment Nos.", xRec."No. Series", 0D, "Appointment No", "No. Series");
        "Creation Date":=Today;
        "User ID":=UserId;
        Status:=Status::Open;
    end;
    var ProcurementComittee: Record "Procurement Commitee";
    TenderRec: Record "Procurement Request";
    PurchSetup: Record "Procurement Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
