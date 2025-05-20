page 52012 "Procurement Plan items"
{
    PageType = ListPart;
    SourceTable = "Procurement Plan";
    SourceTableView = SORTING("Plan Item No")ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control22)
            {
                ShowCaption = false;

                field("Plan Item No"; Rec."Plan Item No")
                {
                    ApplicationArea = All;
                }
                field("Procurement Type"; Rec."Procurement Type")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
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
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
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
    }
}
