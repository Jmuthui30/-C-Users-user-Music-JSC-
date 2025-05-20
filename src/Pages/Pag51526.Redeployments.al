page 51526 "Redeployments"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Redeployment;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("From Dimension 1 Code"; Rec."From Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("From Dimension 2 Code"; Rec."From Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("From Establishment"; Rec."From Establishment")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("From Title"; Rec."From Title")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("From Grade"; Rec."From Grade")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("From Level"; Rec."From Level")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("To Dimension 1 Code"; Rec."To Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("To Dimension 2 Code"; Rec."To Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("To Establishment"; Rec."To Establishment")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("To Title"; Rec."To Title")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("To Grade"; Rec."To Grade")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("To Level"; Rec."To Level")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Old Line Manager"; Rec."Old Line Manager")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("New Line Manager"; Rec."New Line Manager")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                ApplicationArea = All;
                Image = Approve;
                Visible = OpenVisible;
                Caption = 'Approve';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange(Select, true);
                    Rec.SetRange("Selected By", UserId);
                    Rec.SetRange(Status, Rec.Status::New);
                    if Rec.FindSet()then begin
                        repeat EmpMgt.ApproveRedeployment(Rec);
                        until Rec.Next() = 0;
                    end;
                    message('Redeployment Approved');
                end;
            }
            action(NotifyOldLineManager)
            {
                ApplicationArea = All;
                Image = Approve;
                Visible = ApprovedVisible;
                Caption = 'Notify Old Line Manager';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange(Select, true);
                    Rec.SetRange("Selected By", UserId);
                    Rec.SetRange(Status, Rec.Status::Approved);
                    if Rec.FindSet()then begin
                        repeat EmpMgt.NotifyOldLineManager(Rec);
                        until Rec.Next() = 0;
                    end;
                    message('Old Line Manager(s) Notified');
                end;
            }
            action(NotifyNewLineManager)
            {
                ApplicationArea = All;
                Image = Approve;
                Visible = OldLineManagerNotifiedVisible;
                Caption = 'Notify New Line Manager';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange(Select, true);
                    Rec.SetRange("Selected By", UserId);
                    Rec.SetRange(Status, Rec.Status::"Old Line Manager Notified");
                    if Rec.FindSet()then begin
                        repeat EmpMgt.NotifyNewLineManager(Rec);
                        until Rec.Next() = 0;
                    end;
                    message('New Line Manager(s) Notified');
                end;
            }
            action(SendRedeploymentLetter)
            {
                ApplicationArea = All;
                Image = Approve;
                Visible = NewLineManagerNotifiedVisible;
                Caption = 'Send Redeployment Letter';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange(Select, true);
                    Rec.SetRange("Selected By", UserId);
                    Rec.SetRange(Status, Rec.Status::"New Line Manager Notified");
                    if Rec.FindSet()then begin
                        repeat EmpMgt.SendRedeploymentLetter(Rec);
                        until Rec.Next() = 0;
                    end;
                    message('Redeployment Letter Sent');
                end;
            }
            action(Complete)
            {
                ApplicationArea = All;
                Image = Approve;
                Visible = LetterSentVisible;
                Caption = 'Complete';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange(Select, true);
                    Rec.SetRange("Selected By", UserId);
                    Rec.SetRange(Status, Rec.Status::"Redeployment Letter Sent");
                    if Rec.FindSet()then begin
                        repeat EmpMgt.CompleteRedeployment(Rec);
                        until Rec.Next() = 0;
                    end;
                    message('Redeployment Completed');
                end;
            }
            action(StepDown)
            {
                ApplicationArea = All;
                Image = Approve;
                Visible = NotCompletedVisible;
                Caption = 'Step Down';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange(Select, true);
                    Rec.SetRange("Selected By", UserId);
                    if Rec.FindSet()then begin
                        repeat EmpMgt.StepDown(Rec);
                        until Rec.Next() = 0;
                    end;
                    message('Redeployment Stepped Down');
                end;
            }
            action(Reactivate)
            {
                ApplicationArea = All;
                Image = Approve;
                Visible = SteppedDownVisible;
                Caption = 'Reactivate Redeployment';

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange(Select, true);
                    Rec.SetRange("Selected By", UserId);
                    Rec.SetRange(Status, Rec.Status::"Stepped Down");
                    if Rec.FindSet()then begin
                        repeat EmpMgt.Reactivate(Rec);
                        until Rec.Next() = 0;
                    end;
                    message('Redeployment Reactivated');
                end;
            }
        }
    }
    trigger OnInit()
    begin
        OpenVisible:=false;
        ApprovedVisible:=false;
        OldLineManagerNotifiedVisible:=false;
        NewLineManagerNotifiedVisible:=false;
        LetterSentVisible:=false;
        CompletedVisible:=false;
        SteppedDownVisible:=false;
        NotCompletedVisible:=true;
    end;
    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::New then OpenVisible:=true;
        if Rec.Status = Rec.Status::Approved then ApprovedVisible:=true;
        if Rec.Status = Rec.Status::"Old Line Manager Notified" then OldLineManagerNotifiedVisible:=true;
        if Rec.Status = Rec.Status::"New Line Manager Notified" then NewLineManagerNotifiedVisible:=true;
        if Rec.Status = Rec.Status::"Redeployment Letter Sent" then LetterSentVisible:=true;
        if Rec.Status = Rec.Status::"Redeployment Completed" then CompletedVisible:=true;
        if Rec.Status = Rec.Status::"Stepped Down" then SteppedDownVisible:=true;
        if Rec.Status = Rec.Status::"Redeployment Completed" then NotCompletedVisible:=false;
    end;
    trigger OnAfterGetRecord()
    begin
        if Rec.Status = Rec.Status::New then OpenVisible:=true;
        if Rec.Status = Rec.Status::Approved then ApprovedVisible:=true;
        if Rec.Status = Rec.Status::"Old Line Manager Notified" then OldLineManagerNotifiedVisible:=true;
        if Rec.Status = Rec.Status::"New Line Manager Notified" then NewLineManagerNotifiedVisible:=true;
        if Rec.Status = Rec.Status::"Redeployment Letter Sent" then LetterSentVisible:=true;
        if Rec.Status = Rec.Status::"Redeployment Completed" then CompletedVisible:=true;
        if Rec.Status = Rec.Status::"Stepped Down" then SteppedDownVisible:=true;
    end;
    var myInt: Integer;
    OpenVisible: Boolean;
    ApprovedVisible: Boolean;
    OldLineManagerNotifiedVisible: Boolean;
    NewLineManagerNotifiedVisible: Boolean;
    LetterSentVisible: Boolean;
    CompletedVisible: Boolean;
    SteppedDownVisible: Boolean;
    NotCompletedVisible: Boolean;
    EmpMgt: Codeunit "Employee Management";
}
