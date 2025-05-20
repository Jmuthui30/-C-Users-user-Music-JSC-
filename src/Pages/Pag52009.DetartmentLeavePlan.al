page 52009 "Detartment Leave Plan"
{
    SourceTable = "Employee Leave Plan Header";
    SourceTableView = WHERE("HOD Created" = filter('Yes'), Status = CONST(Open));
    Caption = 'Head Of Unit Leave Plan';

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
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        dimension.RESET;
                        dimension.SETRANGE("Dimension Code", 'DEPARTMENT');
                        IF PAGE.RUNMODAL(0, dimension) = ACTION::LookupOK THEN BEGIN
                            Rec."Department Code" := dimension.Code;
                        END;
                    end;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;

                    // trigger OnLookup(var Text: Text): Boolean var
                    // begin
                    //     EmpRec.RESET;
                    //     EmpRec.SETRANGE("Global Dimension 1 Code", Rec."Department Code");
                    //     IF PAGE.RUNMODAL(0, EmpRec) = ACTION::LookupOK THEN BEGIN
                    //         Rec."Employee No":=EmpRec."No.";
                    //         Rec.VALIDATE("Employee No");
                    //     END;
                    // end;
                }
                field("Employee Name"; Rec."Employee Name")
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
            part(Control1; "Dep Employee Plan Details")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No" = FIELD("Employee No"), "Application No" = FIELD("Application No");
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
                action(ALApprove)
                {
                    ApplicationArea = All;
                    Image = Approve;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD("Employee No");
                        Rec.TESTFIELD("Department Code");
                        Rec.TESTFIELD("Days in Plan");
                        Rec.TESTFIELD(Status, Rec.Status::Open);
                        EmployeeLeavePlan.RESET;
                        EmployeeLeavePlan.SETRANGE("Application No", Rec."Application No");
                        EmployeeLeavePlan.SETRANGE("Employee No", Rec."Employee No");
                        IF EmployeeLeavePlan.FINDSET THEN
                            REPEAT BEGIN
                                EmployeeLeavePlan."Approval Date" := TODAY;
                                EmployeeLeavePlan."Approved Days" := EmployeeLeavePlan."Days Applied";
                                EmployeeLeavePlan."Approved Start Date" := EmployeeLeavePlan."Start Date";
                                EmployeeLeavePlan."Approved End Date" := EmployeeLeavePlan."End Date";
                                EmployeeLeavePlan.Status := EmployeeLeavePlan.Status::Released;
                                EmployeeLeavePlan."Department Code" := Rec."Department Code";
                                EmployeeLeavePlan.MODIFY;
                            END;
                            UNTIL EmployeeLeavePlan.NEXT = 0;
                        Rec.Status := Rec.Status::Released;
                        Rec.MODIFY;
                    end;
                }
                action(RePlan)
                {
                    ApplicationArea = All;
                    Image = Replan;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TESTFIELD(Status, Rec.Status::Released);
                        EmployeeLeavePlan.RESET;
                        EmployeeLeavePlan.SETRANGE("Application No", Rec."Application No");
                        EmployeeLeavePlan.SETRANGE("Employee No", Rec."Employee No");
                        IF EmployeeLeavePlan.FINDSET THEN
                            REPEAT BEGIN
                                EmployeeLeavePlan."Approval Date" := 0D;
                                EmployeeLeavePlan."Approved Days" := 0;
                                EmployeeLeavePlan."Approved Start Date" := 0D;
                                EmployeeLeavePlan."Approved End Date" := 0D;
                                EmployeeLeavePlan.Status := EmployeeLeavePlan.Status::Open;
                                EmployeeLeavePlan.MODIFY;
                            END;
                            UNTIL EmployeeLeavePlan.NEXT = 0;
                        Rec.Status := Rec.Status::Open;
                        Rec.MODIFY;
                    end;
                }
            }
        }
    }
    trigger OnInit()
    begin
        Rec."HOD Created" := TRUE;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."HOD Created" := TRUE;
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("User ID",USERID);
    end;

    var
        dimension: Record "Dimension Value";
        Mail: Codeunit 397;
        UserSetup: Record "User Setup";
        EmpRec: Record Employee;
        EmployeeLeavePlan: Record "Employee Leave Plan";
}
