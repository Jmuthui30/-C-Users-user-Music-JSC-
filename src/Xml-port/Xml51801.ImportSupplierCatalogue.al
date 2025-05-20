xmlport 51801 "Import Supplier Catalogue"
{
    //Ibrahim Wasiu
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
    textelement(Root)
    {
    tableelement("Supplier Catalogue";
    "Supplier Catalogue")
    {
    XmlName = 'SupplierCatalogue';

    fieldattribute(ProductName;
    "Supplier Catalogue"."Product Name")
    {
    }
    fieldattribute(Description;
    "Supplier Catalogue".Description)
    {
    }
    fieldattribute(UoM;
    "Supplier Catalogue".UoM)
    {
    }
    fieldattribute(Qty;
    "Supplier Catalogue".Quantity)
    {
    }
    fieldattribute(UnitPrice;
    "Supplier Catalogue"."Unit Price")
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
        "Supplier Catalogue"."Supplier ID":=BatchNo;
        "Supplier Catalogue"."Line No":=Counter;
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
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
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
    var Counter: Integer;
    SupplierCat: Record "Supplier Catalogue";
    BatchNo: Code[20];
    CountRow: Integer;
    CaptionRow: Boolean;
    VendorIn: Record Vendor;
    procedure GetHeader(var Header: Record Vendor)
    begin
        VendorIn.Copy(Header);
        BatchNo:=VendorIn."No.";
    end;
}
