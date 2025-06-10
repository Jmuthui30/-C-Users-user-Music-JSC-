report 51435 "Bank List"
{
    // version THL- Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Client EFT Bank Transfer.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; "Client Employee Master")
        {
            RequestFilterFields = "Pay Period Filter", "Company Code", "Employee Group", "No.";

            column(CompName; CompInfo.Name)
            {
            }
            column(Logo; CompInfo.Picture)
            {
            }
            column(No; Employee."No.")
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
            column(USER; UserId)
            {
            }
            column(VAR_ColumnsText; VAR_ColumnsText)
            {
            }
            column(DT; CurrentDateTime)
            {
            }
            column(BankCode; Employee."Bank Code")
            {
            }
            column(Branch; Employee."Bank Branch")
            {
            }
            column(EFTFile; EFTFile)
            {
            }
            trigger OnAfterGetRecord()
            var
                String: Text;
                Where: text;
                Which: text;
                NewString: text;
                LCL_NewAmount: Decimal;
            begin
                Amount := 0;
                BankName := '';
                NAVEmp.Get(Employee."No.");
                EmpName := NAVEmp."First Name" + ' ' + NAVEmp."Last Name" + ' ' + NAVEmp."Middle Name";
                if NAVEmp.Status <> NAVEmp.Status::Active then CurrReport.Skip;
                if EmpBanks.Get(Employee."Bank Code") then BankName := EmpBanks.Name;
                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions");
                Amount := Employee."Total Allowances" + Employee."Total Deductions";
                if Amount = 0 then CurrReport.Skip;
                //EFT Start
                if SendToEFT = true then begin
                    clear(VAR_EmployeeName);
                    clear(VAR_BankCode);
                    clear(VAR_BranchCode);
                    clear(VAR_AccountNumber);
                    if Employee.get(Employee."No.") then begin
                        VAR_EmployeeName := UpperCase(Employee."Full Name");
                        VAR_BankCode := Employee."Bank Code";
                        VAR_BranchCode := Employee."Bank Branch";
                        VAR_AccountNumber := Employee."Bank Account Number";
                    end;
                    LCL_NewAmount := Amount * 100;
                    //Deleting commas
                    String := format(LCL_NewAmount);
                    Where := '=';
                    Which := ',';
                    NewString := DELCHR(String, Where, Which);
                    Var_NetAmount := NewString;
                    //Deleting decimals
                    String := format(Var_NetAmount);
                    Where := '=';
                    Which := '.';
                    NewString := DELCHR(String, Where, Which);
                    Var_NetAmount := NewString;
                    Clear(VAR_ColumnsText);
                    //Concatenated columns Text;
                    VAR_ColumnsText := VAR_BankCode + Employee."No." + VAR_BranchCode + VAR_AccountNumber + 'P' + Format(Var_NetAmount) + VAR_EmployeeName;
                    EFTFile := Employee."Bank Code" + Employee."No." + VAR_BranchCode + VAR_AccountNumber + 'P' + Var_NetAmount + VAR_EmployeeName;
                    //if SendToEFT then begin
                    //  CashMgt.InsertEFTEntries(Employee."Bank Code", Employee."Bank Branch", Employee."Bank Account Number", "EmpName", Amount, BankName);
                    // VAR_ColumnsText := VAR_BankCode + Employee."No." + VAR_BranchCode + VAR_AccountNumber + 'P' + Var_NetAmount + VAR_EmployeeName;
                    // EFTFile := Employee."Bank Code" + Employee."Bank Branch" + Employee."Bank Account Number" + "EmpName" + Format(Amount);
                    //Eft End
                    //end;
                end;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        MonthStartDate := Employee.GetFilter("Pay Period Filter");
        if MonthStartDate = '' then Error(Text000);
        Filters := Employee.GetFilters;
    end;

    var
        EmployeeCaptionLbl: Label 'Employee';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Current_PeriodCaptionLbl: Label 'Current Period';
        Previous_PeriodCaptionLbl: Label 'Previous Period';
        VarianceCaptionLbl: Label 'Variance';
        NameCaptionLbl: Label 'Name';
        Emp__NoCaptionLbl: Label 'Emp. No';
        Filters: Text;
        VAR_EmployeeName: Text;
        VAR_ColumnsText: text;
        VAR_BankCode: Text;
        VAR_BranchCode: Text;
        VAR_AccountNumber: Text;
        Var_NetAmount: text;
        MonthStartDate: Text;
        CompInfo: Record "Company Information";
        NAVEmp: Record "Client Employee Master";
        Amount: Decimal;
        EmpBanks: Record "Commercial Banks";
        BankName: Text;
        Text000: Label 'Please select Pay Period Filter';
        SendToEFT: Boolean;
        CashMgt: Codeunit "Cash Management";
        EmpName: Text;
        EFTFile: Text;
        OutputMode: Option "Preview Mode","Generate Payment CSV";
}
