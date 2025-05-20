table 50041 "Recruitment Plan Lines"
{
    Caption = 'Recruitment Plan Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                RecruitmentPlan: Record "Recruitment Plan";
            begin
                if RecruitmentPlan.Get("Document No.")then begin
                    "Global Dimension 1 Code":=RecruitmentPlan."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=RecruitmentPlan."Global Dimension 2 Code";
                    "Fiscal Year":=RecruitmentPlan."Fiscal Year";
                end;
            end;
        }
        field(2; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Company Jobs" where("Global Dimension 2 Code" = field("Global Dimension 2 Code"));
            TableRelation = "Company Jobs";

            trigger OnValidate()
            var
                HRJobs: Record "Company Jobs";
            begin
                Clear("Job Title");
                Clear("Grade");
                Clear("No of Posts");
                Clear("Position Reporting to Code");
                Clear("Position Reporting to Name");
                Clear("Occupied Positions");
                Clear("Vacant Positions");
                Clear("Required Positions");
                HRJobs.Reset();
                HRJobs.SetAutoCalcFields("Occupied Position");
                if HRJobs.Get("Job ID")then begin
                    HRJobs.TestField(Grade);
                    HRJobs.TestField(Name);
                    HRJobs.Validate("No of Posts");
                    HRJobs.Modify();
                    "Grade":=HRJobs.Grade;
                    "Job Title":=HRJobs.Name;
                    "Occupied Positions":=HRJobs."Occupied Position";
                    "Vacant Positions":=HRJobs."Vacant Posistions";
                    "No of Posts":=HRJobs."No of Posts";
                    "Position Reporting to Code":=HRJobs."Reporting Postion";
                    "Position Reporting to Name":=HRJobs."Reporting Postion Name";
                end;
            end;
        }
        field(3; "Job Title"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No of Posts"; Integer)
        {
            BlankZero = true;
        }
        field(7; "Position Reporting to Code"; Code[20])
        {
            TableRelation = "Company Jobs";
        }
        field(8; "Occupied Positions"; Integer)
        {
            Editable = false;
        }
        field(9; "Vacant Positions"; Integer)
        {
            Editable = false;
        }
        field(10; "Position Reporting to Name"; Text[250])
        {
            Editable = false;
        }
        field(11; "Required Positions"; Integer)
        {
            trigger OnValidate();
            begin
                IF "Required Positions" > "Vacant Positions" THEN BEGIN
                    Message('Required positions exceeds the total number of vacant positions by [ %1 ]', format("Vacant Positions" - "Required Positions"));
                END;
                IF "Required Positions" <= 0 THEN BEGIN
                    ERROR('Required positions cannot be Less Than or Equal to Zero');
                END;
            end;
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(14; "Fiscal Year"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document No.", "Job ID")
        {
            Clustered = true;
        }
    }
}
