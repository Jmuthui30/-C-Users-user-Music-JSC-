page 51942 "Employee Qualification Card"
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
            }
            part(Control1; "Emp Qualification Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No."=FIELD("No.");
            }
        }
    }
    actions
    {
        area(creation)
        {
            action("Education Verification Letter")
            {
                ApplicationArea = All;
                Caption = 'Education Verification Letter';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

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
    var KPACode: Code[20];
}
