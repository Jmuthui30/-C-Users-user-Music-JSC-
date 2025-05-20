xmlport 50000 "NIC EFT File"
{
    Direction = Export;
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement("PV Header";
    "PV Header")
    {
    XmlName = 'PV';

    textattribute(valuedate)
    {
    XmlName = 'ValueDate';

    trigger OnBeforePassVariable()
    begin
        ValueDate:=Format(Today, 0, '<Day,2>/<Month,2>/<Year4>');
    end;
    }
    fieldattribute(PayeeBankCode;
    "PV Header"."Payee Bank Code")
    {
    }
    textattribute(branchcode)
    {
    XmlName = 'BranchCode';

    trigger OnBeforePassVariable()
    begin
        BranchCode:=PadStr('', 3 - StrLen("PV Header"."Branch Code"), '0') + "PV Header"."Branch Code";
    end;
    }
    textattribute(payeeaccountno)
    {
    XmlName = 'PayeeAccountNo';

    trigger OnBeforePassVariable()
    begin
        PayeeAccountNo:=Format("PV Header"."Payee Account No.");
    end;
    }
    fieldattribute(PayeeAccountName;
    "PV Header"."Payee Account Name")
    {
    }
    textattribute(totalamount)
    {
    XmlName = 'TotalAmount';

    trigger OnBeforePassVariable()
    begin
        "PV Header".CalcFields("Total Amount", "Total Amount LCY");
        if "PV Header".Currency = '' then TotalAmount:=Format("PV Header"."Total Amount", 0, '<Standard Format,2>')
        else
            TotalAmount:=Format("PV Header"."Total Amount LCY", 0, '<Standard Format,2>');
    end;
    }
    fieldattribute(Ref;
    "PV Header"."No.")
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
