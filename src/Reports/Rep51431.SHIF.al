report 51431 "SHIF"
{
    // version THL- Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/SHIF.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Payroll Matrix"; "Payroll Matrix")
        {
            DataItemTableView = SORTING("Employee No", Type, Code, "Payroll Period", "Reference No")WHERE(Type=CONST(Deduction));
            RequestFilterFields = "Pay Period Filter", "Code";
            RequestFilterHeading = 'SHIF';

            /* column(CurrReport_PAGENO;CurrReport.PageNo)
             {
             }*/
            column(Logo; CompInfo.Picture)
            {
            }
            column(COMPANYNAME; CompInfo.Name)
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
            column(ABS__Assignment_Matrix_X1__Amount_; Abs("Payroll Matrix".Amount))
            {
            }
            column(Emp__SHIF_No__; OurEmp."SHIF No")
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
            column(Assignment_Matrix_X1__Assignment_Matrix_X1___Employee_No_; "Payroll Matrix"."Employee No")
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
            column(SHIF_No_Caption; SHIF_No_CaptionLbl)
            {
            }
            column(MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_SHIFCaption; MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_SHIFCaptionLbl)
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
            column(Name_of_EmployeeCaption_Control1000000055; Name_of_EmployeeCaption_Control1000000055Lbl)
            {
            }
            column(SHIF_No_Caption_Control1000000053; SHIF_No_Caption_Control1000000053Lbl)
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
            column(Assignment_Matrix_X1_Payroll_Period; "Payroll Period")
            {
            }
            column(Assignment_Matrix_X1_Reference_No; "Reference No")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if Emp.Get("Payroll Matrix"."Employee No")then begin
                    FirstName:=Emp."First Name";
                    LastName:=Emp."Last Name";
                    YEAR:=Emp."Birth Date";
                    TotalAmount:=TotalAmount + Abs("Payroll Matrix".Amount);
                end;
                if OurEmp.Get("Payroll Matrix"."Employee No")then begin
                    SHIFNo:=OurEmp."SHIF No";
                    Id:=OurEmp."ID Number";
                end;
                Counter:=Counter + 1;
            end;
            trigger OnPreDataItem()
            begin
                StartDate:="Payroll Matrix".GetRangeMin("Pay Period Filter");
                EndDate:="Payroll Matrix".GetRangeMax("Pay Period Filter");
                "Payroll Matrix".SetRange("Payroll Period", StartDate, EndDate);
                DateSpecified:=EndDate;
                if PayrollSetup.Get then EmployerSHIFNo:=PayrollSetup."SHIF No";
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
        SHIFCODE:="Payroll Matrix".GetRangeMin("Payroll Matrix".Code);
        CompInfo.Get;
        CompPINNo:=CompInfo."VAT Registration No.";
        Address:=CompInfo.Address;
        Tel:=CompInfo."Phone No.";
        if not NoLogo then CompInfo.CalcFields(Picture);
    end;
    var DateSpecified: Date;
    SHIFNo: Code[20];
    Emp: Record Employee;
    Id: Code[20];
    FirstName: Text[30];
    LastName: Text[30];
    TotalAmount: Decimal;
    "Count": Integer;
    Deductions: Record "Payroll Matrix";
    EmployerSHIFNo: Code[20];
    DOB: Date;
    CompInfoSetup: Record "Loan Transactions";
    "HR Details": Record Employee;
    CompPINNo: Code[20];
    YEAR: Date;
    Address: Text[90];
    Tel: Text[30];
    Counter: Integer;
    LastFieldNo: Integer;
    BeginDate: Date;
    SHIFCODE: Code[10];
    AmountCaptionLbl: Label 'Amount';
    ID_PassportCaptionLbl: Label 'ID/Passport';
    Date_of_BirthCaptionLbl: Label 'Date of Birth';
    PageCaptionLbl: Label 'Page';
    SHIF_No_CaptionLbl: Label 'SHIF No.';
    MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_SHIFCaptionLbl: Label 'MONTHLY PAYROLL (BY-PRODUCT) RETURNS TO SHIF';
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
    SHIF_No_Caption_Control1000000053Lbl: Label 'SHIF No.';
    Date_of_BirthCaption_Control1000000051Lbl: Label 'Date of Birth';
    ID_PassportCaption_Control1000000049Lbl: Label 'ID/Passport';
    AmountCaption_Control1000000005Lbl: Label 'Amount';
    Total_AmountCaptionLbl: Label 'Total Amount';
    StartDate: Date;
    EndDate: Date;
    OurEmp: Record "Employee Master";
    CompInfo: Record "Company Information";
    NoLogo: Boolean;
    PayrollSetup: Record "QuantumJumps Payroll Setup";
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
