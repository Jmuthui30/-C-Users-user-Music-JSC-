table 51460 "Client Payroll Period"
{
    // version THL- Client Payroll 1.0
    DrillDownPageID = "Client Payroll Periods";
    LookupPageID = "Client Payroll Periods";

    fields
    {
        field(1; "Starting Date"; Date)
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                Name:=Format("Starting Date", 0, '<Month Text>');
            end;
        }
        field(2; Name; Text[50])
        {
        }
        field(3; "New Fiscal Year"; Boolean)
        {
            trigger OnValidate()
            begin
                TestField("Date Locked", false);
            end;
        }
        field(4; Closed; Boolean)
        {
        }
        field(5; "Date Locked"; Boolean)
        {
            Editable = true;
        }
        field(6; "Pay Date"; Date)
        {
        }
        field(7; "Close Pay"; Boolean)
        {
            Editable = true;

            trigger OnValidate()
            begin
            //TESTFIELD("Close Pay",FALSE);
            /*
                IF "Close Pay"=TRUE THEN BEGIN
                  "Closed By":=USERID;
                  "Closed on Date":=CURRENTDATETIME;
                END;
                */
            end;
        }
        field(8; "P.A.Y.E"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Deduction), "Payroll Period"=FIELD("Starting Date"), Paye=CONST(true)));
            FieldClass = FlowField;
        }
        field(9; "Basic Pay"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Deduction), "Payroll Period"=FIELD("Starting Date"), "Basic Salary Code"=CONST(true)));
            FieldClass = FlowField;
        }
        field(10; "Closed By"; Code[30])
        {
        }
        field(11; "Closed on Date"; DateTime)
        {
        }
    }
    keys
    {
        key(Key1; "Starting Date")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if Closed = true then Error('This Period has Already Been Closed. Kindly Contact the System Admnistrator for Assistance');
    end;
    trigger OnModify()
    begin
        if Closed = true then Error('This Period has Already Been Closed. Kindly Contact the System Admnistrator for Assistance');
    end;
    trigger OnRename()
    begin
        if Closed = true then Error('This Period has Already Been Closed. Kindly Contact the System Admnistrator for Assistance');
    end;
}
