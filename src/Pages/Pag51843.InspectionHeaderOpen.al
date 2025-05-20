page 51843 "Inspection Header - Open"
{
    // version THL- PRM 1.0
    Caption = 'New Inspection';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Inspection Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Supplier No."; Rec."Supplier No.")
                {
                    ApplicationArea = All;
                }
                field("Supplier Name"; Rec."Supplier Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("LPO No"; Rec."LPO No")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("RFQ No."; Rec."RFQ No.")
                {
                    ApplicationArea = All;
                }
                field("RFQ Date"; Rec."RFQ Date")
                {
                    ApplicationArea = All;
                }
                field("LPO Date"; Rec."LPO Date")
                {
                    ApplicationArea = All;
                }
                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field("D Note No."; Rec."D Note No.")
                {
                    ApplicationArea = All;
                }
                field("Completion/Delivery Date"; Rec."Completion/Delivery Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part(Control18; "Inspection Lines")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD(No);
            }
        }
        area(factboxes)
        {
            systempart(Control17; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Suggest LPO")
            {
                ApplicationArea = All;
                Image = SuggestLines;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PurchasesMgt.SuggestLPOInspection(Rec);
                end;
            }
            action(Certificate)
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange(No, Rec.No);
                    REPORT.Run(Report::Inspection, true, false, Rec);
                end;
            }
        }
    }
    var PurchasesMgt: Codeunit "Purchases Management";
}
