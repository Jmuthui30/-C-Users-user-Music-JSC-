xmlport 50013 "Import OB"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement("Opening Balances";
    "Opening Balances")
    {
    XmlName = 'OB';

    fieldattribute(Type;
    "Opening Balances".Type)
    {
    }
    fieldattribute(AccountNo;
    "Opening Balances"."Account No.")
    {
    }
    fieldattribute(Name;
    "Opening Balances".Name)
    {
    }
    fieldattribute(Debit;
    "Opening Balances".Debit)
    {
    }
    fieldattribute(Credit;
    "Opening Balances".Credit)
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
    trigger OnPostXmlPort()
    begin
        Message('Complete');
    end;
}
