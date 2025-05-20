page 51841 "RFQ Vendors"
{
    // version THL- PRM 1.0
    PageType = List;
    SourceTable = "RFQ Vendors";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = All;
                }
                field("Vendor Application No."; Rec."Vendor Application No")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Competency; Rec.Competency)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Commitment; Rec.Commitment)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Control; Rec.Control)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cash Resources"; Rec."Cash Resources")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Consistency; Rec.Consistency)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies wheather the vendor has viewed the RFQ on portal or not.';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Generate Quote")
            {
                ApplicationArea = All;
                Image = Quote;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.Find('-')then repeat ProcurementMgt.GenerateQuote(Rec."RFQ No", Rec."Vendor No");
                        until Rec.Next = 0;
                end;
            }
            action("View Quote")
            {
                ApplicationArea = All;
                Image = View;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    if Rec.Find('-')then begin
                        repeat if QuoteRec.Get(QuoteRec."Document Type"::Quote, Rec."Quote No")then PAGE.Run(49, QuoteRec)
                            else
                                Error('A quote has not been generated for %1', Rec.Name);
                        until Rec.Next = 0;
                    end;
                end;
            }
        }
    }
    var ProcurementMgt: Codeunit "Purchases Management";
    QuoteRec: Record "Purchase Header";
}
