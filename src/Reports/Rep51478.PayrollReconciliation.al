
report 51478 "Payroll Reconciliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Payroll Reconciliation.rdlc';

    dataset
    {
        dataitem("Assignment Matrix-X"; "Client Payroll Matrix")
        {
            DataItemTableView = SORTING(Type, Code) ORDER(Ascending);
            RequestFilterFields = "Payroll Period", Company;

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4)) { }
            column(COMPANYNAME; CompanyName) { }
            column(USERID; UserId) { }
            column(PayrollMonth; StrSubstNo('%1', Format(Thismonth, 0, ' '))) { }
            column(EarningCode; Code) { }
            column(EarningDescription; Desc) { }
            column(PAYROLL_RECONCILIATIONCaption; PAYROLL_RECONCILIATIONCaptionLbl) { }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl) { }
            column(EmployeeCaption; EmployeeCaptionLbl) { }
            column(Current_PeriodCaption; Current_PeriodCaptionLbl) { }
            column(Last_PeriodCaption; Last_PeriodCaptionLbl) { }
            column(DifferenceCaption; DifferenceCaptionLbl) { }
            column(Pay_Period_Filter; "Pay Period Filter") { }
            column(EarningEmployeeNo; "Employee No") { }
            column(EarningAmount; CurrentMonthVal) { }  // Changed from Amount
            column(EarningEmpName; EmpName) { }
            column(EarningLastMonthVal; LastMonthVal) { }
            column(EarningDifference; Difference) { }
            column(Type; Type) { }
            column(EanEarningCode; Code) { }
            column(EarningPayrollPeriod; "Payroll Period") { }
            column(EarningRefNo; "Reference No") { }

            trigger OnAfterGetRecord()
            begin


                // Get employee name
                if Emp.Get("Assignment Matrix-X"."Employee No") then begin
                    EmpName := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                end;

                CurrentMonthVal := 0;
                LastMonthVal := 0;
                Difference := 0;
                Desc := '';

                // Get description based on type
                if "Assignment Matrix-X".Type = "Assignment Matrix-X".Type::Payment then begin
                    if ClientEarnings.Get("Assignment Matrix-X".Company, "Assignment Matrix-X".Code) then begin
                        Desc := ClientEarnings.Description;
                        if (ClientEarnings."Earning Type" = ClientEarnings."Earning Type"::"Tax Relief") or
                           (ClientEarnings."Earning Type" = ClientEarnings."Earning Type"::"Insurance Relief") then
                            CurrReport.Skip;
                    end;
                end else if "Assignment Matrix-X".Type = "Assignment Matrix-X".Type::Deduction then begin
                    if ClientDeductions.Get("Assignment Matrix-X".Company, "Assignment Matrix-X".Code) then
                        Desc := ClientDeductions.Description;
                end;

                //  Check if this is current month or last month record
                if "Assignment Matrix-X"."Payroll Period" = Thismonth then begin
                    CurrentMonthVal := "Assignment Matrix-X".Amount;

                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
                    Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type);
                    Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
                    if Assignmat.FindFirst then
                        LastMonthVal := Assignmat.Amount
                    else
                        LastMonthVal := 0;

                end else if "Assignment Matrix-X"."Payroll Period" = Lastmonth then begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
                    Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type);
                    Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
                    Assignmat.SetRange(Assignmat."Payroll Period", Thismonth);
                    if Assignmat.FindFirst then
                        CurrReport.Skip  // handled by the this-month branch already
                    else begin
                        LastMonthVal := "Assignment Matrix-X".Amount;
                        CurrentMonthVal := 0;
                    end;
                end;


                ///asdfghjk

                Difference := CurrentMonthVal - LastMonthVal;

                // Only show records with differences
                if Difference = 0 then
                    CurrReport.Skip;

                if "Assignment Matrix-X".Code = '' then
                    CurrReport.Skip;
            end;

            trigger OnPreDataItem()
            begin
                // Set filter to include BOTH current and last month
                SetRange("Payroll Period", Lastmonth, Thismonth);
            end;
        }
    }

    requestpage
    {
        layout { }
        actions { }
    }

    labels { }

    trigger OnPreReport()
    begin
        Thismonth := "Assignment Matrix-X".GetRangeMin("Payroll Period");
        Lastmonth := CalcDate('-1M', Thismonth);
    end;

    var
        EmpName: Text[230];
        Emp: Record "Client Employee Master";
        Assignmat: Record "Client Payroll Matrix";
        Thismonth: Date;
        Lastmonth: Date;
        CurrentMonthVal: Decimal;
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


