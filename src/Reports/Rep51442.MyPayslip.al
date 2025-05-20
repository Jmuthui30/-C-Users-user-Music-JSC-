report 51442 "My Payslip"
{
    // version THL- Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/My Payslip.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; "Employee Master")
        {
            RequestFilterFields = "Pay Period Filter";

            column(Addr_1__1_; Addr[1][1])
            {
            }
            column(Addr_1__2_; Addr[1][2])
            {
            }
            column(DeptArr_1_1_; DeptArr[1, 1])
            {
            }
            column(ArrEarnings_1_1_; ArrEarnings[1, 1])
            {
            }
            column(ArrEarnings_1_2_; ArrEarnings[1, 2])
            {
            }
            column(ArrEarnings_1_3_; ArrEarnings[1, 3])
            {
            }
            column(ArrEarningsAmt_1_1_; ArrEarningsAmt[1, 1])
            {
            //DecimalPlaces = 2:2;
            }
            column(ArrEarningsAmt_1_2_; ArrEarningsAmt[1, 2])
            {
            //DecimalPlaces = 2:2;
            }
            column(ArrEarningsAmt_1_3_; ArrEarningsAmt[1, 3])
            {
            //DecimalPlaces = 2:2;
            }
            column(ArrEarnings_1_4_; ArrEarnings[1, 4])
            {
            }
            column(ArrEarningsAmt_1_4_; ArrEarningsAmt[1, 4])
            {
            //DecimalPlaces = 2:2;
            }
            column(ArrEarnings_1_5_; ArrEarnings[1, 5])
            {
            }
            column(ArrEarningsAmt_1_5_; ArrEarningsAmt[1, 5])
            {
            //DecimalPlaces = 2:2;
            }
            column(ArrEarnings_1_6_; ArrEarnings[1, 6])
            {
            }
            column(ArrEarningsAmt_1_6_; ArrEarningsAmt[1, 6])
            {
            }
            column(ArrEarnings_1_7_; ArrEarnings[1, 7])
            {
            }
            column(ArrEarningsAmt_1_7_; ArrEarningsAmt[1, 7])
            {
            }
            column(ArrEarnings_1_8_; ArrEarnings[1, 8])
            {
            }
            column(ArrEarningsAmt_1_8_; ArrEarningsAmt[1, 8])
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UpperCase(Format(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(CoName; CoName)
            {
            }
            column(ArrEarningsAmt_1_9_; ArrEarningsAmt[1, 9])
            {
            }
            column(ArrEarningsAmt_1_10_; ArrEarningsAmt[1, 10])
            {
            }
            column(ArrEarningsAmt_1_11_; ArrEarningsAmt[1, 11])
            {
            }
            column(ArrEarningsAmt_1_12_; ArrEarningsAmt[1, 12])
            {
            }
            column(ArrEarningsAmt_1_13_; ArrEarningsAmt[1, 13])
            {
            }
            column(ArrEarningsAmt_1_14_; ArrEarningsAmt[1, 14])
            {
            }
            column(ArrEarningsAmt_1_15_; ArrEarningsAmt[1, 15])
            {
            }
            column(ArrEarningsAmt_1_16_; ArrEarningsAmt[1, 16])
            {
            }
            column(ArrEarnings_1_9_; ArrEarnings[1, 9])
            {
            }
            column(ArrEarnings_1_10_; ArrEarnings[1, 10])
            {
            }
            column(ArrEarnings_1_11_; ArrEarnings[1, 11])
            {
            }
            column(ArrEarnings_1_12_; ArrEarnings[1, 12])
            {
            }
            column(ArrEarnings_1_13_; ArrEarnings[1, 13])
            {
            }
            column(ArrEarnings_1_14_; ArrEarnings[1, 14])
            {
            }
            column(ArrEarnings_1_15_; ArrEarnings[1, 15])
            {
            }
            column(ArrEarnings_1_16_; ArrEarnings[1, 16])
            {
            }
            column(ArrEarningsAmt_1_17_; ArrEarningsAmt[1, 17])
            {
            }
            column(ArrEarnings_1_17_; ArrEarnings[1, 17])
            {
            }
            column(ArrEarnings_1_18_; ArrEarnings[1, 18])
            {
            }
            column(ArrEarnings_1_19_; ArrEarnings[1, 19])
            {
            }
            column(ArrEarnings_1_20_; ArrEarnings[1, 20])
            {
            }
            column(ArrEarnings_1_21_; ArrEarnings[1, 21])
            {
            }
            column(ArrEarnings_1_22_; ArrEarnings[1, 22])
            {
            }
            column(ArrEarnings_1_23_; ArrEarnings[1, 23])
            {
            }
            column(ArrEarnings_1_25_; ArrEarnings[1, 25])
            {
            }
            column(ArrEarnings_1_26_; ArrEarnings[1, 26])
            {
            }
            column(ArrEarnings_1_34_; ArrEarnings[1, 34])
            {
            }
            column(ArrEarnings_1_33_; ArrEarnings[1, 33])
            {
            }
            column(ArrEarnings_1_32_; ArrEarnings[1, 32])
            {
            }
            column(ArrEarnings_1_31_; ArrEarnings[1, 31])
            {
            }
            column(ArrEarnings_1_30_; ArrEarnings[1, 30])
            {
            }
            column(ArrEarnings_1_29_; ArrEarnings[1, 29])
            {
            }
            column(ArrEarnings_1_28_; ArrEarnings[1, 28])
            {
            }
            column(ArrEarnings_1_27_; ArrEarnings[1, 27])
            {
            }
            column(ArrEarnings_1_41_; ArrEarnings[1, 41])
            {
            }
            column(ArrEarnings_1_40_; ArrEarnings[1, 40])
            {
            }
            column(ArrEarnings_1_39_; ArrEarnings[1, 39])
            {
            }
            column(ArrEarnings_1_38_; ArrEarnings[1, 38])
            {
            }
            column(ArrEarnings_1_37_; ArrEarnings[1, 37])
            {
            }
            column(ArrEarnings_1_36_; ArrEarnings[1, 36])
            {
            }
            column(ArrEarnings_1_35_; ArrEarnings[1, 35])
            {
            }
            column(ArrEarningsAmt_1_33_; ArrEarningsAmt[1, 33])
            {
            }
            column(ArrEarningsAmt_1_32_; ArrEarningsAmt[1, 32])
            {
            }
            column(ArrEarningsAmt_1_31_; ArrEarningsAmt[1, 31])
            {
            }
            column(ArrEarningsAmt_1_30_; ArrEarningsAmt[1, 30])
            {
            }
            column(ArrEarningsAmt_1_29_; ArrEarningsAmt[1, 29])
            {
            }
            column(ArrEarningsAmt_1_28_; ArrEarningsAmt[1, 28])
            {
            }
            column(ArrEarningsAmt_1_27_; ArrEarningsAmt[1, 27])
            {
            }
            column(ArrEarningsAmt_1_26_; ArrEarningsAmt[1, 26])
            {
            }
            column(ArrEarningsAmt_1_25_; ArrEarningsAmt[1, 25])
            {
            }
            column(ArrEarningsAmt_1_24_; ArrEarningsAmt[1, 24])
            {
            }
            column(ArrEarningsAmt_1_23_; ArrEarningsAmt[1, 23])
            {
            }
            column(ArrEarningsAmt_1_22_; ArrEarningsAmt[1, 22])
            {
            }
            column(ArrEarningsAmt_1_21_; ArrEarningsAmt[1, 21])
            {
            }
            column(ArrEarningsAmt_1_20_; ArrEarningsAmt[1, 20])
            {
            }
            column(ArrEarningsAmt_1_19_; ArrEarningsAmt[1, 19])
            {
            }
            column(ArrEarningsAmt_1_18_; ArrEarningsAmt[1, 18])
            {
            }
            column(ArrEarnings_1_24_; ArrEarnings[1, 24])
            {
            }
            column(ArrEarningsAmt_1_39_; ArrEarningsAmt[1, 39])
            {
            }
            column(ArrEarningsAmt_1_38_; ArrEarningsAmt[1, 38])
            {
            }
            column(ArrEarningsAmt_1_37_; ArrEarningsAmt[1, 37])
            {
            }
            column(ArrEarningsAmt_1_36_; ArrEarningsAmt[1, 36])
            {
            }
            column(ArrEarningsAmt_1_35_; ArrEarningsAmt[1, 35])
            {
            }
            column(ArrEarningsAmt_1_34_; ArrEarningsAmt[1, 34])
            {
            }
            column(ArrEarningsAmt_1_41_; ArrEarningsAmt[1, 41])
            {
            }
            column(ArrEarningsAmt_1_40_; ArrEarningsAmt[1, 40])
            {
            }
            column(Message2_1_1_; Message2[1, 1])
            {
            }
            column(ArrEarningsAmt_1_43_; ArrEarningsAmt[1, 43])
            {
            }
            column(ArrEarningsAmt_1_42_; ArrEarningsAmt[1, 42])
            {
            }
            column(ArrEarningsAmt_1_45_; ArrEarningsAmt[1, 45])
            {
            }
            column(ArrEarningsAmt_1_44_; ArrEarningsAmt[1, 44])
            {
            }
            column(ArrEarnings_1_45_; ArrEarnings[1, 45])
            {
            }
            column(ArrEarnings_1_44_; ArrEarnings[1, 44])
            {
            }
            column(ArrEarnings_1_43_; ArrEarnings[1, 43])
            {
            }
            column(ArrEarnings_1_42_; ArrEarnings[1, 42])
            {
            }
            column(ArrEarningsAmt_1_48_; ArrEarningsAmt[1, 48])
            {
            }
            column(ArrEarningsAmt_1_46_; ArrEarningsAmt[1, 46])
            {
            }
            column(ArrEarningsAmt_1_47_; ArrEarningsAmt[1, 47])
            {
            }
            column(ArrEarnings_1_48_; ArrEarnings[1, 48])
            {
            }
            column(ArrEarnings_1_47_; ArrEarnings[1, 47])
            {
            }
            column(ArrEarnings_1_46_; ArrEarnings[1, 46])
            {
            }
            column(ArrEarningsAmt_1_49_; ArrEarningsAmt[1, 49])
            {
            }
            column(ArrEarningsAmt_1_50_; ArrEarningsAmt[1, 50])
            {
            }
            column(ArrEarningsAmt_1_51_; ArrEarningsAmt[1, 51])
            {
            }
            column(ArrEarningsAmt_1_52_; ArrEarningsAmt[1, 52])
            {
            }
            column(ArrEarningsAmt_1_53_; ArrEarningsAmt[1, 53])
            {
            }
            column(ArrEarningsAmt_1_54_; ArrEarningsAmt[1, 54])
            {
            }
            column(ArrEarningsAmt_1_55_; ArrEarningsAmt[1, 55])
            {
            }
            column(ArrEarningsAmt_1_56_; ArrEarningsAmt[1, 56])
            {
            }
            column(ArrEarningsAmt_1_57_; ArrEarningsAmt[1, 57])
            {
            }
            column(ArrEarningsAmt_1_58_; ArrEarningsAmt[1, 58])
            {
            }
            column(ArrEarningsAmt_1_59_; ArrEarningsAmt[1, 59])
            {
            }
            column(ArrEarningsAmt_1_60_; ArrEarningsAmt[1, 60])
            {
            }
            column(ArrEarnings_1_49_; ArrEarnings[1, 49])
            {
            }
            column(ArrEarnings_1_50_; ArrEarnings[1, 50])
            {
            }
            column(ArrEarnings_1_51_; ArrEarnings[1, 51])
            {
            }
            column(ArrEarnings_1_52_; ArrEarnings[1, 52])
            {
            }
            column(ArrEarnings_1_53_; ArrEarnings[1, 53])
            {
            }
            column(ArrEarnings_1_54_; ArrEarnings[1, 54])
            {
            }
            column(ArrEarnings_1_55_; ArrEarnings[1, 55])
            {
            }
            column(ArrEarnings_1_56_; ArrEarnings[1, 56])
            {
            }
            column(ArrEarnings_1_57_; ArrEarnings[1, 57])
            {
            }
            column(ArrEarnings_1_58_; ArrEarnings[1, 58])
            {
            }
            column(ArrEarnings_1_59_; ArrEarnings[1, 59])
            {
            }
            column(ArrEarnings_1_60_; ArrEarnings[1, 60])
            {
            }
            column(ArrEarnings_1_61_; ArrEarnings[1, 61])
            {
            }
            column(ArrEarnings_1_62_; ArrEarnings[1, 62])
            {
            }
            column(ArrEarnings_1_63_; ArrEarnings[1, 63])
            {
            }
            column(ArrEarnings_1_73_; ArrEarnings[1, 73])
            {
            }
            column(ArrEarnings_1_64_; ArrEarnings[1, 64])
            {
            }
            column(ArrEarnings_1_65_; ArrEarnings[1, 65])
            {
            }
            column(ArrEarnings_1_66_; ArrEarnings[1, 66])
            {
            }
            column(ArrEarnings_1_67_; ArrEarnings[1, 67])
            {
            }
            column(ArrEarnings_1_68_; ArrEarnings[1, 68])
            {
            }
            column(ArrEarnings_1_69_; ArrEarnings[1, 69])
            {
            }
            column(ArrEarnings_1_70_; ArrEarnings[1, 70])
            {
            }
            column(ArrEarnings_1_71_; ArrEarnings[1, 71])
            {
            }
            column(ArrEarnings_1_72_; ArrEarnings[1, 72])
            {
            }
            column(ArrEarnings_1_74_; ArrEarnings[1, 74])
            {
            }
            column(ArrEarnings_1_75_; ArrEarnings[1, 75])
            {
            }
            column(ArrEarnings_1_76_; ArrEarnings[1, 76])
            {
            }
            column(ArrEarnings_1_77_; ArrEarnings[1, 77])
            {
            }
            column(ArrEarnings_1_78_; ArrEarnings[1, 78])
            {
            }
            column(ArrEarnings_1_79_; ArrEarnings[1, 79])
            {
            }
            column(ArrEarnings_1_80_; ArrEarnings[1, 80])
            {
            }
            column(ArrEarnings_1_81_; ArrEarnings[1, 81])
            {
            }
            column(ArrEarnings_1_82_; ArrEarnings[1, 82])
            {
            }
            column(ArrEarnings_1_83_; ArrEarnings[1, 83])
            {
            }
            column(ArrEarnings_1_84_; ArrEarnings[1, 84])
            {
            }
            column(ArrEarnings_1_85_; ArrEarnings[1, 85])
            {
            }
            column(ArrEarnings_1_86_; ArrEarnings[1, 86])
            {
            }
            column(ArrEarnings_1_87_; ArrEarnings[1, 87])
            {
            }
            column(ArrEarnings_1_88_; ArrEarnings[1, 88])
            {
            }
            column(ArrEarnings_1_89_; ArrEarnings[1, 89])
            {
            }
            column(ArrEarnings_1_90_; ArrEarnings[1, 90])
            {
            }
            column(ArrEarningsAmt_1_61_; ArrEarningsAmt[1, 61])
            {
            }
            column(ArrEarningsAmt_1_62_; ArrEarningsAmt[1, 62])
            {
            }
            column(ArrEarningsAmt_1_63_; ArrEarningsAmt[1, 63])
            {
            }
            column(ArrEarningsAmt_1_64_; ArrEarningsAmt[1, 64])
            {
            }
            column(ArrEarningsAmt_1_65_; ArrEarningsAmt[1, 65])
            {
            }
            column(ArrEarningsAmt_1_66_; ArrEarningsAmt[1, 66])
            {
            }
            column(ArrEarningsAmt_1_67_; ArrEarningsAmt[1, 67])
            {
            }
            column(ArrEarningsAmt_1_68_; ArrEarningsAmt[1, 68])
            {
            }
            column(ArrEarningsAmt_1_69_; ArrEarningsAmt[1, 69])
            {
            }
            column(ArrEarningsAmt_1_70_; ArrEarningsAmt[1, 70])
            {
            }
            column(ArrEarningsAmt_1_71_; ArrEarningsAmt[1, 71])
            {
            }
            column(ArrEarningsAmt_1_72_; ArrEarningsAmt[1, 72])
            {
            }
            column(ArrEarningsAmt_1_73_; ArrEarningsAmt[1, 73])
            {
            }
            column(ArrEarningsAmt_1_74_; ArrEarningsAmt[1, 74])
            {
            }
            column(ArrEarningsAmt_1_75_; ArrEarningsAmt[1, 75])
            {
            }
            column(ArrEarningsAmt_1_76_; ArrEarningsAmt[1, 76])
            {
            }
            column(ArrEarningsAmt_1_77_; ArrEarningsAmt[1, 77])
            {
            }
            column(ArrEarningsAmt_1_78_; ArrEarningsAmt[1, 78])
            {
            }
            column(ArrEarningsAmt_1_79_; ArrEarningsAmt[1, 79])
            {
            }
            column(ArrEarningsAmt_1_80_; ArrEarningsAmt[1, 80])
            {
            }
            column(ArrEarningsAmt_1_81_; ArrEarningsAmt[1, 81])
            {
            }
            column(ArrEarningsAmt_1_82_; ArrEarningsAmt[1, 82])
            {
            }
            column(ArrEarningsAmt_1_83_; ArrEarningsAmt[1, 83])
            {
            }
            column(ArrEarningsAmt_1_84_; ArrEarningsAmt[1, 84])
            {
            }
            column(ArrEarningsAmt_1_85_; ArrEarningsAmt[1, 85])
            {
            }
            column(ArrEarningsAmt_1_86_; ArrEarningsAmt[1, 86])
            {
            }
            column(ArrEarningsAmt_1_87_; ArrEarningsAmt[1, 87])
            {
            }
            column(ArrEarningsAmt_1_88_; ArrEarningsAmt[1, 88])
            {
            }
            column(ArrEarningsAmt_1_89_; ArrEarningsAmt[1, 89])
            {
            }
            column(ArrEarningsAmt_1_90_; ArrEarningsAmt[1, 90])
            {
            }
            column(Logo; CompInfo.Picture)
            {
            }
            column(BalanceArray_1_1_; BalanceArray[1, 1])
            {
            }
            column(BalanceArray_1_2_; BalanceArray[1, 2])
            {
            }
            column(BalanceArray_1_3_; BalanceArray[1, 3])
            {
            }
            column(BalanceArray_1_4_; BalanceArray[1, 4])
            {
            }
            column(BalanceArray_1_5_; BalanceArray[1, 5])
            {
            }
            column(BalanceArray_1_6_; BalanceArray[1, 6])
            {
            }
            column(BalanceArray_1_7_; BalanceArray[1, 7])
            {
            }
            column(BalanceArray_1_8_; BalanceArray[1, 8])
            {
            }
            column(BalanceArray_1_9_; BalanceArray[1, 9])
            {
            }
            column(BalanceArray_1_10_; BalanceArray[1, 10])
            {
            }
            column(BalanceArray_1_11_; BalanceArray[1, 11])
            {
            }
            column(BalanceArray_1_12_; BalanceArray[1, 12])
            {
            }
            column(BalanceArray_1_13_; BalanceArray[1, 13])
            {
            }
            column(BalanceArray_1_14_; BalanceArray[1, 14])
            {
            }
            column(BalanceArray_1_15_; BalanceArray[1, 15])
            {
            }
            column(BalanceArray_1_16_; BalanceArray[1, 16])
            {
            }
            column(BalanceArray_1_17_; BalanceArray[1, 17])
            {
            }
            column(BalanceArray_1_19_; BalanceArray[1, 19])
            {
            }
            column(BalanceArray_1_18_; BalanceArray[1, 18])
            {
            }
            column(BalanceArray_1_20_; BalanceArray[1, 20])
            {
            }
            column(BalanceArray_1_22_; BalanceArray[1, 22])
            {
            }
            column(BalanceArray_1_21_; BalanceArray[1, 21])
            {
            }
            column(BalanceArray_1_23_; BalanceArray[1, 23])
            {
            }
            column(BalanceArray_1_26_; BalanceArray[1, 26])
            {
            }
            column(BalanceArray_1_25_; BalanceArray[1, 25])
            {
            }
            column(BalanceArray_1_24_; BalanceArray[1, 24])
            {
            }
            column(BalanceArray_1_28_; BalanceArray[1, 28])
            {
            }
            column(BalanceArray_1_27_; BalanceArray[1, 27])
            {
            }
            column(BalanceArray_1_30_; BalanceArray[1, 30])
            {
            }
            column(BalanceArray_1_29_; BalanceArray[1, 29])
            {
            }
            column(BalanceArray_1_32_; BalanceArray[1, 32])
            {
            }
            column(BalanceArray_1_31_; BalanceArray[1, 31])
            {
            }
            column(BalanceArray_1_34_; BalanceArray[1, 34])
            {
            }
            column(BalanceArray_1_33_; BalanceArray[1, 33])
            {
            }
            column(BalanceArray_1_36_; BalanceArray[1, 36])
            {
            }
            column(BalanceArray_1_35_; BalanceArray[1, 35])
            {
            }
            column(BalanceArray_1_38_; BalanceArray[1, 38])
            {
            }
            column(BalanceArray_1_37_; BalanceArray[1, 37])
            {
            }
            column(BalanceArray_1_40_; BalanceArray[1, 40])
            {
            }
            column(BalanceArray_1_39_; BalanceArray[1, 39])
            {
            }
            column(BalanceArray_1_41_; BalanceArray[1, 41])
            {
            }
            column(BalanceArray_1_42_; BalanceArray[1, 42])
            {
            }
            column(BalanceArray_1_43_; BalanceArray[1, 43])
            {
            }
            column(BalanceArray_1_44_; BalanceArray[1, 44])
            {
            }
            column(BalanceArray_1_46_; BalanceArray[1, 46])
            {
            }
            column(BalanceArray_1_45_; BalanceArray[1, 45])
            {
            }
            column(BalanceArray_1_48_; BalanceArray[1, 48])
            {
            }
            column(BalanceArray_1_47_; BalanceArray[1, 47])
            {
            }
            column(STRSUBSTNO__Date__1__2__TODAY_TIME_; StrSubstNo('Date %1 %2', Today, Time))
            {
            }
            column(USERID; UserId)
            {
            }
            /*column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }*/
            column(EarningsCaption; EarningsCaptionLbl)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(Dept_Caption; Dept_CaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Pay_slipCaption; Pay_slipCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_No_; "No.")
            {
            }
            column(Loan_Balance; LoanBalance)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Clear(Addr);
                Clear(DeptArr);
                Clear(BasicPay);
                Clear(EmpArray);
                Clear(ArrEarnings);
                Clear(ArrEarningsAmt);
                Clear(BalanceArray);
                GrossPay:=0;
                TotalDeduction:=0;
                Totalcoopshares:=0;
                Totalnssf:=0;
                NetPay:=0;
                Addr[1][1]:=Employee."No.";
                if NAVEmployee.Get(Employee."No.")then Addr[1][2]:=NAVEmployee."First Name" + ' ' + NAVEmployee."Last Name";
                // Get Basic Salary
                Earn.Reset;
                Earn.SetRange(Earn."Basic Salary Code", true);
                if Earn.Find('-')then begin
                    PayrollMatrix.Reset;
                    PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                    PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                    PayrollMatrix.SetRange(PayrollMatrix.Code, Earn.Code);
                    PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                end;
                i:=1;
                Earn.Reset;
                Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                Earn.SetRange(Earn."Non-Cash Benefit", false);
                if Earn.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(Code, Earn.Code);
                        if PayrollMatrix.Find('-')then begin
                            repeat ArrEarnings[1, i]:=PayrollMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(PayrollRounding(PayrollMatrix.Amount)));
                                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                GrossPay:=GrossPay + PayrollRounding(PayrollMatrix.Amount);
                                i:=i + 1;
                            until PayrollMatrix.Next = 0;
                        end;
                    until Earn.Next = 0;
                end;
                ArrEarnings[1, i]:='GROSS PAY';
                Evaluate(ArrEarningsAmt[1, i], Format(GrossPay));
                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                i:=i + 1;
                ArrEarnings[1, i]:='================================================';
                ArrEarningsAmt[1, i]:='================================================';
                i:=i + 1;
                // taxation
                ArrEarnings[1, i]:='Taxations';
                i:=i + 1;
                ArrEarnings[1, i]:='================================================';
                ArrEarningsAmt[1, i]:='===============================================';
                i:=i + 1;
                PayrollMatrix.Reset;
                PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Deduction);
                PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                PayrollMatrix.SetRange(PayrollMatrix.Paye, true);
                if PayrollMatrix.Find('-')then begin
                    ArrEarnings[1, i]:='Less Pension contribution benefit';
                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(PayrollMatrix."Less Pension Contribution"))));
                    ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                    TaxableAmt:=0;
                    PAYE:=0;
                    TaxableAmt:=PayrollMatrix."Taxable amount";
                    PAYE:=PayrollMatrix.Amount;
                end;
                i:=i + 1;
                Earn.Reset;
                Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Owner Occupier");
                if Earn.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix."Basic Salary Code", false);
                        PayrollMatrix.SetRange(Code, Earn.Code);
                        if PayrollMatrix.Find('-')then begin
                            repeat ArrEarnings[1, i]:=PayrollMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(PayrollRounding(PayrollMatrix.Amount)));
                                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                i:=i + 1;
                            until PayrollMatrix.Next = 0;
                        end;
                    until Earn.Next = 0;
                end;
                // Taxable amount
                ArrEarnings[1, i]:='Taxable Amount';
                Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(TaxableAmt))));
                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                i:=i + 1;
                // Tax Charged + Relief
                Earn.Reset;
                Earn.SetFilter(Earn."Earning Type", '%1|%2', Earn."Earning Type"::"Tax Relief", Earn."Earning Type"::"Insurance Relief");
                if Earn.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix."Basic Salary Code", false);
                        PayrollMatrix.SetRange(Code, Earn.Code);
                        if PayrollMatrix.Find('-')then begin
                            repeat TaxCharged:=Abs(PayrollRounding(PAYE)) + Abs(PayrollRounding(PayrollMatrix.Amount));
                                i:=i + 1;
                            until PayrollMatrix.Next = 0;
                        end;
                    until Earn.Next = 0;
                end;
                ArrEarnings[1, i]:='Tax Charged';
                Evaluate(ArrEarningsAmt[1, i], Format(TaxCharged));
                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                i:=i + 1;
                // Relief
                Earn.Reset;
                Earn.SetFilter(Earn."Earning Type", '%1|%2', Earn."Earning Type"::"Tax Relief", Earn."Earning Type"::"Insurance Relief");
                if Earn.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix."Basic Salary Code", false);
                        PayrollMatrix.SetRange(Code, Earn.Code);
                        if PayrollMatrix.Find('-')then begin
                            repeat ArrEarnings[1, i]:=PayrollMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(PayrollMatrix.Amount))));
                                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                i:=i + 1;
                            until PayrollMatrix.Next = 0;
                        end;
                    until Earn.Next = 0;
                end;
                ArrEarnings[1, i]:='================================================';
                ArrEarningsAmt[1, i]:='===============================================';
                i:=i + 1;
                // Deductions
                ArrEarnings[1, i]:='Deductions';
                i:=i + 1;
                ArrEarnings[1, i]:='================================================';
                ArrEarningsAmt[1, i]:='===============================================';
                i:=i + 1;
                PayrollMatrix.Reset;
                PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Deduction);
                PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                PayrollMatrix.SetRange(PayrollMatrix.Paye, true);
                if PayrollMatrix.Find('-')then begin
                    ArrEarnings[1, i]:=PayrollMatrix.Description;
                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(PayrollMatrix.Amount))));
                    ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                    TotalDeduction:=TotalDeduction + Abs(PayrollMatrix.Amount);
                end;
                i:=i + 1;
                Deduct.Reset;
                Deduct.SetFilter(Deduct."Calculation Method", '<>%1', Deduct."Calculation Method"::"% of Salary Recovery");
                Deduct.SetRange(Deduct.Informational, false);
                if Deduct.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetFilter(Type, '%1|%2', PayrollMatrix.Type::Deduction, PayrollMatrix.Type::Loan);
                        PayrollMatrix.SetRange(PayrollMatrix.Code, Deduct.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix.Paye, false);
                        if PayrollMatrix.Find('-')then begin
                            repeat ArrEarnings[1, i]:=PayrollMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(PayrollMatrix.Amount))));
                                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                TotalDeduction:=TotalDeduction + Abs(PayrollRounding(PayrollMatrix.Amount));
                                if Deduct.Get(PayrollMatrix.Code)then begin
                                //
                                end;
                                i:=i + 1;
                            until PayrollMatrix.Next = 0;
                        end;
                    until Deduct.Next = 0;
                end;
                //For PAYE Manual
                Deduct.Reset;
                Deduct.SetRange(Deduct."Calculation Method", Deduct."Calculation Method"::"% of Salary Recovery");
                if Deduct.Find('-')then begin
                    repeat LoanBalance:=0;
                        PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetFilter(Type, '%1|%2', PayrollMatrix.Type::Deduction, PayrollMatrix.Type::Loan);
                        PayrollMatrix.SetRange(Code, Deduct.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix.Paye, false);
                        if PayrollMatrix.Find('-')then begin
                            PayrollMatrix.CalcSums(Amount);
                            ArrEarnings[1, i]:=PayrollMatrix.Description;
                            PositivePAYEManual:=0;
                            Earn.Reset;
                            Earn.SetRange(Earn."Calculation Method", Earn."Calculation Method"::"% of Salary Recovery");
                            if Earn.Find('-')then begin
                                PayDeduct.Reset;
                                PayDeduct.SetRange(PayDeduct."Payroll Period", DateSpecified);
                                PayDeduct.SetFilter(Type, '%1', PayDeduct.Type::Payment);
                                PayDeduct.SetRange(Code, Earn.Code);
                                PayDeduct.SetRange(PayDeduct."Employee No", Employee."No.");
                                PayDeduct.SetRange(PayDeduct."Manual Entry", true);
                                if PayDeduct.Find('-')then begin
                                    repeat PositivePAYEManual:=PositivePAYEManual + PayDeduct.Amount;
                                    until PayDeduct.Next = 0;
                                end;
                            end;
                            Evaluate(ArrEarningsAmt[1, i], Format(PayrollRounding(PayrollMatrix.Amount) + PayrollRounding(PositivePAYEManual)));
                            ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                            TotalDeduction:=TotalDeduction + PayrollRounding(PayrollMatrix.Amount) + PayrollRounding(PositivePAYEManual);
                            i:=i + 1;
                        end;
                    until Deduct.Next = 0;
                end;
                if Totalcoopshares > 0 then begin
                    ArrEarnings[1, i]:='SPORTS/SOCIAL WELFARE';
                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(Totalcoopshares)));
                    ArrEarningsAmt[1, i]:=ArrEarningsAmt[1, i];
                    Totalcoopshares:=0;
                    i:=i + 1;
                end;
                ArrEarnings[1, i]:='TOTAL DEDUCTIONS';
                Evaluate(ArrEarningsAmt[1, i], Format(TotalDeduction));
                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                i:=i + 1;
                ArrEarnings[1, i]:='================================================';
                ArrEarningsAmt[1, i]:='===============================================';
                i:=i + 1;
                // Net Pay
                ArrEarnings[1, i]:='NET PAY';
                NetPay:=GrossPay - TotalDeduction;
                Evaluate(ArrEarningsAmt[1, i], Format(NetPay));
                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                i:=i + 1;
                ArrEarnings[1, i]:='================================================';
                ArrEarningsAmt[1, i]:='===============================================';
                i:=i + 1;
                //Information
                ArrEarnings[1, i]:='Information';
                i:=i + 1;
                ArrEarnings[1, i]:='================================================';
                ArrEarningsAmt[1, i]:='===============================================';
                //Soko Savings Balance to Date
                TotalSavingsToDate:=0;
                Deduct.Reset;
                Deduct.SetRange(Deduct."Show Balance", true);
                Deduct.SetRange(Deduct.Shares, true);
                if Deduct.Find('-')then begin
                    repeat Deduct.CalcFields(Deduct."Total Amount", Deduct."Total Amount Employer");
                        ArrEarnings[1, i]:=Deduct.Description + ' Bal. to Date';
                        PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", 0D, DateSpecified);
                        PayrollMatrix.SetFilter(Type, '%1|%2', PayrollMatrix.Type::Deduction, PayrollMatrix.Type::Loan);
                        PayrollMatrix.SetRange(Code, Deduct.Code);
                        PayrollMatrix.SetRange(PayrollMatrix.Paye, false);
                        PayrollMatrix.SetRange("Employee No", "No.");
                        PayrollMatrix.CalcSums(Amount, "Employer Amount", "Opening Balance");
                        TotalSavingsToDate:=PayrollMatrix.Amount + PayrollMatrix."Employer Amount" + PayrollMatrix."Opening Balance";
                        TotalDeposits:=0;
                        SavingsRec.Reset;
                        SavingsRec.SetCurrentKey(Code, "Payroll Period", Type);
                        SavingsRec.SetRange(SavingsRec.Code, Deduct.Code);
                        SavingsRec.SetRange(SavingsRec."Payroll Period", 0D, DateSpecified);
                        SavingsRec.SetRange(SavingsRec.Type, SavingsRec.Type::Deposit);
                        SavingsRec.SetRange(SavingsRec."Employee No", Employee."No.");
                        SavingsRec.CalcSums(Amount);
                        TotalDeposits:=SavingsRec.Amount;
                        TotalWithdrawals:=0;
                        SavingsRec.Reset;
                        SavingsRec.SetCurrentKey(Code, "Payroll Period", Type);
                        SavingsRec.SetRange(SavingsRec.Code, Deduct.Code);
                        SavingsRec.SetRange(SavingsRec."Payroll Period", 0D, DateSpecified);
                        SavingsRec.SetRange(SavingsRec.Type, SavingsRec.Type::Withdrawal);
                        SavingsRec.SetRange(SavingsRec."Employee No", Employee."No.");
                        SavingsRec.CalcSums(Amount);
                        TotalWithdrawals:=SavingsRec.Amount;
                        TotalSavingsToDate:=TotalSavingsToDate - TotalDeposits;
                        TotalSavingsToDate:=TotalSavingsToDate + TotalWithdrawals;
                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(TotalSavingsToDate))));
                        ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                    until Deduct.Next = 0;
                end;
                i:=i + 1;
                Deduct.Reset;
                Deduct.SetRange(Deduct."Show Balance", true);
                Deduct.SetRange(Loan, true);
                Deduct.SetFilter(Deduct."Calculation Method", '<>%1', Deduct."Calculation Method"::"% of Basic Pay");
                Deduct.SetRange(Deduct.Shares, false);
                Deduct.SetRange(Deduct."Salary Recovery", false);
                if Deduct.Find('-')then begin
                    repeat LoanBalance:=0;
                        TotalBulkRepayments:=0;
                        TotalRepayments:=0;
                        //Balances
                        PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", 0D, DateSpecified);
                        PayrollMatrix.SetFilter(Type, '%1|%2', PayrollMatrix.Type::Deduction, PayrollMatrix.Type::Loan);
                        PayrollMatrix.SetRange(Code, Deduct.Code);
                        PayrollMatrix.SetRange("Employee No", "No.");
                        PayrollMatrix.SetRange(PayrollMatrix.Paye, false);
                        if PayrollMatrix.Find('-')then begin
                            PayrollMatrix.CalcSums(Amount);
                            LoanBalances.Reset;
                            LoanBalances.SetRange(LoanBalances."Date filter", 0D, DateSpecified);
                            LoanBalances.SetRange(LoanBalances."Deduction Code", PayrollMatrix.Code);
                            LoanBalances.SetRange("Employee No", "No.");
                            LoanBalances.SetRange("Stop Loan", false);
                            if LoanBalances.Find('-')then begin
                                repeat if loanType.Get(LoanBalances."Loan Product Type")then begin
                                        if loanType."Interest Calculation Method" = loanType."Interest Calculation Method"::"Flat Rate" then begin
                                            LoanBalances.CalcFields(LoanBalances."Total Repayment", LoanBalances."Total Loan");
                                            // add Total Loan/Approved Amount
                                            if LoanBalances."Total Loan" <> 0 then begin
                                                LoanTopUps.Reset;
                                                LoanTopUps.SetCurrentKey("Loan No", "Payroll Period");
                                                LoanTopUps.SetRange(LoanTopUps."Loan No", LoanBalances."Loan No");
                                                LoanTopUps.SetRange("Payroll Period", 0D, DateSpecified);
                                                LoanTopUps.CalcSums(Amount);
                                                LineAmt:=LoanTopUps.Amount;
                                                LoanBalance:=LoanBalance + LineAmt;
                                            end
                                            else
                                                LoanBalance:=LoanBalance + LoanBalances."Approved Amount";
                                            LoanBalance:=LoanBalance + LoanBalances."Total Repayment";
                                        end;
                                        if loanType."Interest Calculation Method" = loanType."Interest Calculation Method"::"Reducing Balance" then begin
                                            RepSchedule.Reset;
                                            RepSchedule.SetCurrentKey("Loan Category", "Employee No", "Repayment Date");
                                            RepSchedule.SetRange(RepSchedule."Loan Category", loanType.Code);
                                            RepSchedule.SetRange("Employee No", "No.");
                                            RepSchedule.SetRange(RepSchedule."Repayment Date", DateSpecified);
                                            RepSchedule.CalcSums(RepSchedule."Remaining Debt");
                                            LoanBalance:=RepSchedule."Remaining Debt";
                                        end;
                                    end;
                                until LoanBalances.Next = 0;
                                LoanBalance:=LoanBalance;
                            end;
                        end;
                        if LoanBalance <> 0 then begin
                            ArrEarnings[1, i]:=Deduct.Description + ' Balance'; //PayrollMatrix.Description;
                            Evaluate(ArrEarningsAmt[1, i], Format(PayrollRounding(LoanBalance)));
                            ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                            i:=i + 1;
                        end;
                    until Deduct.Next = 0;
                end;
                TotalToDate:=0;
                loanType.Reset;
                loanType.SetRange("Interest Calculation Method", loanType."Interest Calculation Method"::"Reducing Balance");
                if loanType.Find('-')then begin
                    repeat RepSchedule.Reset;
                        RepSchedule.SetCurrentKey("Loan No", "Repayment Date");
                        RepSchedule.SetRange("Loan Category", loanType.Code);
                        RepSchedule.SetRange("Employee No", "No.");
                        RepSchedule.SetRange(RepSchedule."Repayment Date", DateSpecified);
                        RepSchedule.CalcSums("Principal Repayment");
                        TotalToDate:=RepSchedule."Principal Repayment";
                        if TotalToDate <> 0 then begin
                            ArrEarnings[1, i]:=loanType.Description + ' Principal Repayment';
                            Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(TotalToDate))));
                            ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                            i:=i + 1;
                        end;
                    until loanType.Next = 0;
                end;
                //Pension Self Contribution to Date
                TotalToDate:=0;
                TotalPensionInactive:=0;
                Deduct.Reset;
                Deduct.SetRange(Deduct."Show Balance", true);
                Deduct.SetRange(Deduct."Pension Scheme", true);
                if Deduct.Find('-')then begin
                    repeat Deduct.CalcFields(Deduct."Total Amount", Deduct."Total Amount Employer");
                        PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", 0D, DateSpecified);
                        PayrollMatrix.SetFilter(Type, '%1|%2', PayrollMatrix.Type::Deduction, PayrollMatrix.Type::Loan);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", "No.");
                        PayrollMatrix.SetRange(Code, Deduct.Code);
                        PayrollMatrix.SetRange(PayrollMatrix.Paye, false);
                        PayrollMatrix.CalcSums(PayrollMatrix.Amount, "Employer Amount", PayrollMatrix."Opening Balance");
                        TotalToDate:=PayrollMatrix.Amount + PayrollMatrix."Opening Balance";
                        if TotalToDate <> 0 then begin
                            ArrEarnings[1, i]:=Deduct.Description + ' Bal. to Date';
                            Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(TotalToDate))));
                            ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                            i:=i + 1;
                        end;
                    until Deduct.Next = 0;
                end;
                //Gratuity Employer Contribution
                Deduct.Reset;
                Deduct.SetRange(Deduct."Show Balance", true);
                Deduct.SetRange(Deduct."Calculation Method", Deduct."Calculation Method"::"% of Basic Pay");
                Deduct.SetRange(Deduct.Gratuity, true);
                if Deduct.Find('-')then begin
                    repeat //Balances
                        PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetFilter(Type, '%1|%2', PayrollMatrix.Type::Deduction, PayrollMatrix.Type::Loan);
                        PayrollMatrix.SetRange(Code, Deduct.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix.Paye, false);
                        if PayrollMatrix.Find('-')then begin
                            PayrollMatrix.CalcSums(Amount, "Employer Amount");
                            if Deduct.Get(PayrollMatrix.Code)then begin
                                Deduct.SetRange(Deduct."Pay Period Filter", 0D, DateSpecified);
                                Deduct.CalcFields(Deduct."Total Amount", Deduct."Total Amount Employer");
                                ArrEarnings[1, i]:='Gratuity Employer Contribution';
                                Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(Deduct."Total Amount Employer"))));
                                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                            end;
                            Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(PayrollMatrix."Employer Amount"))));
                            ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                            i:=i + 1;
                        end;
                    until Deduct.Next = 0;
                end;
                TotalToDate:=0;
                //Gratuity Balance To Date
                Deduct.Reset;
                Deduct.SetRange(Deduct."Show Balance", true);
                Deduct.SetFilter(Deduct."Calculation Method", '=%1|=%2', Deduct."Calculation Method"::"% of Basic Pay", Deduct."Calculation Method"::"Flat Amount");
                Deduct.SetRange(Deduct.Gratuity, true);
                if Deduct.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", 0D, DateSpecified);
                        PayrollMatrix.SetFilter(Type, '%1|%2', PayrollMatrix.Type::Deduction, PayrollMatrix.Type::Loan);
                        PayrollMatrix.SetRange(Code, Deduct.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix.Paye, false);
                        PayrollMatrix.CalcSums(Amount, "Employer Amount", "Opening Balance Company");
                        Deduct.CalcFields(Deduct."Total Amount", Deduct."Total Amount Employer");
                        TotalToDate:=PayrollMatrix."Employer Amount" + PayrollMatrix."Opening Balance Company";
                        if TotalToDate <> 0 then begin
                            ArrEarnings[1, i]:='Gratuity Employer Contrib Bal. to Date';
                            Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(TotalToDate))));
                            ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                            Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(TotalToDate))));
                            ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                            i:=i + 1;
                        end;
                    until Deduct.Next = 0;
                end;
                // Non Cash Benefits
                Earn.Reset;
                Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                Earn.SetRange(Earn."Non-Cash Benefit", true);
                if Earn.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix."Basic Salary Code", false);
                        PayrollMatrix.SetRange(Code, Earn.Code);
                        if PayrollMatrix.Find('-')then begin
                            repeat ArrEarnings[1, i]:=PayrollMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(PayrollRounding(PayrollMatrix.Amount)));
                                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                i:=i + 1;
                            until PayrollMatrix.Next = 0;
                        end;
                    until Earn.Next = 0;
                end;
                // end of non cash
                Ded.Reset;
                Ded.SetRange(Ded."Reduces Taxable Amt", true);
                Ded.SetRange(Ded."Pay Period Filter", DateSpecified);
                Ded.SetRange(Ded."Employee Filter", Employee."No.");
                Ded.SetRange(Ded."Show on Payslip Information", true);
                if Ded.Find('-')then repeat Ded.CalcFields(Ded."Total Amount", Ded."Total Amount Employer");
                        Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(Ded."Total Amount Employer"))));
                        ArrEarnings[1, i]:=Ded.Description + '(Employer)';
                        ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                        i:=i + 1;
                    until Ded.Next = 0;
                //End balances
                i:=i + 1;
                //
                ArrEarnings[1, i]:='================================================';
                ArrEarningsAmt[1, i]:='===============================================';
                i:=i + 1;
                ArrEarnings[1, i]:='Employee Details';
                // Employee details
                i:=i + 1;
                ArrEarnings[1, i]:='================================================';
                ArrEarningsAmt[1, i]:='===============================================';
                i:=i + 1;
                ArrEarnings[1, i]:='P.I.N';
                ArrEarningsAmt[1, i]:=Employee."PIN Number";
                i:=i + 1;
                if EmpBank.Get("Bank Code", "Bank Branch")then begin
                    BankName:=EmpBank."Bank Name";
                    ArrEarnings[1, i]:='Employee Bank';
                    ArrEarningsAmt[1, i]:=BankName;
                    i:=i + 1;
                    ArrEarnings[1, i]:='Bank Branch';
                    ArrEarningsAmt[1, i]:=EmpBank."Branch Name";
                end;
                i:=i + 1;
                ArrEarnings[1, i]:='Acc No.';
                ArrEarningsAmt[1, i]:="Bank Account Number";
                i:=i + 1;
                ArrEarnings[1, i]:='NSSF No';
                ArrEarningsAmt[1, i]:=Employee."NSSF No";
                i:=i + 1;
                ArrEarnings[1, i]:='SHIF No';
                ArrEarningsAmt[1, i]:=Employee."SHIF No";
                i:=i + 1;
                ArrEarnings[1, i]:='Leave Balance';
                /*AccPeriod.RESET;
                AccPeriod.SETRANGE(AccPeriod."Starting Date",0D,TODAY);
                AccPeriod.SETRANGE(AccPeriod."New Fiscal Year",TRUE);
                IF AccPeriod.FIND('+') THEN
                BEGIN
                FiscalStart:=AccPeriod."Starting Date";
                MaturityDate:=CALCDATE('1Y',AccPeriod."Starting Date")-1;
                
                     LeaveApplication.RESET;
                     LeaveApplication.SETFILTER(LeaveApplication."Leave Code",'%1|%2','ANNUAL','CANNUAL');
                     LeaveApplication.SETRANGE(LeaveApplication."Employee No",Employee."No.");
                     LeaveApplication.SETRANGE(LeaveApplication."Maturity Date",MaturityDate);
                     LeaveApplication.SETRANGE(LeaveApplication.Status,LeaveApplication.Status::Released);
                     IF LeaveApplication.FIND('+') THEN
                       ArrEarningsAmt[1,i]:=FORMAT(LeaveApplication."Leave balance");
                END;
                */
                //Get Working Hours
                // Get Basic Salary
                Earn.Reset;
                Earn.SetRange(Earn."Salary Recovery", true);
                if Earn.Find('-')then begin
                    PayrollMatrix.Reset;
                    PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                    PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                    PayrollMatrix.SetRange(PayrollMatrix.Code, Earn.Code);
                    PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                    if PayrollMatrix.Find('-')then begin
                        ArrEarnings[1, i]:='Expected Working Hours';
                        ArrEarningsAmt[1, i]:=Format(PayrollMatrix."Expected Hrs");
                        i:=i + 1;
                        ArrEarnings[1, i]:='Worked Hours';
                        ArrEarningsAmt[1, i]:=Format(PayrollMatrix."Worked Hrs");
                    end;
                end;
                //
                i:=i + 1;
                ArrEarnings[1, i]:='=======End of Payslip========';
                i:=i + 1;
                PayrollSetup.Get;
                ArrEarnings[1, i]:=PayrollSetup."General Payslip Message";
                i:=i + 1;
                ArrEarnings[1, i]:=UserId;
            end;
            trigger OnPreDataItem()
            begin
                PayrollSetup.Get;
                Message2[1, 1]:=PayrollSetup."General Payslip Message";
                if UserSetup.Get(UserId)then Employee.SetFilter("No.", '%1', UserSetup."Employee No.")
                else
                    Error('Your login has not been mapped to your employee profile. Kindly contact the Administrator.');
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        PayPeriodtext:=Employee.GetFilter("Pay Period Filter");
        if PayPeriodtext = '' then Error('Pay period must be specified for this report');
        Evaluate(PayrollMonth, Format(PayPeriodtext));
        PayrollMonthText:=Format(PayrollMonth, 1, 4);
        Evaluate(DateSpecified, Format(PayPeriodtext));
        if UserSetup.Get(UserId)then Employee.SetFilter("No.", '%1', UserSetup."Employee No.")
        else
            Error('Your login has not been mapped to your employee profile. Kindly contact the Administrator.');
    end;
    var CompInfo: Record "Company Information";
    PayrollSetup: Record "QuantumJumps Payroll Setup";
    PayPeriodtext: Text;
    PayrollMonth: Date;
    PayrollMonthText: Text[30];
    DateSpecified: Date;
    Message2: array[3, 1]of Text[250];
    Addr: array[10, 100]of Text[250];
    DeptArr: array[3, 1]of Text[60];
    BasicPay: array[3, 1]of Text[250];
    EmpArray: array[10, 15]of Decimal;
    ArrEarnings: array[3, 100]of Text[250];
    ArrEarningsAmt: array[3, 100]of Text[60];
    BalanceArray: array[3, 100]of Decimal;
    GrossPay: Decimal;
    TotalDeduction: Decimal;
    Totalcoopshares: Decimal;
    Totalnssf: Decimal;
    NetPay: Decimal;
    NAVEmployee: Record Employee;
    Earn: Record Earnings;
    PayrollMatrix: Record "Payroll Matrix";
    i: Integer;
    TaxableAmt: Decimal;
    PAYE: Decimal;
    TaxCharged: Decimal;
    Deduct: Record Deductions;
    LoanBalance: Decimal;
    PositivePAYEManual: Decimal;
    PayDeduct: Record "Payroll Matrix";
    TotalSavingsToDate: Decimal;
    TotalDeposits: Decimal;
    SavingsRec: Record "Savings Scheme Transactions";
    TotalWithdrawals: Decimal;
    TotalBulkRepayments: Decimal;
    TotalRepayments: Decimal;
    LoanBalances: Record "Loan Application";
    loanType: Record "Loan Product";
    LoanTopUps: Record "Loan Top-up";
    LineAmt: Decimal;
    RepSchedule: Record "Loan Schedule";
    TotalToDate: Decimal;
    TotalPensionInactive: Decimal;
    Ded: Record Deductions;
    EmpBank: Record "Bank Branches";
    BankName: Text;
    CoName: Integer;
    EarningsCaptionLbl: Label 'Earnings';
    Employee_No_CaptionLbl: Label 'Employee No:';
    Name_CaptionLbl: Label 'Name:';
    Dept_CaptionLbl: Label 'Dept:';
    AmountCaptionLbl: Label 'Amount';
    Pay_slipCaptionLbl: Label 'Pay Slip';
    EmptyStringCaptionLbl: Label '================================================';
    CurrReport_PAGENOCaptionLbl: Label 'Copy';
    UserSetup: Record "User Setup";
    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record Bracket;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
    end;
    procedure GetPayPeriod()
    begin
    end;
    procedure CoinageAnalysis(var NetPay: Decimal; var ColNo: Integer)
    var
        Index: Integer;
        Intex: Integer;
    begin
    end;
    procedure PayrollRounding(var Amount: Decimal)PayrollRounding: Decimal var
        HRsetup: Record "QuantumJumps Payroll Setup";
    begin
        HRsetup.Get;
        if HRsetup."Payroll Rounding Precision" = 0 then Error('You must specify the rounding precision under HR setup');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;
    procedure ChckRound(var AmtText: Text[30])ChckRound: Text[30]var
        LenthOfText: Integer;
        DecimalPos: Integer;
        AmtWithoutDec: Text[30];
        DecimalAmt: Text[30];
        Decimalstrlen: Integer;
    begin
        LenthOfText:=StrLen(AmtText);
        DecimalPos:=StrPos(AmtText, '.');
        if DecimalPos = 0 then begin
            AmtWithoutDec:=AmtText;
            DecimalAmt:='.00';
        end
        else
        begin
            AmtWithoutDec:=CopyStr(AmtText, 1, DecimalPos - 1);
            DecimalAmt:=CopyStr(AmtText, DecimalPos + 1, 2);
            Decimalstrlen:=StrLen(DecimalAmt);
            if Decimalstrlen < 2 then begin
                DecimalAmt:='.' + DecimalAmt + '0';
            end
            else
                DecimalAmt:='.' + DecimalAmt end;
        ChckRound:=AmtWithoutDec + DecimalAmt;
    end;
}
