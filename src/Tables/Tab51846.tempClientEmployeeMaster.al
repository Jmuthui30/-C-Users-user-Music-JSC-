table 51846 "temp_Client Employee Master"
{
    // version THL- PRM 1.0
    DrillDownPageID = "Client Payroll List";
    LookupPageID = "Client Payroll List";

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
            TableRelation = "Client Bracket Table";
        }
        field(25; "Full / Part Time"; Option)
        {
            OptionCaption = 'Full Time,Part Time';
            OptionMembers = "Full Time", "Part Time";
        }
        field(26; "Contract Type"; Code[50])
        {
            TableRelation = "Client Employee Contract Type".Contract WHERE(Client=FIELD("Company Code"));
        }
        field(27; "Starting Date"; Date)
        {
        }
        field(28; "Departure Date"; Date)
        {
            trigger OnValidate()
            begin
                if "Departure Date" <> 0D then Status:=Status::Inactive;
            end;
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
            TableRelation = "Client Payroll Period";
        }
        field(35; Basic; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Basic Salary Code"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Basic Arrears"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Basic Pay Arrears"=CONST(true)));
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
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Deduction), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Insurance Code"=CONST(true)));
            FieldClass = FlowField;
        }
        field(40; "Total Allowances"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(false), "Normal Earnings"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Taxable Allowance"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Taxable=CONST(true), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "Total Deductions"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=FILTER(Deduction|Loan), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Information=CONST(false)));
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
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Type=CONST(Payment), "Reduces Taxable Amt"=CONST(true)));
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
            //UpdateNAVEmployee(Rec);
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
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE("Reduces Taxable Amt"=CONST(true), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55; "Benefits-Non Cash"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(true), Type=CONST(Payment), Taxable=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(56; "Cumm. PAYE"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Paye=CONST(true)));
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
            CalcFormula = Sum("Client Payroll Matrix"."Employer Amount" WHERE(Type=FILTER(Deduction|Loan), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Information=CONST(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Payroll No."; Code[20])
        {
        }
        field(60; "Full Name"; Text[150])
        {
            trigger OnValidate()
            begin
                StrPosOne:=0;
                NameLength:=0;
                NameLength:=StrLen("Full Name");
                StrPosOne:=StrPos("Full Name", ' ');
                if StrPosOne <> 0 then Validate("First Name", CopyStr("Full Name", 1, StrPosOne));
                Validate("Last Name", CopyStr("Full Name", StrPosOne + 1, NameLength));
            end;
        }
        field(61; "First Name"; Text[50])
        {
        }
        field(62; "Middle Name"; Text[50])
        {
        }
        field(63; "Last Name"; Text[50])
        {
        }
        field(64; Title; Text[50])
        {
        }
        field(65; "Company Code"; Code[10])
        {
            TableRelation = "Client Company Information";

            trigger OnValidate()
            begin
                if Employer.Get("Company Code")then "Company Name":=Employer.Name;
            end;
        }
        field(66; "Company Name"; Text[50])
        {
        }
        field(67; Department; Code[50])
        {
            TableRelation = "Client Department".Department WHERE(Client=FIELD("Company Code"));
        }
        field(68; Country; Code[10])
        {
            TableRelation = "Country/Region";
        }
        field(69; Gender; Option)
        {
            OptionCaption = ' ,Male,Female';
            OptionMembers = " ", Male, Female;
        }
        field(70; "Date of Birth"; Date)
        {
        }
        field(71; "Postal Address"; Text[250])
        {
        }
        field(72; "Mobile Phone No."; Code[20])
        {
        }
        field(73; "Email Address"; Text[100])
        {
        }
        field(74; Picture; Media)
        {
            ExtendedDatatype = Person;
        }
        field(75; Status; Option)
        {
            OptionCaption = 'Active,Suspended,Inactive, Interdicted';
            OptionMembers = Active, Suspended, Inactive, Interdicted;
        }
        field(76; "Cost Center Code"; Code[20])
        {
            TableRelation = "Client Cost Center"."Cost Center" WHERE(Client=FIELD("Company Code"));

            trigger OnValidate()
            begin
                if CostCenter.Get("Company Code", "Cost Center Code")then "Cost Center Name":=CostCenter.Description;
            end;
        }
        field(77; "Cost Center Name"; Text[30])
        {
        }
        field(78; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(79; "Annual Leave Days Enttitled"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Annual Days Taken"; Integer)
        {
            CalcFormula = Sum("External Employees Leave"."Annual Days" WHERE("Employee No."=FIELD("No."), "Leave Type"=CONST(Annual)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(81; "Annual Leaves Balance"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(82; SHIF; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Deduction), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Insurance Code"=CONST(true), "SHIF Code"=CONST(true)));
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
    var NAVEmp: Record Employee;
    AttachmentMgt: Codeunit "Internal Memo Manager";
    Employer: Record "Client Company Information";
    StrPosOne: Integer;
    NameLength: Integer;
    CostCenter: Record "Client Cost Center";
    OutsourcingSetup: Record "Outsourcing Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
