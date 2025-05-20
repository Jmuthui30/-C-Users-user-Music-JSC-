table 52102 "Advanced Finance Setup"
{
    // version THL- ADV.FIN 1.0
    DrillDownPageID = "Advanced Finance Setup";
    LookupPageID = "Advanced Finance Setup";

    fields
    {
        field(1; "Primary Key"; Integer)
        {
        }
        field(2; "Imprest Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Emp Travels Cust Posting Group"; Code[10])
        {
            trigger OnValidate()
            begin
                if xRec."Emp Travels Cust Posting Group" <> "Emp Travels Cust Posting Group" then begin
                    CustPG.Init;
                    CustPG.Code:="Emp Travels Cust Posting Group";
                    if not CustPG2.Get("Emp Travels Cust Posting Group")then CustPG.Insert;
                end;
            end;
        }
        field(4; "Emp Travel Receivables Account"; Code[10])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if "Emp Travels Cust Posting Group" = '' then Error(Text000);
                if CustPG.Get("Emp Travels Cust Posting Group")then begin
                    CustPG.Validate("Receivables Account", "Emp Travel Receivables Account");
                    CustPG.Modify;
                end;
            end;
        }
        field(5; "Employee Bus Posting Group"; Code[10])
        {
            TableRelation = "Gen. Business Posting Group";
        }
        field(6; "Employee Payment Terms"; Code[10])
        {
            TableRelation = "Payment Terms";
        }
        field(7; "Imprest Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(8; "Imprest Payroll Deduction Code"; Code[10])
        {
            TableRelation = Deductions;
        }
        field(9; "Imprest Payroll Earning Code"; Code[10])
        {
            TableRelation = Earnings;
        }
        field(10; "Petty Cash Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(11; "Petty Cash Template"; Code[20])
        {
            TableRelation = "Gen. Journal Template";
        }
        field(12; "Contract Commitment Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(13; "Watermark Portrait"; BLOB)
        {
            SubType = Bitmap;
        }
        field(14; "Request for Payment Nos."; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(15; "RFPY Workflow User Group"; Code[20])
        {
            TableRelation = "Workflow User Group";
        }
        field(16; "PV Workflow User Group"; Code[20])
        {
            TableRelation = "Workflow User Group";
        }
        field(17; "Emp Advance Cust Posting Group"; Code[10])
        {
            trigger OnValidate()
            begin
                if xRec."Emp Travels Cust Posting Group" <> "Emp Travels Cust Posting Group" then begin
                    CustPG.Init;
                    CustPG.Code:="Emp Travels Cust Posting Group";
                    if not CustPG2.Get("Emp Travels Cust Posting Group")then CustPG.Insert;
                end;
            end;
        }
        field(18; "Emp Advance Receivable Account"; Code[10])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if "Emp Travels Cust Posting Group" = '' then Error(Text000);
                if CustPG.Get("Emp Travels Cust Posting Group")then begin
                    CustPG.Validate("Receivables Account", "Emp Travel Receivables Account");
                    CustPG.Modify;
                end;
            end;
        }
        field(19; "Emp Advances Cust No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(20; "Commitment Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(21; "Emp Travel Cust No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(22; "Staff Claim Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(23; "Suppl. Budget Request Nos"; Code[20])
        {
            TableRelation = "No. Series";
            Caption = 'Supplementary Budget Request Nos.';
        }
        field(24; "Email Pattern"; Text[250])
        {
        }
        field(25; "Narration Pattern"; Text[250])
        {
        }
        field(26; "Staff Based Budget"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50; "Imprest Memo Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(51; "DSA Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
        }
        field(52; "Air Ticket Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
        }
        field(53; "Conference Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
        }
        field(54; "G.Transport Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Ground Transport Expense Code';
        }
        field(55; "Cord. Allow Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Cordination Allowance Expense Code';
        }
        field(56; "Facilitator Allow Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Facilitator Allowance Expense Code';
        }
        field(57; "Secretariat Allow Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Secretariat Allowance Expense Code';
        }
        field(58; "Out of Pocket Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Out of Pocket Expense Code';
        }
        field(59; "Rapporteur Allow Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Rapporteur Allowance Expense Code';
        }
        field(60; "Driver Allow Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Driver Allowance Expense Code';
        }
        field(61; "Retreat Allow Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Retreat Allowance Expense Code';
        }
        field(62; "Expert Allow Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Expert Allowance Expense Code';
        }
        field(63; "Accomodation Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Accomodation Expense Code';
        }
        field(64; "Tuition Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Tuition Expense Code';
        }
        field(65; "Mileage Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Mileage Expense Code';
        }
        field(66; "Qtr. Per Diem Expense Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes";
            Caption = 'Qtr. Per Diem Expense Code';
        }
        field(67; "Imprest Payroll Claim Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        //Limits
        field(70; "Cordination Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Max. No. of Cordinators"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Facilitator Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Max. No. of Facilitators"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(74; "Secretariat Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(75; "Max. No. of Secretaries"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(76; "Out of Pocket Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Rapporteur Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(78; "Max. No. of Rapporteurs"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Driver Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Max. No. of Drivers"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Retreat Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Max. No. of Retreaters"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Max. No. of Retreat Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Expert Allowance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }
    fieldgroups
    {
    }
    var CustPG: Record "Customer Posting Group";
    CustPG2: Record "Customer Posting Group";
    Text000: Label 'You cannot insert the Receivables Account before the Posting Group Code.';
}
