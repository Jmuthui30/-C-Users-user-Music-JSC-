page 51967 "Employee Leave Plan-Approved"
{
    Editable = false;
    PageType = Card;
    SourceTable = "Employee Leave Plan Header";
    SourceTableView = where //(Status = const(Released),
    ("HOD Created"=const(false));

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
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Date Of Joining Company"; Rec."Date Of Joining Company")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Fiscal Start Date"; Rec."Fiscal Start Date")
                {
                    ApplicationArea = All;
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    ApplicationArea = All;
                }
                field("Leave Entitlement"; Rec."Leave Entitlement")
                {
                    ApplicationArea = All;
                }
                field("Days in Plan"; Rec."Days in Plan")
                {
                    ApplicationArea = All;
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    ApplicationArea = All;
                }
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    ApplicationArea = All;
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
                    Visible = false;

                    trigger OnAction()
                    begin
                    /*
                        IF ApprovalMgt.SendLeavePlanApprovalRequest(Rec) THEN;
                        
                        TESTFIELD("Application No");
                        //TESTFIELD("Days Applied");
                        TESTFIELD("Leave Code");
                        */
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
                    Visible = false;

                    trigger OnAction()
                    begin
                    //IF ApprovalMgt.CancelLeavePlanApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                action(RePlan)
                {
                    ApplicationArea = All;
                    Image = Replan;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        EmployeeLeavePlan.Reset;
                        EmployeeLeavePlan.SetRange("Application No", Rec."Application No");
                        EmployeeLeavePlan.SetRange("Employee No", Rec."Employee No");
                        if EmployeeLeavePlan.FindSet then repeat begin
                                EmployeeLeavePlan."Approval Date":=0D;
                                EmployeeLeavePlan."Approved Days":=0;
                                EmployeeLeavePlan."Approved Start Date":=0D;
                                EmployeeLeavePlan."Approved End Date":=0D;
                                EmployeeLeavePlan.Status:=EmployeeLeavePlan.Status::Open;
                                EmployeeLeavePlan.Modify;
                            end;
                            until EmployeeLeavePlan.Next = 0;
                        Rec.Status:=Rec.Status::Open;
                        Rec.Modify;
                    end;
                }
            }
        }
    }
    var ApprovalMgt: Codeunit "Approvals Mgmt.";
    Mail: Codeunit Mail;
    UserSetup: Record "User Setup";
    EmployeeLeavePlan: Record "Employee Leave Plan";
}
