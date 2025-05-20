page 51527 "Employee Career Plan Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Employee;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    Caption = 'Role';
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1; "Educational Background")
            {
                ApplicationArea = All;
                Caption = 'Educational Background';
                SubPageLink = "Employee No."=FIELD("No.");
            }
            part(Control2; "Professional Background")
            {
                ApplicationArea = All;
                Caption = 'Professional Background';
                SubPageLink = "Employee No."=FIELD("No.");
            }
            part(Control3; "Employee Career Aspirations")
            {
                ApplicationArea = All;
                Caption = 'Career Aspirations';
                SubPageLink = "Employee No."=FIELD("No.");
            }
            part(Control4; "Employee Next Steps")
            {
                ApplicationArea = All;
                Caption = 'Possible Next Steps';
                SubPageLink = "Employee No."=FIELD("No.");
            }
            part(Control5; "Employee Last Roles")
            {
                ApplicationArea = All;
                Caption = 'Last 3 Roles';
                SubPageLink = "Employee No."=FIELD("No.");
            }
            group(Mobility)
            {
                Caption = 'Job Role Mobility';
                Editable = true;

                field("Job Mobility"; Rec."Job Mobility")
                {
                    ApplicationArea = All;
                    ToolTip = 'ToolTip: Are you mobile (Mobility refers to movement to roles within the ARM group of companies (ARM Pension inclusive), and/or to different locations within the current business unit of the employee)';
                }
                field("Job Mobility Preference"; Rec."Job Mobility Preference")
                {
                    ApplicationArea = All;
                }
                field("Other Mobility Considerations"; Rec."Other Mobility Considerations")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            group(Review)
            {
                Caption = 'Career Plan Review';
                Editable = false;

                field("Career Plan Submitted"; Rec."Career Plan Submitted")
                {
                    ApplicationArea = All;
                }
                field("Career Plan Reviewer"; Rec."Career Plan Reviewer")
                {
                    ApplicationArea = All;
                }
                field("Career Plan Approved"; Rec."Career Plan Approved")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Submit)
            {
                ApplicationArea = All;
                Caption = 'Submit';
                Promoted = true;
                PromotedIsBig = true;
                Image = Confirm;
                Visible = SubmitVisible;

                trigger OnAction()
                begin
                    Rec."Career Plan Submitted":=true;
                    if QJUserSetup.Get(UserId)then Rec."Career Plan Reviewer":=QJUserSetup."Immediate Supervisor"
                    else
                        Error('You have not been assigned an Immediate Supervisor on the system. Contact the Administrator.');
                    Rec.Modify();
                    message('Submitted.');
                    CurrPage.Update();
                end;
            }
            action(ReopenPlan)
            {
                ApplicationArea = All;
                Caption = 'Reopen';
                Promoted = true;
                PromotedIsBig = true;
                Image = Open;
                Visible = ReopenVisible;

                trigger OnAction()
                begin
                    Rec."Career Plan Submitted":=false;
                    Rec."Career Plan Approved":=false;
                    Rec.Modify();
                    message('Reopened');
                    CurrPage.Update();
                end;
            }
            action(ReviewerComments)
            {
                ApplicationArea = All;
                Caption = 'Line Manager Comments';
                Image = Alerts;
                Promoted = true;
                RunPageMode = Edit;
                RunObject = Page "Employee Career Review";
                RunPageLink = "Employee No."=FIELD("No.");
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Promoted = true;
                PromotedIsBig = true;
                Image = Approve;
                Visible = ApproveVisible;

                trigger OnAction()
                begin
                    Rec."Career Plan Approved":=true;
                    Rec.Modify();
                    message('Approved.');
                    CurrPage.Update();
                end;
            }
        }
        area(creation)
        {
            action("Education Verification Letter")
            {
                ApplicationArea = All;
                Caption = 'Education Verification Letter';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(51841, true, true, Rec);
                end;
            }
            action("Previous Employer Letter")
            {
                ApplicationArea = All;
                Caption = 'Previous Employer Letter';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(51404236, true, true, Rec);
                end;
            }
        }
    }
    trigger OnInit()
    begin
        SubmitVisible:=false;
        ApproveVisible:=false;
        ReopenVisible:=false;
    end;
    trigger OnOpenPage()
    begin
        //Submit
        if QJUserSetup.Get(UserId)then begin
            if QJUserSetup."Employee No." = Rec."No." then if Rec."Career Plan Submitted" = false then SubmitVisible:=true;
        end
        else
            Error('Your login has not been mapped to your employee profile. Kindly contact the Administrator.');
        //Approve
        if(UserId = Rec."Career Plan Reviewer") and (Rec."Career Plan Submitted" = true) and (Rec."Career Plan Approved" = false)then ApproveVisible:=true;
        //Reopen
        if Rec."Career Plan Submitted" = true then ReopenVisible:=true;
    end;
    trigger OnAfterGetRecord()
    begin
        //Submit
        if QJUserSetup.Get(UserId)then begin
            if QJUserSetup."Employee No." = Rec."No." then if Rec."Career Plan Submitted" = false then SubmitVisible:=true;
        end
        else
            Error('Your login has not been mapped to your employee profile. Kindly contact the Administrator.');
        //Approve
        if(UserId = Rec."Career Plan Reviewer") and (Rec."Career Plan Submitted" = true) and (Rec."Career Plan Approved" = false)then ApproveVisible:=true;
        //Reopen
        if Rec."Career Plan Submitted" = true then ReopenVisible:=true;
    end;
    trigger OnAfterGetCurrRecord()
    begin
        //Submit
        if QJUserSetup.Get(UserId)then begin
            ;
            if QJUserSetup."Employee No." = Rec."No." then if Rec."Career Plan Submitted" = false then SubmitVisible:=true;
        end
        else
            Error('Your login has not been mapped to your employee profile. Kindly contact the Administrator.');
        //Approve
        if(UserId = Rec."Career Plan Reviewer") and (Rec."Career Plan Submitted" = true) and (Rec."Career Plan Approved" = false)then ApproveVisible:=true;
        //Reopen
        if Rec."Career Plan Submitted" = true then ReopenVisible:=true;
    end;
    var KPACode: Code[20];
    SubmitVisible: Boolean;
    ApproveVisible: Boolean;
    ReopenVisible: Boolean;
    QJUserSetup: Record "User Setup";
}
