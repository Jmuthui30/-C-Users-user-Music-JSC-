table 51845 "temp_Employee"
{
    // version THL- PRM 1.0
    Caption = 'Employee';
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name";
    DrillDownPageID = "Employee List";
    LookupPageID = "Employee List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(3; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(5; Initials; Text[30])
        {
            Caption = 'Initials';

            trigger OnValidate()
            begin
                if("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '')then "Search Name":=Initials;
            end;
        }
        field(6; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
        }
        field(7; "Search Name"; Code[250])
        {
            Caption = 'Search Name';

            trigger OnValidate()
            begin
                if "Search Name" = '' then "Search Name":=SetSearchNameToFullnameAndInitials;
            end;
        }
        field(8; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(9; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF("Country/Region Code"=CONST(''))"Post Code".City
            ELSE IF("Country/Region Code"=FILTER(<>''))"Post Code".City WHERE("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF("Country/Region Code"=CONST(''))"Post Code"
            ELSE IF("Country/Region Code"=FILTER(<>''))"Post Code" WHERE("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(12; County; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
            Caption = 'County';
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(15; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit 9520;
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(16; "Alt. Address Code"; Code[10])
        {
            Caption = 'Alt. Address Code';
            TableRelation = "Alternative Address".Code WHERE("Employee No."=FIELD("No."));
        }
        field(17; "Alt. Address Start Date"; Date)
        {
            Caption = 'Alt. Address Start Date';
        }
        field(18; "Alt. Address End Date"; Date)
        {
            Caption = 'Alt. Address End Date';
        }
        field(19; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(20; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
        }
        field(21; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
        }
        field(22; "Union Code"; Code[10])
        {
            Caption = 'Union Code';
            TableRelation = Union;
        }
        field(23; "Union Membership No."; Text[30])
        {
            Caption = 'Union Membership No.';
        }
        field(24; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ", Female, Male;
        }
        field(25; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(26; "Manager No."; Code[20])
        {
            Caption = 'Manager No.';
            TableRelation = Employee;
        }
        field(27; "Emplymt. Contract Code"; Code[10])
        {
            Caption = 'Emplymt. Contract Code';
            TableRelation = "Employment Contract";
        }
        field(28; "Statistics Group Code"; Code[10])
        {
            Caption = 'Statistics Group Code';
            TableRelation = "Employee Statistics Group";
        }
        field(29; "Employment Date"; Date)
        {
            Caption = 'Employment Date';
        }
        field(31; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Inactive,Terminated';
            OptionMembers = Active, Inactive, Terminated;

            trigger OnValidate()
            begin
                EmployeeQualification.SetRange("Employee No.", "No.");
                EmployeeQualification.ModifyAll("Employee Status", Status);
                Modify;
            end;
        }
        field(32; "Inactive Date"; Date)
        {
            Caption = 'Inactive Date';
        }
        field(33; "Cause of Inactivity Code"; Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(34; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
        }
        field(35; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(38; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource WHERE(Type=CONST(Person));
        }
        field(39; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name"=CONST(Employee), "No."=FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(42; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(43; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(44; "Cause of Absence Filter"; Code[10])
        {
            Caption = 'Cause of Absence Filter';
            FieldClass = FlowFilter;
            TableRelation = "Cause of Absence";
        }
        field(45; "Total Absence (Base)"; Decimal)
        {
            CalcFormula = Sum("Employee Absence"."Quantity (Base)" WHERE("Employee No."=FIELD("No."), "Cause of Absence Code"=FIELD("Cause of Absence Filter"), "From Date"=FIELD("Date Filter")));
            Caption = 'Total Absence (Base)';
            DecimalPlaces = 0: 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; Extension; Text[30])
        {
            Caption = 'Extension';
        }
        field(47; "Employee No. Filter"; Code[20])
        {
            Caption = 'Employee No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(48; Pager; Text[30])
        {
            Caption = 'Pager';
        }
        field(49; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50; "Company E-Mail"; Text[80])
        {
            Caption = 'Company Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit 9520;
            begin
                MailManagement.ValidateEmailAddressField("Company E-Mail");
            end;
        }
        field(51; Title; Text[30])
        {
            Caption = 'Title';
        }
        field(52; "Salespers./Purch. Code"; Code[20])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(53; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(54; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
        field(55; "Employee Posting Group"; Code[20])
        {
            Caption = 'Employee Posting Group';
            TableRelation = "Employee Posting Group";
        }
        field(56; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.';
        }
        field(57; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(58; IBAN; Code[50])
        {
            Caption = 'IBAN';

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.CheckIBAN(IBAN);
            end;
        }
        field(59; Balance; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Employee Ledger Entry".Amount WHERE("Employee No."=FIELD("No."), "Initial Entry Global Dim. 1"=FIELD("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2"=FIELD("Global Dimension 2 Filter"), "Posting Date"=FIELD("Date Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
        }
        field(80; "Application Method"; Option)
        {
            Caption = 'Application Method';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual, "Apply to Oldest";
        }
        field(140; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(150; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';
        }
        field(1100; "Cost Center Code"; Code[20])
        {
            Caption = 'Cost Center Code';
            TableRelation = "Cost Center";
        }
        field(1101; "Cost Object Code"; Code[20])
        {
            Caption = 'Cost Object Code';
            TableRelation = "Cost Object";
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; Status, "Union Code")
        {
        }
        key(Key4; Status, "Emplymt. Contract Code")
        {
        }
        key(Key5; "Last Name", "First Name", "Middle Name")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "First Name", "Last Name", Initials, "Job Title")
        {
        }
        fieldgroup(Brick; "Last Name", "First Name", "Job Title", Image)
        {
        }
    }
    var HumanResSetup: Record "Human Resources Setup";
    Res: Record Resource;
    PostCode: Record "Post Code";
    AlternativeAddr: Record "Alternative Address";
    EmployeeQualification: Record "Employee Qualification";
    Relative: Record "Employee Relative";
    EmployeeAbsence: Record "Employee Absence";
    MiscArticleInformation: Record "Misc. Article Information";
    ConfidentialInformation: Record "Confidential Information";
    HumanResComment: Record "Human Resource Comment Line";
    SalespersonPurchaser: Record "Salesperson/Purchaser";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    EmployeeResUpdate: Codeunit "Employee/Resource Update";
    EmployeeSalespersonUpdate: Codeunit "Employee/Salesperson Update";
    DimMgt: Codeunit DimensionManagement;
    Text000: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
    BlockedEmplForJnrlErr: Label 'You cannot create this document because employee %1 is blocked due to privacy.', Comment = '%1 = employee no.';
    BlockedEmplForJnrlPostingErr: Label 'You cannot post this document because employee %1 is blocked due to privacy.', Comment = '%1 = employee no.';
    [Scope('Cloud')]
    procedure FullName(): Text[100]var
        NewFullName: Text[100];
        Handled: Boolean;
    begin
    end;
    [Scope('Cloud')]
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Employee, "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;
    procedure DisplayMap()
    var
        MapPoint: Record "Online Map Setup";
        MapMgt: Codeunit "Online Map Management";
    begin
        if MapPoint.FindFirst then MapMgt.MakeSelection(DATABASE::Employee, GetPosition)
        else
            Message(Text000);
    end;
    local procedure UpdateSearchName()
    var
        PrevSearchName: Code[250];
    begin
        PrevSearchName:=xRec.FullName + ' ' + xRec.Initials;
        if((("First Name" <> xRec."First Name") or ("Middle Name" <> xRec."Middle Name") or ("Last Name" <> xRec."Last Name") or (Initials <> xRec.Initials)) and ("Search Name" = PrevSearchName))then "Search Name":=SetSearchNameToFullnameAndInitials;
    end;
    local procedure SetSearchNameToFullnameAndInitials(): Code[250]begin
        exit(FullName + ' ' + Initials);
    end;
    [Scope('Cloud')]
    procedure GetBankAccountNo(): Text begin
        if IBAN <> '' then exit(DelChr(IBAN, '=<>'));
        if "Bank Account No." <> '' then exit("Bank Account No.");
    end;
    [Scope('Cloud')]
    procedure CheckBlockedEmployeeOnJnls(IsPosting: Boolean)
    begin
        if "Privacy Blocked" then begin
            if IsPosting then Error(BlockedEmplForJnrlPostingErr, "No.");
            Error(BlockedEmplForJnrlErr, "No.")end;
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetFullName(Employee: Record Employee; var NewFullName: Text[100]; var Handled: Boolean)
    begin
    end;
}
