report 52214 "Total Earnings/Employee"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Total Earnings Only Per Employee.rdlc';
    Caption = 'Client Total Earnings Only Per Employee';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("PR Transaction Codes"; "Client Earnings")
        {
            DataItemTableView = SORTING(Code)ORDER(Descending);
            RequestFilterFields = Code;

            column(GroupDescription_PRTransactionCodes; "PR Transaction Codes".Description)
            {
            }
            column(CompInfoName; CompInfo.Name)
            {
            }
            column(CompInfoAddress; CompInfo.Address)
            {
            }
            column(CompInfoCity; CompInfo.City)
            {
            }
            column(CompInfoPicture; CompInfo.Picture)
            {
            }
            column(CompInfoEMail; CompInfo."E-Mail")
            {
            }
            column(CompInfoHomePage; CompInfo."Home Page")
            {
            }
            column(PeriodName; PeriodName)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(AppliedFilters; AppliedFilters)
            {
            }
            column(ReportTitle; ReportTitle)
            {
            }
            dataitem("PR Period Transactions"; "Client Payroll Matrix")
            {
                DataItemLink = "Code"=FIELD(Code);
                //DataItemTableView = SORTING()
                RequestFilterFields = "Payroll Period", "Payroll Group";

                column(TransactionName_PRPeriodTransactions; "PR Period Transactions".Description)
                {
                }
                column(TransactionCode_PRPeriodTransactions; "PR Period Transactions"."Code")
                {
                }
                column(EmployeeCode_PRPeriodTransactions; "PR Period Transactions"."Employee No")
                {
                }
                column(Balance_PRPeriodTransactions; "PR Period Transactions"."Opening Balance")
                {
                }
                column(Amount_PRPeriodTransactions; "PR Period Transactions".Amount)
                {
                }
                column(EmpName; EmpName)
                {
                }
                column(IDNumber; IDNumber)
                {
                }
                column(BLN_No; BLN_No)
                {
                }
                column(ReferenceNo_PRPeriodTransactions; "PR Period Transactions"."Reference No")
                {
                }
                dataitem(Employee; "Client Employee Master")
                {
                    DataItemLink = "No."=field("Employee No");

                    column(ID_Number; "ID Number")
                    {
                    }
                    column(Full_Name; "Full Name")
                    {
                    }
                }
                trigger OnAfterGetRecord();
                begin
                    EmpName:='';
                    IDNumber:='';
                    CLEAR(HREmp);
                    IF HREmp.GET("PR Period Transactions"."Employee No")THEN BEGIN
                        EmpName:=UPPERCASE(HREmp."Search Name");
                        begin
                            if("PR Transaction Codes"."Earning Type" = "PR Transaction Codes"."Earning Type"::"Tax Relief") or ("PR Transaction Codes"."Earning Type" = "PR Transaction Codes"."Earning Type"::"Insurance Relief") or ("PR Transaction Codes"."Earning Type" = "PR Transaction Codes"."Earning Type"::"Owner Occupier")then CurrReport.Skip;
                        end;
                    //IDNumber := HREmp."ID Number";
                    END;
                    BLN_No:='';
                    //Get Reference No
                    PREmpTrans.RESET;
                    PREmpTrans.SETRANGE(PREmpTrans."Payroll Period", SelectedPeriod);
                    PREmpTrans.SETRANGE(PREmpTrans."Code", "PR Period Transactions"."Code");
                    PREmpTrans.SetRange(PREmpTrans.Company, "PR Period Transactions".Company);
                    IF PREmpTrans.FIND('-')THEN BEGIN
                        BLN_No:=PREmpTrans."Reference No";
                    END;
                end;
                trigger OnPreDataItem();
                begin
                    "PR Period Transactions".SETRANGE("PR Period Transactions"."Payroll Period", SelectedPeriod);
                    if PostingGrp_TxtFilter = PostingGrp_TxtFilter::ALL then begin
                    end;
                    if PostingGrp_TxtFilter = PostingGrp_TxtFilter::BOARD then begin
                        "PR Period Transactions".SetFilter("PR Period Transactions"."Payroll Group", '%1', 'BOARD');
                    end;
                    if PostingGrp_TxtFilter = PostingGrp_TxtFilter::CASUALS then begin
                        "PR Period Transactions".SetFilter("PR Period Transactions"."Payroll Group", '%1', 'CASUALS');
                    end;
                    if PostingGrp_TxtFilter = PostingGrp_TxtFilter::JSC then begin
                        "PR Period Transactions".SetFilter("PR Period Transactions"."Payroll Group", '%1', 'JSC');
                    end;
                    if PostingGrp_TxtFilter = PostingGrp_TxtFilter::"JSC & KJA" then begin
                        "PR Period Transactions".SetFilter("PR Period Transactions"."Payroll Group", '%1|%2', 'JSC', 'KJA');
                    end;
                    if PostingGrp_TxtFilter = PostingGrp_TxtFilter::KJA then begin
                        "PR Period Transactions".SetFilter("PR Period Transactions"."Payroll Group", '%1', 'KJA');
                    end;
                end;
            }
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(SelectedPeriod; SelectedPeriod)
                {
                    Caption = 'Payroll Period';
                    ApplicationArea = all;
                    TableRelation = "Client Payroll Period"."Starting Date";
                }
                field(PostingGrp_TxtFilter; PostingGrp_TxtFilter)
                {
                    Caption = 'Employee Posting Group';
                    ApplicationArea = all;
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
    trigger OnPreReport();
    begin
        IF SelectedPeriod = 0D THEN ERROR('Please enter selected period');
        //Company Info
        fnCompanyInfo;
        //Period Name
        PRPayrollPeriods.RESET;
        PRPayrollPeriods.SETRANGE(PRPayrollPeriods."Starting Date", SelectedPeriod);
        IF PRPayrollPeriods.FIND('-')THEN PeriodName:=PRPayrollPeriods.Name;
    end;
    var PostingGrp_TxtFilter: Option "ALL", "JSC", "KJA", "BOARD", "JSC & KJA", "CASUALS";
    SelectedPeriod: Date;
    CompInfo: Record "Company Information";
    PeriodName: Text[30];
    AppliedFilters: Text;
    PRPayrollPeriods: Record "Client Payroll Period";
    EmpName: Text;
    HREmp: Record "Employee";
    IDNumber: Text;
    PREmpTrans: Record "Client Payroll Matrix";
    BLN_No: Text;
    ReportTitle: Text;
    procedure fnCompanyInfo();
    begin
        CompInfo.RESET;
        IF CompInfo.GET THEN CompInfo.CALCFIELDS(CompInfo.Picture);
    end;
}
