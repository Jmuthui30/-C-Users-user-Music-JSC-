page 51494 "Staff Disciplinary Case"
{
    // version THL- HRM 1.0
    Caption = 'Staff Disciplinary Case';
    PageType = Card;
    SourceTable = "Staff Disciplinary";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            group("Employee Details")
            {
                Editable = false;

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
                field(Manager; Rec.Manager)
                {
                    ApplicationArea = All;
                }
                field("Manager's Name"; Rec."Manager's Name")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
                field("Staff Response/Defense"; Rec."Staff Response/Defense")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Remarks HR"; Rec."Remarks HR")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
            }
            part(Control001; "Staff Disciplinary Cases Lines")
            {
                SubPageLink = "Refference No"=field("No."), "Employee No"=field("Employee No");
                ApplicationArea = All;
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
                    Rec.TestField("Staff Response/Defense");
                    Rec.TestField(Status, Rec.Status::Accepted);
                    If Confirm(Text001, false) = true then begin
                        Rec.Validate(Status, Rec.Status::"Action Taken");
                        Rec.Modify(true);
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
