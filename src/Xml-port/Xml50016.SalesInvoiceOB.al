xmlport 50016 "SalesInvoice OB"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement("Opening Sales Invoice Tx";
    "Opening Sales Invoice Tx")
    {
    XmlName = 'SI';

    fieldattribute(LineNo;
    "Opening Sales Invoice Tx"."Line No")
    {
    }
    fieldattribute(AccType;
    "Opening Sales Invoice Tx"."Account Type")
    {
    }
    fieldattribute(AccNo;
    "Opening Sales Invoice Tx"."Account No")
    {
    }
    fieldattribute(PostingDate;
    "Opening Sales Invoice Tx"."Posting Date")
    {
    }
    fieldattribute(DocNo;
    "Opening Sales Invoice Tx"."Document No.")
    {
    }
    fieldattribute(Description;
    "Opening Sales Invoice Tx".Description)
    {
    }
    fieldattribute(Amount;
    "Opening Sales Invoice Tx".Amount)
    {
    }
    fieldattribute(BalAccType;
    "Opening Sales Invoice Tx"."Bal. Account Type")
    {
    }
    fieldattribute(BalAccNo;
    "Opening Sales Invoice Tx"."Bal Account No.")
    {
    }
    fieldattribute(Branch;
    "Opening Sales Invoice Tx".Branch)
    {
    }
    fieldattribute(Dept;
    "Opening Sales Invoice Tx".Department)
    {
    }
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
}
