report 52210 "Client Total Payroll Cost"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Client Total Payroll Cost.rdlc';
    Caption = 'Client Total Payroll Cost';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Assignment Matrix-X"; "Client Payroll Matrix")
        {
            DataItemTableView = SORTING(Type, Code)ORDER(Ascending);
            RequestFilterFields = "Payroll Period", Company, "Payroll Group";

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
            column(Logo; CompInfo.Picture)
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
            column(TotalPay; Assignmat."Taxable amount")
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
            column(Company; Company)
            {
            }
            column(EanEarningCode; Code)
            {
            }
            column(institution; ClientDeductions."Institution Code")
            {
            }
            column(TotalEarnings; TotalEarnings)
            {
            }
            column(TotalDeductions; TotalDeductions)
            {
            }
            column(Netpay; Netpay)
            {
            }
            column(NoOfEmployees; NoOfEmployees)
            {
            }
            column(EarningPayrollPeriod; "Payroll Period")
            {
            }
            column(Description; Description)
            {
            }
            column(Employer_Amount; "Employer Amount")
            {
            }
            column(EarningRefNo; "Reference No")
            {
            }
            column(Payroll_Group; "Payroll Group")
            {
            }
            column(EmpGroup; EmpGroup)
            {
            Caption = 'Employee Group';
            }
            trigger OnAfterGetRecord()
            begin
                if Emp.Get("Assignment Matrix-X"."Employee No")then begin
                    EmpName:=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    "Payroll Group":=Emp."Employee Group";
                end;
                TotalEarnings:=0;
                TotalDeductions:=0;
                Desc:='';
                if "Assignment Matrix-X".Type = "Assignment Matrix-X".Type::Payment then begin
                    if ClientEarnings.Get("Assignment Matrix-X".Company, "Assignment Matrix-X".Code)then begin
                        Desc:=ClientEarnings.Description;
                        begin
                            if(ClientEarnings."Earning Type" = ClientEarnings."Earning Type"::"Tax Relief") or (ClientEarnings."Earning Type" = ClientEarnings."Earning Type"::"Insurance Relief") or (ClientEarnings."Earning Type" = ClientEarnings."Earning Type"::"Owner Occupier")then CurrReport.Skip;
                        end;
                    end;
                end
                else if "Assignment Matrix-X".Type = "Assignment Matrix-X".Type::Deduction then begin
                        if ClientDeductions.Get("Assignment Matrix-X".Company, "Assignment Matrix-X".Code)then Desc:=ClientDeductions.Description;
                    end;
                begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
                    Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type::Payment);
                    //Assignmat.SetRange(Assignmat.Company, "Assignment Matrix-X".Company);
                    Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", "Assignment Matrix-X"."Payroll Period");
                    if Assignmat.FindFirst then TotalEarnings:=Assignmat.Amount end;
                begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
                    Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type::Payment);
                    Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", "Assignment Matrix-X"."Payroll Period");
                    if Assignmat.Findfirst then EarningAmount:=Assignmat.Amount;
                end;
                begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
                    Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type::Deduction);
                    Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", "Assignment Matrix-X"."Payroll Period");
                    if Assignmat.FindFirst then TotalDeductions:=Assignmat.Amount end;
                begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
                    Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type::Deduction);
                    Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", "Assignment Matrix-X"."Payroll Period");
                    if Assignmat.FindFirst then "Employer Amount":=Assignmat."Employer Amount" end;
                begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
                    Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
                    Assignmat.SetRange(Assignmat.Company, "Assignment Matrix-X".Company);
                    Assignmat.SetRange(Assignmat."Payroll Period", "Assignment Matrix-X"."Payroll Period");
                    if Assignmat.FindFirst then Netpay:=TotalEarnings - TotalDeductions;
                end;
                begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
                    Assignmat.SetRange(Assignmat.Company, "Assignment Matrix-X".Company);
                    Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type::Deduction);
                    Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", "Assignment Matrix-X"."Payroll Period");
                    if Assignmat.FindFirst then "Employer Amount":=Assignmat."Employer Amount" end;
                //Message('my company is %1', Company);
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
        SaveValues = true;

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
    //Lastmonth := CalcDate('-1M', Thismonth);
    end;
    var EmpName: Text[230];
    Emp: Record "Client Employee Master";
    Assignmat: Record "Client Payroll Matrix";
    Thismonth: Date;
    Lastmonth: Date;
    LastMonthVal: Decimal;
    Difference: Decimal;
    PAYROLL_RECONCILIATIONCaptionLbl: Label 'PAYROLL COST';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    EmployeeCaptionLbl: Label 'Employee';
    Current_PeriodCaptionLbl: Label 'Current Period';
    Last_PeriodCaptionLbl: Label 'Last Period';
    DifferenceCaptionLbl: Label 'Difference';
    ClientEarnings: Record "Client Earnings";
    Desc: Text;
    CompInfo: Record "Client Company Information";
    TotalEarnings: Decimal;
    TotalDeductions: Decimal;
    ClientDeductions: Record "Client Deductions";
    Netpay: Decimal;
    EarningAmount: Decimal;
    NoOfEmployees: Integer;
    PostingGroup: Record "Employee Posting Group";
    EMPPostingGroup: Record "Client Employee Groups";
    EmpGroup: Code[100];
}
