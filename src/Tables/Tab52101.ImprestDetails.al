table 52101 "Imprest Details"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Imprest Details';

    fields
    {
        field(1; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                If ImprestHeader.Get("No.")then begin
                    "Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=ImprestHeader."Global Dimension 3 Code";
                end;
            end;
        }
        field(2; "Line No"; Integer)
        {
        }
        field(3; "Expense Code"; Code[50])
        {
            TableRelation = "Expense Codes";

            trigger OnValidate()
            begin
                Validate("No.");
                if ExpenseCodes.Get("Expense Code")then begin
                    Expense:=ExpenseCodes.Description;
                    Type:=ExpenseCodes."Account Type";
                    "Account No":=ExpenseCodes."Account No";
                    "Account Name":=ExpenseCodes."Account Name";
                    Decision:=ExpenseCodes."Treatment On Imprest";
                end;
            end;
        }
        field(4; Expense; Text[50])
        {
        }
        field(5; Type; Option)
        {
            OptionCaption = 'G/L Account,Vendor,Customer,Item,Fixed Asset';
            OptionMembers = "G/L Account", Vendor, Customer, Item, "Fixed Asset";
        }
        field(6; "Account No"; Code[10])
        {
        }
        field(7; "Account Name"; Text[50])
        {
        }
        field(8; Narration; Text[50])
        {
            trigger OnValidate()
            begin
                FinanceMgnt.TextRegExChecker(Narration);
            end;
        }
        field(9; "Request Amount"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                Difference:="Request Amount" - "Actual Spent";
                if Difference > 0 then begin
                    Refund:=Abs(Difference);
                    Claim:=0;
                end
                else if Difference < 0 then begin
                        Refund:=0;
                        Claim:=Abs(Difference);
                    end
                    else
                    begin
                        Refund:=0;
                        Claim:=0;
                    end;
            end;
        }
        field(10; "Actual Spent"; Decimal)
        {
            trigger OnValidate()
            begin
                Difference:="Request Amount" - "Actual Spent";
                if Difference > 0 then begin
                    Refund:=Abs(Difference);
                    Claim:=0;
                end
                else if Difference < 0 then begin
                        Refund:=0;
                        Claim:=Abs(Difference);
                    end
                    else
                    begin
                        Refund:=0;
                        Claim:=0;
                    end;
            end;
        }
        field(11; Claim; Decimal)
        {
            Editable = false;
        }
        field(12; Refund; Decimal)
        {
            Editable = false;
        }
        field(13; Difference; Decimal)
        {
            Editable = false;
        }
        field(14; Decision; Option)
        {
            OptionCaption = 'Order from Service Provider,Pay Cash to Traveller,Reject,Process to Payroll';
            OptionMembers = "Order from Service Provider", "Pay Cash to Traveller", Reject, "Process to Payroll";
        }
        field(15; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(16; Supplier; Code[10])
        {
            TableRelation = IF(Decision=CONST("Order from Service Provider"))Vendor;
        }
        field(17; UoM; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(18; Quantity; Decimal)
        {
            trigger OnValidate()
            begin
                Validate("Unit Cost");
            end;
        }
        field(19; "Unit Cost"; Decimal)
        {
            trigger OnValidate()
            begin
                "Request Amount":=Quantity * "Unit Cost";
            end;
        }
        field(20; "PV No"; Code[20])
        {
        }
        field(21; "PO No."; Code[20])
        {
        }
        field(22; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(23; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(24; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(25; "Petty Cash"; Boolean)
        {
        }
        field(26; Commited; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.", "Line No")
        {
        }
    }
    fieldgroups
    {
    }
    var ExpenseCodes: Record "Expense Codes";
    ImprestHeader: Record "Imprest Header";
    FinanceMgnt: Codeunit "Finance Management";
}
