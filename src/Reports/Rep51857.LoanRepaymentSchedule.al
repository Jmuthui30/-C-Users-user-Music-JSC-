report 51857 "Loan Repayment Schedule"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Loan Repayment Schedule.rdlc';

    dataset
    {
        dataitem("Loan Schedule"; "Loan Schedule")
        {
            DataItemTableView = SORTING("Loan No", "Employee No", "Repayment Date")ORDER(Ascending);
            RequestFilterFields = "Loan No", "Employee No";

            column(Repayment_Schedule1__Repayment_Schedule1___Employee_No_; "Loan Schedule"."Employee No")
            {
            }
            column(LoanApp__Employee_Name_; LoanApp."Employee Name")
            {
            }
            column(Repayment_Schedule1__Repayment_Schedule1___Loan_No_; "Loan Schedule"."Loan No")
            {
            }
            column(LoanCategory_Description; LoanCategory.Description)
            {
            }
            column(Repayment_Schedule1__Loan_Amount_; "Loan Amount")
            {
            }
            column(Rate; Rate)
            {
            DecimalPlaces = 0: 0;
            }
            column(Duration; Duration)
            {
            }
            column(IssuedDate; IssuedDate)
            {
            }
            column(COMPANYNAME; CompanyName)
            {
            }
            column(Repayment_Schedule1__Monthly_Repayment_; "Monthly Repayment")
            {
            }
            column(Repayment_Schedule1__Repayment_Date_; "Repayment Date")
            {
            }
            column(Repayment_Schedule1__Principal_Repayment_; "Principal Repayment")
            {
            }
            column(Repayment_Schedule1__Monthly_Interest_; "Monthly Interest")
            {
            }
            column(LoanBalance; LoanBalance)
            {
            }
            column(CumInterest; CumInterest)
            {
            }
            column(CumPrincipalRepayment; CumPrincipalRepayment)
            {
            }
            column(CumMonthlyRepayment; CumMonthlyRepayment)
            {
            }
            column(Repayment_Schedule1__Repayment_Schedule1___Instalment_No_; "Loan Schedule"."Instalment No")
            {
            }
            column(Repayment_Schedule1__Monthly_Repayment__Control1000000043; "Monthly Repayment")
            {
            }
            column(Repayment_Schedule1__Principal_Repayment__Control1000000014; "Principal Repayment")
            {
            }
            column(Repayment_Schedule1__Monthly_Interest__Control1000000015; "Monthly Interest")
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(Loan_No_Caption; Loan_No_CaptionLbl)
            {
            }
            column(Loan_CategoryCaption; Loan_CategoryCaptionLbl)
            {
            }
            column(Loan_AmountCaption; Loan_AmountCaptionLbl)
            {
            }
            column(Loan_InterestCaption; Loan_InterestCaptionLbl)
            {
            }
            column(Loan_DurationCaption; Loan_DurationCaptionLbl)
            {
            }
            column(DISBURSMENT_DATECaption; DISBURSMENT_DATECaptionLbl)
            {
            }
            column(Loan_Repayment_ScheduleCaption; Loan_Repayment_ScheduleCaptionLbl)
            {
            }
            column(Monthly_RepaymentCaption; Monthly_RepaymentCaptionLbl)
            {
            }
            column(InterestCaption; InterestCaptionLbl)
            {
            }
            column(Principal_RepaymentCaption; Principal_RepaymentCaptionLbl)
            {
            }
            column(Due_DateCaption; Due_DateCaptionLbl)
            {
            }
            column(Loan_BalanceCaption; Loan_BalanceCaptionLbl)
            {
            }
            column(InterestCaption_Control1000000009; InterestCaption_Control1000000009Lbl)
            {
            }
            column(Principal_RepaymentCaption_Control1000000038; Principal_RepaymentCaption_Control1000000038Lbl)
            {
            }
            column(Monthly_RepaymentCaption_Control1000000039; Monthly_RepaymentCaption_Control1000000039Lbl)
            {
            }
            column(Loan_RepaymentCaption; Loan_RepaymentCaptionLbl)
            {
            }
            column(CummilativeCaption; CummilativeCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            trigger OnAfterGetRecord()
            begin
                i:=i + 1;
                if LoanApp.Get("Loan Schedule"."Loan No", "Loan Schedule"."Loan Category")then begin
                    Duration:=LoanApp.Instalment;
                    IssuedDate:=LoanApp."Issued Date";
                    LoanCategory.Get("Loan Schedule"."Loan Category");
                    TotalPrincipalRepayment:=TotalPrincipalRepayment + "Loan Schedule"."Principal Repayment";
                    if i = 1 then LoanBalance:=LoanApp."Approved Amount"
                    else
                    begin
                        LoanBalance:=LoanApp."Approved Amount" - TotalPrincipalRepayment + "Loan Schedule"."Principal Repayment";
                    end;
                    CumInterest:=CumInterest + "Loan Schedule"."Monthly Interest";
                    CumMonthlyRepayment:=CumMonthlyRepayment + "Loan Schedule"."Monthly Repayment";
                    CumPrincipalRepayment:=CumPrincipalRepayment + "Loan Schedule"."Principal Repayment";
                end;
            end;
            trigger OnPreDataItem()
            begin
                LastFieldNo:=FieldNo("Employee No");
                i:=0;
                j:=0;
                CUser:=UserId;
                //GetGroup.GetUserGroup(CUser,GroupCode);
                SetRange("Loan Schedule"."Payroll Group", GroupCode);
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
    var LastFieldNo: Integer;
    FooterPrinted: Boolean;
    TotalFor: Label 'Total for ';
    Duration: Integer;
    MemberLoan: Record Employee;
    IssuedDate: Date;
    LoanCategory: Record "Loan Product";
    i: Integer;
    LoanBalance: Decimal;
    CumInterest: Decimal;
    CumMonthlyRepayment: Decimal;
    CumPrincipalRepayment: Decimal;
    j: Integer;
    GroupName: Text[70];
    loanGroup: Record "Loan Product";
    TotalPrincipalRepayment: Decimal;
    Rate: Decimal;
    LoanApp: Record "Loan Application";
    GetGroup: Codeunit "Payroll Management";
    GroupCode: Code[20];
    CUser: Code[50];
    Employee_No_CaptionLbl: Label 'Employee No.';
    Name_CaptionLbl: Label 'Name:';
    Loan_No_CaptionLbl: Label 'Loan No.';
    Loan_CategoryCaptionLbl: Label 'Loan Category';
    Loan_AmountCaptionLbl: Label 'Loan Amount';
    Loan_InterestCaptionLbl: Label 'Loan Interest';
    Loan_DurationCaptionLbl: Label 'Loan Duration';
    DISBURSMENT_DATECaptionLbl: Label 'DISBURSMENT DATE';
    Loan_Repayment_ScheduleCaptionLbl: Label 'Loan Repayment Schedule';
    Monthly_RepaymentCaptionLbl: Label 'Monthly Repayment';
    InterestCaptionLbl: Label 'Interest';
    Principal_RepaymentCaptionLbl: Label 'Principal Repayment';
    Due_DateCaptionLbl: Label 'Due Date';
    Loan_BalanceCaptionLbl: Label 'Loan Balance';
    InterestCaption_Control1000000009Lbl: Label 'Interest';
    Principal_RepaymentCaption_Control1000000038Lbl: Label 'Principal Repayment';
    Monthly_RepaymentCaption_Control1000000039Lbl: Label 'Monthly Repayment';
    Loan_RepaymentCaptionLbl: Label 'Loan Repayment';
    CummilativeCaptionLbl: Label 'Cummilative';
    TotalCaptionLbl: Label 'Total';
}
