xmlport 50002 "Import Beneficiary Bank Detail"
{
    schema
    {
    textelement(Root)
    {
    tableelement("Payee Bank Details";
    "Payee Bank Details")
    {
    XmlName = 'Ben';

    fieldattribute(BenID;
    "Payee Bank Details"."BEN ID")
    {
    }
    fieldattribute(BenName;
    "Payee Bank Details"."BENEFICIARY NAME")
    {
    }
    fieldattribute(CustNo;
    "Payee Bank Details"."CUST NO")
    {
    }
    fieldattribute(CustRef;
    "Payee Bank Details"."CUSTOMER REF")
    {
    }
    fieldattribute(BenAccNo;
    "Payee Bank Details"."BEN ACCT NO")
    {
    }
    fieldattribute(TransactionType;
    "Payee Bank Details"."TRANSACTION TYPE")
    {
    }
    fieldattribute(FullBenName;
    "Payee Bank Details"."FULL BEN NAME")
    {
    }
    fieldattribute(BCSortCode;
    "Payee Bank Details"."BC.SORT.CODE")
    {
    }
    fieldattribute(BankName;
    "Payee Bank Details".BANKNAME)
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        if "Payee Bank Details"."BC.SORT.CODE" = '' then currXMLport.Skip;
        "Payee Bank Details"."BC.SORT.CODE":=PadStr('', 5 - StrLen("Payee Bank Details"."BC.SORT.CODE"), '0') + "Payee Bank Details"."BC.SORT.CODE";
        "Payee Bank Details"."BANK CODE":=CopyStr("Payee Bank Details"."BC.SORT.CODE", 1, 2);
        "Payee Bank Details"."BRANCH CODE":=CopyStr("Payee Bank Details"."BC.SORT.CODE", 3, 3);
        if Banks.Get("Payee Bank Details"."BANK CODE")then "Payee Bank Details".BANKNAME:=Banks.Name;
        if Branches.Get("Payee Bank Details"."BANK CODE", "Payee Bank Details"."BRANCH CODE")then "Payee Bank Details"."BRANCH NAME":=Branches."Branch Name";
    end;
    }
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
    var Banks: Record "Commercial Banks";
    Branches: Record "Bank Branches";
}
