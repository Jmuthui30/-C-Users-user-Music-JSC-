table 51604 "Employee Absentism"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if NAVEmp.Get("Employee No")then begin
                    "Employee Name":=NAVEmp."First Name" + '   ' + NAVEmp."Middle Name" + '   ' + NAVEmp."Last Name";
                /*vooIF NAVEmp."Contract Number"<>0 THEN
                    "Contract No.":=Emp."Contract Number";*/
                end;
                if "Employee No" = '' then Delete;
            end;
        }
        field(3; "Absent From"; Date)
        {
        }
        field(4; Approved; Boolean)
        {
        }
        field(5; "Absentism code"; Code[20])
        {
            TableRelation = "Employee Leave Application" WHERE(Status=CONST(Released));

            trigger OnValidate()
            begin
                GeneralOptions.Get;
                "No. of  Days Absent":=NoOfDaysOff;
            end;
        }
        field(6; "Absent To"; Date)
        {
            trigger OnValidate()
            begin
                Validate("No. of  Days Absent");
            end;
        }
        field(7; "No. of  Days Absent"; Decimal)
        {
            trigger OnValidate()
            begin
                Days:=1;
                AbsentFrom:="Absent From";
                HumanResSetup.Reset();
                HumanResSetup.Get();
                HumanResSetup.TestField(HumanResSetup."Base Calendar Code");
                NonWorkingDay:=false;
                if "Absent From" <> 0D then begin
                    if AbsentFrom < "Absent To" then begin
                        while AbsentFrom <> "Absent To" do begin
                            NonWorkingDay:=CalendarMgmt.CheckDateStatus(HumanResSetup."Base Calendar Code", AbsentFrom, Dsptn);
                            if NonWorkingDay then begin
                                NonWorkingDay:=false;
                                AbsentFrom:=CalcDate('1D', AbsentFrom);
                            end
                            else
                            begin
                                AbsentFrom:=CalcDate('1D', AbsentFrom);
                                Days:=Days + 1;
                            end;
                        end;
                    end;
                end;
                "No. of  Days Absent":=Days;
            end;
        }
        field(9; "Maturity Date"; Date)
        {
        }
        field(10; "No. Series"; Code[10])
        {
        }
        field(11; "Employee Name"; Text[30])
        {
        }
        field(12; "Absent No."; Code[20])
        {
        }
        field(13; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(14; "Fiscal Start Date"; Date)
        {
        }
        field(15; "Reported  By"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if NAVEmp.Get("Reported  By")then Name:=NAVEmp."First Name" + '' + NAVEmp."Middle Name" + '' + NAVEmp."Last Name";
            end;
        }
        field(16; Name; Text[50])
        {
            Editable = false;
        }
        field(17; "Reason for Absentism"; Text[130])
        {
        }
        field(18; Penalty; Option)
        {
            OptionCaption = ' ,Leave,Salary';
            OptionMembers = " ", Leave, Salary;

            trigger OnValidate()
            begin
                if Penalty = Penalty::Leave then begin
                    if "No. of  Days Absent" = 0 then Delete;
                    Message(' %1 Will be deducted from the leave days', "No. of  Days Absent");
                    LeaveApplication.SetRange("Employee No", xRec."Employee No");
                end
                else if Penalty = Penalty::Salary then begin
                        //Salary Deduction formula to be provided
                        if Emp.Get("Employee No")then begin
                            ScaleBenefits.Reset;
                            ScaleBenefits.SetRange(ScaleBenefits.Scale, Emp.Scale);
                            ScaleBenefits.SetRange(ScaleBenefits.Level, Emp.Level);
                            if ScaleBenefits.Find('-')then begin
                                PayrollPeriod.Reset;
                                PayrollPeriod.SetRange(PayrollPeriod."Close Pay", false);
                                if PayrollPeriod.Find('-')then PayPeriodStart:=PayrollPeriod."Starting Date";
                                assmatrix.Init;
                                assmatrix."Employee No":="Employee No";
                                assmatrix.Type:=assmatrix.Type::Deduction;
                                assmatrix.Validate(assmatrix.Code);
                                assmatrix."Payroll Period":=PayPeriodStart;
                                assmatrix.Validate("Payroll Period");
                                assmatrix.Amount:=ScaleBenefits.Amount; //Deduction
                                if not assmatrix.Get(assmatrix."Employee No", assmatrix.Type, assmatrix.Code, assmatrix."Payroll Period")then assmatrix.Insert;
                            end;
                        end;
                        Message(' %1 Will be deducted from the salary', Deduction);
                    end;
            end;
        }
        field(19; "Contract No."; Integer)
        {
        }
    }
    keys
    {
        key(Key1; "Employee No")
        {
        }
    }
    trigger OnInsert()
    begin
        Status:=Status::Open;
    end;
    var NAVEmp: Record Employee;
    GeneralOptions: Record "QuantumJumps HR Setup";
    NoOfDaysOff: Decimal;
    Days: Integer;
    AbsentFrom: Date;
    HumanResSetup: Record "QuantumJumps HR Setup";
    NonWorkingDay: Boolean;
    CalendarMgmt: Codeunit "AL Calendar Management";
    Dsptn: Text[30];
    LeaveApplication: Record "Employee Leave Application";
    Emp: Record "Employee Master";
    ScaleBenefits: Record "Scale Benefits";
    PayrollPeriod: Record "Payroll Period";
    PayPeriodStart: Date;
    assmatrix: Record "Payroll Matrix";
    Deduction: Decimal;
}
