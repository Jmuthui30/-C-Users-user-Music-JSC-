report 51466 "Client Bank Instruction"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Client Bank Instruction.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "Pay Period Filter", "Employee Group", "Employee's Bank", "Bank Branch", "No.";
            DataItemTableView = where(Status = const(Active));

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
            column(Bank_Code; "Employee's Bank")
            {
            }
            column(No; Counter)
            {
            }
            column(Bank_Branch; "Bank Branch")
            {
            }
            column(PayPeriodDisplay; PayPeriodDisplay)
            {

            }
            column(Bank_Branch_Name; "Bank Branch")
            {
            }
            column(Name; NAVEmp."First Name" + ' ' + NAVEmp."Last Name" + ' ' + NAVEmp."Middle Name")
            {
            }
            column(Bank_Name; "Employee Bank Name")
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
            column(MonthStartDate; MonthStartDate)
            {
            }
            column(EFTText; EFTText)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Amount := 0;
                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions");
                Amount := Employee."Total Allowances" + Employee."Total Deductions";
                NAVEmp.Get(Employee."No.");
                if Banks.Get(Employee."Employee's Bank") then
                    BankName := Banks.Name;
                if Amount = 0 then
                    CurrReport.Skip;
                Counter := Counter + 1;
                if ExportToTXT then
                    WriteLineToTXT();
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
                field(ExportToTXT; ExportToTXT)
                {
                    ApplicationArea = All;
                    Caption = 'Export to TXT';
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
        if Employee.GetFilter("Pay Period Filter") = '' then
            Error('You must select a pay period to report for.');
        CompInfo.CalcFields(Picture);
        MonthStartDate := Employee.GetFilter("Pay Period Filter");
        if MonthStartDate = '' then Error(Text000);
        if Evaluate(PayPeriodDate, MonthStartDate) then
            PayPeriodDisplay := Format(PayPeriodDate, 0, '<Month Text> <Year4>')
        else
            PayPeriodDisplay := MonthStartDate;
        Filters := Employee.GetFilters;
        CurrentDate := Format(Today, 0, 4);

        // Initialize TXT file if export is enabled
        if ExportToTXT then begin
            TempBlob.CreateOutStream(TxtFile);
            WriteHeaderToTXT();
        end;
    end;

    trigger OnPostReport()
    begin
        if ExportToTXT then begin
            WriteFooterToTXT();
            DownloadTXTFile();
        end;
    end;

    local procedure WriteHeaderToTXT()
    begin
        // No header needed - just employee records
        Counter := 0;  // Reset counter
    end;

    local procedure LeftPadText(InputText: Text; TotalLength: Integer; PadCharacter: Text[1]): Text
    begin
        if StrLen(InputText) >= TotalLength then
            exit(CopyStr(InputText, 1, TotalLength));

        exit(PadStr('', TotalLength - StrLen(InputText), PadCharacter[1]) + InputText);
    end;

    local procedure KeepDigitsOnly(InputText: Text): Text
    var
        OutputText: Text;
        i: Integer;
        CurrentChar: Char;
    begin
        OutputText := '';
        for i := 1 to StrLen(InputText) do begin
            CurrentChar := InputText[i];
            if (CurrentChar >= 48) and (CurrentChar <= 57) then
                OutputText := OutputText + Format(CurrentChar);
        end;

        exit(OutputText);
    end;

    local procedure FormatNumericField(InputText: Text; TotalLength: Integer): Text
    begin
        InputText := KeepDigitsOnly(InputText);

        if StrLen(InputText) > TotalLength then
            InputText := CopyStr(InputText, StrLen(InputText) - TotalLength + 1, TotalLength);

        exit(LeftPadText(InputText, TotalLength, '0'));
    end;

    local procedure CleanText(InputText: Text): Text
    var
        OutputText: Text;
        i: Integer;
        CurrentChar: Char;
    begin
        OutputText := '';
        for i := 1 to StrLen(InputText) do begin
            CurrentChar := InputText[i];
            // Only allow letters, numbers, and spaces (ASCII 32-126)
            if (CurrentChar >= 32) and (CurrentChar <= 126) then
                OutputText := OutputText + Format(CurrentChar);
        end;
        exit(OutputText);
    end;

    local procedure StripNameTitles(InputText: Text): Text
    begin
        InputText := DelChr(InputText, '<>', ' ');

        if StrPos(UpperCase(InputText), 'HON. ') = 1 then
            exit(CopyStr(InputText, 6))
        else
            if StrPos(UpperCase(InputText), 'HON ') = 1 then
                exit(CopyStr(InputText, 5))
            else
                if StrPos(UpperCase(InputText), 'DR. ') = 1 then
                    exit(CopyStr(InputText, 5))
                else
                    if StrPos(UpperCase(InputText), 'DR ') = 1 then
                        exit(CopyStr(InputText, 4))
                    else
                        if StrPos(UpperCase(InputText), 'MR. ') = 1 then
                            exit(CopyStr(InputText, 5))
                        else
                            if StrPos(UpperCase(InputText), 'MR ') = 1 then
                                exit(CopyStr(InputText, 4))
                            else
                                if StrPos(UpperCase(InputText), 'MRS. ') = 1 then
                                    exit(CopyStr(InputText, 6))
                                else
                                    if StrPos(UpperCase(InputText), 'MRS ') = 1 then
                                        exit(CopyStr(InputText, 5))
                                    else
                                        if StrPos(UpperCase(InputText), 'MS. ') = 1 then
                                            exit(CopyStr(InputText, 5))
                                        else
                                            if StrPos(UpperCase(InputText), 'MS ') = 1 then
                                                exit(CopyStr(InputText, 4));

        exit(InputText);
    end;

    local procedure WriteLineToTXT()
    var
        LineText: Text;
        EmployeeNo: Text;
        BranchCode: Text;
        AccountNo: Text;
        AmountText: Text;
        EmployeeName: Text;
    begin
        // Build and clean employee name
        EmployeeName := NAVEmp."First Name" + ' ' + NAVEmp."Last Name" + ' ' + NAVEmp."Middle Name";
        EmployeeName := CleanText(EmployeeName);  // Remove special/non-printable characters
        EmployeeName := StripNameTitles(EmployeeName);
        EmployeeName := DelChr(EmployeeName, '>', ' ');  // Remove trailing spaces

        // Get employee number and bank details
        EmployeeNo := FormatNumericField(NAVEmp."No.", 5);
        BranchCode := FormatNumericField(NAVEmp."Bank Branch", 3);
        AccountNo := FormatNumericField(NAVEmp."Bank Account Number", 17);

        // Format amount
        AmountText := Format(Round(Amount * 100, 1), 0, '<Integer>');
        AmountText := PadStr('', 8 - StrLen(AmountText), '0') + AmountText;

        // Build the line
        LineText :=
            '26100000' +
            EmployeeNo +
            BranchCode +
            AccountNo +
            'P' +
            AmountText +
            '0' +
            EmployeeName;

        TxtFile.WriteText(LineText);
        TxtFile.WriteText();
    end;

    local procedure WriteFooterToTXT()
    begin
        // No footer needed
    end;

    local procedure DownloadTXTFile()
    begin
        FileName := 'BankInstruction_' + Format(PayPeriodDate, 0, '<Year4><Month,2><Day,2>') + '.txt';

        TempBlob.CreateInStream(InStr);
        DownloadFromStream(InStr, 'Export', '', 'Text Files (*.txt)|*.txt', FileName);
    end;

    var
        EmpName: Text[150];
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
        PayPeriodDate: Date;
        PayPeriodDisplay: Text;
        Banks: Record Banks;
        Text000: Label 'Please select Pay Period Filter';
        GenerateEFT: Boolean;
        EFTText: text;
        ExportToTXT: Boolean;
        TxtFile: OutStream;
        TempBlob: Codeunit "Temp Blob";
        InStr: InStream;
        FileName: Text;
}
