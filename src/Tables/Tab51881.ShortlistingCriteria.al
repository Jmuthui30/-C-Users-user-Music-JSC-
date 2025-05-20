table 51881 "Shortlisting Criteria"
{
    fields
    {
        field(1; "Vacancy No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recruitment Needs"."No.";
        }
        field(2; "Stage Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recruitment Stages"."Recruitement Stage";
        }
        field(3; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Jobs"."Job ID";
        }
        field(4; "Qualification Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Academic,Professional,Technical,Experience,Personal Attributes';
            OptionMembers = " ", Academic, Professional, Technical, Experience, "Personal Attributes";
        }
        field(5; Qualification; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = HR_Qualifications.Code WHERE("Qualification Type"=FIELD("Qualification Type"));
        }
        field(6; "Desired Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Score Setup"."Score ID";
        }
    }
    keys
    {
        key(Key1; "Vacancy No.", "Stage Code", "Job ID", "Qualification Type", Qualification)
        {
            SumIndexFields = "Desired Score";
        }
    }
    fieldgroups
    {
    }
}
