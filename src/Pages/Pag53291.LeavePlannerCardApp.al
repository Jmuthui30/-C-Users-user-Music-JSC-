page 53291 "Leave Planner App Card"
{
    ApplicationArea = All;
    Caption = 'Leave Planner App Card';
    PageType = Card;
    SourceTable = "Leave Planner Header";
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec.Status = Rec.Status::Created;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field(employeeCode; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                    caption = 'Employee No.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    Editable = false;
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    caption = 'Responsibility Center';
                    Editable = false;
                }
                field("Email Adress"; Rec."Email Adress")
                {
                    ToolTip = 'Specifies the value of the Email Adress field.';
                    Editable = false;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ToolTip = 'Specifies the value of the Mobile No field.';
                    Editable = false;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ToolTip = 'Specifies the value of the Leave Period field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
            }
            part(LeavePlannerLines; "Leave Planner Lines")
            {
                Caption = 'Leave Planner Lines';
                SubPageLink = "Document No." = field("No.");
                Editable = Rec.Status = Rec.Status::Created;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::Created;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to approve the Leave Plan?', false) then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                    end;
                end;
            }
        }
    }
}






