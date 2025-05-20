report 51432 "NSSF"
{
    // version THL- Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/NSSF.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Payroll Matrix"; "Client Payroll Matrix")
        {
            DataItemTableView = SORTING("Employee No", Type, Code, "Payroll Period", "Reference No") ORDER(Ascending) WHERE(Type = CONST(Deduction));
            RequestFilterFields = "Type", "Pay Period Filter", "Payroll Group", Code;
            RequestFilterHeading = 'NSSF';

            column(CompName; CompRec.Name)
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
            column(COMPANYNAME; CompanyName)
            {
            }
            column(CoNssf; CoNssf)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UpperCase(Format(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(Assignment_Matrix_X1__Employee_No_; "Employee No")
            {
            }
            column(Name; Name)
            {
            }
            column(NavEmpId; Emp."ID Number")
            {
            }
            column(NavEmpPin; Emp."PIN Number")
            {
            }
            column(ABS_Amount_; Abs(Amount))
            {
            }
            column(ABS__Employer_Amount___; Abs("Employer Amount"))
            {
            }
            column(Emp__NSSF_No__; Emp."NSSF No")
            {
            }
            column(ABS__Employer_Amount____ABS_Amount_; Abs("Employer Amount") + Abs(Amount))
            {
            }
            column(EmployeeTotal; EmployeeTotal)
            {
            }
            column(EmployerTotal; EmployerTotal)
            {
            }
            column(SumTotal; SumTotal)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(COMPANY_NSSF_No_Caption; COMPANY_NSSF_No_CaptionLbl)
            {
            }
            column(UserCaption; UserCaptionLbl)
            {
            }
            column(CONTRIBUTIONS_RETURN_FORMCaption; CONTRIBUTIONS_RETURN_FORMCaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(NATIONAL_SOCIAL_SECURITY_FUNDCaption; NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl)
            {
            }
            column(P_O__BOX_30599Caption; P_O__BOX_30599CaptionLbl)
            {
            }
            column(NAIROBICaption; NAIROBICaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Total_AmountCaption; Total_AmountCaptionLbl)
            {
            }
            column(Employer_AmountCaption; Employer_AmountCaptionLbl)
            {
            }
            column(Employee_AmountCaption; Employee_AmountCaptionLbl)
            {
            }
            column(NSSF_No_Caption; NSSF_No_CaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(Certified_correct_by_Company_Authorised_Officer_Caption; Certified_correct_by_Company_Authorised_Officer_CaptionLbl)
            {
            }
            column(NAME_________________________________________________________________________Caption; NAME_________________________________________________________________________CaptionLbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption; SIGNATURE___________________________________________________________CaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption; DESIGNATION____________________________________________________________CaptionLbl)
            {
            }
            column(DATE_____________________________________________________________________Caption; DATE_____________________________________________________________________CaptionLbl)
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
            column(Employer_Amount; "Employer Amount") { }
            column(Amount; Amount) { }
            trigger OnAfterGetRecord()
            begin
                if Emp.Get("Employee No") then begin
                    Emp.SetRange(Emp."Pay Period Filter", "Payroll Matrix"."Payroll Period");
                    /*Emp.CALCFIELDS(Emp."Cumm. Basic Pay");
                        IF BeginDate=DateSpecified THEN
                         BasicPay:=Emp."Basic Pay"
                        ELSE
                         BasicPay:=Emp."Cumm. Basic Pay";*/
                end;
                if NAVEmp.Get("Employee No") then begin
                    Name := NAVEmp."First Name" + ' ' + NAVEmp."Last Name";
                    SSFNo := NAVEmp."Social Security No.";
                end;
                if "Payroll Matrix".Type = "Payroll Matrix".Type::Payment then begin
                    if Payment.Get("Payroll Matrix".Code) then GroupHeader := Payment.Description;
                end;
                if "Payroll Matrix".Type = "Payroll Matrix".Type::Deduction then begin
                    if Deduction.Get("Payroll Matrix".Code) then GroupHeader := Deduction.Description;
                end;
                TotalBasic := TotalBasic + BasicPay;
                EmployerTotal := EmployerTotal + Abs("Payroll Matrix"."Employer Amount");
                EmployeeTotal := EmployeeTotal + Abs("Payroll Matrix".Amount);
                SumTotal := SumTotal + Abs("Payroll Matrix"."Employer Amount") + Abs("Payroll Matrix".Amount);
            end;

            trigger OnPreDataItem()
            begin
                StartDate := "Payroll Matrix".GetRangeMin("Pay Period Filter");
                EndDate := "Payroll Matrix".GetRangeMax("Pay Period Filter");
                "Payroll Matrix".SetRange("Payroll Period", StartDate, EndDate);
                LastFieldNo := FieldNo(Code);
                //"Assignment Matrix-X".SETRANGE("Assignment Matrix-X".Retirement,TRUE);
                "Payroll Matrix".SetRange("Payroll Matrix".Type, "Payroll Matrix".Type::Deduction);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(DateSpecified; DateSpecified)
                {
                    ApplicationArea = All;
                    Caption = 'pay period';
                    Visible = false;
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
        CompRec.Get;
        // PayrollSetup.Get;
        CoNssf := PayrollSetup."NSSF No.";
        GetPayPeriod;
        DateSpecified := "Payroll Matrix".GetRangeMin("Payroll Matrix"."Pay Period Filter");
        if PayPeriod.Get(DateSpecified) then PayPeriodText := PayPeriod.Name;
        // nssfcode := "Payroll Matrix".GetRangeMin("Payroll Matrix".Code);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label 'Total for ';
        Emp: Record "Employee Master";
        Name: Text[250];
        Payment: Record Earnings;
        Deduction: Record Deductions;
        TypeFilter: Text[30];
        GroupHeader: Text[30];
        BasicPay: Decimal;
        SSFNo: Code[30];
        TotalBasic: Decimal;
        PayPeriod: Record "Payroll Period";
        PayPeriodText: Text[30];
        Title: Text[30];
        DateSpecified: Date;
        BeginDate: Date;
        CompRec: Record "Company Information";
        CoNssf: Text[30];
        SumTotal: Decimal;
        EmployeeTotal: Decimal;
        EmployerTotal: Decimal;
        GetGroup: Codeunit "Payroll Calculator";
        GroupCode: Code[20];
        CUser: Code[50];
        nssfcode: Code[10];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        COMPANY_NSSF_No_CaptionLbl: Label 'COMPANY NSSF No.';
        UserCaptionLbl: Label 'User';
        CONTRIBUTIONS_RETURN_FORMCaptionLbl: Label 'CONTRIBUTIONS RETURN FORM';
        PERIODCaptionLbl: Label 'PERIOD';
        NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl: Label 'NATIONAL SOCIAL SECURITY FUND';
        P_O__BOX_30599CaptionLbl: Label 'P.O. BOX 30599';
        NAIROBICaptionLbl: Label 'NAIROBI';
        No_CaptionLbl: Label 'No.';
        NameCaptionLbl: Label 'Name';
        Total_AmountCaptionLbl: Label 'Total Amount';
        Employer_AmountCaptionLbl: Label 'Employer Amount';
        Employee_AmountCaptionLbl: Label 'Employee Amount';
        NSSF_No_CaptionLbl: Label 'NSSF No.';
        TotalCaptionLbl: Label 'Total';
        Certified_correct_by_Company_Authorised_Officer_CaptionLbl: Label 'Certified correct by Company Authorised Officer ';
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';
        StartDate: Date;
        EndDate: Date;
        PayrollSetup: Record "QuantumJumps Payroll Setup";
        NAVEmp: Record Employee;

    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod.Closed, false);
        if PayPeriod.Find('-') then BeginDate := PayPeriod."Starting Date";
    end;

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
}
