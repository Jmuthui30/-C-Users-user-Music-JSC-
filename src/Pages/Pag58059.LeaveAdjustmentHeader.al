page 58059 "Leave Adjustment Header"
{
    ApplicationArea = All;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Approvals';
    SourceTable = "Leave Bal Adjustment Header";
    Caption = 'Leave Adjustment Header';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Maturity Date"; Rec."Maturity Date")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Maturity Date field';
                }
                field(EnteredBy; Rec.EnteredBy)
                {
                    ToolTip = 'Specifies the value of the EnteredBy field';
                }
                field(Comments; Rec.Comments)
                {
                    ToolTip = 'Specifies the value of the Comments field';
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Transaction Type field';
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                group(History)
                {
                    Editable = false;

                    field(Posted; Rec.Posted)
                    {
                        ToolTip = 'Specifies the value of the Posted field';
                    }
                    field("Posted By"; Rec."Posted By")
                    {
                        ToolTip = 'Specifies the value of the Posted By field';
                    }
                    field("Posted Date"; Rec."Posted Date")
                    {
                        ToolTip = 'Specifies the value of the Posted Date field';
                    }
                }
            }
            part(Control11; "Leave Adjustment Lines")
            {
                SubPageLink = "Header No." = field(Code);
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(BatchAllocation)
            {
                Enabled = Rec."Status" = Rec."Status"::Released;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Post action';
                Caption = 'Batch Allocation';

                trigger OnAction()
                begin
                    Rec.TestField(Posted, false);
                    Rec.TestField(Status, Rec.Status::Released);
                    if Confirm(Text001, false) then
                        //  HRMgnt.LeaveAdjustment(Rec.Code);
                        Message('succefully Uploaded');
                    CurrPage.Close();



                end;
            }
            action(Post)
            {
                Enabled = Rec."Status" = Rec."Status"::Released;
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Executes the Post action';

                trigger OnAction()
                begin
                    Rec.TestField(Posted, false);
                    Rec.TestField(Status, Rec.Status::Released);
                    if Confirm(Text001, false) then
                        HRMgnt.LeaveAdjustment(Rec.Code);
                    Message('succefully Uploaded');
                    CurrPage.Close();



                end;
            }
            action("Send For Approval")
            {
                Enabled = Rec."Status" = Rec."Status"::"Open";
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send For Approval action';

                trigger OnAction()
                begin
                    if ApprovalsMgmt.CheckLeaveAdjWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendLeaveAdjApproval(Rec);
                    //ApprovalsMgmt.OnsendLeaveAdjustmentForApproval(Rec);
                end;
            }
            action("Cancel Approval")
            {
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval action';

                trigger OnAction()
                begin
                    ApprovalsMgmt.OnCancelLeaveAdjApproval(Rec);
                end;
            }
            action(Approval)
            {
                Caption = 'Approvals';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Approvals action';

                trigger OnAction()
                var
                    ApprovalEntries: Page "Approval Entries";
                    DocType: Enum "Approval Document Type";
                begin
                    //DocType := DocType::LeaveAdjustment;
                    ApprovalEntries.SetRecordFilters(Database::"Leave Bal Adjustment Header", DocType, Rec.Code);
                    ApprovalEntries.Run();
                end;
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::"Leave Adjustment";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Transaction Type" := Rec."Transaction Type"::"Leave Adjustment";
    end;

    var
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
        // ApprovalsMgmt: Codeunit "Approvals Mgmt. Ext";


        HRMgnt: Codeunit "HR Management";
        //  HRMgnt: Codeunit ;
        Text001: Label 'Are you sure you want to post the leave adjustments?';
}





