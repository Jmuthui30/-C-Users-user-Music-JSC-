page 51495 "Staff Displinary Cases"
{
    // version THL- HRM 1.0
    Caption = 'Staff Displinary Cases';
    CardPageID = "Staff Disciplinary Case";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Staff Disciplinary";
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
            action("Accuse")
            {
                ApplicationArea = All;
                Image = Account;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = Rec.Status = Rec.Status::New;

                trigger OnAction()
                begin
                    If Confirm(StrSubstNo(Text000, Rec."Employee Name", Rec."No."), false) = true then begin
                        Rec.Validate(Status, Rec.Status::Accusations);
                        Rec.Modify(true);
                    end
                    else
                    begin
                        exit;
                    end;
                end;
            }
            action("Action Taken")
            {
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = Rec.Status = Rec.Status::Accepted;

                trigger OnAction()
                begin
                    Rec.TestField("Remarks HR");
                    Rec.TestField(Status, Rec.Status::Accepted);
                    If Confirm(Text001, false) = true then begin
                        Rec.Validate(Status, Rec.Status::"Action Taken");
                        Rec.Modify(true);
                    end
                    else
                    begin
                        exit;
                    end;
                end;
            }
            action("Close")
            {
                ApplicationArea = All;
                Image = Close;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    If Confirm(Text002, false) = true then begin
                        Rec.Validate(Status, Rec.Status::Closed);
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
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status:=Rec.Status::New;
    end;
    var Text000: Label 'You are about to Accuse %1 for the Misconduct as Stated on %2, Do you wish to Continue?';
    Text001: Label 'Confirm Whether the right action have been taken';
    Text002: Label 'You are about to close this case, Do you wish to Continue?';
}
