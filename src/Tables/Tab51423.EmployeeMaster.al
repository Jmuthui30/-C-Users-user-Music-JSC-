table 51423 "Employee Master"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Pays Tax"; Boolean)
        {
        }
        field(3; "ID Number"; Code[10])
        {
        }
        field(4; "Passport No."; Code[10])
        {
        }
        field(5; "Driving License No"; Code[10])
        {
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                if NAVEmp.Get("No.")then begin
                    NAVEmp."Global Dimension 1 Code":="Global Dimension 1 Code";
                    NAVEmp.Modify;
                end;
            end;
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(8; County; Code[10])
        {
        }
        field(9; Disability; Text[30])
        {
        }
        field(10; "Marital Status"; Option)
        {
            OptionCaption = 'Single,Married,Separated,Divorced,Widow(er)';
            OptionMembers = Single, Married, Separated, Divorced, "Widow(er)";
        }
        field(11; "Ethnic Group"; Code[20])
        {
            TableRelation = "Ethnic Groups";
        }
        field(12; "PIN Number"; Code[20])
        {
        }
        field(13; "NSSF No"; Code[20])
        {
        }
        field(14; "SHIF No"; Code[20])
        {
        }
        field(15; "HELB No"; Code[20])
        {
        }
        field(16; "Sacco No"; Code[20])
        {
        }
        field(17; "Pay Mode"; Option)
        {
            OptionCaption = 'Bank,Cash,Cheque,Bank Transfer';
            OptionMembers = Bank, Cash, Cheque, "Bank Transfer";
        }
        field(18; "Bank Account Number"; Code[20])
        {
            trigger OnValidate()
            begin
                NAVEmp.SetRange("No.", "No.");
                NAVEmp.ModifyAll("Bank Account No.", "Bank Account Number");
                Modify;
                if StrLen("Bank Account Number") <> 10 then Error('Account Number must be 10 digit');
                if Evaluate(TotalPercent, "Bank Account Number") = false then Error('Account Number must be  digit ONLY');
            // if StrLen(EftLines."Sort Code") <> 9 then
            //     Error('Sort Code must be 9 digit for %1', EftLines."PV No");
            // if Evaluate(TotalPercent, EftLines."Sort Code") = false then
            //     Error('Sort Code must be  digit ONLY for %1', EftLines."PV No");
            end;
        }
        field(19; "Bank Code"; Code[10])
        {
            TableRelation = "Commercial Banks";
        }
        field(20; "Employee Group"; Code[20])
        {
            TableRelation = "Employee Groups";
        }
        field(21; Scale; Code[10])
        {
            TableRelation = "Salary Scale";
        }
        field(22; Level; Code[10])
        {
            TableRelation = "Salary Level";
        }
        field(23; "Salary Currency"; Code[10])
        {
            TableRelation = Currency;
        }
        field(24; "Country Tax Table"; Code[10])
        {
            TableRelation = "Bracket Table";
        }
        field(25; "Full / Part Time"; Option)
        {
            OptionCaption = 'Full Time,Part Time';
            OptionMembers = "Full Time", "Part Time";
        }
        field(26; "Contract Type"; Code[10])
        {
        }
        field(27; "Contract Start Date"; Date)
        {
        }
        field(28; "Contract End Date"; Date)
        {
        }
        field(29; "Served Notice Period"; Boolean)
        {
        }
        field(30; "Exit Interview Date"; Date)
        {
        }
        field(31; "Exit Interview Done By"; Text[30])
        {
        }
        field(32; "Allow Re-Employment in Future"; Boolean)
        {
        }
        field(33; "Bank Branch"; Code[10])
        {
            TableRelation = "Bank Branches"."Branch Code" WHERE("Bank Code"=FIELD("Bank Code"));
        }
        field(34; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
        }
        field(35; Basic; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Basic Salary Code"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Basic Arrears"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Basic Pay Arrears"=CONST(true)));
            FieldClass = FlowField;
        }
        field(37; "Hourly Rate"; Decimal)
        {
        }
        field(38; "Daily Rate"; Decimal)
        {
        }
        field(39; Insurance; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE(Type=CONST(Deduction), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Insurance Code"=CONST(true)));
            FieldClass = FlowField;
        }
        field(40; "Total Allowances"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(false), "Normal Earnings"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Taxable Allowance"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE(Taxable=CONST(true), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "Total Deductions"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE(Type=FILTER(Deduction|Loan), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Information=CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(43; "Travels Customer Account"; Code[20])
        {
            TableRelation = Customer;
        }
        field(44; "Resource No."; Code[20])
        {
            TableRelation = Resource;
        }
        field(45; "Resource Hours"; Decimal)
        {
            CalcFormula = Sum("Job Ledger Entry".Quantity WHERE("No."=FIELD("Resource No."), Type=CONST(Resource), "Posting Date"=FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(46; "Use Timesheets"; Boolean)
        {
        }
        field(47; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(48; "Home Ownership Status"; Option)
        {
            OptionMembers = "None", "Owner Occupier", "Home Savings";
        }
        field(49; "Owner Occupier"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Type=CONST(Payment), "Reduces Taxable Amt"=CONST(true)));
            FieldClass = FlowField;
        }
        field(50; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(51; "Manager No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                UpdateNAVEmployee(Rec);
            end;
        }
        field(52; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Purchase Requisition,Store Requisition,Imprest,Claim-Accounting,Appointment,Payment Voucher,Payment Request,Petty Cash';
            OptionMembers = Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order", "None", "Purchase Requisition", "Store Requisition", Imprest, "Claim-Accounting", Appointment, "Payment Voucher", "Payment Request", "Petty Cash";
        }
        field(53; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.';
            TableRelation = "Incoming Document";

            trigger OnValidate()
            var
                IncomingDocument: Record "Incoming Document";
            begin
                if "Incoming Document Entry No." = xRec."Incoming Document Entry No." then exit;
                if "Incoming Document Entry No." = 0 then IncomingDocument.RemoveReferenceToWorkingDocument(xRec."Incoming Document Entry No.")
                else
                    ; //  AttachmentMgt.PostMemo(Rec);
            end;
        }
        field(54; "Tax Deductible Amount"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE("Reduces Taxable Amt"=CONST(true), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55; "Benefits-Non Cash"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(true), Type=CONST(Payment), Taxable=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(56; "Cumm. PAYE"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Paye=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Medical Expenses"; Decimal)
        {
            CalcFormula = Sum("Medical Claim"."Claim Amount" WHERE("Employee No."=FIELD("No."), Status=CONST(Released), "Visit Date"=FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(58; "Employer Costs"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix"."Employer Amount" WHERE(Type=FILTER(Deduction|Loan), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Information=CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Advancess Customer Account"; Code[20])
        {
            TableRelation = Customer;
        }
        field(60; "Payroll No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(61; Position; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Jobs";

            trigger OnValidate()
            begin
                if CompanyJobs.Get(Position)then begin
                    "Job Title":=CompanyJobs.Name;
                    if NAVEmp.Get("No.")then begin
                        NAVEmp."Job Title":=CompanyJobs.Name;
                        NAVEmp.Modify(true);
                    end;
                end;
            end;
        }
        field(62; "Termination Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Resignation, "Non-Renewal Of Contract", Dismissal, Retirement, Death, Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
                //**Added by ACR 12/08/2002
                //**Block resource if Terminated
                if "Resource No." <> '' then begin
                    OK:="Lrec Resource".Get("Resource No.");
                    "Lrec Resource".Blocked:=true;
                    "Lrec Resource".Modify;
                end;
            //**
            end;
        }
        field(63; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(64; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active, Inactive, Terminated;

            trigger OnValidate()
            begin
                EmployeeQualification.SetRange("Employee No.", "No.");
                EmployeeQualification.ModifyAll("Employee Status", Status);
                Modify;
                NAVEmp.SetRange("No.", "No.");
                NAVEmp.ModifyAll(Status, Status);
                Modify;
            end;
        }
        field(65; Notes; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Job Title"; Text[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                NavEmp: Record Employee;
            begin
                if NavEmp.Get("No.")then begin
                    NavEmp."Job Title":="Job Title";
                    NavEmp.Modify(true);
                end;
            end;
        }
        field(67; "Appraisable"; Boolean)
        {
        }
        field(68; Sales; Option)
        {
            OptionMembers = " ", Sales, None_Sales;

            trigger OnValidate()
            begin
                TestField(Appraisable, true);
            end;
        }
        field(69; "Bal Score Emp Categories"; Code[20])
        {
            TableRelation = "Bal Score Emp Categories";
            Caption = 'Scoring Category';

            trigger OnValidate()
            begin
                TestField(Appraisable, true);
            end;
        }
        field(70; "Appraisal Supervisor"; Code[20])
        {
            TableRelation = Employee;
            Caption = 'Supervisor';

            trigger OnValidate()
            begin
                TestField(Appraisable, true);
            end;
        }
        field(71; SHIF; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE(Type=CONST(Deduction), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "SHIF Code"=const(true), "Insurance Code"=CONST(true)));
            FieldClass = FlowField;
        }
        field(72; Document; Blob)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    var NAVEmp: Record Employee;
    AttachmentMgt: Codeunit "Internal Memo Manager";
    EmployeeQualification: Record "Employee Qualification";
    CompanyJobs: Record "Company Jobs";
    EmployeeCategories: Record "Job Group Clusters";
    TotalPercent: Decimal;
    [IntegrationEvent(false, false)]
    procedure UpdateNAVEmployee(var Rec: Record "Employee Master")
    begin
    end;
}
