page 51604 "HR Employee List"
{
    // version THL- HRM 1.0
    Caption = 'Employee Master';
    CardPageID = "HR Employee Card";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Employee;

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
                    StyleExpr = Style;
                    ToolTip = 'Specifies a number for the employee.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies the employee''s initials.';
                    Visible = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies the postal code of the address.';
                    Visible = false;
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies the country/region code.';
                    Visible = false;
                }
                field(Extension; Rec.Extension)
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies the employee''s telephone extension.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies the employee''s telephone number.';
                    Visible = false;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies the employee''s mobile telephone number.';
                    Visible = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies the employee''s email address.';
                    Visible = false;
                }
                field("Employee Group"; EmployeeMaster."Employee Group")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                }
                field("Contract Type"; EmployeeMaster."Contract Type")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                }
                field("Contract Start Date"; EmployeeMaster."Contract Start Date")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                }
                field("Contract End Date"; EmployeeMaster."Contract End Date")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies a resource number for the employee, if the employee is a resource in Resources Planning.';
                    Visible = false;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies a search name for the employee.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    StyleExpr = Style;
                    ToolTip = 'Specifies if a comment has been entered for this entry.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }
    actions
    {
        area(processing)
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
                PromotedIsBig = true;
                RunObject = Page "Payroll Infromation";
                RunPageLink = "No."=FIELD("No.");
            }
            action("Admin Infromation")
            {
                ApplicationArea = All;
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Admin Infromation";
                RunPageLink = "No."=FIELD("No.");
            }
            action("Separation Infromation")
            {
                ApplicationArea = All;
                Image = Undo;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Exit Information";
                RunPageLink = "No."=FIELD("No.");
            }
            action("Employee Details")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Employee Details";
            }
            action("Employee Next of KIN")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Employee Kins";
            }
            action("Employee Dependant")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Employee Dependants";
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        Style:='';
        if EmployeeMaster."Contract End Date" <> 0D then begin
            ContractYear:=Date2DMY(EmployeeMaster."Contract End Date", 3);
            ContractMonth:=Date2DMY(EmployeeMaster."Contract End Date", 2);
            Year:=Date2DMY(Today, 3);
            Month:=Date2DMY(Today, 2);
            //Style:
            if((ContractYear = Year) and ((ContractMonth - Month) = 1))then Style:='StrongAccent'
            else if((ContractYear = Year) and (ContractMonth = Month))then Style:='Ambiguous';
            if(EmployeeMaster."Contract End Date" < Today)then Style:='Unfavorable';
        end;
    end;
    trigger OnAfterGetRecord()
    begin
        if EmployeeMaster.Get(Rec."No.")then;
        Style:='';
        if EmployeeMaster."Contract End Date" <> 0D then begin
            ContractYear:=Date2DMY(EmployeeMaster."Contract End Date", 3);
            ContractMonth:=Date2DMY(EmployeeMaster."Contract End Date", 2);
            Year:=Date2DMY(Today, 3);
            Month:=Date2DMY(Today, 2);
            //Style:
            if((ContractYear = Year) and ((ContractMonth - Month) = 1))then Style:='StrongAccent'
            else if((ContractYear = Year) and (ContractMonth = Month))then Style:='Ambiguous';
            if(EmployeeMaster."Contract End Date" < Today)then Style:='Unfavorable';
        end;
    end;
    var EmployeeMaster: Record "Employee Master";
    Style: Text[20];
    ContractYear: Integer;
    ContractMonth: Integer;
    Year: Integer;
    Month: Integer;
    EmpNav: Record "Employee Master";
}
