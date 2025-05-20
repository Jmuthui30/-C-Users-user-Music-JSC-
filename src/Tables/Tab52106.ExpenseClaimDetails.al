table 52106 "Expense Claim Details"
{
    fields
    {
        field(1; No; Code[10])
        {
            trigger OnValidate()
            begin
                If ExpenseClaimHeader.Get(No)then begin
                    "Global Dimension 1 Code":=ExpenseClaimHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=ExpenseClaimHeader."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=ExpenseClaimHeader."Global Dimension 3 Code";
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
                Validate(No);
                if ExpenseCode.Get("Expense Code")then begin
                    Expense:=ExpenseCode.Description;
                    Type:=ExpenseCode."Account Type";
                    "Account No":=ExpenseCode."Account No";
                    Description:=ExpenseCode."Account Name";
                end;
            end;
        }
        field(4; Expense; Text[30])
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
        field(7; Description; Text[250])
        {
        }
        field(8; Amount; Decimal)
        {
            trigger OnValidate()
            Var
                TotalAmount: Decimal;
            begin
                TotalAmount:=0;
                If Amount < 10000 then begin
                    ClaimDetails.Reset();
                    ClaimDetails.SetRange(No, Rec.No);
                    ClaimDetails.SetFilter(Amount, '<>%1', 0);
                    ClaimDetails.CalcSums(Amount);
                    TotalAmount:=ClaimDetails.Amount;
                    if((TotalAmount + Amount) > 10000)then Error('For an expense claim above 10,000, Kindly create a Imprest Request!');
                end
                else
                    Error('For an expense claim above 10,000, Kindly create a Imprest Request!');
            end;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(11; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
    }
    keys
    {
        key(Key1; No, "Line No")
        {
        }
    }
    fieldgroups
    {
    }
    var ExpenseCode: Record "Expense Codes";
    ClaimDetails: Record "Expense Claim Details";
    ExpenseClaimHeader: Record "Expense Claim Header";
}
