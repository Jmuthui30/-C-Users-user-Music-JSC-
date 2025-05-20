report 51471 "Client Deductions"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Client Deductions.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Client Payroll Matrix"; "Client Payroll Matrix")
        {
            DataItemTableView = SORTING("Employee No", Type, Code, "Payroll Period", "Reference No")WHERE(Type=CONST(Deduction));
            RequestFilterFields = Company, "Payroll Period", "Code", "Payroll Group";
            RequestFilterHeading = 'Deduction';

            column(Logo; CompInfo.Picture)
            {
            }
            column(CoName; CompInfo.Name)
            {
            }
            /* column(CurrReport_PAGENO;CurrReport.PageNo)
             {
             }*/
            column(COMPANYNAME; CompanyName)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(EmployerSHIFNo; EmployerSHIFNo)
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
            /*column(CurrReport_PAGENO_Control42;CurrReport.PageNo)
            {
            }*/
            column(USERID; UserId)
            {
            }
            column(COMPANYNAME_Control1000000006; CompanyName)
            {
            }
            column(EmployerSHIFNo_Control1000000007; EmployerSHIFNo)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4_____Control1000000009; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(Assignment_Matrix_X1__Assignment_Matrix_X1__Amount; Abs("Client Payroll Matrix".Amount))
            {
            }
            column(EmployerAmount; Abs("Client Payroll Matrix"."Employer Amount"))
            {
            }
            column(LastName; LastName)
            {
            }
            column(Assignment_Matrix_X1__Assignment_Matrix_X1___Employee_No_; "Client Payroll Matrix"."Employee No")
            {
            }
            column(FirstName; FirstName)
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
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(MONTHLY_EARNINGS_REPORTCaption; MONTHLY_EARNINGS_REPORTCaptionLbl)
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
            column(MONTHLY_EARNINGS_REPORTCaption_Control49; MONTHLY_EARNINGS_REPORTCaption_Control49Lbl)
            {
            }
            column(EMPLOYER_NOCaption_Control1000000008; EMPLOYER_NOCaption_Control1000000008Lbl)
            {
            }
            column(PERIODCaption_Control1000000010; PERIODCaption_Control1000000010Lbl)
            {
            }
            column(AmountCaption_Control1000000005; AmountCaption_Control1000000005Lbl)
            {
            }
            column(Name_of_EmployeeCaption_Control1000000055; Name_of_EmployeeCaption_Control1000000055Lbl)
            {
            }
            column(Payroll_No_Caption_Control1000000056; Payroll_No_Caption_Control1000000056Lbl)
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
            column(Assignment_Matrix_X1_Payroll_Period; "Payroll Period")
            {
            }
            column(Assignment_Matrix_X1_Reference_No; "Reference No")
            {
            }
            column(Assignment_MatrixX1_Description; "Client Payroll Matrix".Description)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Deductions.SetRange(Deductions."Employee No", "Client Payroll Matrix"."Employee No");
                Deductions.SetRange(Deductions."Normal Earnings", true);
                if Deductions.Find('-')then begin
                    if Emp.Get("Client Payroll Matrix"."Employee No")then begin
                        FirstName:=Emp."First Name";
                        LastName:=Emp."Last Name";
                        TotalAmount:=TotalAmount + "Client Payroll Matrix".Amount;
                    end;
                    if OurEmp.Get("Client Payroll Matrix"."Employee No")then SHIFNo:=OurEmp."SHIF No";
                end;
            end;
            trigger OnPreDataItem()
            begin
                DateSpecified:="Client Payroll Matrix".GetRangeMin("Client Payroll Matrix"."Payroll Period");
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
        if "Client Payroll Matrix".GetFilter(Code) = '' then Error('Please select an earning code');
        if "Client Payroll Matrix".GetFilter(Company) = '' then Error('Please select a company to report for.');
        if "Client Payroll Matrix".GetFilter("Payroll Period") = '' then Error('Please select a payroll period to report for.');
        CompInfo.Get("Client Payroll Matrix".GetFilter(Company));
        if not NoLogo then begin
            CompInfo.CalcFields(Picture);
        end;
    end;
    var DateSpecified: Date;
    SHIFNo: Code[20];
    Emp: Record "Client Employee Master";
    Id: Code[20];
    FirstName: Text[30];
    LastName: Text[30];
    TotalAmount: Decimal;
    "Count": Integer;
    Deductions: Record "Client Payroll Matrix";
    EmployerSHIFNo: Code[20];
    DOB: Date;
    CompInfoSetup: Record "Client Loan Transactions";
    "HR Details": Record "Client Employee Master";
    CompPINNo: Code[20];
    YEAR: Integer;
    Address: Text[90];
    Tel: Text[30];
    Counter: Integer;
    AmountCaptionLbl: Label 'Amount';
    PageCaptionLbl: Label 'Page';
    MONTHLY_EARNINGS_REPORTCaptionLbl: Label 'MONTHLY DEDUCTIONS REPORT';
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
    MONTHLY_EARNINGS_REPORTCaption_Control49Lbl: Label 'MONTHLY DEDUCTIONS REPORT';
    EMPLOYER_NOCaption_Control1000000008Lbl: Label 'EMPLOYER NO';
    PERIODCaption_Control1000000010Lbl: Label 'PERIOD';
    AmountCaption_Control1000000005Lbl: Label 'Amount';
    Name_of_EmployeeCaption_Control1000000055Lbl: Label 'Name of Employee';
    Payroll_No_Caption_Control1000000056Lbl: Label 'Payroll No.';
    Total_AmountCaptionLbl: Label 'Total Amount';
    OurEmp: Record "Client Employee Master";
    CompInfo: Record "Client Company Information";
    NoLogo: Boolean;
    procedure PayrollRounding(var Amount: Decimal)PayrollRounding: Decimal var
        HRsetup: Record "QuantumJumps HR Setup";
    begin
        HRsetup.Get;
        if HRsetup."Payroll Rounding Precision" = 0 then Error('You must specify the rounding precision under HR setup');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;
}
