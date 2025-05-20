table 52222 "HR Activities Cue"
{
    fields
    {
        field(1; "Primary Key"; Code[30])
        {
        }
        field(2; "Active Employees"; Integer)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = Count("Employee" where(Status=filter(Active)));
        }
        field(3; "In-Active Employees"; Integer)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = Count("Employee" WHERE(Status=CONST(InActive)));
        }
        field(4; "All Jobs"; Integer)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count("Company Jobs");
        }
        field(5; "Male Employees"; Integer)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count("Employee" where(Gender=const(Male)));
        }
        field(6; "Female Employees"; Integer)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count("Employee" where(Gender=const(Female)));
        }
        field(7; "Current Payroll Period"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Payroll Period"."Starting Date" where(Closed=const(false)));
        }
        field(8; "Net Pay"; Decimal)
        {
            BlankZero = true;
            //FieldClass = FlowField;
            //CalcFormula = sum("Client Payroll Matrix.Amount where("Code" = const('NPAY'), "Closed" = const(false), "Payroll Group" = filter('<>BOARD')));
            DecimalPlaces = 0: 0;
        }
        field(9; "Basic Pay"; Decimal)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = sum("Client Payroll Matrix".Amount where("Basic Salary Code"=const(true)));
            // CalcFormula = sum("Client Payroll Matrix".Amount where("code" = const('BPAY'), Closed = const(false), "Payroll Group" = filter('<>BOARD')));
            DecimalPlaces = 0: 0;
        }
        field(10; "Allowances"; Decimal)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = sum("Client Payroll Matrix".Amount where(Type=const(Payment)));
            //CalcFormula = sum("Client Payroll Matrix.Amount where("Payroll Period" = const(3),"Closed" = const(false), emp = filter('<>BOARD')));
            DecimalPlaces = 0: 0;
        }
        field(11; "SHIF"; Decimal)
        {
            BlankZero = true;
            FieldClass = FlowField;
            //CalcFormula = sum("Client Payroll Matrix.Amount where("SHIF Code" = const(true), "Closed" = const(false), "Payroll Group" = filter('<>BOARD')));
            CalcFormula = sum("Client Payroll Matrix".Amount where("SHIF Code"=const(true)));
            DecimalPlaces = 0: 0;
        }
        field(12; Provident; Decimal)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = sum("Client Payroll Matrix".Amount where(Retirement=const(true)));
            //CalcFormula = sum("Client Payroll Matrix.Amount where("Code" = const('Provident'), "Closed" = const(false), "Payroll Group" = filter('<>BOARD')));
            DecimalPlaces = 0: 0;
        }
        field(13; "PAYE"; Decimal)
        {
            BlankZero = true;
            FieldClass = FlowField;
            // CalcFormula = sum("Client Payroll Matrix.Amount where("Code" = const('PAYE'), "Closed" = const(false), "Posting Group" = filter('<>BOARD')));
            CalcFormula = sum("Client Payroll Matrix".Amount where(Paye=const(true)));
            DecimalPlaces = 0: 0;
        }
        field(14; "Purchase Quotes"; Integer)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type"=filter(Quote)));
        }
        field(15; "Purchase Orders"; Integer)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type"=filter(Order)));
        }
        field(16; "Purchase Invoices"; Integer)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count("Purchase Header" where("Document Type"=filter(Invoice)));
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
}
