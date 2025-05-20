report 51466 "Client Bank Instruction"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Client Bank Instruction.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; "Client Employee Master")
        {
            RequestFilterFields = "Company Code", "Pay Period Filter", "Employee Group", "Bank Code", "Bank Branch", "No.";

            column(CompName; CompInfo.Name)
            {
            }
            column(Logo; CompInfo.Picture)
            {
            }
            column(OurBankName; CompInfo."Bank Name")
            {
            }
            column(OurBankAddress; CompInfo.Address)
            {
            }
            column(OurBankTown; CompInfo.City)
            {
            }
            column(Bank_Code; "Bank Code")
            {
            }
            column(No; Counter)
            {
            }
            column(Bank_Branch; "Bank Branch")
            {
            }
            column(Bank_Branch_Name; "Bank Branch Name")
            {
            }
            column(Name; NAVEmp."First Name" + ' ' + NAVEmp."Last Name" + ' ' + NAVEmp."Middle Name")
            {
            }
            column(Bank_Name; "Bank Name")
            {
            }
            column(StaffID; Employee."Payroll No.")
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
            column(MonthStartDate; MonthStartDate)
            {
            }
            column(EFTText; EFTText)
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
                field(GenerateEFT; GenerateEFT)
                {
                    ApplicationArea = All;
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
        CompInfo.Get(Employee.GetFilter("Company Code"));
        CompInfo.CalcFields(Picture);
        MonthStartDate:=Employee.GetFilter("Pay Period Filter");
        if MonthStartDate = '' then Error(Text000);
        Filters:=Employee.GetFilters;
        CurrentDate:=Format(Today, 0, 4);
    end;
    var EmpName: Text[150];
    EmployeeCaptionLbl: Label 'Employee';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    Current_PeriodCaptionLbl: Label 'Current Period';
    Previous_PeriodCaptionLbl: Label 'Previous Period';
    VarianceCaptionLbl: Label 'Variance';
    NameCaptionLbl: Label 'Name';
    Emp__NoCaptionLbl: Label 'Emp. No';
    NAVEmp: Record "Client Employee Master";
    Filters: Text;
    MonthStartDate: Text;
    CompInfo: Record "Client Company Information";
    ChequeNo: Code[10];
    CurrentDate: Text;
    Counter: Integer;
    Amount: Decimal;
    BankName: Text;
    Banks: Record "Commercial Banks";
    Text000: Label 'Please select Pay Period Filter';
    GenerateEFT: Boolean;
    EFTText: text;
}
