report 51840 "Inventory Consumption Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Inventory Consumption Report.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Requisition Lines"; "Requisition Lines")
        {
            DataItemTableView = SORTING("Requisition No", "Line No")WHERE("Quantity Issued"=FILTER(<>0));
            RequestFilterFields = No, "Global Dimension 1 Code", "Global Dimension 2 Code", "Job No", "Service Order No", "Issued Date";

            column(No_RequisitionLines; "Requisition Lines".No)
            {
            }
            column(Description_RequisitionLines; "Requisition Lines".Description)
            {
            }
            column(UnitofMeasure_RequisitionLines; "Requisition Lines"."Unit of Measure")
            {
            }
            column(UnitPrice_RequisitionLines; "Requisition Lines"."Unit Price")
            {
            }
            column(Amount_RequisitionLines; ActualCost)
            {
            }
            column(GlobalDimension1Code_RequisitionLines; "Requisition Lines"."Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_RequisitionLines; "Requisition Lines"."Global Dimension 2 Code")
            {
            }
            column(QuantityIssued_RequisitionLines; "Requisition Lines"."Quantity Issued")
            {
            }
            column(RequisitionNo_RequisitionLines; "Requisition Lines"."Requisition No")
            {
            }
            column(ReqDate; Date)
            {
            }
            column(IssuedDate_RequisitionLines; "Requisition Lines"."Issued Date")
            {
            }
            column(UnitCost; UnitCost)
            {
            }
            column(JobNo; "Requisition Lines"."Job No")
            {
            }
            column(SoNo; "Requisition Lines"."Service Order No")
            {
            }
            dataitem("Fixed Asset"; "Fixed Asset")
            {
                DataItemLink = "No."=FIELD("Global Dimension 2 Code");

                column(Description_FixedAsset; "Fixed Asset".Description)
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                ItemLedgerEntry.Reset;
                ItemLedgerEntry.SetFilter("Posting Date", VarPeriod);
                ItemLedgerEntry.SetRange("Item No.", "Requisition Lines".No);
                ItemLedgerEntry.SetRange("Document No.", "Requisition Lines"."Requisition No");
                if ItemLedgerEntry.FindSet then begin
                    Date:=ItemLedgerEntry."Posting Date";
                    ItemLedgerEntry.CalcFields("Cost Amount (Actual)");
                    ActualCost:=ItemLedgerEntry."Cost Amount (Actual)";
                end;
                UnitCost:=ActualCost / "Requisition Lines".Quantity;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(VarPeriod; VarPeriod)
                {
                    ApplicationArea = All;
                    Caption = 'Date Period';
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
    trigger OnPreReport()
    begin
        TextManagement.MakeDateFilter(VarPeriod);
    end;
    var Item: Record Item;
    UnitCost: Decimal;
    RequisitionHeader: Record "Requisition Header";
    ReqDate: Date;
    StartDate: Date;
    EndDate: Date;
    TextManagement: Codeunit 51821;
    PeriodVar: Text;
    ItemLedgerEntry: Record "Item Ledger Entry";
    Date: Date;
    ActualCost: Decimal;
    VarPeriod: Text[50];
}