//     dataset
//     {
//         dataitem("Assignment Matrix-X"; "Assignment Matrix")
//         {
//             DataItemTableView = SORTING(Type, Code)ORDER(Ascending);
//             RequestFilterFields = "Payroll Period";

//             column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
//             {
//             }
//             column(COMPANYNAME; CompanyName)
//             {
//             }
//             /*column(CurrReport_PAGENO;CurrReport.PageNo)
//             {
//             }*/
//             column(USERID; UserId)
//             {
//             }
//             column(PayrollMonth; StrSubstNo('%1', Format(Thismonth, 0, '<month text> <year4>')))
//             {
//             }
//             column(EarningCode; Code)
//             {
//             }
//             column(EarningDescription; Desc)
//             {
//             }
//             column(PAYROLL_RECONCILIATIONCaption; PAYROLL_RECONCILIATIONCaptionLbl)
//             {
//             }
//             column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
//             {
//             }
//             column(EmployeeCaption; EmployeeCaptionLbl)
//             {
//             }
//             column(Current_PeriodCaption; Current_PeriodCaptionLbl)
//             {
//             }
//             column(Last_PeriodCaption; Last_PeriodCaptionLbl)
//             {
//             }
//             column(DifferenceCaption; DifferenceCaptionLbl)
//             {
//             }
//             column(Pay_Period_Filter;"Payroll Period")
//             {
//             }
//             column(EarningEmployeeNo; "Employee No")
//             {
//             }
//             column(EarningAmount; Amount)
//             {
//             }
//             column(EarningEmpName; EmpName)
//             {
//             }
//             column(EarningLastMonthVal; LastMonthVal)
//             {
//             }
//             column(EarningDifference; Difference)
//             {
//             }
//             column(Type; Type)
//             {
//             }
//             column(EanEarningCode; Code)
//             {
//             }
//             column(EarningPayrollPeriod; "Payroll Period")
//             {
//             }
//             column(EarningRefNo; "Reference No")
//             {
//             }
//             trigger OnAfterGetRecord()
//             begin
//                 if Emp.Get("Assignment Matrix-X"."Employee No")then begin
//                     EmpName:=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
//                 end;
//                 LastMonthVal:=0;
//                 Difference:=0;
//                 Desc:='';
//                 if "Assignment Matrix-X".Type = "Assignment Matrix-X".Type::Earning then begin
//                     if ClientEarnings.Get("Assignment Matrix-X".Code)then begin
//                         Desc:=ClientEarnings.Description;
//                         if(ClientEarnings."Earning Type" = ClientEarnings."Earning Type"::"Tax Relief") or (ClientEarnings."Earning Type" = ClientEarnings."Earning Type"::"Insurance Relief")then CurrReport.Skip;
//                     end;
//                 end
//                 else if "Assignment Matrix-X".Type = "Assignment Matrix-X".Type::Deduction then begin
//                         if ClientDeductions.Get("Assignment Matrix-X".Code)then Desc:=ClientDeductions.Description;
//                     end;
//                 Assignmat.Reset;
//                 Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
//                 Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type);
//                 Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
//                 Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
//                 Assignmat.SetRange(Assignmat.Amount, "Assignment Matrix-X".Amount);
//                 if Assignmat.FindFirst then CurrReport.Skip
//                 else
//                 begin
//                     Assignmat.Reset;
//                     Assignmat.SetRange(Assignmat."Employee No", "Assignment Matrix-X"."Employee No");
//                     Assignmat.SetRange(Assignmat.Type, "Assignment Matrix-X".Type);
//                     Assignmat.SetRange(Assignmat.Code, "Assignment Matrix-X".Code);
//                     Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
//                     if Assignmat.FindFirst then LastMonthVal:=Assignmat.Amount
//                     else if not Assignmat.FindFirst then LastMonthVal:=0;
//                 end;
//                 Difference:="Assignment Matrix-X".Amount - LastMonthVal;
//                 if Difference = 0 then CurrReport.Skip;
//                 if "Assignment Matrix-X".Code = '' then CurrReport.Skip;
//             end;
//             trigger OnPreDataItem()
//             begin
//             /* CurrReport.CreateTotals(Difference,LastMonthVal,"Assignment Matrix-X".Amount);*/
//             end;
//         }
//     }
//     requestpage
//     {
//         layout
//         {
//         }
//         actions
//         {
//         }
//     }
//     labels
//     {
//     }
//     trigger OnPreReport()
//     begin
//         Thismonth:="Assignment Matrix-X".GetRangeMin("Payroll Period");
//         Lastmonth:=CalcDate('-1M', Thismonth);
//     end;
//     var EmpName: Text[230];
//     Emp: Record "Client Employee Master";
//     Assignmat: Record "Client Payroll Matrix";
//     Thismonth: Date;
//     Lastmonth: Date;
//     LastMonthVal: Decimal;
//     Difference: Decimal;
//     PAYROLL_RECONCILIATIONCaptionLbl: Label 'PAYROLL RECONCILIATION';
//     CurrReport_PAGENOCaptionLbl: Label 'Page';
//     EmployeeCaptionLbl: Label 'Employee';
//     Current_PeriodCaptionLbl: Label 'Current Period';
//     Last_PeriodCaptionLbl: Label 'Last Period';
//     DifferenceCaptionLbl: Label 'Difference';
//     ClientEarnings: Record "Client Earnings";
//     Desc: Text;
//     ClientDeductions: Record "Client Deductions";
// }
//     dataset
//     {
//         dataitem(Earnings; Earning)
//         {
//             DataItemTableView = sorting(Code) where("Non-Cash Benefit" = const(false));
//             PrintOnlyIfDetail = true;
//             RequestFilterFields = "Pay Period Filter";

