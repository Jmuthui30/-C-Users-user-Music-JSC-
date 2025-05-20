report 51479 "Client Salary 12 Month Report"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Client Salary 12 Month Report.rdlc';
    Caption = 'Salary 12 Months Report';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; "Client Employee Master")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Company Code";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompInfo.Name)
            {
            }
            /*column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }*/
            column(Logo; CompInfo.Picture)
            {
            }
            column(USERID; UserId)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UpperCase(Format(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(TIME; Time)
            {
            }
            column(CostCenter; "Cost Center Code")
            {
            }
            column(MonthOne; Month[1])
            {
            }
            column(MonthTwo; Month[2])
            {
            }
            column(MonthThree; Month[3])
            {
            }
            column(MonthFour; Month[4])
            {
            }
            column(MonthFive; Month[5])
            {
            }
            column(MonthSix; Month[6])
            {
            }
            column(MonthSeven; Month[7])
            {
            }
            column(MonthEight; Month[8])
            {
            }
            column(MonthNine; Month[9])
            {
            }
            column(MonthTen; Month[10])
            {
            }
            column(MonthEleven; Month[11])
            {
            }
            column(MonthTwelve; Month[12])
            {
            }
            column(EarnDesc_1_; EarnDesc[1])
            {
            }
            column(EarnDesc_2_; EarnDesc[2])
            {
            }
            column(EarnDesc_3_; EarnDesc[3])
            {
            }
            column(EarnDesc_4_; EarnDesc[4])
            {
            }
            column(EarnDesc_5_; EarnDesc[5])
            {
            }
            column(EarnDesc_6_; EarnDesc[6])
            {
            }
            column(EarnDesc_7_; EarnDesc[7])
            {
            }
            column(EarnDesc_8_; EarnDesc[8])
            {
            }
            column(EarnDesc_9_; EarnDesc[9])
            {
            }
            column(EarnDesc_10_; EarnDesc[10])
            {
            }
            column(DedDesc_1_; DedDesc[1])
            {
            }
            column(DedDesc_2_; DedDesc[2])
            {
            }
            column(DedDesc_3_; DedDesc[3])
            {
            }
            column(DedDesc_4_; DedDesc[4])
            {
            }
            column(DedDesc_5_; DedDesc[5])
            {
            }
            column(DedDesc_6_; DedDesc[6])
            {
            }
            column(Other_Deductions_;'Other Deductions')
            {
            }
            column(CCDesc_1_; CCDesc[1])
            {
            }
            column(CCDesc_2_; CCDesc[2])
            {
            }
            column(CCDesc_3_; CCDesc[3])
            {
            }
            column(CCDesc_4_; CCDesc[4])
            {
            }
            column(CCDesc_5_; CCDesc[5])
            {
            }
            column(Net_Pay_;'Net Pay')
            {
            }
            column(PF_No__;'PF No.')
            {
            }
            column(Name_;'Name')
            {
            }
            column(Employee__No__; "Payroll No.")
            {
            }
            column(Allowances_1_; Allowances[1, 1])
            {
            }
            column(Allowances_2_; Allowances[1, 2])
            {
            }
            column(Allowances_3_; Allowances[1, 3])
            {
            }
            column(Allowances_4_; Allowances[1, 4])
            {
            }
            column(Allowances_5_; Allowances[1, 5])
            {
            }
            column(Allowances_6_; Allowances[1, 6])
            {
            }
            column(Allowances_7_; Allowances[1, 7])
            {
            }
            column(Allowances_8_; Allowances[1, 8])
            {
            }
            column(Allowances_9_; Allowances[1, 9])
            {
            }
            column(Allowances_10_; Allowances[1, 10])
            {
            }
            column(Allowances_2_1_; Allowances[2, 1])
            {
            }
            column(Allowances_2_2_; Allowances[2, 2])
            {
            }
            column(Allowances_2_3_; Allowances[2, 3])
            {
            }
            column(Allowances_2_4_; Allowances[2, 4])
            {
            }
            column(Allowances_2_5_; Allowances[2, 5])
            {
            }
            column(Allowances_2_6_; Allowances[2, 6])
            {
            }
            column(Allowances_2_7_; Allowances[2, 7])
            {
            }
            column(Allowances_2_8_; Allowances[2, 8])
            {
            }
            column(Allowances_2_9_; Allowances[2, 9])
            {
            }
            column(Allowances_2_10_; Allowances[2, 10])
            {
            }
            column(Allowances_3_1_; Allowances[3, 1])
            {
            }
            column(Allowances_3_2_; Allowances[3, 2])
            {
            }
            column(Allowances_3_3_; Allowances[3, 3])
            {
            }
            column(Allowances_3_4_; Allowances[3, 4])
            {
            }
            column(Allowances_3_5_; Allowances[3, 5])
            {
            }
            column(Allowances_3_6_; Allowances[3, 6])
            {
            }
            column(Allowances_3_7_; Allowances[3, 7])
            {
            }
            column(Allowances_3_8_; Allowances[3, 8])
            {
            }
            column(Allowances_3_9_; Allowances[3, 9])
            {
            }
            column(Allowances_3_10_; Allowances[3, 10])
            {
            }
            column(Allowances_4_1_; Allowances[4, 1])
            {
            }
            column(Allowances_4_2_; Allowances[4, 2])
            {
            }
            column(Allowances_4_3_; Allowances[4, 3])
            {
            }
            column(Allowances_4_4_; Allowances[4, 4])
            {
            }
            column(Allowances_4_5_; Allowances[4, 5])
            {
            }
            column(Allowances_4_6_; Allowances[4, 6])
            {
            }
            column(Allowances_4_7_; Allowances[4, 7])
            {
            }
            column(Allowances_4_8_; Allowances[4, 8])
            {
            }
            column(Allowances_4_9_; Allowances[4, 9])
            {
            }
            column(Allowances_4_10_; Allowances[4, 10])
            {
            }
            column(Allowances_5_1_; Allowances[5, 1])
            {
            }
            column(Allowances_5_2_; Allowances[5, 2])
            {
            }
            column(Allowances_5_3_; Allowances[5, 3])
            {
            }
            column(Allowances_5_4_; Allowances[5, 4])
            {
            }
            column(Allowances_5_5_; Allowances[5, 5])
            {
            }
            column(Allowances_5_6_; Allowances[5, 6])
            {
            }
            column(Allowances_5_7_; Allowances[5, 7])
            {
            }
            column(Allowances_5_8_; Allowances[5, 8])
            {
            }
            column(Allowances_5_9_; Allowances[5, 9])
            {
            }
            column(Allowances_5_10_; Allowances[5, 10])
            {
            }
            column(Allowances_6_1_; Allowances[6, 1])
            {
            }
            column(Allowances_6_2_; Allowances[6, 2])
            {
            }
            column(Allowances_6_3_; Allowances[6, 3])
            {
            }
            column(Allowances_6_4_; Allowances[6, 4])
            {
            }
            column(Allowances_6_5_; Allowances[6, 5])
            {
            }
            column(Allowances_6_6_; Allowances[6, 6])
            {
            }
            column(Allowances_6_7_; Allowances[6, 7])
            {
            }
            column(Allowances_6_8_; Allowances[6, 8])
            {
            }
            column(Allowances_6_9_; Allowances[6, 9])
            {
            }
            column(Allowances_6_10_; Allowances[6, 10])
            {
            }
            column(Allowances_7_1_; Allowances[7, 1])
            {
            }
            column(Allowances_7_2_; Allowances[7, 2])
            {
            }
            column(Allowances_7_3_; Allowances[7, 3])
            {
            }
            column(Allowances_7_4_; Allowances[7, 4])
            {
            }
            column(Allowances_7_5_; Allowances[7, 5])
            {
            }
            column(Allowances_7_6_; Allowances[7, 6])
            {
            }
            column(Allowances_7_7_; Allowances[7, 7])
            {
            }
            column(Allowances_7_8_; Allowances[7, 8])
            {
            }
            column(Allowances_7_9_; Allowances[7, 9])
            {
            }
            column(Allowances_7_10_; Allowances[7, 10])
            {
            }
            column(Allowances_8_1_; Allowances[8, 1])
            {
            }
            column(Allowances_8_2_; Allowances[8, 2])
            {
            }
            column(Allowances_8_3_; Allowances[8, 3])
            {
            }
            column(Allowances_8_4_; Allowances[8, 4])
            {
            }
            column(Allowances_8_5_; Allowances[8, 5])
            {
            }
            column(Allowances_8_6_; Allowances[8, 6])
            {
            }
            column(Allowances_8_7_; Allowances[8, 7])
            {
            }
            column(Allowances_8_8_; Allowances[8, 8])
            {
            }
            column(Allowances_8_9_; Allowances[8, 9])
            {
            }
            column(Allowances_8_10_; Allowances[8, 10])
            {
            }
            column(Allowances_9_1_; Allowances[9, 1])
            {
            }
            column(Allowances_9_2_; Allowances[9, 2])
            {
            }
            column(Allowances_9_3_; Allowances[9, 3])
            {
            }
            column(Allowances_9_4_; Allowances[9, 4])
            {
            }
            column(Allowances_9_5_; Allowances[9, 5])
            {
            }
            column(Allowances_9_6_; Allowances[9, 6])
            {
            }
            column(Allowances_9_7_; Allowances[9, 7])
            {
            }
            column(Allowances_9_8_; Allowances[9, 8])
            {
            }
            column(Allowances_9_9_; Allowances[9, 9])
            {
            }
            column(Allowances_9_10_; Allowances[9, 10])
            {
            }
            column(Allowances_10_1_; Allowances[10, 1])
            {
            }
            column(Allowances_10_2_; Allowances[10, 2])
            {
            }
            column(Allowances_10_3_; Allowances[10, 3])
            {
            }
            column(Allowances_10_4_; Allowances[10, 4])
            {
            }
            column(Allowances_10_5_; Allowances[10, 5])
            {
            }
            column(Allowances_10_6_; Allowances[10, 6])
            {
            }
            column(Allowances_10_7_; Allowances[10, 7])
            {
            }
            column(Allowances_10_8_; Allowances[10, 8])
            {
            }
            column(Allowances_10_9_; Allowances[10, 9])
            {
            }
            column(Allowances_10_10_; Allowances[10, 10])
            {
            }
            column(OtherEarn; OtherEarn)
            {
            }
            column(Allowances_11_1_; Allowances[11, 1])
            {
            }
            column(Allowances_11_2_; Allowances[11, 2])
            {
            }
            column(Allowances_11_3_; Allowances[11, 3])
            {
            }
            column(Allowances_11_4_; Allowances[11, 4])
            {
            }
            column(Allowances_11_5_; Allowances[11, 5])
            {
            }
            column(Allowances_11_6_; Allowances[11, 6])
            {
            }
            column(Allowances_11_7_; Allowances[11, 7])
            {
            }
            column(Allowances_11_8_; Allowances[11, 8])
            {
            }
            column(Allowances_11_9_; Allowances[11, 9])
            {
            }
            column(Allowances_11_10_; Allowances[11, 10])
            {
            }
            column(Allowances_12_1_; Allowances[12, 1])
            {
            }
            column(Allowances_12_2_; Allowances[12, 2])
            {
            }
            column(Allowances_12_3_; Allowances[12, 3])
            {
            }
            column(Allowances_12_4_; Allowances[12, 4])
            {
            }
            column(Allowances_12_5_; Allowances[12, 5])
            {
            }
            column(Allowances_12_6_; Allowances[12, 6])
            {
            }
            column(Allowances_12_7_; Allowances[12, 7])
            {
            }
            column(Allowances_12_8_; Allowances[12, 8])
            {
            }
            column(Allowances_12_9_; Allowances[12, 9])
            {
            }
            column(Allowances_12_10_; Allowances[12, 10])
            {
            }
            column(Totallowances_1_; Totallowances[1])
            {
            }
            column(Totallowances_2_; Totallowances[2])
            {
            }
            column(Totallowances_3_; Totallowances[3])
            {
            }
            column(Totallowances_4_; Totallowances[4])
            {
            }
            column(Totallowances_5_; Totallowances[5])
            {
            }
            column(Totallowances_6_; Totallowances[6])
            {
            }
            column(Totallowances_7_; Totallowances[7])
            {
            }
            column(Totallowances_8_; Totallowances[8])
            {
            }
            column(Totallowances_9_; Totallowances[9])
            {
            }
            column(Totallowances_10_; Totallowances[10])
            {
            }
            column(GrossPay; GrossPay[1])
            {
            }
            column(GrossPay_2_; GrossPay[2])
            {
            }
            column(GrossPay_3_; GrossPay[3])
            {
            }
            column(GrossPay_4_; GrossPay[4])
            {
            }
            column(GrossPay_5_; GrossPay[5])
            {
            }
            column(GrossPay_6_; GrossPay[6])
            {
            }
            column(GrossPay_7_; GrossPay[7])
            {
            }
            column(GrossPay_8_; GrossPay[8])
            {
            }
            column(GrossPay_9_; GrossPay[9])
            {
            }
            column(GrossPay_10_; GrossPay[10])
            {
            }
            column(GrossPay_11_; GrossPay[11])
            {
            }
            column(GrossPay_12_; GrossPay[12])
            {
            }
            column(TotalGrossPay; TotalGrossPay)
            {
            }
            column(Deductions_1_; Deductions[1, 1])
            {
            }
            column(Deductions_2_; Deductions[1, 2])
            {
            }
            column(Deductions_3_; Deductions[1, 3])
            {
            }
            column(Deductions_4_; Deductions[1, 4])
            {
            }
            column(Deductions_5_; Deductions[1, 5])
            {
            }
            column(Deductions_6_; Deductions[1, 6])
            {
            }
            column(Deductions_2_1_; Deductions[2, 1])
            {
            }
            column(Deductions_2_2_; Deductions[2, 2])
            {
            }
            column(Deductions_2_3_; Deductions[2, 3])
            {
            }
            column(Deductions_2_4_; Deductions[2, 4])
            {
            }
            column(Deductions_2_5_; Deductions[2, 5])
            {
            }
            column(Deductions_2_6_; Deductions[2, 6])
            {
            }
            column(Deductions_3_1_; Deductions[3, 1])
            {
            }
            column(Deductions_3_2_; Deductions[3, 2])
            {
            }
            column(Deductions_3_3_; Deductions[3, 3])
            {
            }
            column(Deductions_3_4_; Deductions[3, 4])
            {
            }
            column(Deductions_3_5_; Deductions[3, 5])
            {
            }
            column(Deductions_3_6_; Deductions[3, 6])
            {
            }
            column(Deductions_4_1_; Deductions[4, 1])
            {
            }
            column(Deductions_4_2_; Deductions[4, 2])
            {
            }
            column(Deductions_4_3_; Deductions[4, 3])
            {
            }
            column(Deductions_4_4_; Deductions[4, 4])
            {
            }
            column(Deductions_4_5_; Deductions[4, 5])
            {
            }
            column(Deductions_4_6_; Deductions[4, 6])
            {
            }
            column(Deductions_5_1_; Deductions[5, 1])
            {
            }
            column(Deductions_5_2_; Deductions[5, 2])
            {
            }
            column(Deductions_5_3_; Deductions[5, 3])
            {
            }
            column(Deductions_5_4_; Deductions[5, 4])
            {
            }
            column(Deductions_5_5_; Deductions[5, 5])
            {
            }
            column(Deductions_5_6_; Deductions[5, 6])
            {
            }
            column(Deductions_6_1_; Deductions[6, 1])
            {
            }
            column(Deductions_6_2_; Deductions[6, 2])
            {
            }
            column(Deductions_6_3_; Deductions[6, 3])
            {
            }
            column(Deductions_6_4_; Deductions[6, 4])
            {
            }
            column(Deductions_6_5_; Deductions[6, 5])
            {
            }
            column(Deductions_6_6_; Deductions[6, 6])
            {
            }
            column(Deductions_7_1_; Deductions[7, 1])
            {
            }
            column(Deductions_7_2_; Deductions[7, 2])
            {
            }
            column(Deductions_7_3_; Deductions[7, 3])
            {
            }
            column(Deductions_7_4_; Deductions[7, 4])
            {
            }
            column(Deductions_7_5_; Deductions[7, 5])
            {
            }
            column(Deductions_7_6_; Deductions[7, 6])
            {
            }
            column(Deductions_8_1_; Deductions[8, 1])
            {
            }
            column(Deductions_8_2_; Deductions[8, 2])
            {
            }
            column(Deductions_8_3_; Deductions[8, 3])
            {
            }
            column(Deductions_8_4_; Deductions[8, 4])
            {
            }
            column(Deductions_8_5_; Deductions[8, 5])
            {
            }
            column(Deductions_8_6_; Deductions[8, 6])
            {
            }
            column(Deductions_9_1_; Deductions[9, 1])
            {
            }
            column(Deductions_9_2_; Deductions[9, 2])
            {
            }
            column(Deductions_9_3_; Deductions[9, 3])
            {
            }
            column(Deductions_9_4_; Deductions[9, 4])
            {
            }
            column(Deductions_9_5_; Deductions[9, 5])
            {
            }
            column(Deductions_9_6_; Deductions[9, 6])
            {
            }
            column(Deductions_10_1_; Deductions[10, 1])
            {
            }
            column(Deductions_10_2_; Deductions[10, 2])
            {
            }
            column(Deductions_10_3_; Deductions[10, 3])
            {
            }
            column(Deductions_10_4_; Deductions[10, 4])
            {
            }
            column(Deductions_10_5_; Deductions[10, 5])
            {
            }
            column(Deductions_10_6_; Deductions[10, 6])
            {
            }
            column(Deductions_11_1_; Deductions[11, 1])
            {
            }
            column(Deductions_11_2_; Deductions[11, 2])
            {
            }
            column(Deductions_11_3_; Deductions[11, 3])
            {
            }
            column(Deductions_11_4_; Deductions[11, 4])
            {
            }
            column(Deductions_11_5_; Deductions[11, 5])
            {
            }
            column(Deductions_11_6_; Deductions[11, 6])
            {
            }
            column(Deductions_12_1_; Deductions[12, 1])
            {
            }
            column(Deductions_12_2_; Deductions[12, 2])
            {
            }
            column(Deductions_12_3_; Deductions[12, 3])
            {
            }
            column(Deductions_12_4_; Deductions[12, 4])
            {
            }
            column(Deductions_12_5_; Deductions[12, 5])
            {
            }
            column(Deductions_12_6_; Deductions[12, 6])
            {
            }
            column(TotalDed_1_; TotalDeductions[1])
            {
            }
            column(TotalDed_2_; TotalDeductions[2])
            {
            }
            column(TotalDed_3_; TotalDeductions[3])
            {
            }
            column(TotalDed_4_; TotalDeductions[4])
            {
            }
            column(TotalDed_5_; TotalDeductions[5])
            {
            }
            column(TotalDed_6_; TotalDeductions[6])
            {
            }
            column(OtherDeduct; OtherDeduct)
            {
            }
            column(TotalGrossDeduction; TotalGrossDeduction)
            {
            }
            column(CompanyCosts_1_; CompanyCosts[1, 1])
            {
            }
            column(CompanyCosts_2_; CompanyCosts[1, 2])
            {
            }
            column(CompanyCosts_3_; CompanyCosts[1, 3])
            {
            }
            column(CompanyCosts_4_; CompanyCosts[1, 4])
            {
            }
            column(CompanyCosts_5_; CompanyCosts[1, 5])
            {
            }
            column(CompanyCosts_2_1_; CompanyCosts[2, 1])
            {
            }
            column(CompanyCosts_2_2_; CompanyCosts[2, 2])
            {
            }
            column(CompanyCosts_2_3_; CompanyCosts[2, 3])
            {
            }
            column(CompanyCosts_2_4_; CompanyCosts[2, 4])
            {
            }
            column(CompanyCosts_2_5_; CompanyCosts[2, 5])
            {
            }
            column(CompanyCosts_3_1_; CompanyCosts[3, 1])
            {
            }
            column(CompanyCosts_3_2_; CompanyCosts[3, 2])
            {
            }
            column(CompanyCosts_3_3_; CompanyCosts[3, 3])
            {
            }
            column(CompanyCosts_3_4_; CompanyCosts[3, 4])
            {
            }
            column(CompanyCosts_3_5_; CompanyCosts[3, 5])
            {
            }
            column(CompanyCosts_4_1_; CompanyCosts[4, 1])
            {
            }
            column(CompanyCosts_4_2_; CompanyCosts[4, 2])
            {
            }
            column(CompanyCosts_4_3_; CompanyCosts[4, 3])
            {
            }
            column(CompanyCosts_4_4_; CompanyCosts[4, 4])
            {
            }
            column(CompanyCosts_4_5_; CompanyCosts[4, 5])
            {
            }
            column(CompanyCosts_5_1_; CompanyCosts[5, 1])
            {
            }
            column(CompanyCosts_5_2_; CompanyCosts[5, 2])
            {
            }
            column(CompanyCosts_5_3_; CompanyCosts[5, 3])
            {
            }
            column(CompanyCosts_5_4_; CompanyCosts[5, 4])
            {
            }
            column(CompanyCosts_5_5_; CompanyCosts[5, 5])
            {
            }
            column(CompanyCosts_6_1_; CompanyCosts[6, 1])
            {
            }
            column(CompanyCosts_6_2_; CompanyCosts[6, 2])
            {
            }
            column(CompanyCosts_6_3_; CompanyCosts[6, 3])
            {
            }
            column(CompanyCosts_6_4_; CompanyCosts[6, 4])
            {
            }
            column(CompanyCosts_6_5_; CompanyCosts[6, 5])
            {
            }
            column(CompanyCosts_7_1_; CompanyCosts[7, 1])
            {
            }
            column(CompanyCosts_7_2_; CompanyCosts[7, 2])
            {
            }
            column(CompanyCosts_7_3_; CompanyCosts[7, 3])
            {
            }
            column(CompanyCosts_7_4_; CompanyCosts[7, 4])
            {
            }
            column(CompanyCosts_7_5_; CompanyCosts[7, 5])
            {
            }
            column(CompanyCosts_8_1_; CompanyCosts[8, 1])
            {
            }
            column(CompanyCosts_8_2_; CompanyCosts[8, 2])
            {
            }
            column(CompanyCosts_8_3_; CompanyCosts[8, 3])
            {
            }
            column(CompanyCosts_8_4_; CompanyCosts[8, 4])
            {
            }
            column(CompanyCosts_8_5_; CompanyCosts[8, 5])
            {
            }
            column(CompanyCosts_9_1_; CompanyCosts[9, 1])
            {
            }
            column(CompanyCosts_9_2_; CompanyCosts[9, 2])
            {
            }
            column(CompanyCosts_9_3_; CompanyCosts[9, 3])
            {
            }
            column(CompanyCosts_9_4_; CompanyCosts[9, 4])
            {
            }
            column(CompanyCosts_9_5_; CompanyCosts[9, 5])
            {
            }
            column(CompanyCosts_10_1_; CompanyCosts[10, 1])
            {
            }
            column(CompanyCosts_10_2_; CompanyCosts[10, 2])
            {
            }
            column(CompanyCosts_10_3_; CompanyCosts[10, 3])
            {
            }
            column(CompanyCosts_10_4_; CompanyCosts[10, 4])
            {
            }
            column(CompanyCosts_10_5_; CompanyCosts[10, 5])
            {
            }
            column(CompanyCosts_11_1_; CompanyCosts[11, 1])
            {
            }
            column(CompanyCosts_11_2_; CompanyCosts[11, 2])
            {
            }
            column(CompanyCosts_11_3_; CompanyCosts[11, 3])
            {
            }
            column(CompanyCosts_11_4_; CompanyCosts[11, 4])
            {
            }
            column(CompanyCosts_11_5_; CompanyCosts[11, 5])
            {
            }
            column(TotalCC_1_; TotalCC[1])
            {
            }
            column(TotalCC_2_; TotalCC[2])
            {
            }
            column(TotalCC_3_; TotalCC[3])
            {
            }
            column(TotalCC_4_; TotalCC[4])
            {
            }
            column(TotalCC_5_; TotalCC[5])
            {
            }
            column(TotalDeductions; GrossDeduction[1])
            {
            }
            column(TotalDeductions_2_; GrossDeduction[2])
            {
            }
            column(TotalDeductions_3_; GrossDeduction[3])
            {
            }
            column(TotalDeductions_4_; GrossDeduction[4])
            {
            }
            column(TotalDeductions_5_; GrossDeduction[5])
            {
            }
            column(TotalDeductions_6_; GrossDeduction[6])
            {
            }
            column(TotalDeductions_7_; GrossDeduction[7])
            {
            }
            column(TotalDeductions_8_; GrossDeduction[8])
            {
            }
            column(TotalDeductions_9_; GrossDeduction[9])
            {
            }
            column(TotalDeductions_10_; GrossDeduction[10])
            {
            }
            column(TotalDeductions_11_; GrossDeduction[11])
            {
            }
            column(TotalDeductions_12_; GrossDeduction[12])
            {
            }
            column(CompanyCosts_12_1_; CompanyCosts[12, 1])
            {
            }
            column(CompanyCosts_12_2_; CompanyCosts[12, 2])
            {
            }
            column(CompanyCosts_12_3_; CompanyCosts[12, 3])
            {
            }
            column(CompanyCosts_12_4_; CompanyCosts[12, 4])
            {
            }
            column(CompanyCosts_12_5_; CompanyCosts[12, 5])
            {
            }
            column(TotalCompanyCosts; TotalCompanyCosts[1])
            {
            }
            column(TotalCompanyCosts_2_; TotalCompanyCosts[2])
            {
            }
            column(TotalCompanyCosts_3_; TotalCompanyCosts[3])
            {
            }
            column(TotalCompanyCosts_4_; TotalCompanyCosts[4])
            {
            }
            column(TotalCompanyCosts_5_; TotalCompanyCosts[5])
            {
            }
            column(TotalCompanyCosts_6_; TotalCompanyCosts[6])
            {
            }
            column(TotalCompanyCosts_7_; TotalCompanyCosts[7])
            {
            }
            column(TotalCompanyCosts_8_; TotalCompanyCosts[8])
            {
            }
            column(TotalCompanyCosts_9_; TotalCompanyCosts[9])
            {
            }
            column(TotalCompanyCosts_10_; TotalCompanyCosts[10])
            {
            }
            column(TotalCompanyCosts_11_; TotalCompanyCosts[11])
            {
            }
            column(TotalCompanyCosts_12_; TotalCompanyCosts[12])
            {
            }
            column(NetPay; NetPay[1])
            {
            }
            column(NetPay_2_; NetPay[2])
            {
            }
            column(NetPay_3_; NetPay[3])
            {
            }
            column(NetPay_4_; NetPay[4])
            {
            }
            column(NetPay_5_; NetPay[5])
            {
            }
            column(NetPay_6_; NetPay[6])
            {
            }
            column(NetPay_7_; NetPay[7])
            {
            }
            column(NetPay_8_; NetPay[8])
            {
            }
            column(NetPay_9_; NetPay[9])
            {
            }
            column(NetPay_10_; NetPay[10])
            {
            }
            column(NetPay_11_; NetPay[11])
            {
            }
            column(NetPay_12_; NetPay[12])
            {
            }
            column(TotalNetPay; TotalNetPay)
            {
            }
            column(First_Name_________Middle_Name_______Last_Name_; EmpName)
            {
            }
            column(Allowances_1__Control1000000009; Allowances[1, 1])
            {
            }
            column(Allowances_2__Control1000000018; Allowances[1, 2])
            {
            }
            column(Allowances_3__Control1000000032; Allowances[1, 3])
            {
            }
            column(OtherEarn_Control1000000033; OtherEarn)
            {
            }
            column(Deductions_1__Control1000000034; Deductions[1, 1])
            {
            }
            column(Deductions_2__Control1000000035; Deductions[1, 2])
            {
            }
            column(Deductions_3__Control1000000036; Deductions[1, 3])
            {
            }
            column(Deductions_4__Control1000000037; Deductions[1, 4])
            {
            }
            column(OtherDeduct_Control1000000038; OtherDeduct)
            {
            }
            column(NetPay_Control1000000039; NetPay[1])
            {
            }
            column(STRSUBSTNO__Employees__1__counter_; StrSubstNo('Employees=%1', counter))
            {
            }
            column(Prepared_By______________________________________________________;'Prepared By.....................................................')
            {
            }
            column(Approved_By_____________________________________________________;'Approved By....................................................')
            {
            }
            column(Approved_By_____________________________________________;'Approved By............................................')
            {
            }
            column(MASTER_ROLLCaption; MASTER_ROLLCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Other_AllowancesCaption; Other_AllowancesCaptionLbl)
            {
            }
            trigger OnAfterGetRecord()
            begin
                TotalGrossDeduction:=0;
                TotalGrossPay:=0;
                TotalNetPay:=0;
                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions");
                if(Employee."Total Allowances" + Employee."Total Deductions") = 0 then CurrReport.Skip;
                counter:=counter + 1;
                m:=1;
                for m:=1 to 12 do begin
                    if NAVEmp.Get(Employee."No.")then begin
                        EmpName:=NAVEmp."First Name" + ' ' + NAVEmp."Last Name";
                        Month[m]:=CalcDate(Format(m - 1) + 'M', StartingDate);
                        NAVEmp.SetFilter("Pay Period Filter", '%1', Month[m]);
                        NAVEmp.CalcFields("Total Allowances", "Total Deductions");
                        GrossPay[m]:=NAVEmp."Total Allowances";
                        GrossDeduction[m]:=Abs(NAVEmp."Total Deductions");
                        NetPay[m]:=NAVEmp."Total Allowances" + NAVEmp."Total Deductions";
                        NetPay[m]:=Payroll.NetPayRounding(NetPay[m], Employee."Company Code");
                        TotalGrossPay:=TotalGrossPay + GrossPay[m];
                        TotalGrossDeduction:=TotalGrossDeduction + GrossDeduction[m];
                        TotalNetPay:=TotalNetPay + NetPay[m];
                    end;
                end;
                //Gross Pay
                //
                for i:=1 to 10 do begin
                    m:=1;
                    for m:=1 to 12 do begin
                        Clear(Allowances[m, i]);
                        Clear(Deductions[m, i]);
                        Clear(CompanyCosts[m, i]);
                    end;
                end;
                OtherEarn:=0;
                OtherDeduct:=0;
                OtherDeduct:=0;
                TotalRelief:=0;
                for i:=1 to NoOfEarnings do begin
                    m:=1;
                    for m:=1 to 12 do begin
                        Month[m]:=CalcDate(Format(m - 1) + 'M', StartingDate);
                        Assignmat.Reset;
                        Assignmat.SetRange(Assignmat."Employee No", Employee."No.");
                        Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Payment);
                        Assignmat.SetRange(Assignmat.Code, Earncode[i]);
                        Assignmat.SetRange(Assignmat."Payroll Period", Month[m]);
                        //Assignmat.SETRANGE(Assignmat."Normal Earnings",TRUE);
                        if Assignmat.Find('-')then Allowances[m, i]:=Assignmat.Amount;
                        if Assignmat."Normal Earnings" then Totallowances[i]:=Totallowances[i] + Allowances[m, i]
                        else
                        begin
                            Totallowances[i]:=Totallowances[i] - Allowances[m, i];
                            TotalRelief:=TotalRelief - Allowances[m, i];
                        end;
                        OtherEarn:=GrossPay[m] - (Totallowances[i] - TotalRelief);
                    end;
                end;
                for i:=1 to NoOfDeductions do begin
                    m:=1;
                    for m:=1 to 12 do begin
                        Month[m]:=CalcDate(Format(m - 1) + 'M', StartingDate);
                        Assignmat.Reset;
                        Assignmat.SetRange(Assignmat."Employee No", Employee."No.");
                        Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Deduction);
                        //Assignmat.SETFILTER(Assignmat.Code,'%1|%2|%3','PAYE','SHIF','NSSF');
                        Assignmat.SetRange(Assignmat.Code, deductcode[i]);
                        Assignmat.SetRange(Assignmat."Payroll Period", Month[m]);
                        if Assignmat.Find('-')then Deductions[m, i]:=Abs(Assignmat.Amount);
                        TotalDeductions[i]:=TotalDeductions[i] + Deductions[m, i];
                    end;
                    OtherDeduct:=Abs(GrossDeduction[m] + TotalDeductions[i]);
                end;
                for i:=1 to NoOfDeductions do begin
                    m:=1;
                    for m:=1 to 12 do begin
                        Month[m]:=CalcDate(Format(m - 1) + 'M', StartingDate);
                        Assignmat.Reset;
                        Assignmat.SetRange(Assignmat."Employee No", Employee."No.");
                        Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Deduction);
                        Assignmat.SetRange(Assignmat.Code, CCcode[i]);
                        Assignmat.SetRange(Assignmat."Payroll Period", Month[m]);
                        if Assignmat.Find('-')then CompanyCosts[m, i]:=Abs(Assignmat."Employer Amount");
                        TotalCompanyCosts[m]:=TotalCompanyCosts[m] + CompanyCosts[m, i];
                        TotalCC[i]:=TotalCC[i] + CompanyCosts[m, i];
                    end;
                end;
            end;
            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(Allowances,Deductions,OtherEarn,OtherDeduct,NetPay);
                HRSetup.Get;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(DateSpecified; DateSpecified)
                {
                    ApplicationArea = All;
                    Caption = 'Starting Period';
                }
            }
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
        if Employee.GetFilter("Company Code") = '' then Error('You must select a company to report for.');
        if DateSpecified = 0D then Error('You must select a starting date for the report.');
        StartingDate:=DMY2Date(1, Date2DMY(DateSpecified, 2), Date2DMY(DateSpecified, 3));
        //Earnings
        EarnRec.Reset;
        EarnRec.SetRange(Company, Employee.GetFilter("Company Code"));
        EarnRec.SetRange(EarnRec."Show on Master Roll", true);
        if EarnRec.Find('-')then repeat EarnRec.CalcFields("Total Amount");
                if EarnRec."Total Amount" <> 0 then begin
                    i:=i + 1;
                    Earncode[i]:=EarnRec.Code;
                    EarnDesc[i]:=EarnRec.Description;
                end;
            until EarnRec.Next = 0;
        NoOfEarnings:=i;
        //Deductions
        DedRec.Reset;
        DedRec.SetRange(Company, Employee.GetFilter("Company Code"));
        DedRec.SetRange(DedRec."Show on Master Roll", true);
        if DedRec.Find('-')then repeat DedRec.CalcFields("Total Amount");
                if DedRec."Total Amount" <> 0 then begin
                    j:=j + 1;
                    deductcode[j]:=DedRec.Code;
                    DedDesc[j]:=DedRec.Description;
                end;
            until DedRec.Next = 0;
        NoOfDeductions:=j;
        //Company Costs
        CCRec.Reset;
        CCRec.SetRange(Company, Employee.GetFilter("Company Code"));
        CCRec.SetRange(CCRec."Show on Master Roll", true);
        if CCRec.Find('-')then repeat CCRec.CalcFields("Total Amount Employer");
                if CCRec."Total Amount Employer" <> 0 then begin
                    k:=k + 1;
                    CCcode[k]:=CCRec.Code;
                    CCDesc[k]:='ER ' + CCRec.Description;
                end;
            until CCRec.Next = 0;
        CompInfo.Get(Employee.GetFilter("Company Code"));
        CompInfo.CalcFields(Picture);
    end;
    var Allowances: array[12, 30]of Decimal;
    Deductions: array[12, 30]of Decimal;
    CompanyCosts: array[12, 30]of Decimal;
    EarnRec: Record "Client Earnings";
    DedRec: Record "Client Deductions";
    CCRec: Record "Client Deductions";
    Earncode: array[30]of Code[20];
    deductcode: array[30]of Code[20];
    CCcode: array[30]of Code[20];
    EarnDesc: array[30]of Text[50];
    DedDesc: array[30]of Text[50];
    CCDesc: array[30]of Text[50];
    i: Integer;
    j: Integer;
    k: Integer;
    Assignmat: Record "Client Payroll Matrix";
    DateSpecified: Date;
    Totallowances: array[30]of Decimal;
    TotalDeductions: array[30]of Decimal;
    TotalCompanyCosts: array[12]of Decimal;
    OtherEarn: Decimal;
    OtherDeduct: Decimal;
    counter: Integer;
    HRSetup: Record "Human Resources Setup";
    NetPay: array[12]of Decimal;
    Payroll: Codeunit "Client Payroll Calculator";
    MASTER_ROLLCaptionLbl: Label 'MASTER ROLL';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    Other_AllowancesCaptionLbl: Label 'Other Allowances';
    NAVEmp: Record "Client Employee Master";
    EmpName: Text;
    CompInfo: Record "Client Company Information";
    SendToEFT: Boolean;
    CashMgt: Codeunit "Cash Management";
    Banks: Record "Commercial Banks";
    TotalRelief: Decimal;
    NoOfEarnings: Integer;
    NoOfDeductions: Integer;
    EndingDate: Date;
    Month: array[12]of Date;
    StartingDate: Date;
    m: Integer;
    GrossPay: array[12]of Decimal;
    GrossDeduction: array[12]of Decimal;
    TotalGrossPay: Decimal;
    TotalGrossDeduction: Decimal;
    TotalNetPay: Decimal;
    TotalCC: array[30]of Decimal;
}
