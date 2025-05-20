pageextension 51426 "ExtEmployee Card" extends "Employee Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Resource No.")
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("Last Name")
        {
            field("Job Id"; Rec."Job Id")
            {
                ApplicationArea = All;
            }
        }
        addafter(Gender)
        {
            field("Has Special Needs"; Rec."Has Special Needs")
            {
                ApplicationArea = All;
            }
        }
        modify("Job Title")
        {
            Editable = false;
            ApplicationArea = All;
        }
    }
    actions
    {
        addafter(Attachments)
        {
            action("Employee Card")
            {
                ApplicationArea = All;
                Image = PersonInCharge;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "HR Employee Card";
                RunPageLink = "No."=FIELD("No.");
            }
            action("Payroll Information")
            {
                ApplicationArea = All;
                Image = PayrollStatistics;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Payroll Infromation";
                RunPageLink = "No."=FIELD("No.");
            }
            action("Admin Infromation")
            {
                ApplicationArea = All;
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Admin Infromation";
                RunPageLink = "No."=FIELD("No.");
            }
            action("Separation Infromation")
            {
                ApplicationArea = All;
                Image = Undo;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Exit Information";
                RunPageLink = "No."=FIELD("No.");
            }
            action("Delete Blank Emp")
            {
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Emp: Record Employee;
                begin
                    Emp.Reset();
                    Emp.SetRange("No.", '');
                    Emp.Delete(true);
                end;
            }
        }
    }
    var myInt: Integer;
}
