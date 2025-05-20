table 51453 "Client Employee Master"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            //FieldClass = FlowFilter;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    OutsourcingSetup.Get;
                    NoSeriesMgt.TestManual(OutsourcingSetup."Employee Import Nos.");
                    "No. Series":='';
                end;
            end;
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

            trigger OnValidate()
            var
                CommercialBanks: Record "Commercial Banks";
            begin
                CommercialBanks.Reset();
                CommercialBanks.SetRange(Code, Rec."Bank Code");
                if CommercialBanks.findset then "Bank Name":=CommercialBanks.Name;
            end;
        }
        field(20; "Employee Group"; Code[20])
        {
            TableRelation = "Client Employee Groups";
        }
        field(21; Scale; Code[10])
        {
            TableRelation = "Client Salary Scale".Scale;
        }
        field(22; Level; Code[10])
        {
            TableRelation = "Client Salary Level".Level;

            trigger OnValidate()
            var
                ScaleBenefits: Record "Client Scale Benefits";
                PayrollMatrix: Record "Client Payroll Matrix";
            begin
                ScaleBenefits.Reset();
                ScaleBenefits.SetRange(Client, Rec."Company Code");
                ScaleBenefits.SetRange(Scale, Rec.Scale);
                ScaleBenefits.SetRange(Level, Rec.Level);
                if ScaleBenefits.FindSet()then begin
                    repeat PayrollMatrix.INIT;
                        PayrollMatrix."Employee No":="No.";
                        PayrollMatrix.Company:="Company Code";
                        PayrollMatrix."Salary Level":=Level;
                        PayrollMatrix."Job Grade":=Scale;
                        PayrollMatrix.Validate(PayrollMatrix."Employee No");
                        PayrollMatrix.Type:=PayrollMatrix.Type::Payment;
                        PayrollMatrix.Code:=ScaleBenefits.Earning;
                        PayrollMatrix.Validate(PayrollMatrix.Code);
                        //MESSAGE('Payroll period %1',Begindate);
                        PayrollMatrix."Payroll Period":=Rec.GetPayPeriod();
                        PayrollMatrix.Amount:=ScaleBenefits.Amount;
                        IF NOT PayrollMatrix.Insert()THEN PayrollMatrix.Modify();
                    until ScaleBenefits.Next() = 0;
                end;
            end;
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

            trigger OnValidate()
            var
                BankBranches: Record "Bank Branches";
            begin
                BankBranches.Reset();
                BankBranches.SetRange("Bank Code", Rec."Bank Code");
                BankBranches.SetRange("Branch Code", Rec."Bank Branch");
                if BankBranches.FindSet()then "Bank Branch Name":=BankBranches."Branch Name";
            end;
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
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Deduction), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Insurance Code"=CONST(true), AKI=filter(<>''), Company=field("Company Code")));
            FieldClass = FlowField;
        }
        field(40; "Total Allowances"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(false), "Normal Earnings"=CONST(true), Company=field("Company Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Taxable Allowance"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Taxable=CONST(true), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Company=field("Company Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "Total Deductions"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=FILTER(Deduction|Loan), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Information=CONST(false), Company=field("Company Code")));
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
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Type=CONST(Payment), "Reduces Taxable Amt"=CONST(true), Company=field("Company Code")));
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
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE("Reduces Taxable Amt"=CONST(true), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(false), Company=field("Company Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(55; "Benefits-Non Cash"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=FILTER(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(true), Taxable=CONST(true), Company=field("Company Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(56; "Cumm. PAYE"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Paye=CONST(true), Company=field("Company Code")));
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
            CalcFormula = Sum("Client Payroll Matrix"."Employer Amount" WHERE(Type=FILTER(Deduction|Loan), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Information=CONST(false), Company=field("Company Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(59; "Payroll No."; Code[20])
        {
            trigger OnValidate()
            var
                HREmp: Record Employee;
            begin
                HREmp.Reset();
                HREmp.SetRange("No.", Rec."No.");
                if HREmp.FindSet()then begin
                    Rec."First Name":=HREmp."First Name";
                    Rec."Middle Name":=HREmp."Middle Name";
                    Rec."Last Name":=HREmp."Last Name";
                    Rec."Full Name":=HREmp.FullName();
                    Rec.Modify()end;
            end;
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
            OptionCaption = ' ,Male,Female,Other';
            OptionMembers = " ", Male, Female, Other;
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
        field(90; "Bank Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(91; "Bank Branch Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(92; SHIF; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Deduction), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Insurance Code"=CONST(true), "SHIF Code"=CONST(true), Company=field("Company Code")));
            FieldClass = FlowField;
        }
        field(93; "Employee Type"; Option)
        {
            OptionCaption = 'Primary Employee,Secondary Employee';
            OptionMembers = "Primary Employee", "Secondary Employee";
        }
        field(94; "Is Board"; Boolean)
        {
            TableRelation = Employee."Is Board";
        }
        field(95; "Residential Status"; Option)
        {
            OptionCaption = 'Resident,Foreign';
            OptionMembers = "Resident", "Foreign";
        }
        field(96; Retirement; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Deduction), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Retirement=CONST(true), Company=field("Company Code")));
            FieldClass = FlowField;
        }
        field(97; "Personal+Insurance+SHIF-Relief"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Tax Relief"=CONST(true), //"Normal Earnings" = CONST(false),
            Company=field("Company Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(98; "SHIF+InsuranceRelief"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Insurance Relief"=CONST(true), //"Normal Earnings" = CONST(false),
            Company=field("Company Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(99; "Job ID"; Code[10])
        {
            TableRelation = "Company Jobs";

            trigger OnValidate()
            begin
                if CompanyJobs.Get("Job ID")then "Job Title":=CompanyJobs.Name;
            end;
        }
        field(100; "Job Title"; Text[200])
        {
        }
        field(101; "Basic + Regular Allowances"; Decimal)
        {
            CalcFormula = Sum("Client Payroll Matrix".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Basic+Regular Allowances"=CONST(true), "Normal Earnings"=CONST(true), Company=field("Company Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(102; "Next Increamental Date"; Date)
        {
        }
        field(103; "Halt Date"; Date)
        {
        }
        field(104; "Last Salary Review Date"; Date)
        {
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Full Name")
        {
        }
        key(Key3; Status)
        {
        }
        key(Key4; "Last Name", "First Name", "Middle Name")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Full Name", "Employee Group")
        {
        }
        fieldgroup(Brick; "No.", "Full Name", "Employee Group")
        {
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            OutsourcingSetup.Get;
            OutsourcingSetup.TestField("Employee Import Nos.");
            NoSeriesMgt.InitSeries(OutsourcingSetup."Employee Import Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;
    var NAVEmp: Record Employee;
    AttachmentMgt: Codeunit "Internal Memo Manager";
    Employer: Record "Client Company Information";
    CompanyJobs: Record "Company Jobs";
    StrPosOne: Integer;
    NameLength: Integer;
    CostCenter: Record "Client Cost Center";
    OutsourcingSetup: Record "Outsourcing Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    [IntegrationEvent(false, false)]
    procedure UpdateNAVEmployee(var Rec: Record "Client Employee Master")
    begin
    end;
    procedure AssitEdit(): Boolean begin
        OutsourcingSetup.Get;
        OutsourcingSetup.TestField("Employee Import Nos.");
        if NoSeriesMgt.SelectSeries(OutsourcingSetup."Employee Import Nos.", xRec."No. Series", "No. Series")then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;
    procedure GetPayPeriod(): Date var
        PayPeriod: Record "Client Payroll Period";
        PayrollPeriod: Date;
    begin
        PayPeriod.Reset();
        PayPeriod.SetRange("Close Pay", false);
        if PayPeriod.FindFirst()then PayrollPeriod:=PayPeriod."Starting Date";
        exit(PayrollPeriod)end;
}
