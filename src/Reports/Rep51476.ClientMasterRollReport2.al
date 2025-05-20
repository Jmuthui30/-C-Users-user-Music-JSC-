report 51476 "Client Master Roll Report2"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Client Master Roll Report2.rdlc';
    Caption = 'Master Roll Report';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; "Client Employee Master")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Company Code", Status, "Pay Period Filter", "No.";

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
            column(EarnDesc_11_; EarnDesc[11])
            {
            }
            column(EarnDesc_12_; EarnDesc[12])
            {
            }
            column(EarnDesc_13_; EarnDesc[13])
            {
            }
            column(EarnDesc_14_; EarnDesc[14])
            {
            }
            column(EarnDesc_15_; EarnDesc[15])
            {
            }
            column(EarnDesc_16_; EarnDesc[16])
            {
            }
            column(EarnDesc_17_; EarnDesc[17])
            {
            }
            column(EarnDesc_18_; EarnDesc[18])
            {
            }
            column(EarnDesc_19_; EarnDesc[19])
            {
            }
            column(EarnDesc_20_; EarnDesc[20])
            {
            }
            column(EarnDesc_21_; EarnDesc[21])
            {
            }
            column(EarnDesc_22_; EarnDesc[22])
            {
            }
            column(EarnDesc_23_; EarnDesc[23])
            {
            }
            column(EarnDesc_24_; EarnDesc[24])
            {
            }
            column(EarnDesc_25_; EarnDesc[25])
            {
            }
            column(EarnDesc_26_; EarnDesc[26])
            {
            }
            column(EarnDesc_27_; EarnDesc[27])
            {
            }
            column(EarnDesc_28_; EarnDesc[28])
            {
            }
            column(EarnDesc_29_; EarnDesc[29])
            {
            }
            column(EarnDesc_30_; EarnDesc[30])
            {
            }
            column(EarnDesc_31_; EarnDesc[31])
            {
            }
            column(EarnDesc_32_; EarnDesc[32])
            {
            }
            column(EarnDesc_33_; EarnDesc[33])
            {
            }
            column(EarnDesc_34_; EarnDesc[34])
            {
            }
            column(EarnDesc_35_; EarnDesc[35])
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
            column(DedDesc_7_; DedDesc[7])
            {
            }
            column(DedDesc_8_; DedDesc[8])
            {
            }
            column(DedDesc_9_; DedDesc[9])
            {
            }
            column(DedDesc_10_; DedDesc[10])
            {
            }
            column(DedDesc_11_; DedDesc[11])
            {
            }
            column(DedDesc_12_; DedDesc[12])
            {
            }
            column(DedDesc_13_; DedDesc[13])
            {
            }
            column(DedDesc_14_; DedDesc[14])
            {
            }
            column(DedDesc_15_; DedDesc[15])
            {
            }
            column(DedDesc_16_; DedDesc[16])
            {
            }
            column(DedDesc_17_; DedDesc[17])
            {
            }
            column(DedDesc_18_; DedDesc[18])
            {
            }
            column(DedDesc_19_; DedDesc[19])
            {
            }
            column(DedDesc_20_; DedDesc[20])
            {
            }
            column(DedDesc_21_; DedDesc[21])
            {
            }
            column(DedDesc_22_; DedDesc[22])
            {
            }
            column(DedDesc_23_; DedDesc[23])
            {
            }
            column(DedDesc_24_; DedDesc[24])
            {
            }
            column(DedDesc_25_; DedDesc[25])
            {
            }
            column(DedDesc_26_; DedDesc[26])
            {
            }
            column(DedDesc_27_; DedDesc[27])
            {
            }
            column(DedDesc_28_; DedDesc[28])
            {
            }
            column(DedDesc_29_; DedDesc[29])
            {
            }
            column(DedDesc_30_; DedDesc[30])
            {
            }
            column(DedDesc_31_; DedDesc[31])
            {
            }
            column(DedDesc_32_; DedDesc[32])
            {
            }
            column(DedDesc_33_; DedDesc[33])
            {
            }
            column(DedDesc_34_; DedDesc[34])
            {
            }
            column(DedDesc_35_; DedDesc[35])
            {
            }
            column(DedDesc_36_; DedDesc[36])
            {
            }
            column(DedDesc_37_; DedDesc[37])
            {
            }
            column(DedDesc_38_; DedDesc[38])
            {
            }
            column(DedDesc_39_; DedDesc[39])
            {
            }
            column(DedDesc_40_; DedDesc[40])
            {
            }
            column(DedDesc_41_; DedDesc[41])
            {
            }
            column(DedDesc_42_; DedDesc[42])
            {
            }
            column(DedDesc_43_; DedDesc[43])
            {
            }
            column(DedDesc_44_; DedDesc[44])
            {
            }
            column(DedDesc_45_; DedDesc[45])
            {
            }
            column(DedDesc_46_; DedDesc[46])
            {
            }
            column(DedDesc_47_; DedDesc[47])
            {
            }
            column(DedDesc_48_; DedDesc[48])
            {
            }
            column(DedDesc_49_; DedDesc[49])
            {
            }
            column(DedDesc_50_; DedDesc[50])
            {
            }
            column(DedDesc_51_; DedDesc[51])
            {
            }
            column(DedDesc_52_; DedDesc[52])
            {
            }
            column(DedDesc_53_; DedDesc[53])
            {
            }
            column(DedDesc_54_; DedDesc[54])
            {
            }
            column(DedDesc_55_; DedDesc[55])
            {
            }
            column(DedDesc_56_; DedDesc[56])
            {
            }
            column(DedDesc_57_; DedDesc[57])
            {
            }
            column(DedDesc_58_; DedDesc[58])
            {
            }
            column(DedDesc_59_; DedDesc[59])
            {
            }
            column(DedDesc_60_; DedDesc[60])
            {
            }
            column(DedDesc_61_; DedDesc[61])
            {
            }
            column(DedDesc_62_; DedDesc[62])
            {
            }
            column(DedDesc_63_; DedDesc[63])
            {
            }
            column(DedDesc_64_; DedDesc[64])
            {
            }
            column(DedDesc_65_; DedDesc[65])
            {
            }
            column(DedDesc_66_; DedDesc[66])
            {
            }
            column(DedDesc_67_; DedDesc[67])
            {
            }
            column(DedDesc_68_; DedDesc[68])
            {
            }
            column(DedDesc_69_; DedDesc[69])
            {
            }
            column(DedDesc_70_; DedDesc[70])
            {
            }
            column(DedDesc_71_; DedDesc[71])
            {
            }
            column(DedDesc_72_; DedDesc[72])
            {
            }
            column(DedDesc_73_; DedDesc[73])
            {
            }
            column(DedDesc_74_; DedDesc[74])
            {
            }
            column(DedDesc_75_; DedDesc[75])
            {
            }
            column(DedDesc_76_; DedDesc[76])
            {
            }
            column(DedDesc_77_; DedDesc[77])
            {
            }
            column(DedDesc_78_; DedDesc[78])
            {
            }
            column(DedDesc_79_; DedDesc[79])
            {
            }
            column(DedDesc_80_; DedDesc[80])
            {
            }
            column(DedDesc_81_; DedDesc[81])
            {
            }
            column(DedDesc_82_; DedDesc[82])
            {
            }
            column(DedDesc_83_; DedDesc[83])
            {
            }
            column(DedDesc_84_; DedDesc[84])
            {
            }
            column(DedDesc_85_; DedDesc[85])
            {
            }
            column(DedDesc_86_; DedDesc[86])
            {
            }
            column(DedDesc_87_; DedDesc[87])
            {
            }
            column(DedDesc_88_; DedDesc[88])
            {
            }
            column(DedDesc_89_; DedDesc[89])
            {
            }
            column(DedDesc_90_; DedDesc[90])
            {
            }
            column(DedDesc_91_; DedDesc[91])
            {
            }
            column(DedDesc_92_; DedDesc[92])
            {
            }
            column(DedDesc_93_; DedDesc[93])
            {
            }
            column(DedDesc_94_; DedDesc[94])
            {
            }
            column(DedDesc_95_; DedDesc[95])
            {
            }
            column(DedDesc_96_; DedDesc[96])
            {
            }
            column(DedDesc_97_; DedDesc[97])
            {
            }
            column(DedDesc_98_; DedDesc[98])
            {
            }
            column(DedDesc_99_; DedDesc[99])
            {
            }
            column(DedDesc_100_; DedDesc[100])
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
            column(CCDesc_6_; CCDesc[6])
            {
            }
            column(CCDesc_7_; CCDesc[7])
            {
            }
            column(CCDesc_8_; CCDesc[8])
            {
            }
            column(CCDesc_9_; CCDesc[9])
            {
            }
            column(CCDesc_10_; CCDesc[10])
            {
            }
            column(CCDesc_11_; CCDesc[11])
            {
            }
            column(CCDesc_12_; CCDesc[12])
            {
            }
            column(CCDesc_13_; CCDesc[13])
            {
            }
            column(CCDesc_14_; CCDesc[14])
            {
            }
            column(CCDesc_15_; CCDesc[15])
            {
            }
            column(CCDesc_16_; CCDesc[16])
            {
            }
            column(CCDesc_17_; CCDesc[17])
            {
            }
            column(CCDesc_18_; CCDesc[18])
            {
            }
            column(CCDesc_19_; CCDesc[19])
            {
            }
            column(CCDesc_20_; CCDesc[20])
            {
            }
            column(CCDesc_21_; CCDesc[21])
            {
            }
            column(CCDesc_22_; CCDesc[22])
            {
            }
            column(CCDesc_23_; CCDesc[23])
            {
            }
            column(CCDesc_24_; CCDesc[24])
            {
            }
            column(CCDesc_25_; CCDesc[25])
            {
            }
            column(CCDesc_26_; CCDesc[26])
            {
            }
            column(CCDesc_27_; CCDesc[27])
            {
            }
            column(CCDesc_28_; CCDesc[28])
            {
            }
            column(CCDesc_29_; CCDesc[29])
            {
            }
            column(CCDesc_30_; CCDesc[30])
            {
            }
            column(CCDesc_31_; CCDesc[31])
            {
            }
            column(CCDesc_32_; CCDesc[32])
            {
            }
            column(CCDesc_33_; CCDesc[33])
            {
            }
            column(CCDesc_34_; CCDesc[34])
            {
            }
            column(CCDesc_35_; CCDesc[35])
            {
            }
            column(CCDesc_36_; CCDesc[36])
            {
            }
            column(CCDesc_37_; CCDesc[37])
            {
            }
            column(CCDesc_38_; CCDesc[38])
            {
            }
            column(CCDesc_39_; CCDesc[39])
            {
            }
            column(CCDesc_40_; CCDesc[40])
            {
            }
            column(CCDesc_41_; CCDesc[41])
            {
            }
            column(CCDesc_42_; CCDesc[42])
            {
            }
            column(CCDesc_43_; CCDesc[43])
            {
            }
            column(CCDesc_44_; CCDesc[44])
            {
            }
            column(CCDesc_45_; CCDesc[45])
            {
            }
            column(CCDesc_46_; CCDesc[46])
            {
            }
            column(CCDesc_47_; CCDesc[47])
            {
            }
            column(CCDesc_48_; CCDesc[48])
            {
            }
            column(CCDesc_49_; CCDesc[49])
            {
            }
            column(CCDesc_50_; CCDesc[50])
            {
            }
            column(CCDesc_51_; CCDesc[51])
            {
            }
            column(CCDesc_52_; CCDesc[52])
            {
            }
            column(CCDesc_53_; CCDesc[53])
            {
            }
            column(CCDesc_54_; CCDesc[54])
            {
            }
            column(CCDesc_55_; CCDesc[55])
            {
            }
            column(CCDesc_56_; CCDesc[56])
            {
            }
            column(CCDesc_57_; CCDesc[57])
            {
            }
            column(CCDesc_58_; CCDesc[58])
            {
            }
            column(CCDesc_59_; CCDesc[59])
            {
            }
            column(CCDesc_60_; CCDesc[60])
            {
            }
            column(CCDesc_61_; CCDesc[61])
            {
            }
            column(CCDesc_62_; CCDesc[62])
            {
            }
            column(CCDesc_63_; CCDesc[63])
            {
            }
            column(CCDesc_64_; CCDesc[64])
            {
            }
            column(CCDesc_65_; CCDesc[65])
            {
            }
            column(CCDesc_66_; CCDesc[66])
            {
            }
            column(CCDesc_67_; CCDesc[67])
            {
            }
            column(CCDesc_68_; CCDesc[68])
            {
            }
            column(CCDesc_69_; CCDesc[69])
            {
            }
            column(CCDesc_70_; CCDesc[70])
            {
            }
            column(CCDesc_71_; CCDesc[71])
            {
            }
            column(CCDesc_72_; CCDesc[72])
            {
            }
            column(CCDesc_73_; CCDesc[73])
            {
            }
            column(CCDesc_74_; CCDesc[74])
            {
            }
            column(CCDesc_75_; CCDesc[75])
            {
            }
            column(CCDesc_76_; CCDesc[76])
            {
            }
            column(CCDesc_77_; CCDesc[77])
            {
            }
            column(CCDesc_78_; CCDesc[78])
            {
            }
            column(CCDesc_79_; CCDesc[79])
            {
            }
            column(CCDesc_80_; CCDesc[80])
            {
            }
            column(CCDesc_81_; CCDesc[81])
            {
            }
            column(CCDesc_82_; CCDesc[82])
            {
            }
            column(CCDesc_83_; CCDesc[83])
            {
            }
            column(CCDesc_84_; CCDesc[84])
            {
            }
            column(CCDesc_85_; CCDesc[85])
            {
            }
            column(CCDesc_86_; CCDesc[86])
            {
            }
            column(CCDesc_87_; CCDesc[87])
            {
            }
            column(CCDesc_88_; CCDesc[88])
            {
            }
            column(CCDesc_89_; CCDesc[89])
            {
            }
            column(CCDesc_90_; CCDesc[90])
            {
            }
            column(CCDesc_91_; CCDesc[91])
            {
            }
            column(CCDesc_92_; CCDesc[92])
            {
            }
            column(CCDesc_93_; CCDesc[93])
            {
            }
            column(CCDesc_94_; CCDesc[95])
            {
            }
            column(CCDesc_95_; CCDesc[95])
            {
            }
            column(CCDesc_96_; CCDesc[96])
            {
            }
            column(CCDesc_97_; CCDesc[97])
            {
            }
            column(CCDesc_98_; CCDesc[98])
            {
            }
            column(CCDesc_99_; CCDesc[99])
            {
            }
            column(CCDesc_100_; CCDesc[100])
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
            column(Allowances_1_; Allowances[1])
            {
            }
            column(Allowances_2_; Allowances[2])
            {
            }
            column(Allowances_3_; Allowances[3])
            {
            }
            column(Allowances_4_; Allowances[4])
            {
            }
            column(Allowances_5_; Allowances[5])
            {
            }
            column(Allowances_6_; Allowances[6])
            {
            }
            column(Allowances_7_; Allowances[7])
            {
            }
            column(Allowances_8_; Allowances[8])
            {
            }
            column(Allowances_9_; Allowances[9])
            {
            }
            column(Allowances_10_; Allowances[10])
            {
            }
            column(Allowances_11_; Allowances[11])
            {
            }
            column(Allowances_12_; Allowances[12])
            {
            }
            column(Allowances_13_; Allowances[13])
            {
            }
            column(Allowances_14_; Allowances[14])
            {
            }
            column(Allowances_15_; Allowances[15])
            {
            }
            column(Allowances_16_; Allowances[16])
            {
            }
            column(Allowances_17_; Allowances[17])
            {
            }
            column(Allowances_18_; Allowances[18])
            {
            }
            column(Allowances_19_; Allowances[19])
            {
            }
            column(Allowances_20_; Allowances[20])
            {
            }
            column(Allowances_21_; Allowances[21])
            {
            }
            column(Allowances_22_; Allowances[22])
            {
            }
            column(Allowances_23_; Allowances[23])
            {
            }
            column(Allowances_24_; Allowances[24])
            {
            }
            column(Allowances_25_; Allowances[25])
            {
            }
            column(Allowances_26_; Allowances[26])
            {
            }
            column(Allowances_27_; Allowances[27])
            {
            }
            column(Allowances_28_; Allowances[28])
            {
            }
            column(Allowances_29_; Allowances[29])
            {
            }
            column(Allowances_30_; Allowances[30])
            {
            }
            column(Allowances_31_; Allowances[31])
            {
            }
            column(Allowances_32_; Allowances[32])
            {
            }
            column(Allowances_33_; Allowances[33])
            {
            }
            column(Allowances_34_; Allowances[34])
            {
            }
            column(Allowances_35_; Allowances[35])
            {
            }
            column(Allowances_36_; Allowances[36])
            {
            }
            column(Allowances_37_; Allowances[37])
            {
            }
            column(Allowances_38_; Allowances[38])
            {
            }
            column(Allowances_39_; Allowances[39])
            {
            }
            column(Allowances_40_; Allowances[40])
            {
            }
            column(OtherEarn; OtherEarn)
            {
            }
            column(GrossPay; Employee."Total Allowances")
            {
            }
            column(Deductions_1_; Deductions[1])
            {
            }
            column(Deductions_2_; Deductions[2])
            {
            }
            column(Deductions_3_; Deductions[3])
            {
            }
            column(Deductions_4_; Deductions[4])
            {
            }
            column(Deductions_5_; Deductions[5])
            {
            }
            column(Deductions_6_; Deductions[6])
            {
            }
            column(Deductions_7_; Deductions[7])
            {
            }
            column(Deductions_8_; Deductions[8])
            {
            }
            column(Deductions_9_; Deductions[9])
            {
            }
            column(Deductions_10_; Deductions[10])
            {
            }
            column(Deductions_11_; Deductions[11])
            {
            }
            column(Deductions_12_; Deductions[12])
            {
            }
            column(Deductions_13_; Deductions[13])
            {
            }
            column(Deductions_14_; Deductions[14])
            {
            }
            column(Deductions_15_; Deductions[15])
            {
            }
            column(Deductions_16_; Deductions[16])
            {
            }
            column(Deductions_17_; Deductions[17])
            {
            }
            column(Deductions_18_; Deductions[18])
            {
            }
            column(Deductions_19_; Deductions[19])
            {
            }
            column(Deductions_20_; Deductions[20])
            {
            }
            column(Deductions_21_; Deductions[21])
            {
            }
            column(Deductions_22_; Deductions[22])
            {
            }
            column(Deductions_23_; Deductions[23])
            {
            }
            column(Deductions_24_; Deductions[24])
            {
            }
            column(Deductions_25_; Deductions[25])
            {
            }
            column(Deductions_26_; Deductions[26])
            {
            }
            column(Deductions_27_; Deductions[27])
            {
            }
            column(Deductions_28_; Deductions[28])
            {
            }
            column(Deductions_29_; Deductions[29])
            {
            }
            column(Deductions_30_; Deductions[30])
            {
            }
            column(Deductions_31_; Deductions[31])
            {
            }
            column(Deductions_32_; Deductions[32])
            {
            }
            column(Deductions_33_; Deductions[33])
            {
            }
            column(Deductions_34_; Deductions[34])
            {
            }
            column(Deductions_35_; Deductions[35])
            {
            }
            column(Deductions_36_; Deductions[36])
            {
            }
            column(Deductions_37_; Deductions[37])
            {
            }
            column(Deductions_38_; Deductions[38])
            {
            }
            column(Deductions_39_; Deductions[39])
            {
            }
            column(Deductions_40_; Deductions[40])
            {
            }
            column(Deductions_41_; Deductions[41])
            {
            }
            column(Deductions_42_; Deductions[42])
            {
            }
            column(Deductions_43_; Deductions[43])
            {
            }
            column(Deductions_44_; Deductions[44])
            {
            }
            column(Deductions_45_; Deductions[45])
            {
            }
            column(Deductions_46_; Deductions[46])
            {
            }
            column(Deductions_47_; Deductions[47])
            {
            }
            column(Deductions_48_; Deductions[48])
            {
            }
            column(Deductions_49_; Deductions[49])
            {
            }
            column(Deductions_50_; Deductions[50])
            {
            }
            column(Deductions_51_; Deductions[51])
            {
            }
            column(Deductions_52_; Deductions[52])
            {
            }
            column(Deductions_53_; Deductions[53])
            {
            }
            column(Deductions_54_; Deductions[54])
            {
            }
            column(Deductions_55_; Deductions[55])
            {
            }
            column(Deductions_56_; Deductions[56])
            {
            }
            column(Deductions_57_; Deductions[57])
            {
            }
            column(Deductions_58_; Deductions[58])
            {
            }
            column(Deductions_59_; Deductions[59])
            {
            }
            column(Deductions_60_; Deductions[60])
            {
            }
            column(Deductions_61_; Deductions[61])
            {
            }
            column(Deductions_62_; Deductions[62])
            {
            }
            column(Deductions_63_; Deductions[63])
            {
            }
            column(Deductions_64_; Deductions[64])
            {
            }
            column(Deductions_65_; Deductions[65])
            {
            }
            column(Deductions_66_; Deductions[66])
            {
            }
            column(Deductions_67_; Deductions[67])
            {
            }
            column(Deductions_68_; Deductions[68])
            {
            }
            column(Deductions_69_; Deductions[69])
            {
            }
            column(Deductions_70_; Deductions[70])
            {
            }
            column(Deductions_71_; Deductions[71])
            {
            }
            column(Deductions_72_; Deductions[72])
            {
            }
            column(Deductions_73_; Deductions[73])
            {
            }
            column(Deductions_74_; Deductions[74])
            {
            }
            column(Deductions_75_; Deductions[75])
            {
            }
            column(Deductions_76_; Deductions[76])
            {
            }
            column(Deductions_77_; Deductions[77])
            {
            }
            column(Deductions_78_; Deductions[78])
            {
            }
            column(Deductions_79_; Deductions[79])
            {
            }
            column(Deductions_80_; Deductions[80])
            {
            }
            column(Deductions_81_; Deductions[81])
            {
            }
            column(Deductions_82_; Deductions[82])
            {
            }
            column(Deductions_83_; Deductions[83])
            {
            }
            column(Deductions_84_; Deductions[84])
            {
            }
            column(Deductions_85_; Deductions[85])
            {
            }
            column(Deductions_86_; Deductions[86])
            {
            }
            column(Deductions_87_; Deductions[87])
            {
            }
            column(Deductions_88_; Deductions[88])
            {
            }
            column(Deductions_89_; Deductions[89])
            {
            }
            column(Deductions_90_; Deductions[90])
            {
            }
            column(Deductions_91_; Deductions[91])
            {
            }
            column(Deductions_92_; Deductions[92])
            {
            }
            column(Deductions_93_; Deductions[93])
            {
            }
            column(Deductions_94_; Deductions[94])
            {
            }
            column(Deductions_95_; Deductions[95])
            {
            }
            column(Deductions_96_; Deductions[96])
            {
            }
            column(Deductions_97_; Deductions[97])
            {
            }
            column(Deductions_98_; Deductions[98])
            {
            }
            column(Deductions_99_; Deductions[99])
            {
            }
            column(Deductions_100_; Deductions[100])
            {
            }
            column(OtherDeduct; OtherDeduct)
            {
            }
            column(CompanyCosts_1_; CompanyCosts[1])
            {
            }
            column(CompanyCosts_2_; CompanyCosts[2])
            {
            }
            column(CompanyCosts_3_; CompanyCosts[3])
            {
            }
            column(CompanyCosts_4_; CompanyCosts[4])
            {
            }
            column(CompanyCosts_5_; CompanyCosts[5])
            {
            }
            column(CompanyCosts_6_; CompanyCosts[6])
            {
            }
            column(CompanyCosts_7_; CompanyCosts[7])
            {
            }
            column(CompanyCosts_8_; CompanyCosts[8])
            {
            }
            column(CompanyCosts_9_; CompanyCosts[9])
            {
            }
            column(CompanyCosts_10_; CompanyCosts[10])
            {
            }
            column(TotalDeductions; Abs(Employee."Total Deductions"))
            {
            }
            column(TotalCompanyCosts; TotalCompanyCosts)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(First_Name_________Middle_Name_______Last_Name_; EmpName)
            {
            }
            column(Allowances_1__Control1000000009; Allowances[1])
            {
            }
            column(Allowances_2__Control1000000018; Allowances[2])
            {
            }
            column(Allowances_3__Control1000000032; Allowances[3])
            {
            }
            column(OtherEarn_Control1000000033; OtherEarn)
            {
            }
            column(Deductions_1__Control1000000034; Deductions[1])
            {
            }
            column(Deductions_2__Control1000000035; Deductions[2])
            {
            }
            column(Deductions_3__Control1000000036; Deductions[3])
            {
            }
            column(Deductions_4__Control1000000037; Deductions[4])
            {
            }
            column(OtherDeduct_Control1000000038; OtherDeduct)
            {
            }
            column(NetPay_Control1000000039; NetPay)
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
            column(Date_of_Birth; "Date of Birth")
            {
            }
            column(Age; Age)
            {
            }
            column(ID_Number; "ID Number")
            {
            }
            column(DateEngaged; "Starting Date")
            {
            }
            column(Gender; Gender)
            {
            }
            column(Grade; Scale)
            {
            }
            column(Station; "Employee Group")
            {
            }
            column(Designation; Designation)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions");
                if(Employee."Total Allowances" + Employee."Total Deductions") = 0 then CurrReport.Skip;
                //if (Assignmat.Amount <= 0)
                //then begin
                //CurrReport.Skip()
                //end;
                counter:=counter + 1;
                NetPay:=Employee."Total Allowances" + Employee."Total Deductions";
                NetPay:=Payroll.NetPayRounding(NetPay, Employee."Company Code");
                if HREmployee.Get(Employee."No.")then Designation:=HREmployee."Job Title";
                if SendToEFT then begin
                    Banks.Get(Employee."Bank Code");
                    CashMgt.InsertEFTEntries(Employee."Bank Code", Employee."Bank Branch", Employee."Bank Account Number", EmpName, NetPay, Banks.Name);
                end;
                if NAVEmp.Get(Employee."No.")then begin
                    EmpName:=NAVEmp."First Name" + ' ' + NAVEmp."Last Name";
                end;
                for i:=1 to 100 do begin
                    Clear(Allowances[i]);
                    Clear(Deductions[i]);
                    Clear(CompanyCosts[i]);
                end;
                OtherEarn:=0;
                OtherDeduct:=0;
                Totallowances:=0;
                OtherDeduct:=0;
                TotalDeductions:=0;
                TotalRelief:=0;
                TotalCompanyCosts:=0;
                for i:=1 to NoOfEarnings do begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", Employee."No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Payment);
                    Assignmat.SetRange(Assignmat.Code, Earncode[i]);
                    Assignmat.SetRange(Assignmat.Company, Employee.GetFilter("Company Code"));
                    Assignmat.SetRange(Assignmat."Payroll Period", DateSpecified);
                    Assignmat.SetFilter(Assignmat.Amount, '<>%1', 0);
                    if Assignmat.Find('-')then Allowances[i]:=Assignmat.Amount;
                    if Assignmat."Normal Earnings" then Totallowances:=Totallowances + Allowances[i]
                    else
                    begin
                        Totallowances:=Totallowances - Allowances[i];
                        TotalRelief:=TotalRelief - Allowances[i];
                    end;
                end;
                OtherEarn:=Employee."Total Allowances" - (Totallowances - TotalRelief);
                for i:=1 to 100 do begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", Employee."No.");
                    Assignmat.SetRange(Company, Employee.GetFilter("Company Code"));
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Deduction);
                    Assignmat.SETFILTER(Assignmat.Code, '%1|%2|%3', 'PAYE', 'SHIF', 'NSSF');
                    Assignmat.SetRange(Assignmat.Code, deductcode[i]);
                    Assignmat.SetRange(Assignmat."Payroll Period", DateSpecified);
                    Assignmat.SetFilter(Assignmat.Amount, '<>%1', 0);
                    if Assignmat.Find('-')then Deductions[i]:=Abs(Assignmat.Amount);
                    TotalDeductions:=TotalDeductions + Deductions[i];
                end;
                OtherDeduct:=Abs(Employee."Total Deductions" + TotalDeductions);
                for i:=1 to NoOfDeductions do begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", Employee."No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Deduction);
                    Assignmat.SetRange(Assignmat.Code, CCcode[i]);
                    Assignmat.SetRange(Assignmat."Payroll Period", DateSpecified);
                    Assignmat.SetRange(Assignmat.Company, Employee.GetFilter("Company Code"));
                    Assignmat.SetFilter(Assignmat."Employer Amount", '<>%1', 0);
                    if Assignmat.Find('-')then CompanyCosts[i]:=Abs(Assignmat."Employer Amount");
                    TotalCompanyCosts:=TotalCompanyCosts + CompanyCosts[i];
                end;
                // Get Employee Age
                begin
                    if HREmployee.Get(Employee."No.")then begin
                        Age:=Dates.DetermineAge(HREmployee."Birth Date", Today);
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
                field(SendToEFT; SendToEFT)
                {
                    ApplicationArea = All;
                    Caption = 'Send To EFT Generator';
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
        if Employee.GetFilter("Pay Period Filter") = '' then Error('You must select a pay period to report for.');
        DateSpecified:=Employee.GetRangeMin(Employee."Pay Period Filter");
        //Earnings
        EarnRec.Reset;
        EarnRec.SetRange(Company, Employee.GetFilter("Company Code"));
        EarnRec.SetRange(EarnRec."Show on Master Roll", true);
        if EarnRec.Find('-')then repeat EarnRec.SetFilter("Pay Period Filter", '%1', DateSpecified);
                EarnRec.CalcFields("Total Amount");
                if EarnRec."Total Amount" <> 0 then begin
                    i:=i + 1;
                    Earncode[i]:=EarnRec.Code;
                    EarnDesc[i]:=EarnRec.Description;
                end;
            until EarnRec.Next = 0;
        //Earnings
        EarnRec.Reset;
        EarnRec.SetRange(Company, Employee.GetFilter("Company Code"));
        EarnRec.SetRange(EarnRec."Show on Master Roll", true);
        EarnRec.SetRange(EarnRec."Earning Type", EarnRec."Earning Type"::"Tax Relief");
        if EarnRec.Find('-')then repeat EarnRec.SetFilter("Pay Period Filter", '%1', DateSpecified);
                EarnRec.CalcFields("Total Amount");
                if EarnRec."Total Amount" <> 0 then begin
                    i:=i + 1;
                    Earncode[i]:=EarnRec.Code;
                    EarnDesc[i]:=EarnRec.Description;
                end;
            until EarnRec.Next = 0;
        //Earnings
        EarnRec.Reset;
        EarnRec.SetRange(Company, Employee.GetFilter("Company Code"));
        EarnRec.SetRange(EarnRec."Show on Master Roll", true);
        EarnRec.SetRange(EarnRec."Calculation Method", EarnRec."Calculation Method"::"% of SHIF");
        if EarnRec.Find('-')then repeat EarnRec.SetFilter("Pay Period Filter", '%1', DateSpecified);
                EarnRec.CalcFields("Total Amount");
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
        if DedRec.Find('-')then repeat DedRec.SetFilter("Pay Period Filter", '%1', DateSpecified);
                DedRec.CalcFields("Total Amount");
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
        if CCRec.Find('-')then repeat CCRec.SetFilter("Pay Period Filter", '%1', DateSpecified);
                CCRec.CalcFields("Total Amount Employer");
                if CCRec."Total Amount Employer" <> 0 then begin
                    k:=k + 1;
                    CCcode[k]:=CCRec.Code;
                    CCDesc[k]:='ER ' + CCRec.Description;
                end;
            until CCRec.Next = 0;
        CompInfo.Get(Employee.GetFilter("Company Code"));
        CompInfo.CalcFields(Picture);
    end;
    var Allowances: array[100]of Decimal;
    Deductions: array[100]of Decimal;
    CompanyCosts: array[100]of Decimal;
    EarnRec: Record "Client Earnings";
    DedRec: Record "Client Deductions";
    CCRec: Record "Client Deductions";
    Earncode: array[100]of Code[20];
    deductcode: array[100]of Code[20];
    CCcode: array[100]of Code[20];
    EarnDesc: array[100]of Text[50];
    DedDesc: array[100]of Text[50];
    CCDesc: array[100]of Text[50];
    i: Integer;
    j: Integer;
    k: Integer;
    Assignmat: Record "Client Payroll Matrix";
    DateSpecified: Date;
    Totallowances: Decimal;
    TotalDeductions: Decimal;
    TotalCompanyCosts: Decimal;
    OtherEarn: Decimal;
    OtherDeduct: Decimal;
    counter: Integer;
    HRSetup: Record "Human Resources Setup";
    NetPay: Decimal;
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
    HREmployee: Record Employee;
    Designation: Text[250];
    DateOfEngagement: Date;
    Age: Text[100];
    Dates: Codeunit "HR Dates";
}
