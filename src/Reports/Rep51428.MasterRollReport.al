report 51428 "Master Roll Report"
{
    // version THL- Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Master Roll Report.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; "Employee Master")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Pay Period Filter", "No.";

            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(COMPANYNAME; CompanyName)
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
            column(EarnDesc_1_; EarnDesc[1])
            {
            }
            column(EarnDesc_2_; EarnDesc[2])
            {
            }
            column(EarnDesc_3_; EarnDesc[3])
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
            column(Employee__No__; "No.")
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
                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions");
                if(Employee."Total Allowances" + Employee."Total Deductions") = 0 then CurrReport.Skip;
                counter:=counter + 1;
                NetPay:=Employee."Total Allowances" + Employee."Total Deductions";
                NetPay:=Payroll.PayrollRounding(NetPay);
                /*IF SendToEFT THEN BEGIN
                  Banks.GET(Employee."Bank Code");
                  CashMgt.InsertEFTEntries(Employee."Bank Code",Employee."Bank Branch",Employee."Bank Account Number",EmpName,NetPay,Banks.Name);
                END;*/
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
                for i:=1 to 3 do begin
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
                for i:=1 to 4 do begin
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
        DateSpecified:=Employee.GetRangeMin(Employee."Pay Period Filter");
        EarnRec.Reset;
        EarnRec.SetRange(EarnRec."Show on Master Roll", true);
        if EarnRec.Find('-')then repeat i:=i + 1;
                Earncode[i]:=EarnRec.Code;
                EarnDesc[i]:=EarnRec.Description;
            until EarnRec.Next = 0;
        DedRec.Reset;
        DedRec.SetRange(DedRec."Show on Master Roll", true);
        if DedRec.Find('-')then repeat j:=j + 1;
                deductcode[j]:=DedRec.Code;
                DedDesc[j]:=DedRec.Description;
            until DedRec.Next = 0;
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;
    var Allowances: array[30]of Decimal;
    Deductions: array[30]of Decimal;
    EarnRec: Record Earnings;
    DedRec: Record Deductions;
    Earncode: array[30]of Code[10];
    deductcode: array[30]of Code[10];
    EarnDesc: array[30]of Text[50];
    DedDesc: array[30]of Text[50];
    i: Integer;
    j: Integer;
    Assignmat: Record "Payroll Matrix";
    DateSpecified: Date;
    Totallowances: Decimal;
    TotalDeductions: Decimal;
    OtherEarn: Decimal;
    OtherDeduct: Decimal;
    counter: Integer;
    HRSetup: Record "Human Resources Setup";
    NetPay: Decimal;
    Payroll: Codeunit "Payroll Calculator";
    MASTER_ROLLCaptionLbl: Label 'MASTER ROLL';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    Other_AllowancesCaptionLbl: Label 'Other Allowances';
    NAVEmp: Record Employee;
    EmpName: Text;
    CompInfo: Record "Company Information";
    SendToEFT: Boolean;
    CashMgt: Codeunit "Cash Management";
    Banks: Record "Commercial Banks";
    TotalRelief: Decimal;
}
