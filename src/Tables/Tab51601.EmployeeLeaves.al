table 51601 "Employee Leaves"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Employee."No.";
        }
        field(2; "Leave Code"; Code[20])
        {
            NotBlank = false;
            TableRelation = "Leave Setup".Code;

            trigger OnValidate()
            begin
                Period.Reset;
                Period.SetRange(Period."New Fiscal Year", true);
                Period.SetRange(Period.Closed, false);
                if Period.Find('-')then StartDate:=CalcDate('1Y', Period."Starting Date") - 1;
                "Leave Types".Reset;
                "Leave Types".SetRange("Leave Types".Code, "Leave Code");
                if "Leave Types".Find('-')then begin
                    if "Leave Types".Gender <> "Leave Types".Gender::Both then begin
                        EmployeeRec.Reset;
                        EmployeeRec.SetRange(EmployeeRec."No.", "Employee No");
                        if "Leave Types".Gender = "Leave Types".Gender::Female then begin
                            if EmployeeRec.Gender <> EmployeeRec.Gender::Female then begin
                                "Leave Code":='';
                                Balance:=0;
                                Error('%1', 'You cannot assign this employee this leave.');
                            end;
                        end
                        else
                            Balance:="Leave Types".Days;
                    end
                    else
                        Balance:="Leave Types".Days;
                end;
                Balance:="Leave Types".Days;
                Balance:=Entitlement + "Balance Brought Forward" + "Recalled Days" - "Total Days Taken";
            /*IF EmployeeRec.GET("Employee No") THEN BEGIN
                   Entitlement:=(StartDate-EmployeeRec."Employment Date")/30*2.5;
                END;*/
            end;
        }
        field(3; "Maturity Date"; Date)
        {
        }
        field(4; Balance; Decimal)
        {
        }
        field(5; "Acrued Days"; Decimal)
        {
        }
        field(6; "Total Days Taken"; Decimal)
        {
            CalcFormula = Sum("Employee Leave Application"."Days Applied" WHERE("Employee No"=FIELD("Employee No"), "Leave Code"=FIELD("Leave Code"), "Maturity Date"=FIELD("Maturity Date"), Status=CONST(Released)));
            FieldClass = FlowField;
        }
        field(7; Entitlement; Decimal)
        {
        }
        field(8; "Balance Brought Forward"; Decimal)
        {
        }
        field(9; "Recalled Days"; Decimal)
        {
            CalcFormula = Sum("Employee Off/Holidays"."No. of Off Days" WHERE("Employee No"=FIELD("Employee No"), "Maturity Date"=FIELD("Maturity Date"), Recalled=CONST(true), "Leave Code"=FIELD("Leave Code")));
            FieldClass = FlowField;
        }
        field(10; "Days Absent"; Decimal)
        {
            CalcFormula = Sum("Employee Absentism"."No. of  Days Absent" WHERE("Employee No"=FIELD("Employee No"), "Maturity Date"=FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(11; "Leaves Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(12; "Temp. Emp. Contract"; Integer)
        {
        }
        field(13; "Contract No."; Integer)
        {
        }
        field(14; "Leave  Allowance Paid"; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Employee No", "Leave Code", "Maturity Date")
        {
        }
    }
    fieldgroups
    {
    }
    var "Leave Types": Record "Leave Setup";
    EmployeeRec: Record Employee;
    Period: Record "Accounting Period";
    StartDate: Date;
}
