report 51861 "Client Loan Statement"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Client Loan Statement.rdlc';

    dataset
    {
        dataitem("Client Loan Application"; "Client Loan Application")
        {
            column(Logo; CompInfo.Picture)
            {
            }
            column(LoanNo; "Client Loan Application"."Loan No")
            {
            }
            column(IssuedDate; "Client Loan Application"."Issued Date")
            {
            }
            column(ApprovedAmount; "Client Loan Application"."Approved Amount")
            {
            }
            column(InterestCalculationMethod; "Client Loan Application"."Interest Calculation Method")
            {
            }
            column(InterestRate; "Client Loan Application"."Interest Rate")
            {
            }
            column(RepaymentPeriod; "Client Loan Application".Instalment)
            {
            }
            column(Name; "Client Loan Application"."Employee Name")
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
                "Client Loan Application".CalcFields("Total Repayment", Receipts);
                TotalRepayment:=Abs("Client Loan Application"."Total Repayment") + "Client Loan Application".Receipts;
                Balance:="Client Loan Application"."Approved Amount" - (Abs("Client Loan Application"."Total Repayment") + "Client Loan Application".Receipts);
                //TotalRepayment := 0;
                IssueAmount:="Client Loan Application"."Approved Amount";
                if LoanRec.Get("Client Loan Application"."Client Loan Product Type")then LoanName:=LoanRec.Description;
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
    LoanRec: Record "Client Loan Product";
    AssignmentMatrix: Record "Client Payroll Matrix";
    TotalRepayment: Decimal;
    Balance: Decimal;
    NonPayrollReceipts: Record "Non Payroll Receipts";
    DescriptionNonPayroll: Label 'Non payroll receipt -';
    IssueAmount: Decimal;
    LoanName: Text;
}
