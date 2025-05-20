page 51610 "Leave Application - Open"
{
    // version THL- HRM 1.0
    Caption = 'Leave Application For Employee';
    PageType = Card;
    SourceTable = "Employee Leave Application";
    // SourceTableView = WHERE("HR Created"=CONST(true), "SSP Created"=const(false), Status=CONST(Open));
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(content)
        {
            group(Application)
            {
                Caption = 'Application';

                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field(Name; Rec.Name)
                {
                    Editable = false;
                    Visible = true;
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    Editable = true;
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    Caption = 'Leave Type';
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    MultiLine = true;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("HR Created"; "HR Created")
                {
                    ApplicationArea = All;
                }
                //field(Status; Status) { }
                field("SSP Created"; "SSP Created")
                {
                    ApplicationArea = All;
                }

                field("Approver Email"; Rec."Approver Email")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Requestor Email"; Rec."Requestor Email")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(PowerApps; Rec.PowerApps)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            group(Balances)
            {
                Caption = 'Balances';

                field("Leave Entitlment"; Rec."Leave Entitlment")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Balance brought forward"; Rec."Balance brought forward")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    Caption = 'Leave Earned to Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Total Leave Days Taken"; Rec."Total Leave Days Taken")
                {
                    Caption = 'No of Days Taken To Date';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Recalled Days"; Rec."Recalled Days")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Days Absent"; Rec."Days Absent")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Off Days"; Rec."Off Days")
                {
                    Caption = 'Off Days';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Leave balance"; Rec."Leave balance")
                {
                    Caption = 'Available Leave Balance';
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Current Application Details")
            {
                Caption = 'Current Application Details';

                field("Application Date"; Rec."Application Date")
                {
                    Caption = 'Date of Application';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                    NotBlank = true;

                    trigger OnValidate()
                    begin
                        if (Rec."Leave Code" <> 'SICK') and (Rec."Days Applied" > Rec."Leave balance") then Error('The days applied for are more than your leave balance');
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Resumption Date"; Rec."Resumption Date")
                {
                    Editable = false;
                    NotBlank = true;
                    ApplicationArea = All;
                }
                field("Annual Leave Entitlement Bal"; Rec."Annual Leave Entitlement Bal")
                {
                    Caption = 'Leave Balance';
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Leave Allowance Payable"; Rec."Leave Allowance Payable")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Leave Allowance Payable" = Rec."Leave Allowance Payable"::Yes then begin
                            AccPeriod.Reset;
                            AccPeriod.SetRange(AccPeriod."Starting Date", 0D, Today);
                            AccPeriod.SetRange(AccPeriod."New Fiscal Year", true);
                            if AccPeriod.Find('+') then FiscalStart := AccPeriod."Starting Date";
                            //MESSAGE('%1',FiscalStart);
                            FiscalEnd := CalcDate('1Y', FiscalStart) - 1;
                            //MESSAGE('%1',FiscalEnd);
                            assmatrix.Reset;
                            assmatrix.SetRange(assmatrix."Payroll Period", FiscalStart, FiscalEnd);
                            assmatrix.SetRange(assmatrix."Employee No", Rec."Employee No");
                            assmatrix.SetRange(assmatrix.Type, assmatrix.Type::Payment);
                            assmatrix.SetRange(assmatrix.Code, HRSetup."Leave Allowance Code");
                            if assmatrix.Find('-') then begin
                                LeaveAllowancePaid := true;
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
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Pending Approver"; Rec."Pending Approver")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    Caption = 'Address During Leave';
                    MultiLine = true;
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
            action("Send Approval Request")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Send A&pproval Request';
                //Enabled = ;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Request approval of the document.';

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Open);
                    ApprovalsMgmtExt.OnSendLeaveForApproval(Rec);
                    CurrPage.Close();
                end;
            }
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
            action("View SharePoint Documents")
            {
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec."SharePoint Link" = '' then
                        Error('There is no link to documents uploaded in SharePoint. Please contact the SharePoint Administrator.')
                    else
                        HyperLink(Rec."SharePoint Link");
                end;
            }
            action("Leave Application Form")
            {
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("Application No", Rec."Application No");
                    REPORT.Run(51600, true, false, Rec);
                end;
            }
            action(Approve)
            {
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Rec.TestField("Employee No");
                    Rec.TestField("Days Applied");
                    Rec.TestField("Resumption Date");
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.TestField("Duties Taken Over By");
                    Rec.Validate(Status, Rec.Status::Released);
                    Rec.Modify;
                end;
            }
        }
    }
    trigger OnInit()
    begin
        Rec."HR Created" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."HR Created" := true;
    end;

    var
        ApprovalsMgmtExt: Codeunit "Approvals Mgmt. Ext";
        assmatrix: Record "Payroll Matrix";
        AccPeriod: Record "Payroll Period";
        LeaveAllowancePaid: Boolean;
        FiscalStart: Date;
        FiscalEnd: Date;
        HRSetup: Record "QuantumJumps HR Setup";
}
