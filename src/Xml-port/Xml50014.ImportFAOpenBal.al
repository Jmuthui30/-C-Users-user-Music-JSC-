xmlport 50014 "Import FA OpenBal"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement("FA Opening Balances";
    "FA Opening Balances")
    {
    XmlName = 'FA';

    fieldattribute(Desc;
    "FA Opening Balances".Description)
    {
    }
    fieldattribute(Qty;
    "FA Opening Balances".Quantity)
    {
    }
    fieldattribute(UnitCost;
    "FA Opening Balances"."Unit Cost")
    {
    }
    fieldattribute(TotalCost;
    "FA Opening Balances"."Total Cost")
    {
    }
    fieldattribute(Desc2;
    "FA Opening Balances"."Desc 2")
    {
    }
    fieldattribute(Location;
    "FA Opening Balances".Location)
    {
    }
    fieldattribute(Subclass;
    "FA Opening Balances".Subclass)
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        Counter:=Counter + 1;
        "FA Opening Balances"."No.":=Counter;
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
    trigger OnPostXmlPort()
    begin
        Message('Complete');
    end;
    trigger OnPreXmlPort()
    begin
        Counter:=0;
    end;
    var Counter: Integer;
}
