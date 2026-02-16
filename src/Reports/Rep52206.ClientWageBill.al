report 52206 "Client Wage Bill"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Client Wage Bill.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Client Payroll Matrix"; "Client Payroll Matrix")
        {
            DataItemTableView = SORTING("Payroll Period", Type, Code);
            RequestFilterFields = Company, "Payroll Period";
            RequestFilterHeading = 'Payroll';

            column(COMPANYNAME; CompInfo.Name)
            {
            }
            column(Logo; CompInfo.Picture)
            {
            }
            column(UPPERCASE_FORMAT__Payroll_Period__0___month_text___year4____; UpperCase(Format("Payroll Period", 0, '<month text> <year4>')))
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            column(Code; Code)
            {
            }
            /*column(CurrReport_PAGENO;CurrReport.PageNo)
            {
            }*/
            column(USERID; UserId)
            {
            }
            column(TIME; Time)
            {
            }
            column(Assignment_Matrix_X1_Type; Type)
            {
            }
            column(Institution; Deductions."Institution Code")
            {
            }
            column(Assignment_Matrix_X1__Assignment_Matrix_X1__Description; "Client Payroll Matrix".Description)
            {
            }
            column(Assignment_Matrix_X1_Amount; Amount)
            {
            }
            column(Assignment_Matrix_X1_Code; Code)
            {
            }
            column(STRSUBSTNO__Total__1__Type_; StrSubstNo('Total %1', Type))
            {
            }
            column(NumberOfStaff; NumberOfStaff)
            {
            }
            column(Assignment_Matrix_X1_Amount_Control1000000031; Amount)
            {
            }
            column(Net_Salary_;'Net Salary')
            {
            }
            column(TotalNetPay; TotalNetPay)
            {
            }
            column(No_of_Employees_;'No of Employees')
            {
            }
            column(NoOfEmployees; NoOfEmployees)
            {
            }
            column(COMPANY_SUMMARYCaption; COMPANY_SUMMARYCaptionLbl)
            {
            }
            column(PERIOD_Caption; PERIOD_CaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(CODECaption; CODECaptionLbl)
            {
            }
            column(DESCRIPTIONCaption; DESCRIPTIONCaptionLbl)
            {
            }
            column(AMOUNTCaption; AMOUNTCaptionLbl)
            {
            }
            column(Assignment_Matrix_X1_Employee_No; "Employee No")
            {
            }
            column(TotalEarnings; TotalEarnings)
            {
            }
            column(Assignment_Matrix_X1_Payroll_Period; "Payroll Period")
            {
            }
            column(Assignment_Matrix_X1_Reference_No; "Reference No")
            {
            }
            column(Taxableamount_AssignmentMatrixX1; "Client Payroll Matrix"."Taxable amount")
            {
            }
            column(TaxDeductible_AssignmentMatrixX1; "Client Payroll Matrix"."Reduces Taxable Amt")
            {
            }
            column(TaxCharged; Taxcharged)
            {
            }
            column(Contribution_Benefit; "Client Payroll Matrix"."Less Pension Contribution")
            {
            }
            column(GroupCode_PRTransactionCodes; Deductions."Institution Code")
            {
            }
            column(Totaldeductions; NAVEmp."Total Deductions")
            {
            }
            column(Tax_Relief; "Client Payroll Matrix"."Tax Relief")
            {
            }
            column(NonCashBenefit_AssignmentMatrixX1; "Client Payroll Matrix"."Non-Cash Benefit")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if NAVEmp.Get("Client Payroll Matrix"."Employee No")then begin
                    if NAVEmp.Status <> NAVEmp.Status::Active then CurrReport.Skip;
                    if "Client Payroll Matrix"."Tax Relief" = true then CurrReport.Skip();
                    if "Client Payroll Matrix".Amount = 0 then CurrReport.skip;
                    begin
                        if(Earning."Earning Type" = Earning."Earning Type"::"Tax Relief") or (Earning."Earning Type" = Earning."Earning Type"::"Insurance Relief") or (Earning."Earning Type" = Earning."Earning Type"::"Owner Occupier")then CurrReport.Skip;
                    end;
                    begin
                        TotalEarnings:="Client Payroll Matrix".Amount;
                    end;
                end;
                if "Client Payroll Matrix".Type = "Client Payroll Matrix".Type::Payment then begin
                    if "Client Payroll Matrix"."Tax Relief" = false then begin
                        if Earning.Get("Client Payroll Matrix".Code)then begin
                            if not Earning."Non-Cash Benefit" then TotalNetPay:=TotalNetPay + "Client Payroll Matrix".Amount;
                            begin
                                TotalEarnings+="Client Payroll Matrix".Amount end end;
                        begin
                            if "Client Payroll Matrix".Type = "Client Payroll Matrix".Type::Deduction then Amount:=Amount * -1;
                        end;
                    end
                    else
                        TotalNetPay:=TotalNetPay + "Client Payroll Matrix".Amount;
                end;
            end;
            trigger OnPreDataItem()
            begin
                LastFieldNo:=FieldNo(Code);
                TotalNetPay:=0;
            end;
        }
        dataitem("Client Loan Application"; "Client Loan Application")
        {
            column(FORMAT_TODAY_0_4_1; Format(Today, 0, 4))
            {
            }
            column(LOAN_STATUS_REPORT_;'LOAN STATUS REPORT')
            {
            }
            column(Loan_Application1__GETFILTERS; "Client Loan Application".GetFilters)
            {
            }
            column(Loan_Application1__Loan_Product_Type_; "Client Loan Product Type")
            {
            }
            column(Loan_Application1__Employee_No_; "Employee No")
            {
            }
            column(Loan_Application1__Employee_Name_; "Employee Name")
            {
            }
            column(Loan_Application1__Loan_Application1___Approved_Amount_; "Client Loan Application"."Approved Amount")
            {
            }
            column(Loan_Application1__Loan_Application1___Total_Repayment_; "Client Loan Application"."Total Repayment")
            {
            }
            column(Balance; Balance)
            {
            }
            column(Loan_Application1__Loan_Application1___Interest_Amount_; "Client Loan Application"."Interest Amount")
            {
            }
            column(i; i)
            {
            }
            column(Loan_Application1__Loan_Application1___Approved_Amount__Control1000000008; "Client Loan Application"."Approved Amount")
            {
            }
            column(Loan_Application1__Loan_Application1___Interest_Amount__Control1000000009; "Client Loan Application"."Interest Amount")
            {
            }
            column(Loan_Application1__Loan_Application1___Total_Repayment__Control1000000011; "Client Loan Application"."Total Repayment")
            {
            }
            column(Balance_Control1000000016; Balance)
            {
            }
            column(Loan_Application1_Loan_No; "Loan No")
            {
            }
            column(Loan_Application1_Payroll_Group; "Payroll Group")
            {
            }
            column(Loan_App_Description; "Client Loan Application".Description)
            {
            }
            trigger OnAfterGetRecord()
            begin
                "Client Loan Application".CalcFields("Client Loan Application"."Total Repayment", "Client Loan Application"."Interest Amount", "Client Loan Application".Receipts);
                Balance:=0;
                Balance:=("Client Loan Application"."Approved Amount" + "Client Loan Application"."Total Repayment" - "Client Loan Application".Receipts);
                i:=i + 1;
            end;
            trigger OnPreDataItem()
            begin
                LastFieldNo:=FieldNo("Client Loan Product Type");
                if "Client Payroll Matrix".FindSet(false, false)then begin
                    NumberOfStaff:="Client Payroll Matrix".Count();
                end;
            /*CurrReport.CreateTotals(Balance);*/
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(NoLogo; NoLogo)
                {
                    ApplicationArea = All;
                    Caption = 'Print Without Logo';
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
        EmpRec.Reset;
        EmpRec.SetRange(EmpRec."Pay Period Filter", "Client Payroll Matrix".GetRangeMin("Client Payroll Matrix"."Payroll Period"));
        EmpRec.SetRange("Company Code", "Client Payroll Matrix".Company);
        if EmpRec.Find('-')then repeat EmpRec.CalcFields(EmpRec."Total Allowances", EmpRec."Total Deductions");
                if(EmpRec."Total Allowances" + EmpRec."Total Deductions") <> 0 then NoOfEmployees:=NoOfEmployees + 1;
            //Message('test%1', EmpRec."Total Allowances");
            until EmpRec.Next = 0;
        if "Client Payroll Matrix".Type = "Client Payroll Matrix".Type::Deduction then if "Client Payroll Matrix".GetFilter(Company) = '' then Error('Please select a company to report for.');
        if "Client Payroll Matrix".GetFilter("Payroll Period") = '' then Error('Please select a payroll period to report for.');
        CompInfo.Get("Client Payroll Matrix".GetFilter(Company));
        if not NoLogo then CompInfo.CalcFields(Picture);
    end;
    var LastFieldNo: Integer;
    NumberOfStaff: Integer;
    FooterPrinted: Boolean;
    TotalFor: Label 'Total for ';
    TotalNetPay: Decimal;
    Earning: Record "Client Earnings";
    Deductions: Record "Client Deductions";
    NoOfEmployees: Integer;
    EmpRec: Record "Client Employee Master";
    COMPANY_SUMMARYCaptionLbl: Label 'COMPANY SUMMARY';
    PERIOD_CaptionLbl: Label 'PERIOD:';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    CODECaptionLbl: Label 'CODE';
    DESCRIPTIONCaptionLbl: Label 'DESCRIPTION';
    AMOUNTCaptionLbl: Label 'AMOUNT';
    Balance: Decimal;
    TotalEarnings: Decimal;
    i: Integer;
    TaxChargedLbl: Label 'Tax Charged';
    Taxcharged: Decimal;
    NAVEmp: Record "Client Employee Master";
    CompInfo: Record "Client Company Information";
    NoLogo: Boolean;
}
