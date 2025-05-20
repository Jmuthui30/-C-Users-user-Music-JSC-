page 51964 "SS Employee Leave Plan"
{
    PageType = Card;
    SourceTable = "Employee Leave Plan Header";
    SourceTableView = WHERE("HOD Created"=CONST(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Of Joining Company"; Rec."Date Of Joining Company")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Fiscal Start Date"; Rec."Fiscal Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Entitlement"; Rec."Leave Entitlement")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Days in Plan"; Rec."Days in Plan")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control1; "SS Employee Plan Details")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No"=FIELD("Employee No"), "Application No"=FIELD("Application No");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Leave Plan")
            {
                Caption = 'Leave Plan';

                action("Send Leave Plan")
                {
                    ApplicationArea = All;
                    Caption = 'Send Leave Plan';
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField("Application No");
                        Rec.TestField("Leave Code");
                        ApprovalsMgt.OnSendLeavePlanForApproval(Rec);
                    //TESTFIELD("Days Applied");
                    //days:= "Days Applied";
                    /*
                        Mail.NewIncidentMail('hrgrp@erc.go.ke', 'Leave Plan No ' +  "Application No" ,'This is a notification that '+ "Employee Name" +
                        ' entitled to '+FORMAT("Leave Entitlement")+' leave days'
                        +' has forwarded a leave plan for the period between '+FORMAT("Fiscal Start Date")+' and '+FORMAT("Maturity Date")
                        // of ' + FORMAT("Days Applied") + ' days from ' + FORMAT("Start Date")  + ' to ' +  FORMAT("End Date")
                        );
                        
                        IF "Leave Allowance Payable"="Leave Allowance Payable"::Yes THEN BEGIN
                        Mail.NewIncidentMail('finance@erc.go.ke', 'Leave App No ' +  "Application No" , "Employee Name" +
                        ' has applied ' + FORMAT("Days Applied") + ' days from ' + FORMAT("Start Date")  + ' to ' +  FORMAT("End Date"));
                         END
                        */
                    end;
                }
                action("Cancel Leave Plan")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Leave Plan';
                    Image = Cancel;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        ApprovalsMgt.OnCancelLeavePlanApprovalRequest(Rec);
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID", UserId);
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status:=Rec.Status::Open;
    end;
    var ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    Mail: Codeunit 397;
    UserSetup: Record "User Setup";
    local procedure OnAfterGetCurrRecord()
    begin
        xRec:=Rec;
        if Rec.Status = Rec.Status::Released then CurrPage.Editable:=false
        else
            CurrPage.Editable:=true;
    end;
}
