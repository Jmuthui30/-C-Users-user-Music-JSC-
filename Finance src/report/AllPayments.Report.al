report 51024 "All Payments"
{
    ApplicationArea = All;
    Caption = 'All Payments';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/AllPayments.rdlc';
    dataset
    {
        dataitem(Payments; Payments)
        {
            DataItemTableView = where(Posted = const(true));
            RequestFilterFields = "Payment Type";

            column(No_Payments; Payments."No.")
            {
            }
            column(CreatedBy_Payments; Payments."Created By")
            {
            }
            column(Date_Payments; Payments.Date)
            {
            }
            column(PayMode_Payments; Payments."Pay Mode")
            {
            }
            column(ChequeNo_Payments; Payments."Cheque No")
            {
            }
            column(ChequeDate_Payments; Payments."Cheque Date")
            {
            }
            column(PostedBy_Payments; Payments."Posted By")
            {
            }
            column(PostedDate_Payments; Payments."Posted Date")
            {
            }
            column(TotalAmount_Payments; Payments."Total Amount")
            {
            }
            column(PaymentType_Payments; Payments."Payment Type")
            {
            }
            column(PettyCashAmount_Payments; Payments."Petty Cash Amount")
            {
            }
            column(PaymentNarration_Payments; Payments."Payment Narration")
            {
            }
            column(PostingDate_Payments; Payments."Posting Date")
            {
            }
            column(PettyCashAmountLCY_Payments; Payments."Petty Cash Amount (LCY)")
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddress; CompanyInfo.Address)
            {
            }
            column(CompCity; CompanyInfo.City)
            {
            }
            column(CompPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompPic; CompanyInfo.Picture)
            {
            }
        }
    }
    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;
}
