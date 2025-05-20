report 51858 "Loan Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Loan Statement.rdlc';

    dataset
    {
        dataitem("Loan Application"; "Loan Application")
        {
            column(Logo; CompInfo.Picture)
            {
            }
            column(LoanNo; "Loan Application"."Loan No")
            {
            }
            column(IssuedDate; "Loan Application"."Issued Date")
            {
            }
            column(ApprovedAmount; "Loan Application"."Approved Amount")
            {
            }
            column(InterestCalculationMethod; "Loan Application"."Interest Calculation Method")
            {
            }
            column(InterestRate; "Loan Application"."Interest Rate")
            {
            }
            column(RepaymentPeriod; "Loan Application".Instalment)
            {
            }
            column(Name; "Loan Application"."Employee Name")
            {
            }
            column(LoanName; LoanName)
            {
            }
            column(TotalRepayment; TotalRepayment)
            {
            }
            column(Balance; Balance)
            {
            }
            dataitem(AssMatrix; "Payroll Matrix")
            {
                DataItemLink = "Employee No"=FIELD("Employee No");
                DataItemTableView = WHERE(Type=CONST(Deduction));

                column(DatePayroll; AssMatrix."Payroll Period")
                {
                }
                column(DescPayroll; AssMatrix.Description)
                {
                }
                column(AmountPayroll; Abs(AssMatrix.Amount))
                {
                }
                trigger OnAfterGetRecord()
                begin
                //TotalRepayment := TotalRepayment + ABS(AssMatrix.Amount);
                end;
            }
            dataitem(NonPayroll; "Non Payroll Receipts")
            {
                DataItemLink = "Loan No"=FIELD("Loan No");

                column(DateNonPayroll; NonPayroll."Receipt Date")
                {
                }
                column(DescNonPayroll; DescriptionNonPayroll + Format(NonPayroll."Receipt Date"))
                {
                }
                column(AmountNonPayroll; NonPayroll.Amount)
                {
                }
                trigger OnAfterGetRecord()
                begin
                //TotalRepayment := TotalRepayment + NonPayroll.Amount;
                end;
                trigger OnPostDataItem()
                begin
                //Balance := IssueAmount - TotalRepayment;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                "Loan Application".CalcFields("Total Repayment", Receipts);
                TotalRepayment:=Abs("Loan Application"."Total Repayment") + "Loan Application".Receipts;
                Balance:="Loan Application"."Approved Amount" - (Abs("Loan Application"."Total Repayment") + "Loan Application".Receipts);
                //TotalRepayment := 0;
                IssueAmount:="Loan Application"."Approved Amount";
                if LoanRec.Get("Loan Application"."Loan Product Type")then LoanName:=LoanRec.Description;
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;
    var CompInfo: Record "Company Information";
    LoanRec: Record "Loan Product";
    AssignmentMatrix: Record "Payroll Matrix";
    TotalRepayment: Decimal;
    Balance: Decimal;
    NonPayrollReceipts: Record "Non Payroll Receipts";
    DescriptionNonPayroll: Label 'Non payroll receipt -';
    IssueAmount: Decimal;
    LoanName: Text;
}
