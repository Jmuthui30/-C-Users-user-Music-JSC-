table 51883 "Vendor Reg. Request"
{
    LookupPageId = "Vendor Reg Requests";
    DrillDownPageId = "Vendor Reg Requests";
    DataCaptionFields = "No.", "Company Name";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Request Date';
        }
        field(3; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Company Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "VAT Reg No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Tax Id Number"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Company Date Reg Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Company Date of Registration Date';
        }
        field(8; "Cert. Of Incorporation No"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Certificate of Incorporation No';
        }
        field(9; "Reg. Office Address"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Registered Office Address';
        }
        field(10; State; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Email Address"; Text[50])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                atExists: Boolean;
                CountedXters: Integer;
            begin
                Clear(atExists);
                Clear(CountedXters);
                if "Email Address" <> '' then begin
                    repeat begin
                        CountedXters:=CountedXters + 1;
                        if(CopyStr("Email Address", CountedXters, 1)) = '@' then atExists:=true;
                    end;
                    until((CountedXters = StrLen("Email Address")) or atExists);
                    if atExists = false then Error('Provide a valid email address!');
                end;
            end;
        }
        field(12; "Phone Number"; Text[50])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = PhoneNo;
        }
        field(13; "Mem Articles Of Assoc Link"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Memoradum Articles Of Association Link';
        }
        field(14; "Cert Of Incorporation Link"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Certificate Of Incorporation Link';
            ExtendedDatatype = URL;
        }
        field(15; "CO7 Part. Of Directors Link"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Form CO7 Partculars Of Directors Link';
            ExtendedDatatype = URL;
        }
        field(16; "VAT Registration Cert Link"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Registration Certificate Link';
            ExtendedDatatype = URL;
        }
        field(17; "Tax Clearance Cert Link"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tax Clearance Certificate Link';
            ExtendedDatatype = URL;
        }
        field(18; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(19; "Vendor No"; Code[20])
        {
            TableRelation = Vendor;
            Editable = false;
        }
        field(20; Status;Enum "Document Status")
        {
            Editable = false;

            trigger OnValidate()
            begin
                if Rec.Status = Rec.Status::Released then VendorOnboardingMgnt.CreateVendor(Rec);
            end;
        }
        field(21; "Vendor Created"; Boolean)
        {
            Editable = false;
            Caption = 'Effected';
        }
        field(22; Approvers; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51883), "Document No."=FIELD("No."), Status=FILTER(Approved)));
            FieldClass = FlowField;
            Caption = 'Approvers';
        }
        field(23; "Pending Approvals Ext"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51883), "Document No."=FIELD("No."), Status=FILTER(Open|Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
            Editable = false;
        }
        field(24; "Vendor Reg Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Local Vendor (Limited),Local Vendor (Non-Limited),International Vendor';
            OptionMembers = " ", "Local Vendor (Limited)", "Local Vendor (Non-Limited)", "International Vendor";
        }
        field(25; Country; text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Country.Code where(Blocked=filter(false));

            trigger OnValidate()
            var
                Country: Record Country;
            begin
                Country.Reset();
                Country.SetRange(Code, Rec.Country);
                if Country.FindSet()then "Country Name":=Country.Name;
            end;
        }
        field(100; "Country Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(26; "Registration No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; "Account No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Bank Sort Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Bank Address"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(31; AssistEdit; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(40; "Ownership";Enum CompanyOwnership)
        {
            DataClassification = CustomerContent;
        }
        field(41; "KRA PIN"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(42; City; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(43; Street; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(44; "Postal Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(45; "P.O Box"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(46; Telephone; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(47; Fax; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(48; "Company Email"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(49; "Company Phone"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50; "Alternative Company Phone"; Code[250])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(51; Title; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(52; Firstname; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(53; Surname; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(54; Gender;Enum "Employee Gender")
        {
            DataClassification = CustomerContent;
        }
        field(55; "National ID No."; Code[20])
        {
            DataClassification = CustomerContent;
        //NotBlank = true;
        }
        field(56; "Personal KRA PIN"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(57; "Primary Phone"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(58; "E-Mail"; Text[100])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = EMail;
        }
        field(59; "Other Attachments"; Text[250])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(60; "Certificate of Incorporation"; Text[250])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(61; "KRA PIN Certificate"; Text[250])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(62; CR12; Text[250])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(63; AGPO; Text[250])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
        field(64; "Other Certificates"; Text[250])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        field(65; "Bank Branch Name"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(66; "Bank Code"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Commercial Banks".Code;

            trigger OnValidate()
            begin
                CommercialBanks.Reset();
                CommercialBanks.SetRange(Code, "Bank Code");
                if CommercialBanks.FindSet()then begin
                    "Bank Name":=CommercialBanks.Name;
                    "Bank Swift Code":=CommercialBanks."Swift Code";
                end;
            end;
        }
        field(67; "Bank Branch Code"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Bank Branches"."Branch Code";

            trigger OnValidate()
            begin
                CommercialBankBranches.Reset();
                CommercialBankBranches.SetRange("Bank Code", "Bank Code");
                CommercialBankBranches.SetRange("Branch Code", "Bank Branch Code");
                if CommercialBankBranches.FindSet()then begin
                    "Bank Branch Name":=CommercialBankBranches."Branch Name";
                end;
            end;
        }
        field(68; "Bank Swift Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70; "Bank Account No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(69; Notes; Text[2048])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    trigger OnInsert()
    begin
        ProcurementSetup.Get;
        if "No." = '' then begin
            ProcurementSetup.TestField("Vendor Reg Req Nos.");
            NoSeriesMgt.InitSeries(ProcurementSetup."Vendor Reg Req Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Created By":=UserId;
        Status:=Status::Open;
        Date:=Today;
    end;
    trigger OnDelete()
    begin
        TestField(Status, Status::Open);
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    ProcurementSetup: Record "Procurement Setup";
    VendorOnboardingMgnt: Codeunit "Vendor Onboarding Mgnt";
    CommercialBanks: Record "Commercial Banks";
    CommercialBankBranches: Record "Bank Branches";
}
