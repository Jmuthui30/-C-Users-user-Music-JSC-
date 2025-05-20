report 50018 "Generate & Post Sales Invoices"
{
    // version THL-Basic Fin 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Generate & Post Sales Invoices.rdlc';

    dataset
    {
        dataitem("Opening Sales Invoice Tx"; "Opening Sales Invoice Tx")
        {
            RequestFilterFields = "Line No";

            trigger OnAfterGetRecord()
            begin
                //Invoice Header
                if not BillHeader.Get(BillHeader."Document Type"::Invoice, "Opening Sales Invoice Tx"."Document No.")then begin
                    BillHeader.Init;
                    BillHeader."No.":="Opening Sales Invoice Tx"."Document No.";
                    BillHeader."Document Type":=BillHeader."Document Type"::Invoice;
                    BillHeader."Sell-to Customer No.":="Opening Sales Invoice Tx"."Account No";
                    BillHeader.Validate("Sell-to Customer No.");
                    BillHeader.Validate("Posting Date", "Opening Sales Invoice Tx"."Posting Date");
                    //BillHeader."Prices Including VAT" := TRUE;
                    BillHeader.Validate("Prices Including VAT");
                    BillHeader.Insert;
                end;
                BillLines.Init;
                BillLines."Document Type":=BillLines."Document Type"::Invoice;
                BillLines."Document No.":="Opening Sales Invoice Tx"."Document No.";
                BillLines."Line No.":="Opening Sales Invoice Tx"."Line No";
                BillLines.Type:=BillLines.Type::"G/L Account";
                BillLines."No.":="Opening Sales Invoice Tx"."Bal Account No.";
                BillLines.Validate("No.");
                BillLines.Quantity:=1;
                BillLines.Validate(Quantity);
                /*BillLines."Unit of Measure" := BillingLines."Unit of Measure";
                BillLines.VALIDATE("Unit of Measure");*/
                BillLines."Unit Price":="Opening Sales Invoice Tx".Amount;
                BillLines.Validate("Unit Price");
                BillLines."Shortcut Dimension 1 Code":="Opening Sales Invoice Tx".Department;
                BillLines."Shortcut Dimension 2 Code":="Opening Sales Invoice Tx".Branch;
                BillLines.Insert;
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
    var BillHeader: Record "Sales Header";
    BillLines: Record "Sales Line";
    BillHeader2: Record "Sales Header";
}
