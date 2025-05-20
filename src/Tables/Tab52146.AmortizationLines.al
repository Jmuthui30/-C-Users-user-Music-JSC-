table 52146 "Amortization Lines"
{
    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; Period; Date)
        {
        }
        field(3; "Period Name"; Text[30])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Invoiced; Boolean)
        {
        }
        field(6; "Invoice No"; Code[20])
        {
        }
        field(7; Expensed; Boolean)
        {
            trigger OnValidate()
            begin
                if DMY2Date(1, 1, Date2DMY(Today, 3)) > Period then begin
                    if Expensed = false then Error('This period has been expensed.');
                end;
                if Expensed = true then "Expensed Date":=Today
                else
                    "Expensed Date":=0D;
                "Expensed By":=UserId;
            end;
        }
        field(8; "Expense No"; Code[20])
        {
        }
        field(9; "Invoiced By"; Code[50])
        {
        }
        field(10; "Expensed By"; Code[50])
        {
        }
        field(11; "Invoiced Date"; Date)
        {
        }
        field(12; "Expensed Date"; Date)
        {
        }
        field(13; Addition; Decimal)
        {
        }
        field(14; "Total Adition"; Decimal)
        {
        }
        field(15; "Amount Distributed"; Decimal)
        {
            CalcFormula = Sum("Amortization Distribution".Amount WHERE(No=FIELD(No), Period=FIELD(Period)));
            FieldClass = FlowField;
        }
        field(16; "Distribution Base"; Integer)
        {
            CalcFormula = Sum("Amortization Distribution"."Distribution Share" WHERE(No=FIELD(No), Period=FIELD(Period)));
            FieldClass = FlowField;
        }
        field(17; "Addition Distributed"; Decimal)
        {
            CalcFormula = Sum("Amortization Distribution".Addition WHERE(No=FIELD(No), Period=FIELD(Period)));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; No, Period)
        {
        }
    }
    fieldgroups
    {
    }
}
