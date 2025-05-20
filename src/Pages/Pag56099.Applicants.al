page 56099 "Applicants"
{
    PageType = ListPart;
    SourceTable = Applicant;
    Caption = 'Applicants';

    layout
    {
        area(content)
        {
            repeater(Control5)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a number for the employee.';
                }
                field(FullName; Rec.FullName)
                {
                    ApplicationArea = All;
                    Caption = 'Full Name';
                    ToolTip = 'Specifies the full name of the employee.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s first name.';
                    Visible = false;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s middle name.';
                    Visible = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s last name.';
                    Visible = false;
                }
                field(Shortlisting; Rec.Shortlisting)
                {
                    ApplicationArea = All;
                }
                field(Interview; Rec.Interview)
                {
                    ApplicationArea = All;
                }
                // field("Total Interview Marks"; Rec."Total Interview Marks")
                // {
                //     ApplicationArea = All;
                // }
                // field("Offer Status"; Rec."Offer Status")
                // {
                //     ApplicationArea = All;
                // }
                // field("Offer Signed By"; Rec."Offer Signed By")
                // {
                //     ApplicationArea = All;
                // }
                field("Vacancy No."; Rec."Vacancy No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Job Description"; Rec."Position Applied For")
                {
                    ApplicationArea = All;
                }
                field("Applicant Type"; Rec."Applicant Type")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Portal ID"; Rec."Portal ID")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Highest Level Of Education"; Rec."Highest Level Of Education")
                {
                    ApplicationArea = All;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field("Position Applied For"; Rec."Position Applied For")
                {
                    ApplicationArea = All;
                }
                Field("Years Of Experience"; Rec."Years Of Experience")
                {
                    ApplicationArea = All;
                }
                field("Current Salary"; Rec."Current Salary")
                {
                    ApplicationArea = all;
                }
                field("Expected Salary"; Rec."Expected Salary")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
