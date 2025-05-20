report 51802 "Inspection"
{
    // version THL- PRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Inspection.rdl';

    dataset
    {
        dataitem("Inspection Header"; "Inspection Header")
        {
            column(Logo; CompInfo.Picture)
            {
            }
            column(Logo2; CompInfo.Picture2)
            {
            }
            column(Watermark; AdvancedFinanceSetup."Watermark Portrait")
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompAddress; CompInfo.Address)
            {
            }
            column(CompAddress2; CompInfo."Address 2")
            {
            }
            column(CompCity; CompInfo.City)
            {
            }
            column(CompPhone; CompInfo."Phone No.")
            {
            }
            column(Email; CompInfo."E-Mail")
            {
            }
            column(Website; CompInfo."Home Page")
            {
            }
            column(CompCountry; CompInfo."Country/Region Code")
            {
            }
            column(No; "Inspection Header".No)
            {
            }
            column(LPONo; "Inspection Header"."LPO No")
            {
            }
            column(PreparedBy; PreparedBy)
            {
            }
            column(ReviewedBy; "Inspection Header"."Reviewed By")
            {
            }
            column(SupplierNo; "Inspection Header"."Supplier No.")
            {
            }
            column(SupplierName; "Inspection Header"."Supplier Name")
            {
            }
            column(Date; "Inspection Header".Date)
            {
            }
            column(RFQNo; "Inspection Header"."RFQ No.")
            {
            }
            column(RFQDate; "Inspection Header"."RFQ Date")
            {
            }
            column(LPODate; "Inspection Header"."LPO Date")
            {
            }
            column(TotalValue; "Inspection Header"."Total Value")
            {
            }
            column(InvoiceNo; "Inspection Header"."Invoice No.")
            {
            }
            column(DNoteNo; "Inspection Header"."D Note No.")
            {
            }
            column(Desc; "Inspection Header".Description)
            {
            }
            column(CompletionDate; "Inspection Header"."Completion/Delivery Date")
            {
            }
            column(State; State)
            {
            }
            column(Dept; Dept)
            {
            }
            dataitem("Inspection Lines"; "Inspection Lines")
            {
                DataItemLink = "No."=field(No);

                column(Description; "Inspection Lines".Description)
                {
                }
                column(Line_No; "Line No.")
                {
                }
                column(Qty; "Inspection Lines".Quantity)
                {
                }
                column(UOM; "Inspection Lines".UoM)
                {
                }
                column(UnitCost; "Inspection Lines"."Unit Cost")
                {
                }
                column(TotalCost; "Inspection Lines"."Total Cost")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                UserRec.Reset;
                UserRec.SetRange("User Name", "Inspection Header"."Created By");
                if UserRec.FindFirst then PreparedBy:=UserRec."Full Name";
            //Dept := 'MECHANICAL AND TRANSPORT DIVISION';
            //State := 'STATE DEPARTMENTT OF INFRASTRUCTURE';
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
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        CompInfo.CalcFields(Picture2);
        AdvancedFinanceSetup.Get;
        AdvancedFinanceSetup.CALCFIELDS("Watermark Portrait");
    end;
    var CompInfo: Record "Company Information";
    UserRec: Record User;
    PreparedBy: Text;
    ProcurementSetup: Record "Procurement Setup";
    ReviewedBy: Text;
    AdvancedFinanceSetup: Record "Advanced Finance Setup";
    State: Text;
    Dept: Text;
}
