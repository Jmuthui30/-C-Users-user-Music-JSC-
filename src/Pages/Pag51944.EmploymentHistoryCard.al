page 51944 "Employment History Card"
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
            part(KPA; "Emp History Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No."=FIELD("No.");
            }
            part(Control1; Referees)
            {
                ApplicationArea = All;
                SubPageLink = No=FIELD("No.");
            }
        }
    }
    actions
    {
        area(creation)
        {
            action("Reference Request Release")
            {
                ApplicationArea = All;
                Caption = 'Reference Request Release';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(51843, true, true, Rec);
                end;
            }
            action("Letter to Former Employer")
            {
                ApplicationArea = All;
                Caption = 'Letter to Former Employer';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(51842, true, true, Rec);
                end;
            }
            action("Personal Reference Letter")
            {
                ApplicationArea = All;
                Caption = 'Personal Reference Letter';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(51844, true, true, Rec);
                end;
            }
        }
    }
}
