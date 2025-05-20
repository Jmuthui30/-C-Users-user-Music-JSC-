table 51481 "Client Deductions"
{
    // version THL- Client Payroll 1.0
    DrillDownPageID = "Client Deductions";
    LookupPageID = "Client Deductions";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Deductions Master";

            trigger OnValidate()
            begin
                if DeductionsMaster.Get(Code)then begin
                    Init;
                    TransferFields(DeductionsMaster);
                    Insert;
                end;
            end;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Type; Option)
        {
            OptionMembers = Recurring, "Non-recurring";
        }
        field(6; "Reduces Taxable Amt"; Boolean)
        {
        }
        field(7; Advance; Boolean)
        {
        }
        field(10; Percentage; Decimal)
        {
        }
        field(11; "Calculation Method";Enum DeductionCalculationType)
        {
        }
        field(12; "G/L Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(13; "Flat Amount"; Decimal)
        {
        }
        field(14; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE("Employee No"=FIELD("Employee Filter"), Type=FILTER(Deduction|"Saving Scheme"), "Payroll Period"=FIELD("Pay Period Filter"), "Payroll Group"=FIELD("Employee Group Filter"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"), "Reference No"=FIELD("Reference Filter"), Code=FIELD(Code), Company=FIELD(Company)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Date Filter"; Date)
        {
        }
        field(16; "Employee Group Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Employee Groups";
        }
        field(17; Loan; Boolean)
        {
        }
        field(18; "Maximum Amount"; Decimal)
        {
        }
        field(21; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Client Payroll Period";
        }
        field(26; "Pension Scheme"; Boolean)
        {
        }
        field(27; "Deduction Table"; Code[10])
        {
            TableRelation = "Client Bracket Table";
        }
        field(28; "G/L Account Employer"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(29; "Percentage Employer"; Decimal)
        {
        }
        field(30; "Minimum Amount"; Decimal)
        {
        }
        field(31; "Flat Amount Employer"; Decimal)
        {
        }
        field(32; "Total Amount Employer"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix"."Employer Amount" WHERE(Type=CONST(Deduction), Code=FIELD(Code), "Payroll Period"=FIELD("Pay Period Filter"), "Payroll Group"=FIELD("Employee Group Filter"), "Employee No"=FIELD("Employee Filter"), Company=FIELD(Company)));
            FieldClass = FlowField;
        }
        field(33; "Loan Type"; Option)
        {
            OptionMembers = " ", "Low Interest Benefit", "Fringe Benefit";
        }
        field(34; "Show Balance"; Boolean)
        {
        }
        field(35; CoinageRounding; Boolean)
        {
        }
        field(36; "Employee Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(38; "Global Dimension 2 Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(40; "Main Loan Code"; Code[20])
        {
        }
        field(41; Shares; Boolean)
        {
        }
        field(42; "Show on report"; Boolean)
        {
        }
        field(43; "Non-Interest Loan"; Boolean)
        {
        }
        field(44; "Exclude when on Leave"; Boolean)
        {
        }
        field(45; "Co-operative"; Boolean)
        {
        }
        field(46; "Total Shares"; Decimal)
        {
        }
        field(48; "PAYE Code"; Boolean)
        {
        }
        field(49; "Total Days"; Decimal)
        {
        }
        field(51; "Pension Limit Percentage"; Decimal)
        {
        }
        field(52; "Pension Limit Amount"; Decimal)
        {
        }
        field(53; "Applies to All"; Boolean)
        {
        }
        field(54; "Show on Master Roll"; Boolean)
        {
        }
        field(55; "Pension Scheme Code"; Boolean)
        {
        }
        field(56; "Main Deduction Code"; Code[10])
        {
        }
        field(57; "Insurance Code"; Boolean)
        {
        }
        field(58; Block; Boolean)
        {
        }
        field(59; "Institution Code"; Code[20])
        {
            TableRelation = Institution;
        }
        field(60; "Reference Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(61; "Show on Payslip Information"; Boolean)
        {
        }
        field(62; "Voluntary Percentage"; Decimal)
        {
        }
        field(63; "Salary Recovery"; Boolean)
        {
            Description = 'For Paye manual calculation';
        }
        field(64; Gratuity; Boolean)
        {
        }
        field(65; "Gratuity Arrears"; Boolean)
        {
        }
        field(66; Informational; Boolean)
        {
        }
        field(67; Board; Boolean)
        {
        }
        field(68; "Pension Arrears"; Boolean)
        {
        }
        field(69; "Grace period"; DateFormula)
        {
        }
        field(70; "Repayment Period"; DateFormula)
        {
        }
        field(71; Company; Code[10])
        {
            TableRelation = "Client Company Information";
        }
        field(72; "SHIF Code"; Boolean)
        {
        }
        field(73; "NSSF Code"; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; Company, "Code")
        {
        }
    }
    fieldgroups
    {
    }
    var DeductionsMaster: Record "Deductions Master";
}
