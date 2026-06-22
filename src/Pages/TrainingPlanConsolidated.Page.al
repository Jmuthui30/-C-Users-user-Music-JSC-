page 52976 "Consolidated Training Plan"
{
    ApplicationArea = All;
    Caption = 'Consolidated Training Plan';
    CardPageID = "Training Need";
    PageType = List;
    SourceTable = "Training Need";
    SourceTableView = sorting("Start Date") where(Status = filter(Open | "Pending Plan Approval" | "Approved Plan" | Application));
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the training need number.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the planned training description.';
                }
                field("Need Source"; Rec."Need Source")
                {
                    ToolTip = 'Specifies the source of the training need.';
                }
                field("Source Assessment No."; Rec."Source Assessment No.")
                {
                    ToolTip = 'Specifies the approved assessment that created the training need.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the planned start date.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the planned end date.';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Specifies the planned training location.';
                }
                field(Provider; Rec.Provider)
                {
                    ToolTip = 'Specifies the training provider.';
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    ToolTip = 'Specifies the training provider name.';
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    ToolTip = 'Specifies the budgeted cost of training.';
                }
                field("Cost Of Training (LCY)"; Rec."Cost Of Training (LCY)")
                {
                    ToolTip = 'Specifies the budgeted cost of training in LCY.';
                }
                field("No. of Participants"; Rec."No. of Participants")
                {
                    ToolTip = 'Specifies the number of approved participants.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the training plan status.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Plan For Approval")
            {
                ApplicationArea = All;
                Caption = 'Send Plan For Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::Open;
                ToolTip = 'Mark this planned training need as pending plan approval.';

                trigger OnAction()
                begin
                    ValidatePlanForApproval();
                    Rec.Status := Rec.Status::"Pending Plan Approval";
                    Rec.Modify(true);
                end;
            }
            action("Approve Plan")
            {
                ApplicationArea = All;
                Caption = 'Approve Plan';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::"Pending Plan Approval";
                ToolTip = 'Approve this planned training need before scheduling.';

                trigger OnAction()
                begin
                    ValidatePlanForApproval();
                    Rec.Status := Rec.Status::"Approved Plan";
                    Rec.Modify(true);
                end;
            }
            action("Open For Application")
            {
                ApplicationArea = All;
                Caption = 'Open For Application';
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::"Approved Plan";
                ToolTip = 'Open the approved and scheduled training plan for staff application.';

                trigger OnAction()
                var
                    HRNotifications: Codeunit "HR Notifications";
                begin
                    ValidateScheduleForApplication();
                    Rec.Status := Rec.Status::Application;
                    Rec.Modify(true);

                    if Confirm('Do you want to notify proposed participants by mail?', false) then
                        HRNotifications.NotifyTrainingNeeds(Rec);
                end;
            }
            action("Reopen Plan")
            {
                ApplicationArea = All;
                Caption = 'Reopen Plan';
                Image = ReOpen;
                Promoted = true;
                PromotedCategory = Process;
                Visible = (Rec.Status = Rec.Status::"Pending Plan Approval") or (Rec.Status = Rec.Status::"Approved Plan");
                ToolTip = 'Return this plan item to open status for updates.';

                trigger OnAction()
                begin
                    Rec.Status := Rec.Status::Open;
                    Rec.Modify(true);
                end;
            }
        }
    }

    local procedure ValidatePlanForApproval()
    begin
        Rec.TestField(Description);
        Rec.CalcFields("Cost Of Training");
        if Rec."Cost Of Training" = 0 then
            Error('Add at least one budget line before sending this training plan for approval.');
    end;

    local procedure ValidateScheduleForApplication()
    begin
        ValidatePlanForApproval();
        Rec.TestField("Start Date");
        Rec.TestField("End Date");
        Rec.TestField(Provider);
    end;
}
