page 51491 "Applicants to Examine"
{
    // version THL- HRM 1.0
    Caption = 'Applicants to Examine';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = Applicant;
    SourceTableView = WHERE(Interview=CONST(Passed));

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
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("Mediacal Examination"; Rec."Mediacal Examination")
                {
                    ApplicationArea = All;
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
            group(Examination)
            {
                action("Assign Examiners")
                {
                    ApplicationArea = All;
                    Image = Allocate;
                    RunObject = Page "Medical Examination Lines";
                    RunPageLink = "Applicant No"=FIELD("No."), "Vacancy No."=field("Vacancy No.");
                }
            }
        }
    }
}
