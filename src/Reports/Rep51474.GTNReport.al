report 51474 "GTN Report"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/GTN Report.rdlc';

    dataset
    {
        dataitem(Employee; "Client Employee Master")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Company Code", "Pay Period Filter", "No.", Status;

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompInfo.Name)
            {
            }
            /*column(CurrReport_PAGENO; CurrReport.PageNo)
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
            column(Other_Deductions_;'Other Deductions')
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
            column(CostCenterCode; "Cost Center Code")
            {
            }
            column(CostCenterName; "Cost Center Name")
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
            column(OtherEarn; OtherEarn)
            {
            }
            column(SOCCosts; SOCCosts)
            {
            }
            column(EmpCosts; EmpCosts)
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
            column(OtherDeduct; OtherDeduct)
            {
            }
            column(TotalDeductions; Abs(Employee."Total Deductions"))
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
            trigger OnAfterGetRecord()
            begin
                SOCCosts:=0;
                EmpCosts:=0;
                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions");
                if(Employee."Total Allowances" + Employee."Total Deductions") = 0 then CurrReport.Skip;
                counter:=counter + 1;
                NetPay:=Employee."Total Allowances" + Employee."Total Deductions";
                NetPay:=Payroll.NetPayRounding(NetPay, Employee."Company Code");
                SOCCosts:=Round(0.3142 * Employee."Total Allowances", 0.01);
                EmpCosts:=Employee."Total Allowances" + SOCCosts;
                if SendToEFT then begin
                    Banks.Get(Employee."Bank Code");
                    CashMgt.InsertEFTEntries(Employee."Bank Code", Employee."Bank Branch", Employee."Bank Account Number", EmpName, NetPay, Banks.Name);
                end;
                if NAVEmp.Get(Employee."No.")then begin
                    EmpName:=NAVEmp."First Name" + ' ' + NAVEmp."Last Name";
                end;
                for i:=1 to 10 do begin
                    Clear(Allowances[i]);
                    Clear(Deductions[i]);
                end;
                OtherEarn:=0;
                OtherDeduct:=0;
                Totallowances:=0;
                OtherDeduct:=0;
                TotalDeductions:=0;
                TotalRelief:=0;
                for i:=1 to 10 do begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", Employee."No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Payment);
                    Assignmat.SetRange(Assignmat.Code, Earncode[i]);
                    Assignmat.SetRange(Assignmat."Payroll Period", DateSpecified);
                    //Assignmat.SETRANGE(Assignmat."Normal Earnings",TRUE);
                    if Assignmat.Find('-')then Allowances[i]:=Assignmat.Amount;
                    if Assignmat."Normal Earnings" then Totallowances:=Totallowances + Allowances[i]
                    else
                    begin
                        Totallowances:=Totallowances - Allowances[i];
                        TotalRelief:=TotalRelief - Allowances[i];
                    end;
                end;
                OtherEarn:=Employee."Total Allowances" - (Totallowances - TotalRelief);
                for i:=1 to 5 do begin
                    Assignmat.Reset;
                    Assignmat.SetRange(Assignmat."Employee No", Employee."No.");
                    Assignmat.SetRange(Assignmat.Type, Assignmat.Type::Deduction);
                    //Assignmat.SETFILTER(Assignmat.Code,'%1|%2|%3','PAYE','SHIF','NSSF');
                    Assignmat.SetRange(Assignmat.Code, deductcode[i]);
                    Assignmat.SetRange(Assignmat."Payroll Period", DateSpecified);
                    if Assignmat.Find('-')then Deductions[i]:=Abs(Assignmat.Amount);
                    TotalDeductions:=TotalDeductions + Deductions[i];
                end;
                OtherDeduct:=Abs(Employee."Total Deductions" + TotalDeductions);
            end;
            trigger OnPreDataItem()
            begin
                //CurrReport.CreateTotals(Allowances, Deductions, OtherEarn, OtherDeduct, NetPay);
                HRSetup.Get;
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
        if Employee.GetFilter("Company Code") = '' then Error('You must select a company to report for.');
        if Employee.GetFilter("Pay Period Filter") = '' then Error('You must select a pay period to report for.');
        DateSpecified:=Employee.GetRangeMin(Employee."Pay Period Filter");
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
        CompInfo.Get(Employee.GetFilter("Company Code"));
        CompInfo.CalcFields(Picture);
    end;
    var Allowances: array[30]of Decimal;
    Deductions: array[30]of Decimal;
    EarnRec: Record "Client Earnings";
    DedRec: Record "Client Deductions";
    Earncode: array[30]of Code[20];
    deductcode: array[30]of Code[20];
    EarnDesc: array[30]of Text[50];
    DedDesc: array[30]of Text[50];
    i: Integer;
    j: Integer;
    Assignmat: Record "Client Payroll Matrix";
    DateSpecified: Date;
    Totallowances: Decimal;
    TotalDeductions: Decimal;
    OtherEarn: Decimal;
    OtherDeduct: Decimal;
    counter: Integer;
    HRSetup: Record "Human Resources Setup";
    NetPay: Decimal;
    Payroll: Codeunit "Client Payroll Calculator";
    MASTER_ROLLCaptionLbl: Label 'GTN REPORT';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    Other_AllowancesCaptionLbl: Label 'Other Allowances';
    NAVEmp: Record "Client Employee Master";
    EmpName: Text;
    CompInfo: Record "Client Company Information";
    SendToEFT: Boolean;
    CashMgt: Codeunit "Cash Management";
    Banks: Record "Commercial Banks";
    TotalRelief: Decimal;
    SOCCosts: Decimal;
    EmpCosts: Decimal;
}
