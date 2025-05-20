report 51433 "Company Totals"
{
    // version THL- Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Company Totals.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Payroll Matrix"; "Payroll Matrix")
        {
            DataItemTableView = SORTING("Payroll Period", Type, Code);
            RequestFilterFields = "Payroll Period";
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
            column(Assignment_Matrix_X1__Assignment_Matrix_X1__Description; "Payroll Matrix".Description)
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
            column(Assignment_Matrix_X1_Payroll_Period; "Payroll Period")
            {
            }
            column(Assignment_Matrix_X1_Reference_No; "Reference No")
            {
            }
            column(Taxableamount_AssignmentMatrixX1; "Payroll Matrix"."Taxable amount")
            {
            }
            column(TaxDeductible_AssignmentMatrixX1; "Payroll Matrix"."Reduces Taxable Amt")
            {
            }
            column(TaxCharged; Taxcharged)
            {
            }
            column(Contribution_Benefit; "Payroll Matrix"."Less Pension Contribution")
            {
            }
            column(NonCashBenefit_AssignmentMatrixX1; "Payroll Matrix"."Non-Cash Benefit")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if NAVEmp.Get("Payroll Matrix"."Employee No")then begin
                    if NAVEmp.Status <> NAVEmp.Status::Active then CurrReport.Skip;
                end;
                if "Payroll Matrix".Type = "Payroll Matrix".Type::Payment then begin
                    if "Payroll Matrix"."Tax Relief" = false then begin
                        if Earning.Get("Payroll Matrix".Code)then begin
                            if not Earning."Non-Cash Benefit" then TotalNetPay:=TotalNetPay + "Payroll Matrix".Amount;
                        end;
                    end
                    else
                        TotalNetPay:=TotalNetPay + "Payroll Matrix".Amount;
                end;
            end;
            trigger OnPreDataItem()
            begin
                LastFieldNo:=FieldNo(Code);
                TotalNetPay:=0;
            end;
        }
        dataitem("Loan Application"; "Loan Application")
        {
            column(FORMAT_TODAY_0_4_1; Format(Today, 0, 4))
            {
            }
            column(LOAN_STATUS_REPORT_;'LOAN STATUS REPORT')
            {
            }
            column(Loan_Application1__GETFILTERS; "Loan Application".GetFilters)
            {
            }
            column(Loan_Application1__Loan_Product_Type_; "Loan Product Type")
            {
            }
            column(Loan_Application1__Employee_No_; "Employee No")
            {
            }
            column(Loan_Application1__Employee_Name_; "Employee Name")
            {
            }
            column(Loan_Application1__Loan_Application1___Approved_Amount_; "Loan Application"."Approved Amount")
            {
            }
            column(Loan_Application1__Loan_Application1___Total_Repayment_; "Loan Application"."Total Repayment")
            {
            }
            column(Balance; Balance)
            {
            }
            column(Loan_Application1__Loan_Application1___Interest_Amount_; "Loan Application"."Interest Amount")
            {
            }
            column(i; i)
            {
            }
            column(Loan_Application1__Loan_Application1___Approved_Amount__Control1000000008; "Loan Application"."Approved Amount")
            {
            }
            column(Loan_Application1__Loan_Application1___Interest_Amount__Control1000000009; "Loan Application"."Interest Amount")
            {
            }
            column(Loan_Application1__Loan_Application1___Total_Repayment__Control1000000011; "Loan Application"."Total Repayment")
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
            column(Loan_App_Description; "Loan Application".Description)
            {
            }
            trigger OnAfterGetRecord()
            begin
                "Loan Application".CalcFields("Loan Application"."Total Repayment", "Loan Application"."Interest Amount", "Loan Application".Receipts);
                Balance:=0;
                Balance:=("Loan Application"."Approved Amount" + "Loan Application"."Total Repayment" - "Loan Application".Receipts);
                i:=i + 1;
            end;
            trigger OnPreDataItem()
            begin
                LastFieldNo:=FieldNo("Loan Product Type");
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
        EmpRec.SetRange(EmpRec."Pay Period Filter", "Payroll Matrix".GetRangeMin("Payroll Matrix"."Payroll Period"));
        if EmpRec.Find('-')then repeat EmpRec.CalcFields(EmpRec."Total Allowances", EmpRec."Total Deductions");
                if(EmpRec."Total Allowances" + EmpRec."Total Deductions") <> 0 then NoOfEmployees:=NoOfEmployees + 1;
            until EmpRec.Next = 0;
        CompInfo.Get;
        if not NoLogo then CompInfo.CalcFields(Picture);
    end;
    var LastFieldNo: Integer;
    FooterPrinted: Boolean;
    TotalFor: Label 'Total for ';
    TotalNetPay: Decimal;
    Earning: Record Earnings;
    NoOfEmployees: Integer;
    EmpRec: Record "Employee Master";
    COMPANY_SUMMARYCaptionLbl: Label 'COMPANY SUMMARY';
    PERIOD_CaptionLbl: Label 'PERIOD:';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    CODECaptionLbl: Label 'CODE';
    DESCRIPTIONCaptionLbl: Label 'DESCRIPTION';
    AMOUNTCaptionLbl: Label 'AMOUNT';
    Balance: Decimal;
    i: Integer;
    TaxChargedLbl: Label 'Tax Charged';
    Taxcharged: Decimal;
    NAVEmp: Record Employee;
    CompInfo: Record "Company Information";
    NoLogo: Boolean;
}
