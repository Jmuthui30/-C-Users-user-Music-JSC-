table 51630 "Applicant"
{
    // version THL- HRM 1.0
    Caption = 'Employee';
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name";
    DrillDownPageID = "Applicant List";
    LookupPageID = "Applicant List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HumanResSetup.Get;
                    NoSeriesMgt.TestManual(HumanResSetup."Applicants Nos.");
                    "No. Series":='';
                //
                end;
                HumanResSetup.Get;
                "Probation Period":=HumanResSetup."Probation Period";
                "Probation Termination Notice":=HumanResSetup."Probation Termination Notice";
                "Annual Leave Days":=HumanResSetup."Annual Leave Days";
                "Leave Notice Period":=HumanResSetup."Leave Notice Period";
                "Contract Termination Notice":=HumanResSetup."Contract Termination Notice";
                "Hours Worked Per Week":=HumanResSetup."Hours Worked Per Week";
                "Days Worked Per Week":=HumanResSetup."Days Worked Per Week";
                "Reporting Time":=HumanResSetup."Reporting Time";
                "Closing Time":=HumanResSetup."Closing Time";
                "Lunch Break Duration":=HumanResSetup."Lunch Break Duration";
                "Lunch Start Time":=HumanResSetup."Lunch Start Time";
                "Lunch End Time":=HumanResSetup."Lunch End Time";
                "Week Start Day":=HumanResSetup."Week Start Day";
                "Week End Day":=HumanResSetup."Week End Day";
                "Offer Signed By":=HumanResSetup."Offers Signed By";
                Modify;
            end;
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
        field(6; "Position Applied For"; Text[200])
        {
        }
        field(7; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
        }
        field(8; "Postal Address"; Text[50])
        {
            Caption = 'Address';
        }
        field(181; "Postal Address new"; Integer)
        {
            Caption = 'Address';
        }
        field(9; "Physical Address"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';

            //TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code".City
            // ELSE
            // IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            // ValidateTableRelation = false;
            trigger OnValidate()
            begin
            //PostCode.ValidateCity(City, "Post Code", "Home County", "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            //TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code";
            TableRelation = "Post Code".Code;

            /*Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST('')) "Post Code"
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code" WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;*/
            trigger OnValidate()
            var
                countyrreg: Record "Post Code";
            begin
                ///countyrreg.Get();
                 //  PostCode.ValidatePostCode(City, "Post Code", "Home County", "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
                PostCode.RESET;
                PostCode.SETRANGE(PostCode.Code, "Post Code");
                IF PostCode.FIND('-')THEN BEGIN
                    City:=PostCode.City;
                END;
            end;
        }
        field(12; "Home County"; Text[30])
        {
            TableRelation = Counties;
        }
        field(13; "Alternative Phone No."; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(15; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
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

            trigger OnValidate()
            begin
                AgeValidation;
                Age:=HRDatesExt.DetermineDatesDiffrence("Birth Date", Today);
            end;
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
        field(24; Gender;Enum "Employee Gender")
        {
            Caption = 'Gender';
        }
        field(25; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(26; "Manager No."; Code[20])
        {
            Caption = 'Manager No.';
            TableRelation = Employee where(Status=const(Active));
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
        field(30; "Portal ID"; Integer)
        {
        }
        field(31; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = '"Active",Inactive,Terminated/Withdrawn';
            OptionMembers = Active, Inactive, Terminated;

            //Editable = false;
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
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=const(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(38; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3), Blocked=const(false));
        }
        field(39; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource WHERE(Type=CONST(Person));
        }
        field(40; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name"=CONST(Employee), "No."=FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
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
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=const(false));
        }
        field(43; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=const(false));
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
            TableRelation = Employee where(Status=const(Active));
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
        }
        field(51; Title; Text[100])
        {
            Caption = 'Title';
        }
        field(52; "Salespers./Purch. Code"; Code[10])
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
        field(54; "Years Of Experience"; Decimal)
        {
        }
        field(55; "Years Of Relevant Experience"; Decimal)
        {
        }
        field(56; "Current/Expected Salary"; Decimal)
        {
        }
        field(57; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Jobs";

            trigger OnValidate()
            var
                CompanyJobs: Record "Company Jobs";
            begin
                If CompanyJobs.Get("Job ID")then "Position Applied For":=CompanyJobs.Name;
                "Vacancy No.":=Format(CompanyJobs."No of Posts");
            end;
        }
        field(58; "Applicant Type";Enum ApplicantType)
        {
            DataClassification = ToBeClassified;
        }
        field(59; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(60; "Cost Center Code"; Code[20])
        {
            Caption = 'Cost Center Code';
            TableRelation = "Cost Center";
        }
        field(61; "Cost Object Code"; Code[20])
        {
            Caption = 'Cost Object Code';
            TableRelation = "Cost Object";
        }
        field(62; "Office Location"; Text[30])
        {
        }
        field(63; "Probation Period"; Text[30])
        {
        }
        field(64; "Probation Termination Notice"; Text[30])
        {
        }
        field(65; "Annual Leave Days"; Integer)
        {
        }
        field(66; "Leave Notice Period"; Integer)
        {
        }
        field(67; "Contract Termination Notice"; Text[30])
        {
        }
        field(68; "Hours Worked Per Week"; Decimal)
        {
        }
        field(69; "Days Worked Per Week"; Decimal)
        {
        }
        field(70; "Reporting Time"; Time)
        {
        }
        field(71; "Closing Time"; Time)
        {
        }
        field(72; "Lunch Break Duration"; Text[30])
        {
        }
        field(73; "Lunch Start Time"; Time)
        {
        }
        field(74; "Lunch End Time"; Time)
        {
        }
        field(75; "Week Start Day"; Text[30])
        {
        }
        field(76; "Week End Day"; Text[30])
        {
        }
        field(77; "Offer Signed By"; Text[50])
        {
        }
        field(78; "Offer Status"; Option)
        {
            OptionCaption = 'Applicant,Offer Made,Accepted Offer,Reported to Work,Rejected Offer,Failed';
            OptionMembers = Applicant, "Offer Made", "Accepted Offer", "Reported to Work", "Rejected Offer", Failed;
            Editable = false;
        }
        field(79; Shortlisting; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Passed,Failed';
            OptionMembers = Open, Passed, Failed;
            Editable = false;
        }
        field(80; "Total Interview Marks"; Decimal)
        {
            CalcFormula = Sum("Job Interview Rating".Marks WHERE("Applicant No"=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(81; Interview; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Passed,Failed';
            OptionMembers = " ", Passed, Failed;
            Editable = true;
        }
        field(82; "National ID"; Code[10])
        {
            Caption = 'ID No. (For Kenyans)';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                RecApplicant: Record Applicant;
            begin
                IF "National ID" <> '' THEN BEGIN
                    RecApplicant.RESET;
                    RecApplicant.SETRANGE(RecApplicant."National ID", "National ID");
                    IF RecApplicant.FIND('-')THEN BEGIN
                        IF(RecApplicant."No." <> "No.")THEN ERROR('ID No. already exists.Belong to 1%', RecApplicant.FullName);
                    END;
                END;
            end;
        }
        field(83; Profession; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Professions;
        }
        field(84; LinkedIn; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(85; "Highest Level Of Education"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Education Levels";
        }
        field(86; "Ethnic Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Ethnic Groups";
        }
        field(87; "Pays Tax"; Boolean)
        {
        }
        /* field(88; "ID Number"; Code[10])
        {
        } */
        field(89; "Passport No."; Code[10])
        {
        }
        field(90; "Marital Status";Enum MaritalStatus)
        {
        }
        field(91; "NSSF No"; Code[20])
        {
        }
        field(92; "SHIF No"; Code[20])
        {
        }
        field(93; "HELB No"; Code[20])
        {
        }
        field(94; "Full / Part Time"; Option)
        {
            OptionCaption = 'Full Time,Part Time';
            OptionMembers = "Full Time", "Part Time";
        }
        field(95; "Contract Type"; Code[10])
        {
        }
        field(96; "Exit Interview Date"; Date)
        {
        }
        field(97; "Exit Interview Done By"; Text[30])
        {
        }
        field(98; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(99; "Staff No."; Code[20])
        {
        }
        field(100; "Created Date"; DateTime)
        {
        }
        field(101; "Vacancy No."; Code[20])
        {
        }
        field(102; Nationality; Option)
        {
            OptionMembers = Kenyan, Others;
        // TableRelation = "Country/Region".Code;
        }
        field(222; "Nationality New"; Code[30])
        {
            // OptionMembers = Kenyan,Others;
            TableRelation = "Country/Region".Code;
        }
        field(103; "Passport Issue Date"; Date)
        {
        }
        field(104; "Passport Expiry Date"; Date)
        {
        }
        field(105; "Permit No."; Code[20])
        {
        }
        field(106; "Permit Issue Date"; Date)
        {
        }
        field(107; "Permit Validity Period"; Date)
        {
            Editable = true;
        }
        field(108; Disability; Boolean)
        {
        }
        field(109; "NCPWD Certificate No."; Code[20])
        {
        }
        field(110; "Criminal Declaration"; Boolean)
        {
            Caption = 'Have you ever been convicted of, or cautioned for, any criminal offence or are any other proceedings pending against you?';

            trigger OnValidate()
            begin
                if not "Criminal Declaration" then "Criminal Decl. Specification":='';
            end;
        }
        field(111; "Criminal Decl. Specification"; Text[250])
        {
            Caption = 'Please Give Details of the case and any penalty for each offence';
        }
        field(112; "Dismissal Declaration"; Boolean)
        {
            Caption = 'Have you ever been dismissed or otherwise removed from the Judicial service, Public Service or other engagement?';

            trigger OnValidate()
            begin
                if not "Dismissal Declaration" then "Dismissal Decl. Specification":='';
            end;
        }
        field(113; "Dismissal Decl. Specification"; Text[250])
        {
            //ToolTip = 'Dismissal Declaration Specification';
            Caption = 'Please Give Details';
        }
        field(114; "Application Letter"; Text[2048])
        {
            ExtendedDatatype = URL;
        }
        field(115; "Curriculum Vitae"; Text[2048])
        {
            ExtendedDatatype = URL;
        }
        field(116; "Testimonials"; MediaSet)
        {
        }
        field(117; "Passport Photo"; Text[2048])
        {
            Caption = 'Passport Photo (Optional)';
        //Subtype = Bitmap;
        }
        field(118; "Identification Document"; Text[2048])
        {
            ExtendedDatatype = URL;
            Caption = 'National ID/Other Legal Identification Document';
        }
        field(119; "Certificate of Admission"; MediaSet)
        {
            Caption = 'Certificate of Admission to the Roll of Advocates (Where Applicable)';
        }
        field(120; "Final Declaration"; Boolean)
        {
            Caption = 'I certify that the particulars given on this form are correct and understand that any incorrect/misleading information may lead to disqualification/ legal action ';
        }
        field(121; "Declaration Date"; DateTime)
        {
            Caption = 'Date (dd-mm-yyyy)';
        }
        field(122; Signature; Text[2048])
        {
            //SubType = Bitmap;
            Caption = 'Signature of Applicant (Upload scanned signature)';
            ExtendedDatatype = URL;
        }
        field(123; "Gender Specification"; Text[100])
        {
        }
        field(124; "Disability Description"; Text[2000])
        {
            Caption = 'Description';
        }
        field(125; "Nationality Specification"; Text[50])
        {
        }
        field(126; "Current Salary"; Decimal)
        {
        }
        field(127; "Expected Salary"; Decimal)
        {
        }
        field(128; "Mediacal Examination"; Option)
        {
            Caption = 'Examination Results';
            OptionMembers = " ", Passed, Failed;
            Editable = false;
        }
        field(129; "Annual Gross Salary"; Decimal)
        {
        }
        field(130; "Salary Currency"; Code[10])
        {
            TableRelation = Currency;
        }
        field(131; "Staff ID"; Code[20])
        {
            TableRelation = Employee;
        }
        field(200; Age; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Age';
        }
        field(201; Submitted; Boolean)
        {
        }
        field(208; Qualified; Boolean)
        {
            Caption = 'Qualified';
        }
        field(259; "Job Applied For"; Code[20])
        {
            Editable = true;
            TableRelation = "Company Job";
            Caption = 'Job Applied For';

            trigger OnValidate()
            begin
                Jobs.Reset();
                Jobs.SetRange("Job ID", "Job Applied For");
                if Jobs.Find('-')then begin
                    "Job Description":=Jobs."Job Description";
                    Practical:=Jobs.Practical;
                    Classroom:=Jobs.Classroom;
                    "Oral (Board)":=Jobs."Oral Interview (Board)";
                    Oral:=Jobs."Oral Interview";
                end;
            end;
        }
        field(269; "Job Description"; Text[200])
        {
            Editable = false;
            Caption = 'Job Description';
        }
        field(285; Practical; Boolean)
        {
            Caption = 'Practical';
        }
        field(286; Classroom; Boolean)
        {
            Caption = 'Classroom';
        }
        field(284; "Oral (Board)"; Boolean)
        {
            Caption = 'Oral (Board)';
        }
        field(283; Oral; Boolean)
        {
            Caption = 'Oral';
        }
        field(261; "Total Score"; Decimal)
        {
            CalcFormula = sum("Applicants Qualification".Score where(No=field("No.")));
            FieldClass = FlowField;
            Caption = 'Total Score';
        }
        field(263; Employ; Boolean)
        {
            Caption = 'Employ';

            trigger OnValidate()
            begin
                if Jobs.Get("Job Applied For")then begin
                    Oral:=Jobs."Oral Interview";
                    "Oral (Board)":=Jobs."Oral Interview (Board)";
                    Classroom:=Jobs.Classroom;
                    Practical:=Jobs.Practical;
                    Modify();
                end;
            end;
        }
        field(280; "Interview Date"; Date)
        {
            Caption = 'Interview Date';

            trigger OnValidate()
            begin
                if "Interview Date" > Today()then Error('Date can not be in the future');
            end;
        }
        field(281; "Interview Time"; Time)
        {
            Caption = 'Interview Time';
        }
        field(282; "Personal Title"; Option)
        {
            OptionCaption = ',Mr,Mrs,Ms,Dr,Prof,Other';
            OptionMembers = , Mr, Mrs, Ms, Dr, Prof, Other;
        }
        field(287; "First Language Read"; Boolean)
        {
        }
        field(288; "First Language Write"; Boolean)
        {
        }
        field(289; "First Language Speak"; Boolean)
        {
        }
        field(290; "Second Language Read"; Boolean)
        {
        }
        field(300; "Second Language Write"; Boolean)
        {
        }
        field(301; "Second Language Speak"; Boolean)
        {
        }
        field(302; "First Language (R/W/S)"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Language.Code;
        }
        field(303; "Second Language (R/W/S)"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Language.Code;
        }
        field(304; "Current Employer"; Code[200])
        {
        }
        field(305; "Sector Of Employement"; Option)
        {
            OptionCaption = ',Public,Private,Academia,Corporate,Others (Specify),';
            OptionMembers = , Public, Private, Academia, Corporate, Others;
        }
        field(306; "Others Description"; Text[2048])
        {
        }
        field(307; "Substantive Post"; Text[2048])
        {
        }
        field(308; "Employment No."; Code[30])
        {
        }
        field(309; "Job Group/ Grade"; Code[30])
        {
        }
        field(310; "Effective Date of Employment"; Date)
        {
        }
        field(311; "Terms of Service"; Option)
        {
            OptionCaption = ',Pensionable,Contract,Others (Specify),';
            OptionMembers = , Pensionable, Contract, Others;
        }
        field(312; "Other Language (R/W/S)"; Code[10])
        {
            DataClassification = CustomerContent;
        //TableRelation = Language.Code;
        }
        field(313; "Other Language Read"; Boolean)
        {
        }
        field(314; "Other Language Write"; Boolean)
        {
        }
        field(315; "Other Language Speak"; Boolean)
        {
        }
        field(316; "SampleWritings count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Titles of Sample Writings" where("Source No"=field("No.")));
        }
        field(317; "Nationality Name"; Code[100])
        {
            TableRelation = "Country/Region".Code;
        }
        field(318; "No of Year"; Code[100])
        {
        }
        field(319; "Description"; Code[200])
        {
        }
        field(320; "Submitted Date"; Date)
        {
        }
        field(321; "Submitted Time"; Time)
        {
        }
        field(322; "Recruitment Needs NO"; Code[100])
        {
        }
        field(386; "Sub Ethnic Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        // TableRelation = "Ethnic Groups";
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
        fieldgroup(DropDown; "No.", "First Name", "Last Name", Initials, "Position Applied For")
        {
        }
        fieldgroup(Brick; "No.", "First Name", "Last Name", "Position Applied For", Image)
        {
        }
    }
    trigger OnDelete()
    begin
        OnDeleteApplicant(Rec);
    end;
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Applicants Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Applicants Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            "Probation Period":=HumanResSetup."Probation Period";
            "Probation Termination Notice":=HumanResSetup."Probation Termination Notice";
            "Annual Leave Days":=HumanResSetup."Annual Leave Days";
            "Leave Notice Period":=HumanResSetup."Leave Notice Period";
            "Contract Termination Notice":=HumanResSetup."Contract Termination Notice";
            "Hours Worked Per Week":=HumanResSetup."Hours Worked Per Week";
            "Days Worked Per Week":=HumanResSetup."Days Worked Per Week";
            "Reporting Time":=HumanResSetup."Reporting Time";
            "Closing Time":=HumanResSetup."Closing Time";
            "Lunch Break Duration":=HumanResSetup."Lunch Break Duration";
            "Lunch Start Time":=HumanResSetup."Lunch Start Time";
            "Lunch End Time":=HumanResSetup."Lunch End Time";
            "Week Start Day":=HumanResSetup."Week Start Day";
            "Week End Day":=HumanResSetup."Week End Day";
            "Offer Signed By":=HumanResSetup."Offers Signed By";
        end;
        //
        OnInsertApplicant(Rec);
        "Created Date":=CurrentDateTime;
    end;
    trigger OnModify()
    begin
        "Last Date Modified":=Today;
    end;
    trigger OnRename()
    begin
        "Last Date Modified":=Today;
    end;
    var HumanResSetup: Record "Human Resources Setup";
    Employee: Record Applicant;
    PostCode: Record "Post Code";
    EmployeeQualification: Record "Employee Qualification";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    DimMgt: Codeunit DimensionManagement;
    Text000: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
    HRDatesExt: Codeunit "HR Dates Mgt";
    CompanyJob: Record "Company Job";
    Jobs: Record "Company Job";
    procedure AssistEdit(OldEmployee: Record Applicant): Boolean begin
        Employee:=Rec;
        HumanResSetup.Get;
        HumanResSetup.TestField("Applicants Nos.");
        if NoSeriesMgt.SelectSeries(HumanResSetup."Applicants Nos.", OldEmployee."No. Series", Employee."No. Series")then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Applicants Nos.");
            NoSeriesMgt.SetSeries(Employee."No.");
            Rec:=Employee;
            exit(true);
        end;
    end;
    procedure FullName(): Text[100]begin
        if "Middle Name" = '' then exit("First Name" + ' ' + "Last Name");
        exit("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;
    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
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
    [IntegrationEvent(false, false)]
    procedure OnInsertApplicant(var Applicant: Record Applicant)
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnDeleteApplicant(var Applicant: Record Applicant)
    begin
    end;
    local procedure AgeValidation()
    begin
        if "Birth Date" <> 0D then if((Date2DMY(WorkDate, 3) - Date2DMY("Birth Date", 3)) < 18)then Error('You cannot employ an underage candidate');
    end;
}
