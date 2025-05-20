page 51809 "SS Store Requisitions - Receiv"
{
    // version THL- PRM 1.0
    Caption = 'Received Store Requisition';
    CardPageID = "SS Store Requisition Header-Re";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE(Received=CONST(true), "Requisition Type"=FILTER("Store Requisition"|"S_Store Requisition"|"J_Store Requisition"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Raised by"; Rec."Raised by")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control15; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action(PrintS11)
            {
                ApplicationArea = Suite;
                Image = Print;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Caption = 'Print S11';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(51821, true, false, Rec);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetFilter("Raised by", UserId);
    end;
}
