table 51454 "Client Payroll Setup"
{
    fields
    {
        field(1; Client; Code[10])
        {
            TableRelation = "Client Company Information";
        }
        field(2; "Activate Payroll"; Boolean)
        {
            trigger OnValidate()
            begin
                if "Activate Payroll" = true then OnActivatePayroll;
            end;
        }
        field(3; "Tax Table"; Code[10])
        {
            TableRelation = "Client Bracket Table";
        }
        field(4; "Corporation Tax"; Decimal)
        {
        }
        field(5; "Housing Earned Limit"; Decimal)
        {
        }
        field(6; "Pension Limit Percentage"; Decimal)
        {
        }
        field(7; "Pension Limit Amount"; Decimal)
        {
        }
        field(8; "Round Down"; Boolean)
        {
        }
        field(9; "Working Hours"; Decimal)
        {
        }
        field(10; "Payroll Rounding Precision"; Decimal)
        {
        }
        field(11; "Payroll Rounding Type";Enum PayrollRoundingType)
        {
        }
        field(12; "Special Duty Table"; Code[10])
        {
        }
        field(13; "CFW Round Deduction code"; Code[20])
        {
            TableRelation = "Client Deductions";
        }
        field(14; "BFW Round Earning code"; Code[20])
        {
            TableRelation = "Client Earnings";
        }
        field(15; "Company overtime hours"; Decimal)
        {
        }
        field(16; "Loan Product Type Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(17; "Tax Relief Amount"; Decimal)
        {
        }
        field(18; "General Payslip Message"; Text[100])
        {
        }
        field(19; "Base Calendar Code"; Code[10])
        {
            TableRelation = "Base Calendar";
        }
        field(20; "SHIF No"; Code[10])
        {
        }
        field(21; "NSSF No."; Code[10])
        {
        }
        field(22; "Owner occupier interest"; Code[10])
        {
            TableRelation = "Client Earnings".Code WHERE(Company=FIELD(Client));
        }
        field(23; "Time Sheet Penalty Code"; Code[10])
        {
            TableRelation = "Client Deductions";
        }
        field(24; "Time Sheet Earning Code"; Code[10])
        {
            TableRelation = "Client Earnings";
        }
        field(25; "Salary Advance Code"; Code[10])
        {
            TableRelation = "Client Deductions";
        }
        field(26; "Net Pay Rounding Precision"; Decimal)
        {
        }
        field(27; "Net Pay Rounding Type"; Option)
        {
            OptionMembers = Nearest, Up, Down;
        }
    }
    keys
    {
        key(Key1; Client)
        {
        }
    }
    fieldgroups
    {
    }
    [IntegrationEvent(false, false)]
    procedure OnActivatePayroll()
    begin
    end;
}
