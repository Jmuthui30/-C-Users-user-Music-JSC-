page 52010 "Dep Employee Plan Details"
{
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Employee Leave Plan";

    layout
    {
        area(content)
        {
            repeater(Control14)
            {
                ShowCaption = false;

                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                    Caption = 'No. Of Days';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Names; Names)
                {
                    ApplicationArea = All;
                    Caption = 'Names';
                    Editable = false;
                    Visible = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Approved Start Date"; Rec."Approved Start Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Verified By Manager"; Rec."Verified By Manager")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Approved End Date"; Rec."Approved End Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
    var Names: Text[250];
    Employee: Record Employee;
    UserRec: Record "User Setup";
    Emp: Record Employee;
    ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    Mail: Codeunit 365;
    d: Date;
    LeavePlanRec: Record "Employee Leave Plan";
}
