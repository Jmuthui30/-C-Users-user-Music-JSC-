page 51934 "Employee Leaves Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
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
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Leave Entitlment"; Rec."Leave Entitlement")
                {
                    ToolTip = 'Specifies the value of the Leave Entitlment field.';
                    Caption = 'Leave Entitlement';
                }

                field("Leave Adjustment"; "Leave Adjustment")
                {
                    ToolTip = 'Specifies the value of the Leave Entitlment field.';
                    Caption = 'Leave Adjustment';
                }
                field("Recalled Days"; Rec."Leave Recall Days")
                {
                    ToolTip = 'Specifies the value of the Recalled Days field.';
                    Caption = 'Recalled Days';
                }

                field("Balance brought forward"; Rec."Leave Balance Brought Forward")
                {
                    ToolTip = 'Specifies the value of the Balance brought forward field.';
                    Caption = 'Balance Brought Forward';
                }
                field("Total Leave Days Taken"; Rec."Leave Days Taken")
                {
                    ToolTip = 'Specifies the value of the Total Leave Days Taken field.';
                    Caption = 'Leave Days Taken';
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    ToolTip = 'Specifies the value of the Leave balance field.';
                    Caption = 'Leave Balance';
                }
            }
            part(Control1; "Employee Leave Assignment")
            {
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "Employee No" = FIELD("No.");
                Visible = false;
            }

        }
    }
    actions
    {
    }
}
