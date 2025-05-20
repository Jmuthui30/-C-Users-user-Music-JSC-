table 51823 "Cost Period"
{
    // version THL- PRM 1.0
    DrillDownPageID = "Cost Periods";
    LookupPageID = "Cost Periods";

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
        field(6; "Analysis Date"; Date)
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
        field(8; "Fuel Cost"; Decimal)
        {
        }
        field(9; "Total Mileage"; Decimal)
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
