xmlport 52101 "Import Eft Lines"
{
    Direction = Import;
    Format = VariableText;

    schema
    {
    textelement(Root)
    {
    tableelement("EFT Lines";
    "EFT Lines")
    {
    XmlName = 'EFT';

    fieldattribute(Code;
    "EFT Lines"."Vendor Code")
    {
    }
    fieldattribute(Description;
    "EFT Lines".Description)
    {
    }
    fieldattribute(AccountName;
    "EFT Lines"."Account Name")
    {
    }
    fieldattribute(BankAccountNumber;
    "EFT Lines"."Bank Account No")
    {
    }
    fieldattribute(SortCode;
    "EFT Lines"."Sort Code")
    {
    }
    fieldattribute(Amount;
    "EFT Lines".Amount)
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        LineNo:=LineNo + 1;
        "EFT Lines"."EFT No":=BatchNo;
        "EFT Lines".Payee:="EFT Lines"."Vendor Name";
        if "EFT Lines".Payee = '' then currXMLport.Skip;
        "EFT Lines"."Account No":="EFT Lines"."Bank Account No";
        "EFT Lines"."Vendor Name":="EFT Lines"."Account Name";
        if StrLen("EFT Lines"."Account No") > 10 then Error('Invalid Account Number for ' + "EFT Lines"."Account Name" + '\\' + 'check line ' + Format(LineNo));
        "EFT Lines"."PV No":=Format(LineNo);
        Window.Update(1, "EFT Lines"."Account Name");
        Commit;
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
        Window.Close;
        Message('Complete.');
    end;
    trigger OnPreXmlPort()
    begin
        Window.Open('Importing adhoc payment details for #####1', Names);
    end;
    var BatchTime: Text;
    CurrentNumber: Integer;
    Window: Dialog;
    Names: Text;
    BatchNo: Code[20];
    Eftheader1: Record "EFT Header";
    LineNo: Integer;
    FundID: Code[10];
    Employer: Record Customer;
    EmployerCopy: Record Customer;
    procedure GetRecHeader(var EFTHeader: Record "EFT Header")
    begin
        BatchNo:=EFTHeader.No;
        Eftheader1.Copy(EFTHeader);
    end;
}
