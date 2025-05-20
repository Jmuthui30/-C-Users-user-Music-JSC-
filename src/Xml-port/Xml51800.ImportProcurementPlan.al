xmlport 51800 "Import Procurement Plan"
{
    //Ibrahim Wasiu
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
    textelement(Root)
    {
    tableelement("Procurement Plan Lines";
    "Procurement Plan Lines")
    {
    XmlName = 'ProcurementPlanLines';

    fieldattribute(ProcurementType;
    "Procurement Plan Lines"."Procurement Type")
    {
    }
    fieldattribute(No;
    "Procurement Plan Lines"."No.")
    {
    }
    fieldattribute(Description;
    "Procurement Plan Lines".Description)
    {
    }
    fieldattribute(DepartmentCode;
    "Procurement Plan Lines"."Department Code")
    {
    }
    fieldattribute(Quantity;
    "Procurement Plan Lines".Quantity)
    {
    }
    fieldattribute(UnitPrice;
    "Procurement Plan Lines"."Unit Price")
    {
    }
    fieldattribute(SourceFunds;
    "Procurement Plan Lines"."Source of Funds")
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        //To skip the Header of the excel
        /*if CaptionRow then begin
                        CaptionRow := false;
                        currXMLport.Skip();
                    end;*/
        //
        Counter:=Counter + 1;
        "Procurement Plan Lines"."Plan No":=BatchNo;
        "Procurement Plan Lines"."Line No":=Counter;
        "Procurement Plan Lines"."Plan Status":="Procurement Plan Lines"."Plan Status"::Open;
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
    trigger OnPreXmlPort()
    begin
        Counter:=0;
        CountRow:=0;
        CaptionRow:=true;
    end;
    trigger OnPostXmlPort()
    begin
        Message('Import Completed.');
    end;
    var ProcureHead: Record "Procurement Plan Header";
    BatchNo: Code[20];
    Counter: Integer;
    CountRow: Integer;
    CaptionRow: Boolean;
    procedure GetHeader(var ProcuremntHdr: Record "Procurement Plan Header")
    begin
        ProcureHead.Copy(ProcuremntHdr);
        BatchNo:=ProcureHead."No.";
    end;
}
