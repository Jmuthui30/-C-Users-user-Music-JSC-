page 51426 "Payroll Employee List"
{
    // version THL- Payroll 1.0
    Caption = 'Employee Master';
    CardPageID = "Employee Card";
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
            repeater(Control66)
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
            systempart(Control2; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1; Notes)
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
                RunObject = Page "Employee Card";
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
            action("Exit Infromation")
            {
                ApplicationArea = All;
                Image = Undo;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Exit Information";
                RunPageLink = "No."=FIELD("No.");
            }
            group(New)
            {
                Caption = 'New';

                action("Payroll Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll Setup';
                    Image = PayrollStatistics;
                    RunObject = Page "QuantumJumps Payroll Setup";
                    RunPageMode = Edit;
                    ToolTip = 'Modify a value in the Payroll Setup';
                }
                action("Employee Groups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employee Groups';
                    Image = EmployeeAgreement;
                    RunObject = Page "Employee Groups";
                    RunPageMode = Edit;
                    ToolTip = 'Edit or Add new Emloyee Groups';
                }
                action("Payroll GL Mapping")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll GL Mapping';
                    Image = Accounts;
                    RunObject = Page "Payroll GL Mapping";
                }
                action("Payroll Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll Periods';
                    Image = PaymentPeriod;
                    RunObject = Page "Payroll Periods";
                    RunPageMode = Edit;
                    ToolTip = 'Manage or Create new Payroll Periods';
                }
                action(Earnings)
                {
                    ApplicationArea = Suite;
                    Caption = 'Earnings';
                    Image = PaymentJournal;
                    RunObject = Page Earnings;
                    RunPageMode = Edit;
                    ToolTip = 'Manage or Create new Employee Earnings';
                }
                action(Deductions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deductions';
                    Image = Receipt;
                    RunObject = Page Deductions;
                    RunPageMode = Edit;
                    ToolTip = 'Manage or create new earnings';
                }
                action("Bracket Tables")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bracket Tables';
                    Image = Database;
                    RunObject = Page "Bracket Tables";
                    RunPageMode = Edit;
                    ToolTip = 'Manage or Create new Bracket Tables';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';

                group("Periodic Activities")
                {
                    Caption = 'Periodic Activities';
                    Image = Reconcile;

                    action("Payroll Run")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Run';
                        Image = Calculate;
                        RunObject = Report "Payroll Calculator";
                        ToolTip = 'Calculate Payroll';
                    }
                    action("Email Payslips")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Email Payslips';
                        Image = SendEmailPDF;
                        RunObject = Report "Email Payslips";
                        ToolTip = 'Email Payslips';
                    }
                    action("Generate Payroll Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'Generate Payroll Journal';
                        Image = Suggest;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Transfer Journal to GL";
                    }
                }
                group("Process Payments")
                {
                    Caption = 'Process Payments';
                    Image = Reconcile;

                    action("EFT Payments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'EFT Payments';
                        Image = Payment;
                        RunObject = Page "New EFT Entries";
                        ToolTip = 'Process EFT Payments';
                    }
                }
            }
            group(Reports)
            {
                Caption = 'Reports';

                group("Management Reports")
                {
                    Caption = 'Management Reports';
                    Image = ReferenceData;

                    action(Payslips)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payslips';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report Payslip;
                        ToolTip = 'View Employee Payslips';
                    }
                    action("Master Roll")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Master Roll';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Master Roll Report";
                        ToolTip = 'View Master Roll Report';
                    }
                    action("Monthly PAYE Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Monthly PAYE Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Monthly PAYE Report";
                        ToolTip = 'View the monthly PAYE Report';
                    }
                    action("Earnings Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Earnings Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report Earnings;
                        ToolTip = 'View Earnings Report';
                    }
                    action("Deductions Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Deductions Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report Deductions;
                    }
                    action("SHIF Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'SHIF Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report SHIF;
                        ToolTip = 'View SHIF Report';
                    }
                    action("NSSF Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'NSSF Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report NSSF;
                        ToolTip = 'View NSSF Report';
                    }
                    action("Bank List")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank List';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Bank List";
                        ToolTip = 'View Bank List Report';
                    }
                    action("Bank Instruction")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Instruction';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Bank Instruction Format 2";
                        ToolTip = 'Generate Instruction to the Bank';
                    }
                    action("Company Totals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Company Totals';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Company Totals";
                        ToolTip = 'View the Company Totals Report';
                    }
                    action("Accounted Time")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Accounted Time';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Time Sheet Entries";
                    }
                }
                group("Statutory Reports")
                {
                    Caption = 'Statutory Reports';
                    Image = ReferenceData;

                    action(P9A)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'P9A';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report P9A;
                        ToolTip = 'View Employee P9A Report';
                    }
                    action("<Report P10>")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'P10';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "P10 A";
                        ToolTip = 'View Employee P10 Report';
                    }
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;

                action("Company Settings")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Company Settings';
                    Image = CompanyInformation;
                    RunObject = Page "Company Information";
                    ToolTip = 'Enter the company name, address, and bank information that will be inserted on your business documents.';
                }
                action("User Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'User Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "QuantumJumps User Setup";
                    ToolTip = 'Set up core functionality for users';
                }
                group("Commercial Banks")
                {
                    Caption = 'Commercial Banks';
                    Image = ServiceSetup;

                    action("Employee Banks")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Banks';
                        Image = NonStockItemSetup;
                        RunObject = Page "Commercial Banks";
                        ToolTip = 'Manage Employee Banks';
                    }
                    action("Bank Branches")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Branches';
                        Image = ServiceTasks;
                        RunObject = Page "Bank Branches";
                        ToolTip = 'Manage Bank Branches';
                    }
                }
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
    trigger OnOpenPage()
    begin
        IF UserSetup.GET(USERID)THEN IF NOT UserSetup.Payroll THEN ERROR(TEXT001);
    end;
    var PayrollInt: Codeunit "Client Payroll Mgt";
    UserSetup: Record "User Setup";
    TEXT001: Label 'Kindly Note that you are not Allowed to View Payroll.Consult your System Administrator for Setup';
}
