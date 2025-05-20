table 50031 "Company Director"
{
    Caption = 'Company Director';
    DataClassification = ToBeClassified;
    LookupPageId = "Company Directors";
    DrillDownPageId = "Company Directors";

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; Gender;Enum "Employee Gender")
        {
            Caption = 'Gender';
            DataClassification = CustomerContent;
        }
        field(4; "Nationality Code"; Code[20])
        {
            Caption = 'Nationality Code';
            DataClassification = CustomerContent;
            TableRelation = Country.Code where(Blocked=filter(false));

            trigger OnValidate()
            var
                Country: Record Country;
            begin
                Country.Reset();
                Country.SetRange(Code, Rec."Nationality Code");
                if Country.findset then Rec."Nationality Name":=Country.Name;
            end;
        }
        field(5; "Nationality Name"; Text[250])
        {
            Caption = 'Nationality Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; Email; Text[100])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;
        }
        field(7; Phone; Text[100])
        {
            Caption = 'Phone';
            DataClassification = CustomerContent;
        }
        field(8; "KRA PIN"; Code[20])
        {
            Caption = 'KRA PIN';
            DataClassification = CustomerContent;
        }
        field(9; "Passport No."; Code[50])
        {
            Caption = 'Passport No.';
            DataClassification = CustomerContent;
        }
        field(10; "Share Percentage"; Decimal)
        {
            Caption = 'Share Percentage';
            DataClassification = CustomerContent;
            MinValue = 0.01;
            MaxValue = 100;
            DecimalPlaces = 2;
        /*trigger OnValidate()
            var
                VendRegReq: Record "Vendor Reg. Request";
                CDirector: Record "Company Director";
                SharePercentageErr: Label 'Share Perecentage cannot exceed %1 current value is %2';
                TotalShares: Decimal;
            begin
                Reset();
                SetRange("Vendor No.", "Vendor No.");
                CalcSums("Share Percentage");
                if "Share Percentage" > 100 then
                    Error(SharePercentageErr, 100, CDirector."Share Percentage");
            end;*/
        }
        field(11; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; "Vendor No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
