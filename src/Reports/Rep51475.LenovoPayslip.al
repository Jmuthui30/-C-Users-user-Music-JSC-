report 51475 "Lenovo Payslip"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Lenovo Payslip.rdlc';
    Caption = 'Payslip';

    dataset
    {
        dataitem(Employee; "Client Employee Master")
        {
            RequestFilterFields = "Company Code", "No.", "Pay Period Filter", Status;

            column(Addr_1__1_; Addr[1][1])
            {
            }
            column(Addr_1__2_; Addr[1][2])
            {
            }
            column(Addr_1__3_; Addr[1][3])
            {
            }
            column(Addr_1__4_; Addr[1][4])
            {
            }
            column(Addr_1__5_; Addr[1][5])
            {
            }
            column(Addr_1__6_; Addr[1][6])
            {
            }
            column(Addr_1__7_; Addr[1][7])
            {
            }
            column(Addr_1__8_; Addr[1][8])
            {
            }
            column(PayslipPeriod; PayslipPeriod)
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
            column(CoName; CompInfo.Name)
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
                CompInfo.Get(Employee."Company Code");
                CompInfo.CalcFields(Picture);
                PayrollSetup.Get(Employee."Company Code");
                Message2[1, 1]:=PayrollSetup."General Payslip Message";
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
                Addr[1][3]:=NAVEmployee."ID Number";
                Addr[1][4]:=NAVEmployee."PIN Number";
                Addr[1][5]:=NAVEmployee."SHIF No";
                Addr[1][6]:=NAVEmployee."NSSF No";
                Addr[1][7]:=NAVEmployee."Mobile Phone No.";
                Addr[1][8]:=NAVEmployee."Email Address";
                // Get Basic Salary
                Earn.Reset;
                Earn.SetRange(Earn."Basic Salary Code", true);
                Earn.SetRange(Company, Employee."Company Code");
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
                Earn.SetRange(Company, Employee."Company Code");
                if Earn.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(Code, Earn.Code);
                        if PayrollMatrix.Find('-')then begin
                            repeat ArrEarnings[1, i]:=PayrollMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(PayrollRounding(PayrollMatrix.Amount, Employee."Company Code")));
                                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                GrossPay:=GrossPay + PayrollRounding(PayrollMatrix.Amount, Employee."Company Code");
                                i:=i + 1;
                            until PayrollMatrix.Next = 0;
                        end;
                    until Earn.Next = 0;
                end;
                ArrEarnings[1, i]:='Gross Pay(kshs)';
                Evaluate(ArrEarningsAmt[1, i], Format(GrossPay));
                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                i:=i + 1;
                ArrEarnings[1, i]:='------------------------------------------------';
                ArrEarningsAmt[1, i]:='------------------------------------------------';
                i:=i + 1;
                /*// taxation
                ArrEarnings[1,i]:='Taxations';

                i:=i+1;

                ArrEarnings[1,i]:='------------------------------------------------';
                ArrEarningsAmt[1,i]:='------------------------------------------------';*/
                i:=i + 1;
                PayrollMatrix.Reset;
                PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Deduction);
                PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                PayrollMatrix.SetRange(PayrollMatrix.Paye, true);
                if PayrollMatrix.Find('-')then begin
                    ArrEarnings[1, i]:='Excempt Contributions (-)';
                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(PayrollMatrix."Less Pension Contribution", Employee."Company Code"))));
                    ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                    TaxableAmt:=0;
                    PAYE:=0;
                    TaxableAmt:=PayrollMatrix."Taxable amount";
                    PAYE:=PayrollMatrix.Amount;
                end;
                i:=i + 1;
                Earn.Reset;
                Earn.SetRange(Earn."Earning Type", Earn."Earning Type"::"Owner Occupier");
                Earn.SetRange(Company, Employee."Company Code");
                if Earn.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix."Basic Salary Code", false);
                        PayrollMatrix.SetRange(Code, Earn.Code);
                        if PayrollMatrix.Find('-')then begin
                            repeat ArrEarnings[1, i]:=PayrollMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(PayrollRounding(PayrollMatrix.Amount, Employee."Company Code")));
                                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                i:=i + 1;
                            until PayrollMatrix.Next = 0;
                        end;
                    until Earn.Next = 0;
                end;
                // Taxable amount
                ArrEarnings[1, i]:='Taxable Amount';
                Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(TaxableAmt, Employee."Company Code"))));
                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                i:=i + 1;
                // Tax Charged + Relief
                Earn.Reset;
                Earn.SetFilter(Earn."Earning Type", '%1|%2', Earn."Earning Type"::"Tax Relief", Earn."Earning Type"::"Insurance Relief");
                Earn.SetRange(Company, Employee."Company Code");
                if Earn.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix."Basic Salary Code", false);
                        PayrollMatrix.SetRange(Code, Earn.Code);
                        if PayrollMatrix.Find('-')then begin
                            repeat TaxCharged:=Abs(PayrollRounding(PAYE, Employee."Company Code")) + Abs(PayrollRounding(PayrollMatrix.Amount, Employee."Company Code"));
                            //i:=i+1;
                            until PayrollMatrix.Next = 0;
                        end;
                    until Earn.Next = 0;
                end;
                ArrEarnings[1, i]:='Gross Tax';
                Evaluate(ArrEarningsAmt[1, i], Format(TaxCharged));
                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                i:=i + 1;
                // Relief
                Earn.Reset;
                Earn.SetFilter(Earn."Earning Type", '%1|%2', Earn."Earning Type"::"Tax Relief", Earn."Earning Type"::"Insurance Relief");
                Earn.SetRange(Company, Employee."Company Code");
                if Earn.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix."Basic Salary Code", false);
                        PayrollMatrix.SetRange(Code, Earn.Code);
                        if PayrollMatrix.Find('-')then begin
                            repeat ArrEarnings[1, i]:=PayrollMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(PayrollMatrix.Amount, Employee."Company Code"))));
                                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                i:=i + 1;
                            until PayrollMatrix.Next = 0;
                        end;
                    until Earn.Next = 0;
                end;
                ArrEarnings[1, i]:='------------------------------------------------';
                ArrEarningsAmt[1, i]:='------------------------------------------------';
                i:=i + 1;
                // Deductions
                /*ArrEarnings[1,i]:='Deductions';

                i:=i+1;

                ArrEarnings[1,i]:='------------------------------------------------';
                ArrEarningsAmt[1,i]:='------------------------------------------------';*/
                i:=i + 1;
                PayrollMatrix.Reset;
                PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Deduction);
                PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                PayrollMatrix.SetRange(PayrollMatrix.Paye, true);
                if PayrollMatrix.Find('-')then begin
                    ArrEarnings[1, i]:=PayrollMatrix.Description;
                    Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(PayrollMatrix.Amount, Employee."Company Code"))));
                    ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                    TotalDeduction:=TotalDeduction + Abs(PayrollMatrix.Amount);
                end;
                i:=i + 1;
                Deduct.Reset;
                Deduct.SetFilter(Deduct."Calculation Method", '<>%1', Deduct."Calculation Method"::"% of Salary Recovery");
                Deduct.SetRange(Deduct.Informational, false);
                Deduct.SetRange(Company, Employee."Company Code");
                if Deduct.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetFilter(Type, '%1|%2', PayrollMatrix.Type::Deduction, PayrollMatrix.Type::Loan);
                        PayrollMatrix.SetRange(PayrollMatrix.Code, Deduct.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix.Paye, false);
                        PayrollMatrix.SetFilter(PayrollMatrix.Amount, '<>%1', 0);
                        if PayrollMatrix.Find('-')then begin
                            repeat ArrEarnings[1, i]:=PayrollMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(PayrollMatrix.Amount, Employee."Company Code"))));
                                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                TotalDeduction:=TotalDeduction + Abs(PayrollRounding(PayrollMatrix.Amount, Employee."Company Code"));
                                if Deduct.Get(Employee."Company Code", PayrollMatrix.Code)then begin
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
                Deduct.SetRange(Company, Employee."Company Code");
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
                            Earn.SetRange(Company, Employee."Company Code");
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
                            Evaluate(ArrEarningsAmt[1, i], Format(PayrollRounding(PayrollMatrix.Amount, Employee."Company Code") + PayrollRounding(PositivePAYEManual, Employee."Company Code")));
                            ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                            TotalDeduction:=TotalDeduction + PayrollRounding(PayrollMatrix.Amount, Employee."Company Code") + PayrollRounding(PositivePAYEManual, Employee."Company Code");
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
                ArrEarnings[1, i]:='Total Deductions';
                Evaluate(ArrEarningsAmt[1, i], Format(TotalDeduction));
                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                i:=i + 1;
                ArrEarnings[1, i]:='------------------------------------------------';
                ArrEarningsAmt[1, i]:='------------------------------------------------';
                i:=i + 1;
                // Net Pay
                ArrEarnings[1, i]:='Net Pay Kshs';
                NetPay:=GrossPay - TotalDeduction;
                NetPay:=NetPayRounding(NetPay, Employee."Company Code");
                if NetPay = 0 then CurrReport.Skip;
                Evaluate(ArrEarningsAmt[1, i], Format(NetPay));
                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                i:=i + 1;
                ArrEarnings[1, i]:='Payment Mode';
                ArrEarningsAmt[1, i]:='';
                i:=i + 1;
                ArrEarnings[1, i]:='Net Pay Kshs Paid by STO';
                Evaluate(ArrEarningsAmt[1, i], Format(NetPay));
                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                i:=i + 1;
                ArrEarnings[1, i]:='Balance Paid By Cheque';
                ArrEarningsAmt[1, i]:='';
                i:=i + 1;
                ArrEarnings[1, i]:='';
                ArrEarningsAmt[1, i]:='------------------------------------------------';
                i:=i + 1;
                Evaluate(ArrEarningsAmt[1, i], Format(NetPay));
                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                i:=i + 1;
                ArrEarnings[1, i]:='------------------------------------------------';
                ArrEarningsAmt[1, i]:='------------------------------------------------';
                //VOO: Add Lenovo Employer Information
                ArrEarnings[1, i]:='Employer Information';
                i:=i + 1;
                ArrEarnings[1, i]:='------------------------------------------------';
                /*ArrEarningsAmt[1,i]:='------------------------------------------------';*/
                i:=i + 1;
                Deduct.Reset;
                Deduct.SetFilter(Deduct."Calculation Method", '<>%1', Deduct."Calculation Method"::"% of Salary Recovery");
                Deduct.SetRange(Deduct.Informational, false);
                Deduct.SetRange(Company, Employee."Company Code");
                if Deduct.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetFilter(Type, '%1|%2', PayrollMatrix.Type::Deduction, PayrollMatrix.Type::Loan);
                        PayrollMatrix.SetRange(PayrollMatrix.Code, Deduct.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                        PayrollMatrix.SetRange(PayrollMatrix.Paye, false);
                        PayrollMatrix.SetFilter(PayrollMatrix."Employer Amount", '<>%1', 0);
                        if PayrollMatrix.Find('-')then begin
                            repeat ArrEarnings[1, i]:=PayrollMatrix.Description;
                                Evaluate(ArrEarningsAmt[1, i], Format(Abs(PayrollRounding(PayrollMatrix."Employer Amount", Employee."Company Code"))));
                                ArrEarningsAmt[1, i]:=ChckRound(ArrEarningsAmt[1, i]);
                                i:=i + 1;
                            until PayrollMatrix.Next = 0;
                        end;
                    until Deduct.Next = 0;
                end;
            //
            /*   i:=i+1;
                      //Information
                   ArrEarnings[1,i]:='Information';

                   i:=i+1;

                   ArrEarnings[1,i]:='------------------------------------------------';
                   ArrEarningsAmt[1,i]:='------------------------------------------------';

               //Soko Savings Balance to Date
                 TotalSavingsToDate:=0;
                   Deduct.RESET;
                   Deduct.SETRANGE(Deduct."Show Balance",TRUE);
                   Deduct.SETRANGE(Deduct.Shares,TRUE);
                   IF Deduct.FIND('-') THEN
                   BEGIN
                    REPEAT
                         Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");
                         ArrEarnings[1,i]:=Deduct.Description+' Bal. to Date';
                   PayrollMatrix.RESET;
                   PayrollMatrix.SETRANGE(PayrollMatrix."Payroll Period",0D,DateSpecified);
                   PayrollMatrix.SETFILTER(Type,'%1|%2',PayrollMatrix.Type::Deduction,PayrollMatrix.Type::Loan);
                   PayrollMatrix.SETRANGE(Code,Deduct.Code);
                   PayrollMatrix.SETRANGE(PayrollMatrix.Paye,FALSE);
                   PayrollMatrix.SETRANGE("Employee No","No.");
                   PayrollMatrix.CALCSUMS(Amount,"Employer Amount","Opening Balance");
                   TotalSavingsToDate:=PayrollMatrix.Amount+PayrollMatrix."Employer Amount"+PayrollMatrix."Opening Balance";
                        TotalDeposits:=0;
                        SavingsRec.RESET;
                        SavingsRec.SETCURRENTKEY(Code,"Payroll Period",Type);
                        SavingsRec.SETRANGE(SavingsRec.Code,Deduct.Code);
                        SavingsRec.SETRANGE(SavingsRec."Payroll Period",0D,DateSpecified);
                        SavingsRec.SETRANGE(SavingsRec.Type,SavingsRec.Type::Deposit);
                        SavingsRec.SETRANGE(SavingsRec."Employee No",Employee."No.");
                        SavingsRec.CALCSUMS(Amount);
                        TotalDeposits:=SavingsRec.Amount;

                        TotalWithdrawals:=0;
                        SavingsRec.RESET;
                        SavingsRec.SETCURRENTKEY(Code,"Payroll Period",Type);
                        SavingsRec.SETRANGE(SavingsRec.Code,Deduct.Code);
                        SavingsRec.SETRANGE(SavingsRec."Payroll Period",0D,DateSpecified);
                        SavingsRec.SETRANGE(SavingsRec.Type,SavingsRec.Type::Withdrawal);
                        SavingsRec.SETRANGE(SavingsRec."Employee No",Employee."No.");
                        SavingsRec.CALCSUMS(Amount);
                        TotalWithdrawals:=SavingsRec.Amount;

                        TotalSavingsToDate:=TotalSavingsToDate-TotalDeposits;
                        TotalSavingsToDate:=TotalSavingsToDate+TotalWithdrawals;
                        EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(TotalSavingsToDate,Employee."Company Code"))));
                        ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                   UNTIL Deduct.NEXT=0;
                  END;

                   i:=i+1;

                   Deduct.RESET;
                   Deduct.SETRANGE(Deduct."Show Balance",TRUE);
                   Deduct.SETRANGE(Loan,TRUE);
                   Deduct.SETFILTER(Deduct."Calculation Method",'<>%1',Deduct."Calculation Method"::"% of Basic Pay");
                   Deduct.SETRANGE(Deduct.Shares,FALSE);
                   Deduct.SETRANGE(Deduct."Salary Recovery",FALSE);
                   IF Deduct.FIND('-') THEN BEGIN
                    REPEAT
                   LoanBalance:=0;
                   TotalBulkRepayments:=0;
                   TotalRepayments:=0;
               //Balances
                   PayrollMatrix.RESET;
                   PayrollMatrix.SETRANGE(PayrollMatrix."Payroll Period",0D,DateSpecified);
                   PayrollMatrix.SETFILTER(Type,'%1|%2',PayrollMatrix.Type::Deduction,PayrollMatrix.Type::Loan);
                   PayrollMatrix.SETRANGE(Code,Deduct.Code);
                   PayrollMatrix.SETRANGE("Employee No","No.");
                   PayrollMatrix.SETRANGE(PayrollMatrix.Paye,FALSE);
                   IF PayrollMatrix.FIND('-') THEN BEGIN

                   PayrollMatrix.CALCSUMS(Amount);
                        LoanBalances.RESET;
                        LoanBalances.SETRANGE(LoanBalances."Date filter",0D,DateSpecified);
                        LoanBalances.SETRANGE(LoanBalances."Deduction Code",PayrollMatrix.Code);
                        LoanBalances.SETRANGE("Employee No","No.");
                        LoanBalances.SETRANGE("Stop Loan",FALSE);
                        IF LoanBalances.FIND('-') THEN
                         BEGIN REPEAT
                         IF loanType.GET(LoanBalances."Loan Product Type") THEN BEGIN
                          IF loanType."Interest Calculation Method"=loanType."Interest Calculation Method"::"Flat Rate" THEN BEGIN
                          LoanBalances.CALCFIELDS(LoanBalances."Total Repayment",LoanBalances."Total Loan");
                         // add Total Loan/Approved Amount
                          IF LoanBalances."Total Loan"<>0 THEN BEGIN
                             LoanTopUps.RESET;
                             LoanTopUps.SETCURRENTKEY("Loan No","Payroll Period");
                             LoanTopUps.SETRANGE(LoanTopUps."Loan No",LoanBalances."Loan No");
                             LoanTopUps.SETRANGE("Payroll Period",0D,DateSpecified);
                             LoanTopUps.CALCSUMS(Amount);
                             LineAmt:=LoanTopUps.Amount;
                           LoanBalance:=LoanBalance+LineAmt;

                         END ELSE
                          LoanBalance:=LoanBalance+LoanBalances."Approved Amount";

                          LoanBalance:=LoanBalance+LoanBalances."Total Repayment";
                          END;
                          IF loanType."Interest Calculation Method"=loanType."Interest Calculation Method"::"Reducing Balance" THEN BEGIN
                              RepSchedule.RESET;
                              RepSchedule.SETCURRENTKEY("Loan Category","Employee No","Repayment Date");
                              RepSchedule.SETRANGE(RepSchedule."Loan Category",loanType.Code);
                              RepSchedule.SETRANGE("Employee No","No.");
                              RepSchedule.SETRANGE(RepSchedule."Repayment Date",DateSpecified);
                              RepSchedule.CALCSUMS(RepSchedule."Remaining Debt");
                              LoanBalance:=RepSchedule."Remaining Debt";
                          END;
                         END;

                        UNTIL LoanBalances.NEXT=0;
                        LoanBalance:=LoanBalance;
                        END;
                    END;
                     IF LoanBalance<>0 THEN BEGIN
                       ArrEarnings[1,i]:=Deduct.Description+' Balance';//PayrollMatrix.Description;
                       EVALUATE(ArrEarningsAmt[1,i],FORMAT(PayrollRounding(LoanBalance,Employee."Company Code")));
                       ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                       i:=i+1;
                     END;
                   UNTIL Deduct.NEXT=0;
                  END;
               TotalToDate:=0;
               loanType.RESET;
               loanType.SETRANGE("Interest Calculation Method",loanType."Interest Calculation Method"::"Reducing Balance");
               IF loanType.FIND('-') THEN BEGIN
                 REPEAT

                   RepSchedule.RESET;
                   RepSchedule.SETCURRENTKEY("Loan No","Repayment Date");
                   RepSchedule.SETRANGE("Loan Category",loanType.Code);
                   RepSchedule.SETRANGE("Employee No","No.");
                   RepSchedule.SETRANGE(RepSchedule."Repayment Date",DateSpecified);
                   RepSchedule.CALCSUMS("Principal Repayment");
                   TotalToDate:=RepSchedule."Principal Repayment";
                   IF TotalToDate<>0 THEN BEGIN
                     ArrEarnings[1,i]:=loanType.Description+' Principal Repayment';
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(TotalToDate,Employee."Company Code"))));
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                   i:=i+1;
                   END;

                 UNTIL loanType.NEXT=0;
               END;


                //Pension Self Contribution to Date
                  TotalToDate:=0;
                  TotalPensionInactive:=0;
                   Deduct.RESET;
                   Deduct.SETRANGE(Deduct."Show Balance",TRUE);
                   Deduct.SETRANGE(Deduct."Pension Scheme",TRUE);
                   IF Deduct.FIND('-') THEN
                   BEGIN
                    REPEAT

                         Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");

                   PayrollMatrix.RESET;
                   PayrollMatrix.SETRANGE(PayrollMatrix."Payroll Period",0D,DateSpecified);
                   PayrollMatrix.SETFILTER(Type,'%1|%2',PayrollMatrix.Type::Deduction,PayrollMatrix.Type::Loan);
                   PayrollMatrix.SETRANGE(PayrollMatrix."Employee No","No.");
                   PayrollMatrix.SETRANGE(Code,Deduct.Code);
                   PayrollMatrix.SETRANGE(PayrollMatrix.Paye,FALSE);
                   PayrollMatrix.CALCSUMS(PayrollMatrix.Amount,"Employer Amount",PayrollMatrix."Opening Balance");
                   TotalToDate:=PayrollMatrix.Amount+PayrollMatrix."Opening Balance";
                   IF TotalToDate<>0 THEN BEGIN
                    ArrEarnings[1,i]:=Deduct.Description+' Bal. to Date';
                    EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(TotalToDate,Employee."Company Code"))));
                    ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                     i:=i+1;
                  END;

                   UNTIL Deduct.NEXT=0;
                  END;




               //Gratuity Employer Contribution

                   Deduct.RESET;
                   Deduct.SETRANGE(Deduct."Show Balance",TRUE);
                   Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"% of Basic Pay");
                   Deduct.SETRANGE(Deduct.Gratuity,TRUE);
                   IF Deduct.FIND('-') THEN
                   BEGIN
                    REPEAT
               //Balances
                   PayrollMatrix.RESET;
                   PayrollMatrix.SETRANGE(PayrollMatrix."Payroll Period",DateSpecified);
                   PayrollMatrix.SETFILTER(Type,'%1|%2',PayrollMatrix.Type::Deduction,PayrollMatrix.Type::Loan);
                   PayrollMatrix.SETRANGE(Code,Deduct.Code);
                   PayrollMatrix.SETRANGE(PayrollMatrix."Employee No",Employee."No.");
                   PayrollMatrix.SETRANGE(PayrollMatrix.Paye,FALSE);
                   IF PayrollMatrix.FIND('-') THEN
                    BEGIN

                    PayrollMatrix.CALCSUMS(Amount,"Employer Amount");
                       IF Deduct.GET(Employee."Company Code",PayrollMatrix.Code) THEN
                        BEGIN
                         Deduct.SETRANGE(Deduct."Pay Period Filter",0D,DateSpecified);
                         Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");
                         ArrEarnings[1,i]:='Gratuity Employer Contribution';
                         EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(Deduct."Total Amount Employer",Employee."Company Code"))));
                         ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                           END;
                         EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(PayrollMatrix."Employer Amount",Employee."Company Code"))));
                         ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                         i:=i+1;
                    END;
                   UNTIL Deduct.NEXT=0;
                  END;
               TotalToDate:=0;
               //Gratuity Balance To Date
                   Deduct.RESET;
                   Deduct.SETRANGE(Deduct."Show Balance",TRUE);
                   Deduct.SETFILTER(Deduct."Calculation Method",'=%1|=%2',Deduct."Calculation Method"::"% of Basic Pay",Deduct."Calculation Method"::"Flat Amount");
                   Deduct.SETRANGE(Deduct.Gratuity,TRUE);
                   IF Deduct.FIND('-') THEN
                   BEGIN
                    REPEAT
                   PayrollMatrix.RESET;
                   PayrollMatrix.SETRANGE(PayrollMatrix."Payroll Period",0D,DateSpecified);
                   PayrollMatrix.SETFILTER(Type,'%1|%2',PayrollMatrix.Type::Deduction,PayrollMatrix.Type::Loan);
                   PayrollMatrix.SETRANGE(Code,Deduct.Code);
                   PayrollMatrix.SETRANGE(PayrollMatrix."Employee No",Employee."No.");
                   PayrollMatrix.SETRANGE(PayrollMatrix.Paye,FALSE);
                   PayrollMatrix.CALCSUMS(Amount,"Employer Amount","Opening Balance Company");
                   Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");

                         TotalToDate:=PayrollMatrix."Employer Amount"+PayrollMatrix."Opening Balance Company";
                       IF TotalToDate<>0 THEN BEGIN
                         ArrEarnings[1,i]:='Gratuity Employer Contrib Bal. to Date';
                         EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(TotalToDate,Employee."Company Code"))));
                         ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                         EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(TotalToDate,Employee."Company Code"))));
                         ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                     i:=i+1;
                     END;
                   UNTIL Deduct.NEXT=0;
                  END;


                   // Non Cash Benefits
                  Earn.RESET;
                  Earn.SETRANGE(Earn."Earning Type",Earn."Earning Type"::"Normal Earning");
                  Earn.SETRANGE(Earn."Non-Cash Benefit",TRUE);
                   IF Earn.FIND('-') THEN BEGIN
                    REPEAT
                     PayrollMatrix.RESET;
                     PayrollMatrix.SETRANGE(PayrollMatrix."Payroll Period",DateSpecified);
                     PayrollMatrix.SETRANGE(Type,PayrollMatrix.Type::Payment);
                     PayrollMatrix.SETRANGE(PayrollMatrix."Employee No",Employee."No.");
                     PayrollMatrix.SETRANGE(PayrollMatrix."Basic Salary Code",FALSE);
                     PayrollMatrix.SETRANGE(Code,Earn.Code);
                     IF PayrollMatrix.FIND('-') THEN BEGIN
                      REPEAT
                         ArrEarnings[1,i]:=PayrollMatrix.Description;
                         EVALUATE(ArrEarningsAmt[1,i],FORMAT(PayrollRounding(PayrollMatrix.Amount,Employee."Company Code")));
                         ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                         i:=i+1;
                      UNTIL PayrollMatrix.NEXT=0;
                     END;
                    UNTIL Earn.NEXT=0;
                   END;
                   // end of non cash

               Ded.RESET;
               Ded.SETRANGE(Ded."Reduces Taxable Amt",TRUE);
               Ded.SETRANGE(Ded."Pay Period Filter",DateSpecified);
               Ded.SETRANGE(Ded."Employee Filter",Employee."No.");
               Ded.SETRANGE(Ded."Show on Payslip Information",TRUE);
               IF Ded.FIND('-') THEN
                REPEAT
                 Ded.CALCFIELDS(Ded."Total Amount",Ded."Total Amount Employer");
                 EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(Ded."Total Amount Employer",Employee."Company Code"))));
                 ArrEarnings[1,i]:=Ded.Description+'(Employer)';
                 ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                 i:=i+1;
                UNTIL Ded.NEXT=0;
               //End balances

                i:=i+1;

                  //

                   ArrEarnings[1,i]:='------------------------------------------------';
                   ArrEarningsAmt[1,i]:='------------------------------------------------';






                    i:=i+1;
                   ArrEarnings[1,i]:='Employee Details';
                   // Employee details
                    i:=i+1;

                   ArrEarnings[1,i]:='------------------------------------------------';
                   ArrEarningsAmt[1,i]:='------------------------------------------------';
                    i:=i+1;

                   ArrEarnings[1,i]:='P.I.N';
                   ArrEarningsAmt[1,i]:=Employee."PIN Number";

                   i:=i+1;

                   ArrEarnings[1,i]:='National ID';
                   ArrEarningsAmt[1,i]:=Employee."ID Number";

                   i:=i+1;
                   ArrEarnings[1,i]:='Bank Branch';
                   ArrEarningsAmt[1,i]:=EmpBank."Branch Name";

                   i:=i+1;
                   ArrEarnings[1,i]:='Acc No.';
                   ArrEarningsAmt[1,i]:="Bank Account Number";

                   i:=i+1;
                   ArrEarnings[1,i]:='NSSF No';
                   ArrEarningsAmt[1,i]:=Employee."NSSF No";
                   i:=i+1;
                   ArrEarnings[1,i]:='SHIF No';
                   ArrEarningsAmt[1,i]:=Employee."SHIF No";
                   i:=i+1;


               ArrEarnings[1,i]:='Leave Balance';

               {AccPeriod.RESET;
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
               }
               //Get Working Hours
               // Get Basic Salary
               Earn.RESET;
               Earn.SETRANGE(Earn."Salary Recovery",TRUE);
               IF Earn.FIND('-') THEN BEGIN
                 PayrollMatrix.RESET;
                 PayrollMatrix.SETRANGE(PayrollMatrix."Payroll Period",DateSpecified);
                 PayrollMatrix.SETRANGE(Type,PayrollMatrix.Type::Payment);
                 PayrollMatrix.SETRANGE(PayrollMatrix.Code,Earn.Code);
                 PayrollMatrix.SETRANGE(PayrollMatrix."Employee No",Employee."No.");
                  IF PayrollMatrix.FIND('-') THEN BEGIN
                  ArrEarnings[1,i]:='Expected Working Hours';
                  ArrEarningsAmt[1,i]:=FORMAT(PayrollMatrix."Expected Hrs");
                  i:=i+1;
                  ArrEarnings[1,i]:='Worked Hours';
                  ArrEarningsAmt[1,i]:=FORMAT(PayrollMatrix."Worked Hrs");
                 END;
               END;

               //

                    i:=i+1;
                   ArrEarnings[1,i]:='=======End of Payslip========';

                   i:=i+1;
                    PayrollSetup.GET(Employee."Company Code");
                    ArrEarnings[1,i]:=PayrollSetup."General Payslip Message";

                   i:=i+1;
                   ArrEarnings[1,i]:=USERID;
                   */
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
        PayPeriodtext:=Employee.GetFilter("Pay Period Filter");
        if PayPeriodtext = '' then Error('Pay period must be specified for this report');
        Evaluate(PayrollMonth, Format(PayPeriodtext));
        PayrollMonthText:=Format(PayrollMonth, 1, 4);
        Evaluate(DateSpecified, Format(PayPeriodtext));
        PayslipPeriod:=Format(Employee.GetRangeMin("Pay Period Filter")) + ' to ' + Format(CalcDate('1M', Employee.GetRangeMin("Pay Period Filter") - 1));
    end;
    var CompInfo: Record "Client Company Information";
    PayrollSetup: Record "Client Payroll Setup";
    PayPeriodtext: Text;
    PayrollMonth: Date;
    PayrollMonthText: Text[30];
    DateSpecified: Date;
    Message2: array[3, 1]of Text[250];
    Addr: array[10, 100]of Text[250];
    DeptArr: array[3, 1]of Text[60];
    BasicPay: array[3, 1]of Text[250];
    EmpArray: array[10, 15]of Decimal;
    ArrEarnings: array[3, 200]of Text[250];
    ArrEarningsAmt: array[3, 200]of Text[60];
    BalanceArray: array[3, 100]of Decimal;
    GrossPay: Decimal;
    TotalDeduction: Decimal;
    Totalcoopshares: Decimal;
    Totalnssf: Decimal;
    NetPay: Decimal;
    NAVEmployee: Record "Client Employee Master";
    Earn: Record "Client Earnings";
    PayrollMatrix: Record "Client Payroll Matrix";
    i: Integer;
    TaxableAmt: Decimal;
    PAYE: Decimal;
    TaxCharged: Decimal;
    Deduct: Record "Client Deductions";
    LoanBalance: Decimal;
    PositivePAYEManual: Decimal;
    PayDeduct: Record "Client Payroll Matrix";
    TotalSavingsToDate: Decimal;
    TotalDeposits: Decimal;
    SavingsRec: Record "Client Savings Scheme Trans";
    TotalWithdrawals: Decimal;
    TotalBulkRepayments: Decimal;
    TotalRepayments: Decimal;
    LoanBalances: Record "Client Loan Application";
    loanType: Record "Client Loan Product";
    LoanTopUps: Record "Client Loan Top-up";
    LineAmt: Decimal;
    RepSchedule: Record "Client Loan Schedule";
    TotalToDate: Decimal;
    TotalPensionInactive: Decimal;
    Ded: Record "Client Deductions";
    EmpBank: Record "Bank Branches";
    BankName: Text;
    CoName: Integer;
    EarningsCaptionLbl: Label 'Description';
    Employee_No_CaptionLbl: Label 'Employee No:';
    Name_CaptionLbl: Label 'Name:';
    Dept_CaptionLbl: Label 'Dept:';
    AmountCaptionLbl: Label 'Amount';
    Pay_slipCaptionLbl: Label 'Pay Slip';
    EmptyStringCaptionLbl: Label '----------------------------------------------------------------------------------------------------------';
    CurrReport_PAGENOCaptionLbl: Label 'Copy';
    PayslipPeriod: Text;
    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record "Client Bracket";
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
    procedure PayrollRounding(var Amount: Decimal; var Company: Code[20])PayrollRounding: Decimal var
        HRsetup: Record "Client Payroll Setup";
    begin
        HRsetup.Get(Company);
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
    procedure NetPayRounding(var Amount: Decimal; var Company: Code[20])PayrollRounding: Decimal var
        HRsetup: Record "Client Payroll Setup";
    begin
        HRsetup.Get(Company);
        if HRsetup."Net Pay Rounding Precision" <> 0 then begin
            if HRsetup."Net Pay Rounding Type" = HRsetup."Net Pay Rounding Type"::Nearest then PayrollRounding:=Round(Amount, HRsetup."Net Pay Rounding Precision", '=');
            if HRsetup."Net Pay Rounding Type" = HRsetup."Net Pay Rounding Type"::Up then PayrollRounding:=Round(Amount, HRsetup."Net Pay Rounding Precision", '>');
            if HRsetup."Net Pay Rounding Type" = HRsetup."Net Pay Rounding Type"::Down then PayrollRounding:=Round(Amount, HRsetup."Net Pay Rounding Precision", '<');
        end
        else
            PayrollRounding:=Amount;
    end;
}
