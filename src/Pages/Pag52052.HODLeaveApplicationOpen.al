page 52052 "HOD Leave Application - Open"
{
    // version THL- HRM 1.0
    Caption = 'HOD Leave Application for Employee';
    PageType = Card;
    SourceTable = "Employee Leave Application";
    SourceTableView = WHERE("HOD Created"=CONST(true), Status=CONST(Open));

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

                    trigger OnLookup(var Text: Text): Boolean begin
                        if UserRec.Get(UserId)then begin
                            UserRec.TestField("Employee No.");
                            if NAVEmp.Get(UserRec."Employee No.")then begin
                                NAVEmp.TestField("Global Dimension 1 Code");
                                Emp.Reset;
                                Emp.SetRange("Global Dimension 1 Code", NAVEmp."Global Dimension 1 Code");
                                if PAGE.RunModal(0, Emp) = ACTION::LookupOK then begin
                                    Rec."Employee No":=Emp."No.";
                                    Rec.Validate("Employee No");
                                end;
                            end;
                        end;
                    end;
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
                    Editable = true;
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
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
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
                field(PowerApps; Rec.PowerApps)
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
                field("Leave Allowance Payable"; Rec."Leave Allowance Payable")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Address During Leave';
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("View SharePoint Documents")
            {
                ApplicationArea = All;
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."SharePoint Link" = '' then Error('There is no link to documents uploaded in SharePoint. Please contact the SharePoint Administrator.')
                    else
                        HyperLink(Rec."SharePoint Link");
                end;
            }
            action("Leave Application Form")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("Application No", Rec."Application No");
                    REPORT.Run(51600, true, false, Rec);
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Employee No");
                    Rec.TestField("Days Applied");
                    Rec.TestField("Resumption Date");
                    Rec.TestField(Status, Rec.Status::Open);
                    Rec.TestField("Duties Taken Over By");
                    Rec.Status:=Rec.Status::Released;
                    Rec.Modify;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Leave Code");
                    Rec.TestField("Start Date");
                    Rec.TestField("Days Applied");
                    Rec.TestField("Duties Taken Over By");
                    ApprovalsMgt.OnSendLeaveForApproval(Rec);
                /*
                    IF LeaveSetup.GET("Leave Code") THEN  BEGIN
                      IF LeaveSetup."Notify on Application" THEN BEGIN
                        IF LeaveSetup."Email Address" <> '' THEN BEGIN
                          SMTPSetup.GET;
                          CompInfo.GET;
                          SMTPMail.CreateMessage(CompInfo.Name,SMTPSetup."User ID",LeaveSetup."Email Address",'NOTICE OF LEAVE APPLICATION'+'-'+UPPERCASE(Name),'',TRUE);
                    
                          //SMTPMail.AddCC(LeaveSetup."Email Address");
                          SMTPMail.AppendBody('Hello,');
                          SMTPMail.AppendBody('<br><br>');
                          SMTPMail.AppendBody('This is to bring to your notice that'+' '+Name+' '+'has applied for '+"Leave Code"+' '+'leave.');
                          SMTPMail.AppendBody('<br><br>');
                          SMTPMail.AppendBody('He/she intends to take '+FORMAT("Days Applied")+' '+'day(s) beginning '+FORMAT("Start Date",0,4)+' '+'to resume on '+FORMAT("Resumption Date",0,4)+'.');
                          SMTPMail.AppendBody('<br><br>');
                          SMTPMail.AppendBody('Should you have any reservations, kindly contact the direct approvers involved.');
                          SMTPMail.AppendBody('<br><br>');
                          SMTPMail.AppendBody('Thank you.');
                          SMTPMail.AppendBody('<br><br>');
                          SMTPMail.AppendBody('Yours Sincerely,');
                          SMTPMail.AppendBody('<br><br>');
                          SMTPMail.AppendBody('<b>Dynamics NAV Notifications<b>');
                          SMTPMail.AppendBody('<br>');
                          CompInfo.GET;
                          SMTPMail.AppendBody(CompInfo.Name);
                          SMTPMail.AppendBody('<br>');
                          SMTPMail.Send;
                        END;
                      END;
                    END;
                    */
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        UserRec.Reset;
        if UserRec.Get(UserId)then Emp.Reset;
        if Emp.Get(UserRec."Employee No.")then Rec.SetRange("Global Dimension 1 Code", Emp."Global Dimension 1 Code");
    end;
    trigger OnInit()
    begin
        Rec."HOD Created":=true;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."HOD Created":=true;
    end;
    trigger OnOpenPage()
    begin
        UserRec.Reset;
        if UserRec.Get(UserId)then Emp.Reset;
        if Emp.Get(UserRec."Employee No.")then Rec.SetRange("Global Dimension 1 Code", Emp."Global Dimension 1 Code");
    end;
    var ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    LeaveSetup: Record "Leave Setup";
    SMTPSetup: Record "Email Account";
    CompInfo: Record "Company Information";
    SMTPMail: Codeunit EMail;
    Names: Text[250];
    Employee: Record Employee;
    UserRec: Record "User Setup";
    Emp: Record Employee;
    NAVEmp: Record "Employee Master";
}
