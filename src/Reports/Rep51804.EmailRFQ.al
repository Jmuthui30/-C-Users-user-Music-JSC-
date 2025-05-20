report 51804 "Email RFQ"
{
    // version THL- Payroll 1.0
    ProcessingOnly = true;

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                if "Purchase Header"."Buy-from Vendor No." = '' then Error('Vendor has not been selected.');
                if Supplier.Get("Purchase Header"."Buy-from Vendor No.")then Supplier.TestField("E-Mail");
                PurchMgt.GenerateRFQEmail("Purchase Header");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(MonthBeginDate; MonthBeginDate)
                {
                    ApplicationArea = All;
                    Caption = 'Month Begin Date';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var MonthBeginDate: Date;
    PurchMgt: Codeunit "Purchases Management";
    Supplier: Record Vendor;
}
