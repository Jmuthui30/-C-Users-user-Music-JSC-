table 51629 "Medical Claim"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if EmpRec.Get("Employee No.")then begin
                    "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                end;
                if NAVemp.Get("Employee No.")then begin
                    "Employee Name":=NAVemp."Last Name" + ' ' + NAVemp."First Name" + ' ' + NAVemp."Middle Name";
                    "Job Title":=NAVemp."Job Title";
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; "Job Title"; Text[30])
        {
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(7; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(8; "Claim Date"; Date)
        {
        }
        field(9; "Pay Claim To"; Option)
        {
            OptionCaption = 'Service Provider,Employee';
            OptionMembers = "Service Provider", Employee;
        }
        field(10; "Service Provider"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Suppliers.Get("Service Provider")then "Service Provider Name":=Suppliers.Name;
            end;
        }
        field(11; "Service Provider Name"; Text[50])
        {
        }
        field(12; "Visit Date"; Date)
        {
        }
        field(13; "Patient Name"; Text[100])
        {
        }
        field(14; "Hospital/Specialist"; Text[50])
        {
        }
        field(15; Policy; Code[10])
        {
            TableRelation = "Employee Medical Cover" WHERE("Employee No."=FIELD("Employee No."), "Cover Status"=CONST(Active));

            trigger OnValidate()
            begin
                if Policies.Get(Policy)then begin
                    "Policy Name":=Policies.Description;
                    "Cover Amount":=Policies."Cover Amount";
                    Policies.CalcFields(Expenditure);
                    "Expenditure To Date":=Policies.Expenditure;
                    Balance:="Cover Amount" - "Expenditure To Date";
                    "Settled By":=Policies."Settled By";
                    "Pay Claim To":=Policies."Pay Claim To";
                end;
            end;
        }
        field(16; "Policy Name"; Text[30])
        {
        }
        field(17; "Cover Amount"; Decimal)
        {
        }
        field(18; "Expenditure To Date"; Decimal)
        {
        }
        field(19; Balance; Decimal)
        {
        }
        field(20; "Claim Amount"; Decimal)
        {
        }
        field(21; "Invoice No."; Code[20])
        {
        }
        field(22; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(23; Settled; Boolean)
        {
        }
        field(24; "Settled Date"; Date)
        {
        }
        field(25; "Payment Tx. No. (Cheque No.)"; Code[20])
        {
        }
        field(26; "Created By"; Code[50])
        {
        }
        field(27; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(28; "Self Created"; Boolean)
        {
        }
        field(29; "Settled By"; Option)
        {
            OptionCaption = 'Insurance,Our Organization';
            OptionMembers = Insurance, "Our Organization";
        }
        field(30; "Claim Paying Account"; Code[10])
        {
            TableRelation = "Bank Account";
        }
        field(31; "Claim Pay Mode"; Code[10])
        {
            TableRelation = "Pay Mode";
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
            ClaimSetup.Get;
            ClaimSetup.TestField("Claim Nos.");
            NoSeriesMgt.InitSeries(ClaimSetup."Claim Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Claim Date":=Today;
        Status:=Status::Open;
        if "Self Created" then begin
            if UserSetup.Get(UserId)then begin
                "Employee No.":=UserSetup."Employee No.";
                Validate("Employee No.");
            end;
        end;
        "Created By":=UserId;
    end;
    var ClaimSetup: Record "Medical Covers Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UsersRec: Record "User Setup";
    NAVemp: Record Employee;
    EmpRec: Record "Employee Master";
    UserSetup: Record "User Setup";
    Suppliers: Record Vendor;
    Policies: Record "Employee Medical Cover";
}
