page 52055 "HOD Leave Apps - Approval"
{
    // version THL- HRM 1.0
    Caption = 'HOD Leave Application Pending Approval';
    CardPageID = "HOD Leave App - Approval";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Leave Application";
    SourceTableView = WHERE("HOD Created"=CONST(true), Status=CONST("Pending Approval"));

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
    }
    actions
    {
        area(processing)
        {
            action("Create Employee Leave Entitlements")
            {
                ApplicationArea = All;
                Image = CreateSerialNo;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Create Leave Entitlement";
                Visible = false;
            }
            action("Employee Leave Balances")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Leave Balance";
                Visible = false;
            }
            action("Outstanding Leave Days")
            {
                ApplicationArea = All;
                Caption = 'Outstanding Leave Days';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Outstanding Leave Days";
                Visible = false;
            }
            action("Staff On Leave")
            {
                ApplicationArea = All;
                Caption = 'Staff On Leave';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Staff On Leave";
                Visible = false;
            }
            action("Leave Grant Paid")
            {
                ApplicationArea = All;
                Caption = 'Leave Grant Paid';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Leave Grant Paid";
                Visible = false;
            }
            action("Excuse Duty")
            {
                ApplicationArea = All;
                Caption = 'Excuse Duty';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Excuse Duty";
                Visible = false;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        UserRec.Reset;
        if UserRec.Get(UserId)then Emp.Reset;
        if Emp.Get(UserRec."Employee No.")then Rec.SetRange("Global Dimension 1 Code", Emp."Global Dimension 1 Code");
    end;
    trigger OnOpenPage()
    begin
        UserRec.Reset;
        if UserRec.Get(UserId)then Emp.Reset;
        if Emp.Get(UserRec."Employee No.")then Rec.SetRange("Global Dimension 1 Code", Emp."Global Dimension 1 Code");
    end;
    var Employee: Record Employee;
    UserRec: Record "User Setup";
    Emp: Record Employee;
}
