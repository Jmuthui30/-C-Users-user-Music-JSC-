table 51659 "Job Template"
{
    LookupPageId = "Job Template List";
    DrillDownPageId = "Job Template Card";
    DataCaptionFields = "No.", "Job Title";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(2; "Job Title"; Text[30])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(3; Description; Text[250])
        {
            DataClassification = CustomerContent;
            caption = 'Description';
        }
        field(4; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5; "Job Tasks"; Text[200])
        {
            DataClassification = CustomerContent;
            caption = 'Job Tasks';
        }
        field(6; "Areas of Responsibility"; Text[200])
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if CompJob.Get("Job No.")then begin
                    CompJob."Job Template":=Rec."No.";
                    CompJob.Modify(true);
                end;
            end;
        }
        field(7; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Company Jobs";

            trigger OnValidate()
            begin
                if CompJob.Get("Job No.")then begin
                    "Job Title":=CompJob.Name;
                    Description:=CompJob.Objective;
                    CompJob."Job Template":=Rec."No.";
                    CompJob.Modify(true);
                end;
            end;
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
    begin
        if "No." = '' then begin
            QuantumJumpsHRSetup.Get;
            QuantumJumpsHRSetup.TestField("Job Templ Nos");
            NoSeriesMgt.InitSeries(QuantumJumpsHRSetup."Job Templ Nos", '', 0D, "No.", "No. Series");
        end;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    QuantumJumpsHRSetup: Record "QuantumJumps HR Setup";
    CompJob: Record "Company Jobs";
}
