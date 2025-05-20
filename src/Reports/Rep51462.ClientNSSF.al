report 51462 "Client NSSF"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Client NSSF.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Client Payroll Matrix"; "Client Payroll Matrix")
        {
            DataItemTableView = WHERE(Type = CONST(payment), "Tax Relief" = const(false), "Normal Earnings" = const(true));
            RequestFilterFields = Company, "Type", "Pay Period Filter", "Payroll Group";
            RequestFilterHeading = 'NSSF';

            column(CompName; CompInfo.Name)
            {
            }
            column(Logo; CompInfo.Picture)
            {
            }
            column(COMPANYNAME; CompInfo.Name)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(EmployerNSSFNo; EmployerNSSFNo)
            {
            }
            column(Payroll_Period; "Payroll Period")
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(Address; Address)
            {
            }
            column(Tel; Tel)
            {
            }
            column(CompPINNo; CompPINNo)
            {
            }
            column(FORMAT_TODAY_0_4_; Format(Today, 0, 4))
            {
            }
            /* column(CurrReport_PAGENO_Control42;CurrReport.PageNo)
             {
             }*/
            column(USERID; UserId)
            {
            }
            column(Id; Id)
            {
            }
            column(COMPANYNAME_Control1000000006; CompanyName)
            {
            }
            column(EmployerNSSFNo_Control1000000007; EmployerNSSFNo)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4_____Control1000000009; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(ABS__Assignment_Matrix_X1__Amount_; Abs("Client Payroll Matrix".Amount))
            {
            }
            column(Emp__NSSF_No__; OurEmp."NSSF No")
            {
            }
            column(FirstName_____Emp__Middle_Name______LastName; FirstName + ' ' + Emp."Middle Name" + ' ' + LastName)
            {
            }
            column(LastName; LastName)
            {
            }
            column(OtherNames; FirstName + ' ' + Emp."Middle Name")
            {
            }
            column(Assignment_Matrix_X1__Assignment_Matrix_X1___Employee_No_; OurEmp."Payroll No.")
            {
            }
            column(YEAR; YEAR)
            {
            }
            column(Emp__ID_Number_; OurEmp."ID Number")
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(Counter; Counter)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(ID_PassportCaption; ID_PassportCaptionLbl)
            {
            }
            column(Date_of_BirthCaption; Date_of_BirthCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(NSSF_No_Caption; NSSF_No_CaptionLbl)
            {
            }
            column(MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_NSSFCaption; MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_NSSFCaptionLbl)
            {
            }
            column(Name_of_EmployeeCaption; Name_of_EmployeeCaptionLbl)
            {
            }
            column(EMPLOYER_NOCaption; EMPLOYER_NOCaptionLbl)
            {
            }
            column(Payroll_No_Caption; Payroll_No_CaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(EMPLOYERCaption; EMPLOYERCaptionLbl)
            {
            }
            column(ADDRESSCaption; ADDRESSCaptionLbl)
            {
            }
            column(NSSFNo; NSSFNo)
            {
            }
            column(EMPLOYER_PIN_NOCaption; EMPLOYER_PIN_NOCaptionLbl)
            {
            }
            column(TEL_NOCaption; TEL_NOCaptionLbl)
            {
            }
            column(PageCaption_Control44; PageCaption_Control44Lbl)
            {
            }
            column(UserCaption; UserCaptionLbl)
            {
            }
            column(NATIONAL_HOSPITAL_INSURANCE_FUND_REPORTCaption; NATIONAL_HOSPITAL_INSURANCE_FUND_REPORTCaptionLbl)
            {
            }
            column(EMPLOYER_NOCaption_Control1000000008; EMPLOYER_NOCaption_Control1000000008Lbl)
            {
            }
            column(PERIODCaption_Control1000000010; PERIODCaption_Control1000000010Lbl)
            {
            }
            column(Payroll_No_Caption_Control1000000056; Payroll_No_Caption_Control1000000056Lbl)
            {
            }
            column(NSSFTemplate; NSSFTemplate)
            {
            }
            column(Name_of_EmployeeCaption_Control1000000055; Name_of_EmployeeCaption_Control1000000055Lbl)
            {
            }
            column(NSSF_No_Caption_Control1000000053; NSSF_No_Caption_Control1000000053Lbl)
            {
            }
            column(Date_of_BirthCaption_Control1000000051; Date_of_BirthCaption_Control1000000051Lbl)
            {
            }
            column(ID_PassportCaption_Control1000000049; ID_PassportCaption_Control1000000049Lbl)
            {
            }
            column(AmountCaption_Control1000000005; AmountCaption_Control1000000005Lbl)
            {
            }
            column(Total_AmountCaption; Total_AmountCaptionLbl)
            {
            }
            column(Assignment_Matrix_X1_Type; Type)
            {
            }
            column(Assignment_Matrix_X1_Code; Code)
            {
            }
            column(Employee_No; "Employee No")
            {
            }
            column(Assignment_Matrix_X1_Payroll_Period; "Payroll Period")
            {
            }
            column(Assignment_Matrix_X1_Reference_No; "Reference No")
            {
            }
            column(Amount; Amount)
            {
            }
            column(Pin; Pin)
            {
            }
            column(Employer_Amount; "Employer Amount") { }
            trigger OnAfterGetRecord()
            begin
                IF Emp.GET("Employee No") THEN BEGIN
                    Emp.SETRANGE(Emp."Pay Period Filter", "Client Payroll Matrix"."Payroll Period");
                    begin
                        if (Earnings."Earning Type" = Earnings."Earning Type"::"Tax Relief") or (Earnings."Earning Type" = Earnings."Earning Type"::"Insurance Relief") or (Earnings."Earning Type" = Earnings."Earning Type"::"Owner Occupier") then CurrReport.Skip();
                    end;
                    //if Emp.Get("Client Payroll Matrix"."Employee No") then begin
                    FirstName := Emp."First Name";
                    LastName := Emp."Last Name";
                    YEAR := Emp."Date of Birth";
                    Pin := Emp."PIN Number";
                    TotalAmount := TotalAmount + Abs("Client Payroll Matrix".Amount);
                end;
                begin
                    Emp.SETRANGE(Emp."Pay Period Filter", "Client Payroll Matrix"."Payroll Period");
                    Amount := "Employer Amount" + Amount;
                end;
                if OurEmp.Get("Client Payroll Matrix"."Employee No") then begin
                    NSSFNo := OurEmp."NSSF No";
                    Id := OurEmp."ID Number";
                end;
                Counter := Counter + 1;
                if NSSFTemplate then begin
                    LineNo := LineNo + 1;
                    CSVBuffer.InsertEntry(LineNo, 1, "Employee No");
                    CSVBuffer.InsertEntry(LineNo, 2, emp."Last Name");
                    CSVBuffer.InsertEntry(LineNo, 3, Emp."First Name" + ' ' + Emp."Middle Name");
                    CSVBuffer.InsertEntry(LineNo, 4, Emp."ID Number");
                    CSVBuffer.InsertEntry(LineNo, 5, '');
                    CSVBuffer.InsertEntry(LineNo, 6, format(Amount, 0, 2));
                    if "Client Payroll Matrix".Amount = 0 then CurrReport.Skip();
                end;
            end;

            trigger OnPreDataItem()
            begin
                StartDate := "Client Payroll Matrix".GetRangeMin("Pay Period Filter");
                EndDate := "Client Payroll Matrix".GetRangeMax("Pay Period Filter");
                "Client Payroll Matrix".SetRange("Payroll Period", StartDate, EndDate);
                DateSpecified := EndDate;
                if PayrollSetup.Get("Client Payroll Matrix".GetFilter(Company)) then EmployerNSSFNo := PayrollSetup."NSSF No.";
                if NSSFTemplate then begin
                    CSVBuffer.InsertEntry(LineNo, 1, 'Payroll No.');
                    CSVBuffer.InsertEntry(LineNo, 2, 'Last Name');
                    CSVBuffer.InsertEntry(LineNo, 3, 'Other Names');
                    CSVBuffer.InsertEntry(LineNo, 4, 'ID No.');
                    CSVBuffer.InsertEntry(LineNo, 5, 'NSSF No.');
                    CSVBuffer.InsertEntry(LineNo, 6, 'Amount');
                end;
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
                field(NSSFTemplate; NSSFTemplate)
                {
                    ApplicationArea = All;
                    Caption = 'Export to NSSF Template';
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
        //NSSFCODE := "Client Payroll Matrix".GetRangeMin("Client Payroll Matrix".Code);
        // Set the default NSSF code filter
        //"Client Payroll Matrix".SetFilter("Client Payroll Matrix".Code, 'NSSFev ');
        //if "Client Payroll Matrix".GetFilter(Code) = '' then
        // Error('Please select an earning code');
        if "Client Payroll Matrix".GetFilter(Company) = '' then Error('Please select a company to report for.');
        if "Client Payroll Matrix".GetFilter("Pay Period Filter") = '' then Error('Please select a payroll period to report for.');
        CompInfo.Get("Client Payroll Matrix".GetFilter(Company));
        if not NoLogo then begin
            CompInfo.CalcFields(Picture);
        end;
        CompPINNo := CompInfo."VAT Registration No.";
        Address := CompInfo.Address;
        Tel := CompInfo."Phone No.";
        if NSSFTemplate then LineNo := 1;
    end;

    trigger OnPostReport()
    begin
        if NSSFTemplate then begin
            FileName := 'B_Employees_Dtls.csv';
            CSVBuffer.SaveDataToBlob(TempBlob, ',');
            TempBlob.CreateInStream(InStr);
            DownloadFromStream(InStr, '', '', '', FileName);
        end;
    end;

    var
        DateSpecified: Date;
        NSSFNo: Code[20];
        Emp: Record "Client Employee Master";
        Id: Code[20];
        FirstName: Text[30];
        LastName: Text[30];
        TotalAmount: Decimal;
        "Count": Integer;
        Deductions: Record "Client Payroll Matrix";
        EmployerNSSFNo: Code[20];
        DOB: Date;
        CompInfoSetup: Record "Client Loan Transactions";
        "HR Details": Record "Client Employee Master";
        CompPINNo: Code[20];
        YEAR: Date;
        Earnings: Record "Client Earnings";
        Address: Text[90];
        Tel: Text[30];
        Counter: Integer;
        LastFieldNo: Integer;
        Pin: Code[30];
        BeginDate: Date;
        NSSFCODE: Code[10];
        AmountCaptionLbl: Label 'Amount';
        ID_PassportCaptionLbl: Label 'ID/Passport';
        Date_of_BirthCaptionLbl: Label 'Date of Birth';
        PageCaptionLbl: Label 'Page';
        NSSF_No_CaptionLbl: Label 'NSSF No.';
        MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_NSSFCaptionLbl: Label 'MONTHLY PAYROLL (BY-PRODUCT) RETURNS TO NSSF';
        Name_of_EmployeeCaptionLbl: Label 'Name of Employee';
        EMPLOYER_NOCaptionLbl: Label 'EMPLOYER NO';
        Payroll_No_CaptionLbl: Label 'Payroll No.';
        PERIODCaptionLbl: Label 'PERIOD';
        EMPLOYERCaptionLbl: Label 'EMPLOYER';
        ADDRESSCaptionLbl: Label 'ADDRESS';
        EMPLOYER_PIN_NOCaptionLbl: Label 'EMPLOYER PIN NO';
        TEL_NOCaptionLbl: Label 'TEL NO';
        PageCaption_Control44Lbl: Label 'Page';
        UserCaptionLbl: Label 'User';
        NATIONAL_HOSPITAL_INSURANCE_FUND_REPORTCaptionLbl: Label 'NATIONAL HOSPITAL INSURANCE FUND REPORT';
        EMPLOYER_NOCaption_Control1000000008Lbl: Label 'EMPLOYER NO';
        PERIODCaption_Control1000000010Lbl: Label 'PERIOD';
        Payroll_No_Caption_Control1000000056Lbl: Label 'Payroll No.';
        Name_of_EmployeeCaption_Control1000000055Lbl: Label 'Name of Employee';
        NSSF_No_Caption_Control1000000053Lbl: Label 'NSSF No.';
        Date_of_BirthCaption_Control1000000051Lbl: Label 'Date of Birth';
        ID_PassportCaption_Control1000000049Lbl: Label 'ID/Passport';
        AmountCaption_Control1000000005Lbl: Label 'Amount';
        Total_AmountCaptionLbl: Label 'Total Amount';
        StartDate: Date;
        EndDate: Date;
        OurEmp: Record "Client Employee Master";
        CompInfo: Record "Client Company Information";
        NoLogo: Boolean;
        NSSFTemplate: Boolean;
        LineNo: Integer;
        PayrollSetup: Record "Client Payroll Setup";
        TempBlob: Codeunit "Temp Blob";
        FileMgt: Codeunit "File Management";
        InStr: InStream;
        Deduction: Record "Client Deductions";
        FileName: Text;
        CSVBuffer: Record "CSV Buffer" temporary;

    procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal
    var
        HRsetup: Record "QuantumJumps HR Setup";
    begin
        HRsetup.Get;
        if HRsetup."Payroll Rounding Precision" = 0 then Error('You must specify the rounding precision under HR setup');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;

    procedure ExportReportToCSV(var DocumentManagement: Codeunit "File Management") ExportReportToCSV: Boolean
    var
        DocMGT: Codeunit "File Management";
        FileExtension: Text[10];
        Filename: Text[50];
    begin
        if NSSFTemplate then begin
            Report.RUN(51461);
            FileExtension := '.csv';
            Filename := 'Kenya NSSF Return.csv';
        end;
    end;
}
