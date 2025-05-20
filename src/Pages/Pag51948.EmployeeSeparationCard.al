page 51948 "Employee Separation Card"
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
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1; "Clearing Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No"=FIELD("No.");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            action("Separation Infromation")
            {
                ApplicationArea = All;
                Image = Undo;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Exit Information";
                RunPageLink = "No."=FIELD("No.");
            }
        }
    }
}
