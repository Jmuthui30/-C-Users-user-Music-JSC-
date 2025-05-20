table 51448 "Payroll Apportionment"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
        }
        field(2; "Payroll Period"; Date)
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = 'Payment,Deduction,Saving Scheme,Loan,Informational';
            OptionMembers = Payment, Deduction, "Saving Scheme", Loan, Informational;
        }
        field(4; "ED Code"; Code[10])
        {
        }
        field(5; "ED Description"; Text[50])
        {
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(8; Amount; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; "Employee No.", "Payroll Period", Type, "ED Code", "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
        }
    }
    fieldgroups
    {
    }
}
