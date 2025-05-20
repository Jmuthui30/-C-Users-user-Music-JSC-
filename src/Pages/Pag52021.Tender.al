page 52021 "Tender"
{
    SourceTable = "Procurement Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Requisition No"; Rec."Requisition No")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan No"; Rec."Procurement Plan No")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field(Procurementtype; Rec.Procurementtype)
                {
                    ApplicationArea = All;
                }
                field(TenderClosingDate; Rec.TenderClosingDate)
                {
                    ApplicationArea = All;
                }
                field("Tender Status"; Rec."Tender Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control1; "Procurement Request Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Requisition No"=FIELD(No);
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(Tender)
            {
                Caption = 'Tender';

                action("Mandatory Requirements")
                {
                    ApplicationArea = All;
                    Caption = 'Mandatory Requirements';
                    Image = ReminderTerms;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Tender Mandatory Requirements";
                    RunPageLink = "Tender No"=FIELD(No);
                }
                action(Bidders)
                {
                    ApplicationArea = All;
                    Caption = 'Bidders';
                    Image = Vendor;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page Bidders;
                    RunPageLink = "Ref No."=FIELD(No);
                }
            }
        }
    }
    trigger OnInit()
    begin
        Rec."Process Type":=Rec."Process Type"::Tender;
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec."Process Type":=Rec."Process Type"::Tender;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Process Type":=Rec."Process Type"::Tender;
    end;
}
