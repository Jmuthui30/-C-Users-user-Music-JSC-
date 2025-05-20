table 51430 "Payroll Period"
{
    // version THL- Payroll 1.0
    DrillDownPageID = "Payroll Periods";
    LookupPageID = "Payroll Periods";

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
            Editable = false;
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
        }
        field(9; "Basic Pay"; Decimal)
        {
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
}
