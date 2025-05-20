table 51631 "Applicant Master"
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
        field(11; "Ethnic Group"; Code[10])
        {
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
            TableRelation = "Bank Branches";
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
        field(43; "Customer Code"; Code[20])
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
                UpdateNAVApplicant(Rec);
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
            /*IF "Incoming Document Entry No." = xRec."Incoming Document Entry No." THEN
                  EXIT;
                IF "Incoming Document Entry No." = 0 THEN
                  IncomingDocument.RemoveReferenceToWorkingDocument(xRec."Incoming Document Entry No.")
                ELSE
                  AttachmentMgt.PostMemo(Rec);
                */
            end;
        }
        field(54; SHIF; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE(Type=CONST(Deduction), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "SHIF Code"=CONST(true)));
            FieldClass = FlowField;
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
    var NAVApplicant: Record Applicant;
    AttachmentMgt: Codeunit "Internal Memo Manager";
    [IntegrationEvent(false, false)]
    procedure UpdateNAVApplicant(var Rec: Record "Applicant Master")
    begin
    end;
}
