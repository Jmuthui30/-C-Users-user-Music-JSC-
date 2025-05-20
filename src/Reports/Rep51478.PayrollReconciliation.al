report 51478 "Payroll Reconciliation"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Payroll Reconciliation.rdlc';

    dataset
    {
        dataitem("Assignment Matrix-X"; "Client Payroll Matrix")
        {
            DataItemTableView = SORTING(Type, Code)ORDER(Ascending);
            RequestFilterFields = "Payroll Period", Company;

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            /*column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }*/
            column(USERID; UserId)
            {
            }
            column(PayrollMonth; StrSubstNo('%1', Format(Thismonth, 0, '<month text> <year4>')))
            {
            }
            column(EarningCode; Code)
            {
            }
            column(EarningDescription; Desc)
            {
            }
            column(PAYROLL_RECONCILIATIONCaption; PAYROLL_RECONCILIATIONCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(Current_PeriodCaption; Current_PeriodCaptionLbl)
            {
            }
            column(Last_PeriodCaption; Last_PeriodCaptionLbl)
            {
            }
            column(DifferenceCaption; DifferenceCaptionLbl)
            {
            }
            column(Pay_Period_Filter; "Pay Period Filter")
            {
            }
            column(EarningEmployeeNo; "Employee No")
            {
            }
            column(EarningAmount; Amount)
            {
            }
            column(EarningEmpName; EmpName)
            {
            }
            column(EarningLastMonthVal; LastMonthVal)
            {
            }
            column(EarningDifference; Difference)
            {
            }
            column(Type; Type)
            {
            }
            column(EanEarningCode; Code)
            {
            }
            column(EarningPayrollPeriod; "Payroll Period")
            {
            }
            column(EarningRefNo; "Reference No")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if Emp.Get("Assignment Matrix-X"."Employee No")then begin
                    EmpName:=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                end;
                LastMonthVal:=0;
                Difference:=0;
                Desc:='';
                if "Assignment Matrix-X".Type = "Assignment Matrix-X".Type::Payment then begin
                    if ClientEarnings.Get("Assignment Matrix-X".Company, "Assignment Matrix-X".Code)then begin
                        Desc:=ClientEarnings.Description;
                        if(ClientEarnings."Earning Type" = ClientEarnings."Earning Type"::"Tax Relief") or (ClientEarnings."Earning Type" = ClientEarnings."Earning Type"::"Insurance Relief")then CurrReport.Skip;
                    end;
                end
                else if "Assignment Matrix-X".Type = "Assignment Matrix-X".Type::Deduction then begin
                        if ClientDeductions.Get("Assignment Matrix-X".Company, "Assignment Matrix-X".Code)then Desc:=ClientDeductions.Description;
                    end;
                Assignmat.Reset;
                Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
                Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type);
                Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
                Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
                Assignmat.SetRange(Assignmat.Amount, "Assignment Matrix-X".Amount);
                if Assignmat.FindFirst then CurrReport.Skip
                else
                begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
                    Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type);
                    Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
                    if Assignmat.FindFirst then LastMonthVal:=Assignmat.Amount
                    else if not Assignmat.FindFirst then LastMonthVal:=0;
                end;
                Difference:="Assignment Matrix-X".Amount - LastMonthVal;
                if Difference = 0 then CurrReport.Skip;
                if "Assignment Matrix-X".Code = '' then CurrReport.Skip;
            end;
            trigger OnPreDataItem()
            begin
            /* CurrReport.CreateTotals(Difference,LastMonthVal,"Assignment Matrix-X".Amount);*/
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        Thismonth:="Assignment Matrix-X".GetRangeMin("Payroll Period");
        Lastmonth:=CalcDate('-1M', Thismonth);
    end;
    var EmpName: Text[230];
    Emp: Record "Client Employee Master";
    Assignmat: Record "Client Payroll Matrix";
    Thismonth: Date;
    Lastmonth: Date;
    LastMonthVal: Decimal;
    Difference: Decimal;
    PAYROLL_RECONCILIATIONCaptionLbl: Label 'PAYROLL RECONCILIATION';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    EmployeeCaptionLbl: Label 'Employee';
    Current_PeriodCaptionLbl: Label 'Current Period';
    Last_PeriodCaptionLbl: Label 'Last Period';
    DifferenceCaptionLbl: Label 'Difference';
    ClientEarnings: Record "Client Earnings";
    Desc: Text;
    ClientDeductions: Record "Client Deductions";
}
