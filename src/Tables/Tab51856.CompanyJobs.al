table 51856 "Company Jobs"
{
    DrillDownPageID = "Company Job List";
    LookupPageID = "Company Job List";
    Caption = 'Establishment';
    Permissions = tabledata "Company Jobs" = rimd;

    fields
    {
        field(1; "Job ID"; Code[20])
        {
        }
        field(2; Name; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "No of Posts"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "No of Posts" <> xRec."No of Posts" then "Vacant Posistions" := "No of Posts" - "Occupied Position";
            end;
        }
        field(4; "Position Reporting to"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Jobs"."Job ID";
        }
        field(5; "Occupied Position"; Integer)
        {
            // CalcFormula = Count("Employee Master" WHERE(Position = FIELD("Job ID"),
            // Status = CONST(Active)));
            CalcFormula = count("Employee" where("Job ID" = field("Job ID"), Status = filter(Active)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Vacant Posistions"; Integer)
        {
            Caption = 'Vacant Positions';
            DataClassification = ToBeClassified;
        }
        field(7; "Score code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Dimension 1"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(9; "Dimension 2"; Code[20])
        {
            CaptionClass = '1,1,2';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(10; "Dimension 3"; Code[20])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(11; "Dimension 4"; Code[20])
        {
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(12; "Dimension 5"; Code[20])
        {
            CaptionClass = '1,2,5';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(13; "Dimension 6"; Code[20])
        {
            CaptionClass = '1,2,6';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(14; "Dimension 7"; Code[20])
        {
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(15; "Dimension 8"; Code[20])
        {
            CaptionClass = '1,2,8';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(16; "No of Position"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Total Score"; Decimal)
        {
            CalcFormula = Sum("Job Requirements"."Score ID" WHERE("Job Id" = FIELD("Job ID")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Stage filter"; Integer)
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value";
        }
        field(19; "Objective"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Key Position"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Category; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; Grade; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale";

            trigger OnValidate()
            var
                SalaryScale: Record "Salary Scale";
                SalaryLevel: Record "Salary Level";
            begin
                SalaryScale.Reset();
                SalaryScale.SetRange(Scale, Rec.Grade);
                if SalaryScale.FindFirst() then begin
                    SalaryLevel.Reset();
                    SalaryLevel.SetRange(Level, SalaryScale."Minimum Pointer");
                    if SalaryLevel.FindSet() then begin
                        "Minimum Salary" := SalaryLevel."Basic Pay";
                    end;
                end;
                SalaryScale.Reset();
                SalaryScale.SetRange(Scale, Rec.Grade);
                if SalaryScale.FindFirst() then begin
                    SalaryLevel.Reset();
                    SalaryLevel.SetRange(Level, SalaryScale."Maximum Pointer");
                    if SalaryLevel.FindSet() then begin
                        "Maximum Salary" := SalaryLevel."Basic Pay";
                    end;
                end;
            end;
        }
        field(24; "Primary Skills Category"; Enum "Skills Categories")
        {
            DataClassification = ToBeClassified;
        }
        field(25; "2nd Skills Category"; Enum "Skills Categories")
        {
            DataClassification = ToBeClassified;
        }
        field(26; "3nd Skills Category"; Enum "Skills Categories")
        {
            DataClassification = ToBeClassified;
        }
        field(27; Management; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; Profession; Code[20])
        {
            TableRelation = "Job Professions";
        }
        field(29; "No Series"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Job Template"; Code[20])
        {
            Editable = false;
            TableRelation = "Job Template";
        }
        field(34; Status; Enum "Document Status")
        {
            //OptionMembers = Open,"Pending Approval",Approved;        
            Editable = false;
        }
        field(35; "Deployment Center"; Code[20])
        {
            TableRelation = "Responsibility Center";

            trigger OnValidate()
            var
                Responsibility: Record "Responsibility Center";
            begin
                if Responsibility.Get("Deployment Center") then "Deployment Center Name" := Responsibility.Name;
            end;
        }
        field(36; "Date Created"; Date)
        {
        }
        field(37; "Reason for Job creation"; Option)
        {
            OptionMembers = "New Vacancy","Replacement","Retirement","Retrenchment","Demise","Other";
        }
        field(38; "Memo Ref No."; Code[100])
        {
        }
        field(39; "Memo Approval Date"; Date)
        {
        }
        field(40; "Male Ocupants"; Integer)
        {
            CalcFormula = count("Employee" where("Job ID" = field("Job ID"), Status = filter(active), Gender = filter(Male)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(41; "Female Ocupants"; Integer)
        {
            CalcFormula = count("Employee" where("Job ID" = field("Job ID"), Status = filter(active), Gender = filter(Female)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(42; "Reporting Postion"; Code[20])
        {
            TableRelation = "Company Jobs";

            trigger OnValidate()
            var
                HRJobs: Record "Company Jobs";
            begin
                If HRJobs.Get("Reporting Postion") then "Reporting Postion Name" := HRJobs.Name;
            end;
        }
        field(43; "Reporting Postion Name"; Text[250])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(44; "Job Purpose"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Criticality Status"; Enum "Criticality Status")
        {
        }
        field(46; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(47; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            trigger OnValidate()
            begin
                if DimisionReg.Get("Global Dimension 2 Code") then
                    "Description Programme Code" := DimisionReg.Name;
            end;
        }
        field(48; "Deployment Center Name"; Text[100])
        {
            Editable = false;
            Caption = 'Name';
        }
        field(49; "Sample Writings"; Boolean)
        {
        }
        field(50; "Min. Years of Experience"; Decimal)
        {
        }
        field(60; "Minimum Salary"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(61; "Maximum Salary"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(62; "Vacancy Announcement"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(63; "Tems of Service"; Enum "TermsOf Service")
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Reporting Responsibilities"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(65; "Area Of Deployment"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(67; "Reason for Job creations"; Text[500])
        {
            // OptionMembers = "New Vacancy", "Replacement", "Retirement", "Retrenchment", "Demise", "Other";
        }

        //Programme Code
        field(147; "Description Programme Code"; Code[20])
        {
            Caption = 'Description Programme';
            //TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(148; "Minimum Sample Writings"; Integer)
        {
        }
    }
    keys
    {
        key(Key1; "Job ID")
        {
        }
        key(Key2; "Vacant Posistions")
        {
        }
        key(Key3; "Dimension 1")
        {
        }
        key(Key4; "Dimension 2")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Job ID", Name)
        {
        }
    }
    var
        CompanyJobsSetup: Record "QuantumJumps HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimisionReg: Record "Dimension Value";

    trigger OnInsert()
    begin
        //Message('start');
        if "Job ID" = '' then begin
            CompanyJobsSetup.Get;
            CompanyJobsSetup.TestField("Job Nos");
            NoSeriesMgt.InitSeries(CompanyJobsSetup."Job Nos", xRec."Job ID", 0D, "Job ID", "No Series");
            "Date Created" := Today;
            Status := Status::Open;
        end;
    end;
}
