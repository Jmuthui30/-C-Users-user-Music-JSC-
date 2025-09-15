table 51436 "Scale Benefits"
{
    // version THL- Payroll 1.0
    DrillDownPageID = "Scale Benefits";
    LookupPageID = "Scale Benefits";

    fields
    {
        field(1; Scale; Code[10])
        {
        }
        field(2; Level; Code[10])
        {
        }
        field(3; Earning; Code[10])
        {
        }
        field(4; Description; Text[50])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Salary Pointer"; Code[10])
        {
            TableRelation = "Salary Pointer"."Salary Pointer" where("Salary Scale" = field(Scale));
            Caption = 'Salary Pointer';
        }
        field(7; "Payment Option"; Option)
        {
            OptionCaption = 'Amount,Hour Rate,Daily Rate,Percentage';
            OptionMembers = Amount,"Hour Rate","Daily Rate",Percentage;
            Caption = 'Payment Option';
        }
        field(8; Rate; Decimal)
        {
            Caption = 'Rate';
        }
        field(9; "ED Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = Earning;
            Caption = 'ED Code';

            trigger OnValidate()
            var 
            EarningRec:Record Earning;
            begin
                if EarningRec.Get("ED Code") then begin
                    "ED Description" := EarningRec.Description;
                    "Basic Salary Code" := EarningRec."Basic Salary Code";
                    case EarningRec."Calculation Method" of
                        EarningRec."Calculation Method"::"Flat amount":
                            Amount := EarningRec."Flat Amount";
                    end;
                end;
            end;
        }
       
        field(10; "ED Description"; Text[30])
        {
            Caption = 'ED Description';
        }
        field(11; "Basic Salary Code"; Boolean)
        {
            Caption = 'Basic Salary Code';
            Editable = false;
        }
    }
    keys
    {
        key(Key1; Scale, Level, Earning)
        {
        }
    }
    fieldgroups
    {
    }
}
