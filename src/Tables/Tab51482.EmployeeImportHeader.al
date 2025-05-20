table 51482 "Employee Import Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Date; Date)
        {
        }
        field(3; Company; Code[20])
        {
            TableRelation = "Client Company Information";

            trigger OnValidate()
            begin
                if Comp.Get(Company)then "Company Name":=Comp.Name;
            end;
        }
        field(4; "Company Name"; Text[100])
        {
        }
        field(5; "Created By"; Code[50])
        {
        }
        field(6; "Created Date"; Date)
        {
        }
        field(7; Posted; Boolean)
        {
        }
        field(8; "Posted By"; Code[50])
        {
        }
        field(9; "Posted Date"; Date)
        {
        }
        field(10; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
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
            OutsourcingSetup.Get;
            OutsourcingSetup.TestField("Employee Import Nos.");
            NoSeriesMgt.InitSeries(OutsourcingSetup."Employee Import Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Date:=Today;
        "Created By":=UserId;
        "Created Date":=Today;
    end;
    var OutsourcingSetup: Record "Outsourcing Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Comp: Record "Client Company Information";
}
