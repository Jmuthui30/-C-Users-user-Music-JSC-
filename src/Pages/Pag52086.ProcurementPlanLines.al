page 52086 "Procurement Plan Lines"
{
    //Ibrahim Wasiu
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = Listpart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Procurement Plan Lines";
    SourceTableView = SORTING("Plan No", "Line No");

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field("Plan No"; Rec."Plan No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Procurement Type"; Rec."Procurement Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    visible = false;
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
                {
                    visible = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Q1 Qty"; Rec."Q1 Qty")
                {
                    ApplicationArea = All;
                }
                field("Q2 Qty"; Rec."Q2 Qty")
                {
                    ApplicationArea = All;
                }
                field("Q3 Qty"; Rec."Q3 Qty")
                {
                    ApplicationArea = All;
                }
                field("Q4 Qty"; Rec."Q4 Qty")
                {
                    ApplicationArea = All;
                }
                field("Q1 Cost Estimate"; Rec."Q1 Cost Estimate")
                {
                    ApplicationArea = All;
                }
                field("Q2 Cost Estimate"; Rec."Q2 Cost Estimate")
                {
                    ApplicationArea = All;
                }
                field("Q3 Cost Estimate"; Rec."Q3 Cost Estimate")
                {
                    ApplicationArea = All;
                }
                field("Q4 Cost Estimate"; Rec."Q4 Cost Estimate")
                {
                    ApplicationArea = ALl;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Procurement Method"; Rec."Procurement Method")
                {
                    ApplicationArea = All;
                }
                field("Source of Funds"; Rec."Source of Funds")
                {
                    ApplicationArea = All;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
                {
                    ApplicationArea = All;
                }
                field("AGPO Reservation Est. Amnt."; Rec."AGPO Reservation Est. Amnt.")
                {
                    ApplicationArea = All;
                }
                field("Plan Status"; Rec."Plan Status")
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                }
                field("Advertisement Date"; Rec."Advertisement Date")
                {
                    ApplicationArea = All;
                }
                field("Bid/Quotation Opening Date"; Rec."Bid/Quotation Opening Date")
                {
                    ApplicationArea = All;
                }
                field("Proposal Evaluation date"; Rec."Proposal Evaluation date")
                {
                    ApplicationArea = All;
                }
                field("Financial Opening date"; Rec."Financial Opening date")
                {
                    ApplicationArea = All;
                }
                field("Negotiation date"; Rec."Negotiation date")
                {
                    ApplicationArea = All;
                }
                field("Notification of award date"; Rec."Notification of award date")
                {
                    ApplicationArea = All;
                }
                field("Contract Date"; Rec."Contract Date")
                {
                    ApplicationArea = All;
                }
                field("Contract End Date (Planned)"; Rec."Contract End Date (Planned)")
                {
                    ApplicationArea = All;
                }
                field("TOR/Technical specs due Date"; Rec."TOR/Technical specs due Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
        }
    }
    var ProcurePlanImp: XmlPort "Import Procurement Plan";
    ProcurePlanLines: Record "Procurement Plan Lines";
    ProcuremntHdr: Record "Procurement Plan Header";
}
