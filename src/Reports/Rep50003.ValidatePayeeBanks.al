report 50003 "Validate Payee Banks"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Validate Payee Banks.rdlc';

    dataset
    {
        dataitem("Payee Bank Details"; "Payee Bank Details")
        {
            trigger OnAfterGetRecord()
            begin
                "Payee Bank Details"."BC.SORT.CODE":=PadStr('', 5 - StrLen("Payee Bank Details"."BC.SORT.CODE"), '0') + "Payee Bank Details"."BC.SORT.CODE";
                "Payee Bank Details"."BANK CODE":=CopyStr("Payee Bank Details"."BC.SORT.CODE", 1, 2);
                Evaluate(BranchCode, CopyStr("Payee Bank Details"."BC.SORT.CODE", 3, 3));
                "Payee Bank Details"."BRANCH CODE":=Format(BranchCode);
                if Banks.Get("Payee Bank Details"."BANK CODE")then "Payee Bank Details".BANKNAME:=Banks.Name;
                if Branches.Get("Payee Bank Details"."BANK CODE", "Payee Bank Details"."BRANCH CODE")then "Payee Bank Details"."BRANCH NAME":=Branches."Branch Name";
                "Payee Bank Details".Modify;
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
    trigger OnPostReport()
    begin
        Message('Complete.');
    end;
    var Banks: Record "Commercial Banks";
    Branches: Record "Bank Branches";
    BranchCode: Decimal;
}
