page 52059 "PR Purch Requisitions - Open"
{
    // version THL- PRM 1.0
    Caption = 'Create Purchase Requisitions for Employee';
    CardPageID = "PR Purch Requisition Header-Op";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE(Status=CONST(Open), "Requisition Type"=CONST("Purchase Requisition"), "PR Created"=CONST(true));

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
                field("Amount Limit Code"; Rec."Amount Limit Code")
                {
                    ApplicationArea = All;
                }
                field("Amount Limit Description"; Rec."Amount Limit Description")
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
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Raised by", UserId);
    end;
}
