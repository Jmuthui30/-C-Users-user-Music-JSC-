table 51880 "Recruitment Needs"
{
    DrillDownPageID = "Approved Recruitment Request";
    LookupPageID = "Approved Recruitment Request";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = false;
        }
        field(2; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = "Company Jobs"."Job ID" where(Status = const(Released));

            trigger OnValidate()
            var
                SalaryScale: Record "Salary Scale";
                SalaryLevel: Record "Salary Level";
            begin
                if Jobs.Get("Job ID") then begin
                    //Jobs.TestField(Profession);
                    // Jobs.TestField(Objective);
                    Description := Jobs.Name;
                    Profession := Jobs.Profession;
                    Objective := Jobs.Objective;
                    "Vacancy Announcement" := Jobs."Vacancy Announcement";
                    "Tems of Service" := Jobs."Tems of Service";
                    "Job Purpose" := Jobs."Job Purpose";
                    "Area Of Deployment" := Jobs."Deployment Center";
                    "Min. Years of Experience" := Jobs."Min. Years of Experience";
                    "Sample Writings" := Jobs."Sample Writings";
                    "Reporting Responsibilities" := Jobs."Reporting Responsibilities";
                    "Memo Ref No." := Jobs."Memo Ref No.";
                    Positions := Jobs."No of Position";
                    SalaryScale.Reset();
                    SalaryScale.SetRange(Scale, Jobs.Grade);
                    if SalaryScale.FindFirst() then begin
                        SalaryLevel.Reset();
                        SalaryLevel.SetRange(Level, SalaryScale."Minimum Pointer");
                        if SalaryLevel.FindSet() then begin
                            "Minimum Salary" := SalaryLevel."Basic Pay";
                        end;
                    end;
                    SalaryScale.Reset();
                    SalaryScale.SetRange(Scale, Jobs.Grade);
                    if SalaryScale.FindFirst() then begin
                        SalaryLevel.Reset();
                        SalaryLevel.SetRange(Level, SalaryScale."Maximum Pointer");
                        if SalaryLevel.FindSet() then begin
                            "Maximum Salary" := SalaryLevel."Basic Pay";
                        end;
                    end;
                end;
            end;
        }
        field(3; Date; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; Priority; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'High,Medium,Low';
            OptionMembers = High,Medium,Low;
        }
        field(5; Positions; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ConsolidatedPlan: Record "Recruitment Plan Lines";
            begin
                // Get(ConsolidatedPlan."Document No.");
                // SetRange("No.", "No.");
                // SetRange("Job ID", "Job ID");
                if Positions <> ConsolidatedPlan."Required Positions" then Message('You are trying to request fo unplanned positions. Proceeed with caution as this may result into future errors. For more information, Kindly contact The HR admin.');
                Jobs.SetRange(Jobs."Job ID", "Job ID");
                if Jobs.Find('-') then
                    if Positions > Jobs."Vacant Posistions" then
                        Error('Positions cannot be more than vacant positions in staff establishment');
            end;
        }

        field(6; Approved; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Date Approved" := Today;
            end;
        }
        field(7; "Date Approved"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Description; Text[2000])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; Stage; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Recruitment Stages"."Recruitement Stage";
        }
        field(10; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Stage Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recruitment Stages"."Recruitement Stage";
        }
        field(12; Qualified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "No Filter"; Integer)
        {
            FieldClass = FlowFilter;
        }
        field(14; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(16; "Documentation Link"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'External Documentation Link';
            ExtendedDatatype = URL;
        }
        field(17; "Turn Around Time"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(19; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }

        field(20; "Reason for Recruitment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","New Position","Existing Position";
        }
        field(21; "Appointment Type"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employment Contract";
            trigger OnValidate()
            var
                Employ: Record "Employment Contract";
            begin
                if Employ.Get("Appointment Type") then
                    "Appointment Type Description" := Employ.Description;
            end;
        }
        field(22; "Requested By"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(23; "Expected Reporting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; Status; Enum "Document Status")
        {
        }
        field(25; "Interview Conducted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Interview Committee"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Committees.Code;

            trigger OnValidate()
            begin
                if Committees.Get("Interview Committee") then begin
                    Committees.TestField(Interview, true);
                    "Interview Commitee Name" := Committees.Description;
                end;
            end;
        }
        field(27; "Interview Commitee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(28; Objective; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Job Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Advertisement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Advertisement Close Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "No Of Applicants"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count(Applicant WHERE("Vacancy No." = FIELD("No.")));
            Editable = false;
        }
        field(34; "Advertisement Status"; Enum AdvertismentStatus)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Profession"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(36; "Advertisement Type"; Enum "Advertisement Types")
        {
        }
        field(37; "Medical Examonation Conducted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Shortlisting Conducted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Advertised"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(41; Closed; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(42; "Closed By"; Code[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(43; "Closed Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50; "Minimum Salary"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(51; "Maximum Salary"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52; "Show Salary"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = true;
        }
        field(60; "Min. Years of Experience"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(61; "Sample Writings"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(62; "Area Of Deployment"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(63; "No. Of Positions"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(64; "Advertisement Reg. Date"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Advertisment Registration Date';
        }
        field(65; "Advertisment Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(66; "Advertisment Status"; Enum AdvertismentStatus)
        {
            DataClassification = ToBeClassified;
        }
        field(67; "No. Of Applicants"; Integer)
        {
            //DataClassification = ToBeClassified;
            FieldClass = FlowField;
            CalcFormula = count(Applicant where("Job ID" = field("Job ID"), "Vacancy No." = field("No.")));
            Editable = false;
        }
        field(68; "Vacancy Announcement"; Text[2048])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(69; "Tems of Service"; Enum "TermsOf Service")
        {
            DataClassification = CustomerContent;
        }
        field(70; "Job Purpose"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(71; "Reporting Responsibilities"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(72; "Preferred Gender"; text[20])
        {
            DataClassification = CustomerContent;
        }
        field(73; "Age Limit"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(74; "Work Experience"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(101; "Submitted To Portal"; Boolean)
        {
            Caption = 'Submitted To Portal';
        }
        field(102; "Shortlisting Started"; Boolean)
        {
            Caption = 'Shortlisting Started';
        }
        field(103; "Appointment Type Description"; Text[200])
        {
            Caption = 'Appointment Type Description';
        }
        field(104; "Qualified Applicants"; Integer)
        {
            Editable = false;
            Caption = 'Qualified Applicants';
            FieldClass = FlowField;
            CalcFormula = count("Applicant Shortlist" where("Need Code" = field("No."), Qualified = const(true)));
        }
        field(125; "Reason for Recruitment(text)"; Text[250])
        {
            Caption = 'Reason for Recruitment(text)';
        }
        field(129; "Shortlisting Closed"; Boolean)
        {
            Caption = 'Shortlisting Closed';
        }
        field(191; "Shortlist Criteria"; Enum "Shortlist Criteria")
        {
            Caption = 'Shortlist Criteria';
        }
        field(192; "Education Type"; Enum "Education Types")
        {
            Caption = 'Education Type';
        }
        field(193; "Education Level"; Enum "Education Level")
        {
            Caption = 'Education Level';
        }
        field(194; "Proficiency Level"; Enum "Proficiency Level")
        {
            Caption = 'Proficiency Level';
        }
        field(195; "Field of Study"; Code[50])
        {
            TableRelation = "Field of Study";
            Caption = 'Field of Study';
        }

        field(106; "Non-Qualified Applicants"; Integer)
        {
            Editable = false;
            Caption = 'Non-Qualified Applicants';
            FieldClass = FlowField;
            CalcFormula = count("Applicant Shortlist" where("Need Code" = field("No."), Qualified = const(false)));
        }
        field(107; "Total Recruitment Costs"; Decimal)
        {
            Caption = 'Total Recruitment Costs';
            FieldClass = FlowField;
            CalcFormula = sum("Recruitment Cost".Amount where("Need Code" = field("No.")));
            Editable = false;
        }
        field(196; "Minimum years of experience"; integer)
        {
            Caption = 'Minimum years of experience';
        }
        field(197; "Maximum years of experience"; integer)
        {
            Caption = 'Maximum years of experience';
        }
        field(98; "Experience industry"; Code[50])
        {
            TableRelation = "Company Job Industry";
            Caption = 'Experience industry';
        }
        field(99; "Professional Course"; Code[50])
        {
            TableRelation = Qualification.Code where("Qualification Type" = const(Academic));
            Caption = 'Professional Course';
        }
        field(100; "Professional Membership"; Code[50])
        {
            TableRelation = "Professional Memberships";
            Caption = 'Professional Membership';
        }
        field(111; "Employment Done"; Code[50]) { }
        field(112; "Employment Date"; Date) { }
        //************************************************************Added 5th march
        field(113; "Memo Ref No."; Code[100])
        {
        }
        field(114; "Terms of Service:"; Text[500])
        {

        }
        field(115; "Remuneration:"; Text[500])
        { }
        field(116; "Key Duties & Responsibilities:"; Text[2000])
        {

        }
        field(117; "HOW TO APPLY"; Text[2000])
        {

        }
        field(118; "HOW TO APPLY1"; Text[2000])
        {

        }
        field(119; "Terms and Conditions"; Text[2048])
        {

        }
        field(123; "Terms and Conditions 2"; Text[2048])
        { }
        field(230; "Terms and Conditions 3"; Text[2048])
        { }
        field(120; "Job Academic and Professional"; Text[2048])
        { }
        field(121; "Submitted Applicant Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(Applicant where("Recruitment Needs NO" = field("No."), Submitted = filter(true)));


        }
        field(229; "Submitted jobs Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Job Application" where("Recruitment Needs No." = field("No."), Submitted = filter(true)));


        }
        field(122; "Work Station"; Text[500])
        { }
        field(124; Grade; Code[20])
        { }
        field(231; "Constitution Requirement"; Text[2048])
        { }
        field(234; "Judge Function Title"; Text[100]) { }
        field(232; "Functions of the Judge"; Text[2048]) { }
        field(233; "Functions of the Judge1"; Text[2048]) { }



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
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField(HumanResSetup."Recruitment Needs Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Recruitment Needs Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Date := Today;
        "Requested By" := UserId;
        "Advertisement Type" := "Advertisement Type"::" ";
        Status := Status::Open;
    end;

    var
        Jobs: Record "Company Jobs";
        App: Record Applicant;
        RShort: Record "Shortlisting Criteria";
        DimMgt: Codeunit DimensionManagement;
        HumanResSetup: Record "QuantumJumps HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Committees: Record Committees;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.SaveDefaultDim(DATABASE::"Recruitment Needs","No.",FieldNumber,ShortcutDimCode);
        Modify;
    end;
}
