page 51497 "SS Staff Displinary Cases"
{
    // version THL- HRM 1.0
    Caption = 'Staff Displinary Cases';
    CardPageID = "SS Staff Disciplinary Case";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Staff Disciplinary";
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater("Employee Details")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
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
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control23; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Accept")
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = Rec.Status = Rec.Status::Accusations;

                trigger OnAction()
                begin
                    Rec.TestField("Staff Response/Defense");
                    If Confirm(StrSubstNo(Text000, Rec."No."), false) = true then begin
                        Rec.Validate(Status, Rec.Status::Accepted);
                        Rec.Modify(true);
                    end
                    else
                    begin
                        exit;
                    end;
                end;
            }
            action("Reject")
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = Rec.Status = Rec.Status::Accusations;

                trigger OnAction()
                begin
                    Rec.TestField("Staff Response/Defense");
                    If Confirm(Text001, false) = true then begin
                        Rec.Validate(Status, Rec.Status::Rejected);
                        Rec.Modify(true);
                    end
                    else
                    begin
                        exit;
                    end;
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        QuantumpJumpUserSetup.Reset();
        QuantumpJumpUserSetup.SetRange("User ID", UserId);
        If QuantumpJumpUserSetup.FindFirst()then begin
            Rec.SetRange("Employee No", QuantumpJumpUserSetup."Employee No.");
        end
        else
            Error(Text002);
    end;
    var Text000: Label 'You have accepted the accuisitions as stated on %1, Do you wish to submit yor Response?';
    Text001: Label 'You have Rejected the accuisitions as stated on %1, Do you wish to submit yor Response?';
    Text002: Label 'You QuantumJump havent been set please Contact Admin';
    QuantumpJumpUserSetup: Record "User Setup";
}
