page 51611 "Leave Applications - Open"
{
    // version THL- HRM 1.0
    Caption = 'Create Leave Application for Employee';
    CardPageID = "Leave Application - Open";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "Employee Leave Application";
    //SourceTableView = WHERE("HR Created"=CONST(true), "SSP Created"=const(true), Status=CONST(Open));
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "Leave Apps Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("Application No"), "Table ID" = CONST(51602);
            }
            systempart(Control15; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                PromotedOnly = true;
                RunObject = Page "Leave Apps Documents";
                RunPageLink = "Document No." = FIELD("Application No"), "Table ID" = CONST(51602);
            }
            action("HR Setup")
            {
                ApplicationArea = All;
                Image = HRSetup;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "QuantumJumps HR Setup";
            }
            action("Create Employee Leave Entitlements")
            {
                ApplicationArea = All;
                Image = CreateSerialNo;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Report "Create Leave Entitlement";
            }
            action("Employee Leave Balances")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Report "Leave Balance";
            }
            action("Outstanding Leave Days")
            {
                ApplicationArea = All;
                Caption = 'Outstanding Leave Days';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Report "Outstanding Leave Days";
            }
            action("Staff On Leave")
            {
                ApplicationArea = All;
                Caption = 'Staff On Leave';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Report "Staff On Leave";
            }
            action("Leave Grant Paid")
            {
                ApplicationArea = All;
                Caption = 'Leave Grant Paid';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Report "Leave Grant Paid";
            }
            action("Excuse Duty")
            {
                ApplicationArea = All;
                Caption = 'Excuse Duty';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Report "Excuse Duty";
            }
        }
    }
}
