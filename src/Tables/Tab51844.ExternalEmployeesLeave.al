table 51844 "External Employees Leave"
{
    // version THL- PRM 1.0
    DrillDownPageID = "Ex Employees Leaves list";
    LookupPageID = "Ex Employees Leaves list";

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if No <> xRec.No then begin
                    OutsourcingSetup.Get;
                    NoSeriesMgt.TestManual(OutsourcingSetup."Employee Leave Nos.");
                    "No. Series":='';
                end;
            end;
        }
        field(2; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(3; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Client Employee Master";

            trigger OnValidate()
            begin
                if ClientEmployeeMaster.Get("Employee No.")then "Employee Name":=ClientEmployeeMaster."First Name" + ' ' + ClientEmployeeMaster."Middle Name" + ' ' + ClientEmployeeMaster."Last Name";
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Leave Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Sick Off,Sick Leave,Marternity,Parternity,Annual,Unpaid Leave';
            OptionMembers = " ", "Sick Off", "Sick Leave", Marternity, Parternity, Annual, "Unpaid Leave";
        }
        field(8; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Posted By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Annual Days"; Integer)
        {
            FieldClass = Normal;
        }
        field(11; "Other Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; No)
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if No = '' then begin
            OutsourcingSetup.Get;
            OutsourcingSetup.TestField("Employee Leave Nos.");
            NoSeriesMgt.InitSeries(OutsourcingSetup."Employee Leave Nos.", xRec."No. Series", 0D, No, "No. Series");
        end;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    OutsourcingSetup: Record "Outsourcing Setup";
    ClientEmployeeMaster: Record "Client Employee Master";
}
