page 51601 "SS Leave Application - Open"
{
    // version THL- HRM 1.0
    Caption = 'New Leave Application';
    PageType = Card;
    SourceTable = "Employee Leave Application";
    SourceTableView = WHERE(Status=CONST(Open));
    PromotedActionCategories = 'Submit,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(content)
        {
            group(Application)
            {
                Caption = 'Application';

                field("Leave Plan"; Rec."Leave Plan")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Type';
                    NotBlank = true;

                    trigger OnValidate()
                    var
                        LeavePlanHeader: Record "Employee Leave Plan Header";
                    begin
                        LeavePlanHeader.Reset;
                        LeavePlanHeader.SetRange("Fiscal Start Date", rec."Fiscal Start Date");
                        LeavePlanHeader.SetRange("Maturity Date", rec."Maturity Date");
                        LeavePlanHeader.FindFirst;
                        if LeavePlanHeader.Get('ANNUAL')then begin
                            if LeavePlanHeader.IsEmpty then begin
                                if LeavePlanHeader.Status <> LeavePlanHeader.Status::Released then Error('You must have a leave plan to start application');
                            end;
                        end;
                    end;
                }
                // field(Reason; Rec.Reason)
                // {
                //     ApplicationArea = All;
                //     MultiLine = true;
                // }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Approver Email"; Rec."Approver Email")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Requestor Email"; Rec."Requestor Email")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            group(Balances)
            {
                Caption = 'Balances';

                field("Leave Entitlment"; Rec."Leave Entitlment")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Balance brought forward"; Rec."Balance brought forward")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Earned to Date';
                    Editable = false;
                }
                field("Total Leave Days Taken"; Rec."Total Leave Days Taken")
                {
                    ApplicationArea = All;
                    Caption = 'No of Days Taken To Date';
                    Editable = false;
                }
                field("Recalled Days"; Rec."Recalled Days")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Days Absent"; Rec."Days Absent")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Off Days"; Rec."Off Days")
                {
                    ApplicationArea = All;
                    Caption = 'Off Days';
                    Editable = false;
                }
                field("Leave balance"; Rec."Leave balance")
                {
                    ApplicationArea = All;
                    Caption = 'Available Leave Balance';
                    Editable = false;
                }
            }
            group("Current Application Details")
            {
                Caption = 'Current Application Details';

                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date of Application';
                    Editable = false;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                    NotBlank = true;

                    trigger OnValidate()
                    begin
                        if(Rec."Leave Code" <> 'SICK') and (Rec."Days Applied" > Rec."Leave balance")then Error('The days applied for are more than your leave balance');
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Start Date" < Today then Error('You cannot backdate a Leave Application');
                    end;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Resumption Date"; Rec."Resumption Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    NotBlank = true;
                }
                field("Annual Leave Entitlement Bal"; Rec."Annual Leave Entitlement Bal")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Balance';
                    Editable = false;
                }
                field("Leave Allowance Payable"; Rec."Leave Allowance Payable")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        if Rec."Leave Allowance Payable" = Rec."Leave Allowance Payable"::Yes then begin
                            AccPeriod.Reset;
                            AccPeriod.SetRange(AccPeriod."Starting Date", 0D, Today);
                            AccPeriod.SetRange(AccPeriod."New Fiscal Year", true);
                            if AccPeriod.Find('+')then FiscalStart:=AccPeriod."Starting Date";
                            //MESSAGE('%1',FiscalStart);
                            FiscalEnd:=CalcDate('1Y', FiscalStart) - 1;
                            //MESSAGE('%1',FiscalEnd);
                            assmatrix.Reset;
                            assmatrix.SetRange(assmatrix."Payroll Period", FiscalStart, FiscalEnd);
                            assmatrix.SetRange(assmatrix."Employee No", Rec."Employee No");
                            assmatrix.SetRange(assmatrix.Type, assmatrix.Type::Payment);
                            assmatrix.SetRange(assmatrix.Code, HRSetup."Leave Allowance Code");
                            if assmatrix.Find('-')then begin
                                LeaveAllowancePaid:=true;
                                Message('Your leave allowance for this year has already been paid on %1', assmatrix."Payroll Period");
                            end;
                        end;
                    end;
                }
                field("Duties Taken Over By"; Rec."Duties Taken Over By")
                {
                    ApplicationArea = All;
                }
                field("Reliever Name"; Rec."Reliever Name")
                {
                    ApplicationArea = All;
                }
                field("No. of Approvals"; Rec."No. of Approvals")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pending Approver"; Rec."Pending Approver")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Address During Leave';
                    MultiLine = true;
                    Visible = true;
                }
                field("Alternative Email Address"; Rec."Alternative Email Address")
                {
                    ApplicationArea = All;
                }
                field("Alternative Phone No."; Rec."Alternative Phone No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "Document Attachment Details")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("Application No"), "Table ID"=CONST(51602);
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

                // PromotedOnly = true;
                // RunObject = Page "Document Attachment Details";
                // // RunObject = Page "Leave Apps Documents";
                // RunPageLink = "No." = FIELD("Application No"),
                //               "Table ID" = CONST(51602);
                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            }
            action("Leave Application Form")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("Application No", Rec."Application No");
                    REPORT.Run(Report::"Leave Application", true, false, Rec);
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    LeaveSetupEmail: List of[Text];
                begin
                    Rec.TestField("Leave Code");
                    Rec.TestField("Start Date");
                    Rec.TestField("Days Applied");
                    Rec.TestField("Duties Taken Over By");
                    HRCommunications.HRLeaveNotification(Rec);
                    // HRCommunications.LeaveRelieverNotification(Rec);
                    // HRCommunications.LeaveEmployeeNotification(Rec);
                    ApprovalsMgt.OnSendLeaveForApproval(Rec);
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status:=Rec.Status::Open;
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID", UserId);
    end;
    var assmatrix: Record "Payroll Matrix";
    AccPeriod: Record "Payroll Period";
    LeaveAllowancePaid: Boolean;
    FiscalStart: Date;
    FiscalEnd: Date;
    HRSetup: Record "QuantumJumps HR Setup";
    ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    LeaveSetup: Record "Leave Setup";
    CompInfo: Record "Company Information";
    HRCommunications: Codeunit "HR Communication Management";
    Employee: Record Employee;
}
