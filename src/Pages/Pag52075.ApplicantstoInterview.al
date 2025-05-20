page 52075 "Applicants to Interview"
{
    // version THL- HRM 1.0
    Caption = 'Applicants to Interview';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Applicant;
    SourceTableView = WHERE(Shortlisting=CONST(Passed));

    layout
    {
        area(content)
        {
            repeater(Control1)
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
            group("Interview Marks")
            {
                action("Allocate Marks")
                {
                    ApplicationArea = All;
                    Image = Allocate;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    RunObject = Page "Interview Marks All. Header";
                    RunPageLink = "No."=FIELD("No.");
                }
            }
        }
    }
}
