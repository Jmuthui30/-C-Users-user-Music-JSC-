report 51477 "Payroll Recon Combined"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Payroll Recon Combined.rdlc';

    dataset
    {
        dataitem(Employee; "Client Employee Master")
        {
            DataItemTableView = WHERE(Status=CONST(Active));
            RequestFilterFields = "Company Code", "Pay Period Filter", "No.";

            column(CompName; CompInfo.Name)
            {
            }
            column(Logo; CompInfo.Picture)
            {
            }
            column(No; Employee."Payroll No.")
            {
            }
            column(Name; Employee."Last Name" + ' ' + Employee."First Name" + ' ' + Employee."Middle Name")
            {
            }
            column(Current; Amount)
            {
            }
            column(Previous; LastMonthAmount)
            {
            }
            column(Variance; Difference)
            {
            }
            column(Remark; Remark)
            {
            }
            column(Filters; Filters)
            {
            }
            trigger OnAfterGetRecord()
            begin
                LastMonthAmount:=0;
                Amount:=0;
                Difference:=0;
                i:=0;
                j:=0;
                Remark:='';
                Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions");
                Amount:=Employee."Total Allowances" + Employee."Total Deductions";
                if EmpCopy.Get(Employee."No.")then begin
                    EmpCopy.SetFilter(EmpCopy."Pay Period Filter", '%1', Lastmonth);
                    EmpCopy.CalcFields(EmpCopy."Total Allowances", EmpCopy."Total Deductions");
                    LastMonthAmount:=EmpCopy."Total Allowances" + EmpCopy."Total Deductions";
                end;
                Difference:=Amount - LastMonthAmount;
                if Difference <> 0 then begin
                    //Earnings
                    AssignMatrixCurrent.Reset;
                    AssignMatrixCurrent.SetCurrentKey("Employee No", Type, Code, "Payroll Period", "Reference No");
                    AssignMatrixCurrent.SetRange(AssignMatrixCurrent."Employee No", Employee."No.");
                    AssignMatrixCurrent.SetRange(AssignMatrixCurrent.Type, AssignMatrixCurrent.Type::Payment);
                    AssignMatrixCurrent.SetRange(AssignMatrixCurrent."Payroll Period", Thismonth);
                    if AssignMatrixCurrent.FindFirst then begin
                        repeat AssignMatrixPrevious.Reset;
                            AssignMatrixPrevious.SetCurrentKey("Employee No", Type, Code, "Payroll Period", "Reference No");
                            AssignMatrixPrevious.SetRange(AssignMatrixPrevious."Employee No", Employee."No.");
                            AssignMatrixPrevious.SetRange(AssignMatrixPrevious.Type, AssignMatrixPrevious.Type::Payment);
                            AssignMatrixPrevious.SetRange(AssignMatrixPrevious.Code, AssignMatrixCurrent.Code);
                            AssignMatrixPrevious.SetRange(AssignMatrixPrevious."Payroll Period", Lastmonth);
                            if AssignMatrixPrevious.FindFirst then if AssignMatrixPrevious.Amount <> AssignMatrixCurrent.Amount then begin
                                    if Earnings.Get(AssignMatrixPrevious.Code)then EarningName:=Earnings.Description
                                    else if Earnings.Get(AssignMatrixCurrent.Code)then EarningName:=Earnings.Description;
                                //By Grace to match JSC Shared Template this is a mannually input field
                                // if EarningName <> '' then
                                //Remark := Remark + ',' + EarningName;
                                end;
                            i:=i + 1;
                        until AssignMatrixCurrent.Next = 0;
                    end;
                    //Deductions
                    AssignMatrixCurrentCopy.Reset;
                    AssignMatrixCurrentCopy.SetCurrentKey("Employee No", Type, Code, "Payroll Period", "Reference No");
                    AssignMatrixCurrentCopy.SetRange(AssignMatrixCurrentCopy."Employee No", Employee."No.");
                    AssignMatrixCurrentCopy.SetRange(AssignMatrixCurrentCopy.Type, AssignMatrixCurrentCopy.Type::Deduction);
                    AssignMatrixCurrentCopy.SetRange(AssignMatrixCurrentCopy."Payroll Period", Thismonth);
                    if AssignMatrixCurrentCopy.FindFirst then begin
                        repeat AssignMatrixPreviousCopy.Reset;
                            AssignMatrixPreviousCopy.SetCurrentKey("Employee No", Type, Code, "Payroll Period", "Reference No");
                            AssignMatrixPreviousCopy.SetRange(AssignMatrixPreviousCopy."Employee No", Employee."No.");
                            AssignMatrixPreviousCopy.SetRange(AssignMatrixPreviousCopy.Type, AssignMatrixPreviousCopy.Type::Deduction);
                            AssignMatrixPreviousCopy.SetRange(AssignMatrixPreviousCopy.Code, AssignMatrixCurrent.Code);
                            AssignMatrixPreviousCopy.SetRange(AssignMatrixPreviousCopy."Payroll Period", Lastmonth);
                            if AssignMatrixPreviousCopy.FindFirst then if AssignMatrixPreviousCopy.Amount <> AssignMatrixCurrentCopy.Amount then begin
                                    if Deductions.Get(AssignMatrixPreviousCopy.Code)then DeductionName:=Deductions.Description
                                    else if Deductions.Get(AssignMatrixCurrentCopy.Code)then DeductionName:=Deductions.Description;
                                    if DeductionName <> '' then Remark:='';
                                //Remark := Remark+','+DeductionName;
                                end;
                            j:=j + 1;
                        until AssignMatrixCurrentCopy.Next = 0;
                    end;
                end;
            end;
            trigger OnPreDataItem()
            begin
            //Employee.SETFILTER("Pay Period Filter",'%1',MonthStartDate);
            end;
        }
    }
    requestpage
    {
        layout
        {
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
        CompInfo.Get(Employee.GetFilter("Company Code"));
        CompInfo.CalcFields(Picture);
        MonthStartDate:=Employee.GetRangeMin(Employee."Pay Period Filter");
        Thismonth:=MonthStartDate;
        Lastmonth:=CalcDate('-1M', Thismonth);
        //Employee.SETFILTER("Pay Period Filter",'%1',MonthStartDate);
        Filters:=Employee.GetFilters;
    end;
    var LastFieldNo: Integer;
    FooterPrinted: Boolean;
    AssignMatrixCurrent: Record "Client Payroll Matrix";
    AssignMatrixPrevious: Record "Client Payroll Matrix";
    Amount: Decimal;
    LastMonthAmount: Decimal;
    Difference: Decimal;
    Thismonth: Date;
    Lastmonth: Date;
    EmpName: Text[150];
    EmployeeCaptionLbl: Label 'Employee';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    Current_PeriodCaptionLbl: Label 'Current Period';
    Previous_PeriodCaptionLbl: Label 'Previous Period';
    VarianceCaptionLbl: Label 'Variance';
    NameCaptionLbl: Label 'Name';
    Emp__NoCaptionLbl: Label 'Emp. No';
    EmpCopy: Record "Client Employee Master";
    Remark: Text;
    Earnings: Record "Client Earnings";
    Deductions: Record "Client Deductions";
    i: Integer;
    EarningName: Text;
    DeductionName: Text;
    j: Integer;
    AssignMatrixCurrentCopy: Record "Client Payroll Matrix";
    AssignMatrixPreviousCopy: Record "Client Payroll Matrix";
    Filters: Text;
    MonthStartDate: Date;
    CompInfo: Record "Client Company Information";
}
