page 52076 "Interview Marks All. Header"
{
    // version THL- HRM 1.0
    Caption = 'Applicants to Interview';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = Applicant;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;

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
                field("Vacancy No."; Rec."Vacancy No.")
                {
                    ApplicationArea = All;
                }
                field(Shortlisting; Rec.Shortlisting)
                {
                    ApplicationArea = All;
                }
                field(Interview; Rec.Interview)
                {
                    ApplicationArea = All;
                }
                field("Total Interview Marks"; Rec."Total Interview Marks")
                {
                    ApplicationArea = All;
                }
            }
            part(Control7; "Interviewers Marks Allocation")
            {
                ApplicationArea = All;
                SubPageLink = "Applicant No"=FIELD("No."), "Vacancy No."=FIELD("Vacancy No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("Applicant Information")
            {
                action("Admin Infromation")
                {
                    ApplicationArea = All;
                    Image = EmployeeAgreement;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Applicant Admin Infromation";
                    RunPageLink = "No."=FIELD("No.");
                }
                action("Payroll Information")
                {
                    ApplicationArea = All;
                    Image = PayrollStatistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Applicant Payroll Infromation";
                    RunPageLink = "No."=FIELD("No.");
                }
            }
        }
    }
}
