xmlport 50019 "Payments Tx"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement("Payments Tx";
    "Payments Tx")
    {
    XmlName = 'Payment';

    fieldattribute(LineNo;
    "Payments Tx"."Line No.")
    {
    }
    fieldattribute(AccountType;
    "Payments Tx"."Account Type")
    {
    }
    fieldattribute(AccountNo;
    "Payments Tx"."Account No.")
    {
    }
    fieldattribute(Date;
    "Payments Tx"."Posting Date")
    {
    }
    fieldattribute(DocNo;
    "Payments Tx"."Document No.")
    {
    }
    fieldattribute(Desc;
    "Payments Tx".Description)
    {
    }
    fieldattribute(Amount;
    "Payments Tx".Amount)
    {
    }
    fieldattribute(BalAccountType;
    "Payments Tx"."Bal. Account Type")
    {
    }
    fieldattribute(BalAccountNo;
    "Payments Tx"."Bal. Account No.")
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