//             column(CompInfo_Picture; CompInfo.Picture)
//             {
//             }
//             column(COMPANYNAME; CompanyName)
//             {
//             }
//             column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
//             {
//             }
//             column(USERID; UserId)
//             {
//             }
//             column(STRSUBSTNO__PERIOD___1__UPPERCASE_FORMAT_Thismonth_0___month_text___year4_____; StrSubstNo('PERIOD: %1', UpperCase(Format(Thismonth, 0, '<month text> <year4>'))))
//             {
//             }
//             column(Earnings_Description; Description)
//             {
//             }
//             column(PAYROLL_RECONCILIATION_DETAILED_REPORTCaption; PAYROLL_RECONCILIATION_DETAILED_REPORTCaptionLbl)
//             {
//             }
//             column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
//             {
//             }
//             column(EmployeeCaption; EmployeeCaptionLbl)
//             {
//             }
//             column(Current_PeriodCaption; Current_PeriodCaptionLbl)
//             {
//             }
//             column(Last_PeriodCaption; Last_PeriodCaptionLbl)
//             {
//             }
//             column(DifferenceCaption; DifferenceCaptionLbl)
//             {
//             }
//             column(Earnings_Code; Code)
//             {
//             }
//             dataitem(Employee; Employee)
//             {
//                 DataItemTableView = sorting("No.") where("Employee Job Type" = const("  "), "Employee Type" = filter(<> "Board Member"));

//                 column(Employee__No__; "No.")
//                 {
//                 }
//                 column(EmpName; EmpName)
//                 {
//                 }
//                 column(ThisMonthVal; ThisMonthVal)
//                 {
//                 }
//                 column(LastMonthVal; LastMonthVal)
//                 {
//                 }
//                 column(Difference; Difference)
//                 {
//                 }
//                 column(ThisMonthVal_Control1000000043; ThisMonthVal)
//                 {
//                 }
//                 column(LastMonthVal_Control1000000044; LastMonthVal)
//                 {
//                 }
//                 column(Difference_Control1000000045; Difference)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     LastMonthVal := 0;
//                     Difference := 0;
//                     ThisMonthVal := 0;
//                     EmpName := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
//                     //Last Month
//                     Assignmat.Reset();
//                     Assignmat.SetRange(Assignmat."Employee No", "No.");
//                     Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Earning);
//                     Assignmat.SetRange(Assignmat.Code, Earnings.Code);
//                     Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
//                     if Assignmat.Find('+') then
//                         LastMonthVal := Assignmat.Amount;

