page 51796 "Job Template Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Job Template";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Temp Code"; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    Caption = 'Job Title';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
            part(Control1; "Job Templates Matrix")
            {
                Caption = 'Skills';
                ApplicationArea = All;
                SubPageLink = "Job Template"=FIELD("No."), Type=const(Skills);
            }
            part(Control2; "Job Templates Matrix")
            {
                Caption = 'Certificates';
                ApplicationArea = All;
                SubPageLink = "Job Template"=FIELD("No."), Type=const(Certificates);
            }
            part(Control3; "Emp Qualification Lines")
            {
                Caption = 'Education';
                ApplicationArea = All;
                SubPageLink = "Job Template"=FIELD("No.");
            }
            part(Control4; "Job Templates Matrix")
            {
                Caption = 'Screenings';
                ApplicationArea = All;
                SubPageLink = "Job Template"=FIELD("No."), Type=const(Screenings);
            }
            part(Control5; "Job Templates Matrix")
            {
                Caption = 'Tests';
                ApplicationArea = All;
                SubPageLink = "Job Template"=FIELD("No."), Type=const(Tests);
            }
            group(Tasks)
            {
                Caption = 'Job Tasks';

                field("Job Tasks"; Rec."Job Tasks")
                {
                    Caption = 'Description';
                    MultiLine = true;
                    ApplicationArea = All;
                }
            }
            group(Responsibility)
            {
                Caption = 'Areas of responsibility';

                field("Areas of Responsibility"; Rec."Areas of Responsibility")
                {
                    Caption = 'Description';
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
}
