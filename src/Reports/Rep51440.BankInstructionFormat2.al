report 51440 "Bank Instruction Format 2"
{
    // version THL- Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Bank Instruction Format 2.rdlc';
    Caption = 'Bank Instruction';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; "Employee Master")
        {
            RequestFilterFields = "Pay Period Filter";

            column(CompName; CompInfo.Name)
            {
            }
            column(Logo; CompInfo.Picture)
            {
            }
            column(OurBankName; CompInfo."Bank Name")
            {
            }
            column(OurBankAddress; CompInfo."Bank Branch No.")
            {
            }
            column(OurBankTown; CompInfo.City)
            {
            }
            column(No; Counter)
            {
            }
            column(Name; NAVEmp."First Name" + ' ' + NAVEmp."Last Name" + ' ' + NAVEmp."Middle Name")
            {
            }
            column(StaffID; Employee."No.")
            {
            }
            column(BankName; BankName)
            {
            }
            column(AccountNumber; Employee."Bank Account Number")
            {
            }
            column(Current; Amount)
            {
            }
            column(Filters; Filters)
            {
            }
            column(ChequeNo; ChequeNo)
            {
            }
            column(CurrentDate; CurrentDate)
            {
            }
            column(BankCode; Employee."Bank Code")
            {
            }
            column(BranchCode; PadStr('', 3 - StrLen(Employee."Bank Branch"), '0') + Employee."Bank Branch")
            {
            }
            column(MonthName; MonthName)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Amount:=0;
                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions");
                Amount:=Employee."Total Allowances" + Employee."Total Deductions";
                NAVEmp.Get(Employee."No.");
                if Banks.Get(Employee."Bank Code")then BankName:=Banks.Name;
                if Amount = 0 then CurrReport.Skip;
                Counter:=Counter + 1;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(ChequeNo; ChequeNo)
                {
                    ApplicationArea = All;
                    Caption = 'Cheque Number';
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        MonthStartDate:=Employee.GetFilter("Pay Period Filter");
        if MonthStartDate = '' then Error(Text000);
        Filters:=Employee.GetFilters;
        CurrentDate:=Format(Today, 0, 4);
        Evaluate(PayPeriod, MonthStartDate);
        MonthName:=UpperCase(Format(PayPeriod, 0, '<Month Text> <Year4>'));
    end;
    var EmpName: Text[150];
    EmployeeCaptionLbl: Label 'Employee';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    Current_PeriodCaptionLbl: Label 'Current Period';
    Previous_PeriodCaptionLbl: Label 'Previous Period';
    VarianceCaptionLbl: Label 'Variance';
    NameCaptionLbl: Label 'Name';
    Emp__NoCaptionLbl: Label 'Emp. No';
    NAVEmp: Record Employee;
    Filters: Text;
    MonthStartDate: Text;
    CompInfo: Record "Company Information";
    ChequeNo: Code[10];
    CurrentDate: Text;
    Counter: Integer;
    Amount: Decimal;
    BankName: Text;
    Banks: Record "Commercial Banks";
    Text000: Label 'Please select Pay Period Filter';
    MonthName: Text;
    PayPeriod: Date;
}