//                     //CurrentMonth
//                     Assignmat.Reset();
//                     Assignmat.SetRange(Assignmat."Employee No", "No.");
//                     Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Earning);
//                     Assignmat.SetRange(Assignmat.Code, Earnings.Code);
//                     Assignmat.SetRange(Assignmat."Payroll Period", Thismonth);
//                     if Assignmat.Find('+') then
//                         ThisMonthVal := Assignmat.Amount;
//                     Difference := ThisMonthVal - LastMonthVal;
//                     if Difference = 0 then
//                         CurrReport.Skip();
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     //CurrReport.CreateTotals(Difference, LastMonthVal, ThisMonthVal);
//                 end;
//             }
//         }
//         dataitem(Deductions; Deduction)
//         {
//             DataItemTableView = sorting(Code);
//             PrintOnlyIfDetail = true;

//             column(Deductions_Description; Description)
//             {
//             }
//             column(Deductions_Code; Code)
//             {
//             }
//             dataitem(EmpDed; Employee)
//             {
//                 DataItemTableView = sorting("No.") where("Employee Job Type" = const("  "), "Employee Type" = filter(<> "Board Member"));

//                 column(EmpDed__No__; "No.")
//                 {
//                 }
//                 column(EmpName_Control1000000035; EmpName)
//                 {
//                 }
//                 column(ThisMonthVal_Control1000000036; ThisMonthVal)
//                 {
//                 }
//                 column(LastMonthVal_Control1000000037; LastMonthVal)
//                 {
//                 }
//                 column(Difference_Control1000000038; Difference)
//                 {
//                 }
//                 column(ThisMonthVal_Control1000000039; ThisMonthVal)
//                 {
//                 }
//                 column(LastMonthVal_Control1000000040; LastMonthVal)
//                 {
//                 }
//                 column(Difference_Control1000000041; Difference)
//                 {
//                 }

//                 trigger OnAfterGetRecord()
//                 begin
//                     LastMonthVal := 0;
//                     Difference := 0;
//                     ThisMonthVal := 0;
//                     EmpName := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
//                     //Last Month
//                     Assignmat.Reset();
//                     Assignmat.SetRange(Assignmat."Employee No", "No.");
//                     Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Deduction);
//                     Assignmat.SetRange(Assignmat.Code, Deductions.Code);
//                     Assignmat.SetRange(Assignmat."Payroll Period", Lastmonth);
//                     if Assignmat.Find('+') then
//                         LastMonthVal := Assignmat.Amount + Assignmat."Loan Interest";

//                     //CurrentMonth
//                     Assignmat.Reset();
//                     Assignmat.SetRange(Assignmat."Employee No", "No.");
//                     Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Deduction);
//                     Assignmat.SetRange(Assignmat.Code, Deductions.Code);
//                     Assignmat.SetRange(Assignmat."Payroll Period", Thismonth);
//                     if Assignmat.Find('+') then
//                         ThisMonthVal := Assignmat.Amount + Assignmat."Loan Interest";
//                     Difference := ThisMonthVal - LastMonthVal;
//                     if Difference = 0 then
//                         CurrReport.Skip();
//                 end;

//                 trigger OnPreDataItem()
//                 begin
//                     //CurrReport.CreateTotals(Difference, LastMonthVal, ThisMonthVal);
//                 end;
//             }
//         }
//     }

//     requestpage
//     {
//         layout
//         {
//         }

//         actions
//         {
//         }
//     }
//     labels
//     {
//     }

//     trigger OnPreReport()
//     begin
//         CompInfo.Get();
//         CompInfo.CalcFields(Picture);

//         Thismonth := Earnings.GetRangeMin(Earnings."Pay Period Filter");
//         Lastmonth := CalcDate('-1M', Thismonth);
//     end;

//     var
//         Assignmat: Record "Assignment Matrix";
//         CompInfo: Record "Company Information";
//         Lastmonth: Date;
//         Thismonth: Date;
//         Difference: Decimal;
//         LastMonthVal: Decimal;
//         ThisMonthVal: Decimal;
//         Current_PeriodCaptionLbl: Label 'Current Period';
//         CurrReport_PAGENOCaptionLbl: Label 'Page';
//         DifferenceCaptionLbl: Label 'Difference';
//         EmployeeCaptionLbl: Label 'Employee';
//         Last_PeriodCaptionLbl: Label 'Last Period';
//         PAYROLL_RECONCILIATION_DETAILED_REPORTCaptionLbl: Label 'PAYROLL RECONCILIATION DETAILED REPORT';
//         EmpName: Text[230];
// }
