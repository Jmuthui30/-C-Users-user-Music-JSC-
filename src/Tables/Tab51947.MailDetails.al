table 51947 "Mail Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if EmpRec.Get("Employee Code")then begin
                    "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                end;
                if NAVemp.Get("Employee Code")then "Employee Name":=NAVemp.FullName();
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(4; Status;Enum "Document Status")
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "No. Series"; code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(6; "Raised by"; Code[50])
        {
            Editable = false;
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=FILTER(1));
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(9; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(10; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Time; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Sender's Detail"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(14; Receiver; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Item Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Personal/Official"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Personal,Official';
            OptionMembers = Personal, Official;
        }
        field(17; "Send To"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Department,Employee';
            OptionMembers = Department, Employee;
        }
        field(18; "Send To No."; code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Send To"=CONST(Department))"Dimension Value".Code WHERE("Global Dimension No."=FILTER(1))
            ELSE IF("Send To"=CONST(Employee))Employee;

            trigger OnValidate()
            begin
                if "Send To" = "Send To"::Department then begin
                    //if Dim.Get("Send To No.") then begin
                    if DimValue.Get("Send To No.")then begin
                        "Send To Name":=DimValue.Name;
                    end;
                end;
                if "Send To" = "Send To"::Employee then begin
                    if NAVemp1.Get("Send To No.")then "Send To Name":=NAVemp1.FullName();
                end;
            end;
        }
        field(19; "Send To Name"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Posted Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Posted By"; code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Mail Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Incoming Mail,Outgoing Mail';
            OptionMembers = "Incoming Mail", "Outgoing Mail";
        }
        field(23; "Sender's Department"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=FILTER(1));
        }
        field(24; "Destination Contact"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Carrier"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(26; AssistEdit; Boolean)
        {
            DataClassification = CustomerContent;
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
        PurchSetup.Get;
        if "No." = '' then begin
            PurchSetup.TestField("Mail No.");
            NoSeriesMgt.InitSeries(PurchSetup."Mail No.", xRec."No.", 0D, "No.", "No. Series");
        end;
        "Raised by":=UserId;
        if UsersRec.Get(UserId)then begin
            UsersRec.TestField("Employee No.");
            "Employee Code":=UsersRec."Employee No.";
            Validate("Employee Code");
        end;
    end;
    var PurchSetup: Record "Procurement Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UsersRec: Record "User Setup";
    NAVemp: Record Employee;
    EmpRec: Record "Employee Master";
    Dim: Record Dimension;
    DimValue: Record "Dimension Value";
    NAVemp1: Record Employee;
    procedure AssitEdit(): Boolean begin
        PurchSetup.Get;
        PurchSetup.TestField("Mail No.");
        if NoSeriesMgt.SelectSeries(PurchSetup."Mail No.", xRec."No. Series", "No. Series")then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
