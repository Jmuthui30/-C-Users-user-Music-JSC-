table 51477 "Client Company Information"
{
    // version THL- Client Payroll 1.0
    Caption = 'Company Information';

    fields
    {
        field(1; "Client No."; Code[10])
        {
            Caption = 'Client No.';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(4; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(6; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF("Country/Region Code"=CONST(''))"Post Code".City
            ELSE IF("Country/Region Code"=FILTER(<>''))"Post Code".City WHERE("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(7; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(8; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
        }
        field(9; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.';
        }
        field(10; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(11; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';

            trigger OnValidate()
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
                VATRegNoFormat.Test(IBAN, "Country/Region Code", '', DATABASE::"Company Information");
            end;
        }
        field(12; "Registration No."; Text[20])
        {
            Caption = 'Registration No.';
        }
        field(13; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(14; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF("Country/Region Code"=CONST(''))"Post Code".Code
            ELSE IF("Country/Region Code"=FILTER(<>''))"Post Code".Code WHERE("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(15; County; Text[30])
        {
            Caption = 'County';
        }
        field(16; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }
        field(17; "Home Page"; Text[80])
        {
            Caption = 'Home Page';
            ExtendedDatatype = URL;
        }
        field(18; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(19; IBAN; Code[50])
        {
            Caption = 'IBAN';
        }
        field(20; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
        }
        field(21; "Created DateTime"; DateTime)
        {
            Caption = 'Created DateTime';
            Editable = false;
        }
        field(22; "Employee Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(23; Status; Option)
        {
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active, Inactive;
        }
        field(24; "Salary Bank File Format"; Option)
        {
            OptionCaption = ' ,Citibank Format,NIC Format';
            OptionMembers = " ", "Citibank Format", "NIC Format";
        }
        field(25; "Contact Name"; Text[100])
        {
        }
        field(26; "Payroll Administrator"; Text[100])
        {
        }
        field(27; "Payroll Admin Email"; Text[80])
        {
        }
        field(28; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Client Payroll Period";
        }
        field(29; "Job Title"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Client No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var PostCode: Record "Post Code";
    Text000: Label 'The number that you entered may not be a valid International Bank Account Number (IBAN). Do you want to continue?';
    Text001: Label 'File Location for IC files';
    Text002: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
    NoPaymentInfoQst: Label 'No payment information is provided in %1. Do you want to update it now?', Comment = '%1 = Company Information';
    NoPaymentInfoMsg: Label 'No payment information is provided in %1. Review the report.';
    GLNCheckDigitErr: Label 'The %1 is not valid.';
    DevBetaModeTxt: Label 'DEV_BETA', Locked = true;
    procedure CheckIBAN(IBANCode: Code[100])
    var
        Modulus97: Integer;
        I: Integer;
    begin
    end;
    local procedure ConvertIBAN(var IBANCode: Code[100])
    var
        I: Integer;
    begin
    end;
    local procedure IBANError()
    begin
    end;
    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
    end;
}
