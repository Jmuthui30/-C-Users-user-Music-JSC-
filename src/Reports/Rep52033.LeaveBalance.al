report 52033 "Leave Balance"
{
    ApplicationArea = All;
    Caption = 'Leave Balances';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/LeaveBalance.rdl';

    dataset
    {
        dataitem("Leave Type"; "Leave Type")
        {
            RequestFilterFields = Code;
            column(LeaveTypeCode; Code)
            {
            }
            dataitem(Employee; Employee)
            {
                RequestFilterFields = "Leave Period Filter", "No.";
                column(No_Employee; Employee."No.")
                {
                }
                column(FirstName_Employee; Employee.FullName())
                {
                }
                column(MiddleName_Employee; Employee."Middle Name")
                {
                }
                column(LastName_Employee; Employee."Last Name")
                {
                }

                column(Entitlement; Employee."Leave Entitlement")
                {
                }
                column(Balance; Employee."Leave Balance")
                {
                }
                column(Adjustment; Employee."Leave Adjustment")
                {
                }
                column(BroughtForward; Employee."Leave Balance Brought Forward")
                {
                }
                column(Recall; Employee."Leave Recall Days")
                {
                }
                column(Taken; Employee."Leave Days Taken")
                {
                }

                column(Company_Name; CompanyInfo.Name)
                {
                }
                column(Comp_Logo; CompanyInfo.Picture)
                {
                }
                column(Email; CompanyInfo."E-Mail")
                {
                }
                column(Website; CompanyInfo."Home Page")
                {
                }
                column(Tel_No; CompanyInfo."Phone No.")
                {
                }
                column(Address; CompanyInfo.Address)
                {
                }
                column(City; CompanyInfo.City)
                {
                }
                column(Country; CompanyInfo."Country/Region Code")
                {
                }
                column(Post_Code; CompanyInfo."Post Code")
                {
                }
                column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(LeaveEarnedToDate; LeaveEarnedToDate)
                {
                }
                column(LeaveLiability; LeaveLiability)
                {
                }
                column(LeaveBalToDate; LeaveBalToDate)
                {
                }
                column(Forfeited; Forfeited)
                {
                }
                column(LeaveTypeFilter; LeaveTypeFilter)
                {
                }
                column(ReportFilters; ReportFilters)
                {
                }

                trigger OnPreDataItem()
                begin
                end;


                trigger OnAfterGetRecord()
                begin
                    Adjustment := 0;
                    LeaveLiability := 0;
                    Forfeited := 0;
                    LeaveEarnedToDate := 0;
                    LeaveBalToDate := 0;

                    LeaveLiability := 0;


                    if Forfeited < 0 then
                        Forfeited := 0;
                end;
            }
        }
    }

    trigger OnPreReport()
    begin
        ReportFilters := Employee.GetFilters();

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);

        AccPeriod.Reset();
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+') then begin
            MaturityDateFilter := CalcDate('1Y', AccPeriod."Starting Date") - 1;
            FiscalStartDate := AccPeriod."Starting Date";
        end;

    end;

    var
        CompanyInfo: Record "Company Information";
        AccPeriod: Record "Payroll Period";
        FiscalStartDate: Date;
        MaturityDateFilter: Date;
        Adjustment: Decimal;
        Forfeited: Decimal;
        LeaveBalToDate: Decimal;
        LeaveEarnedToDate: Decimal;
        LeaveLiability: Decimal;
        LeavePeriodFilter, LeaveTypeFilter, ReportFilters : Text;
}


