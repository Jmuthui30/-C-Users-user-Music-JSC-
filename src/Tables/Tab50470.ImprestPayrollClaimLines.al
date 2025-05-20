table 50470 "Imprest Payroll Claim Lines"
{
    Caption = 'Imprest Payroll Claim Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Line No"; Integer)
        {
        }
        field(3; "Employee No"; Code[20])
        {
            TableRelation = "Client Employee Master"."No." where(Status=const(Active));

            trigger OnValidate()
            begin
                if Emp.Get(Rec."Employee No")then begin
                    Rec."Employee Name":=Emp."First Name" + ' ' + Emp."Last Name";
                end;
            end;
        }
        field(4; "Employee Name"; Text[150])
        {
        }
        field(5; "Expense Code"; Code[50])
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
        field(6; Expense; Text[50])
        {
        }
        field(7; Type; Option)
        {
            OptionCaption = 'G/L Account,Vendor,Customer,Item,Fixed Asset';
            OptionMembers = "G/L Account", Vendor, Customer, Item, "Fixed Asset";
        }
        field(8; "Account No"; Code[10])
        {
        }
        field(9; "Account Name"; Text[50])
        {
        }
        field(10; Narration; Text[50])
        {
            trigger OnValidate()
            begin
                FinanceMgnt.TextRegExChecker(Narration);
            end;
        }
        field(11; Amount; Decimal)
        {
        }
        field(12; Decision; Option)
        {
            OptionCaption = 'Order from Service Provider,Pay Cash to Traveller,Reject,Process to Payroll';
            OptionMembers = "Order from Service Provider", "Pay Cash to Traveller", Reject, "Process to Payroll";
        }
        field(13; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(14; UoM; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(15; Quantity; Decimal)
        {
            trigger OnValidate()
            begin
                Validate("Unit Cost");
            end;
        }
        field(16; "Unit Cost"; Decimal)
        {
            trigger OnValidate()
            begin
                Amount:=Quantity * "Unit Cost";
            end;
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(19; "Payroll Code"; Code[20])
        {
            TableRelation = "Client Company Information";

            trigger OnValidate()
            begin
            end;
        }
        field(20; "Payroll Earning Code"; Code[20])
        {
            TableRelation = "Client Earnings".Code where(Company=field("Payroll Code"));

            trigger OnValidate()
            begin
                if Earn.Get(Rec."Payroll Code", Rec."Payroll Earning Code")then Rec."Payroll Description":=Earn.Description;
            end;
        }
        field(21; "Payroll Description"; Text[150])
        {
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
    ImprestHeader: Record "Imprest Payroll Claims Header";
    FinanceMgnt: Codeunit "Finance Management";
    Emp: Record "Client Employee Master";
    Earn: Record "Client Earnings";
}
