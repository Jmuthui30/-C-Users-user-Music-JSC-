page 51946 "Emp Succession Planning Card"
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
                field("Position To Succeed"; Rec."Position To Succeed")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
            }
            field(Control6;'')
            {
                ApplicationArea = All;
                CaptionClass = Text19062331;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(Gaps; "Successsion GAP")
            {
                Editable = false;
                ApplicationArea = All;
                SubPageLink = "Employee No"=FIELD("No."), "Job Id"=FIELD("Position To Succeed");
            }
            field(Control3;'')
            {
                ApplicationArea = All;
                CaptionClass = Text19065507;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(KPA; "Succession Requirements")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No."=FIELD("No."), "Need Source"=CONST(Succesion);
            }
        }
    }
    actions
    {
    }
    var Text19062331: Label 'Requirements Gaps';
    Text19065507: Label 'Succesion Training and Development Requirements';
}
