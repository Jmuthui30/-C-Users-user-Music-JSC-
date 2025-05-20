table 51662 "Job Templates Matrix"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Job Templates Matrix";
    DrillDownPageId = "Job Templates Matrix";

    fields
    {
        field(1; "Job Template"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            OptionMembers = "", Skills, Certificates, Screenings, Tests;
        }
        field(3; Code; Code[20])
        {
            TableRelation = IF(Type=CONST(Skills))"Job Skills"
            else IF(Type=CONST(Certificates))"Job Certificates"
            else IF(Type=CONST(Screenings))"Job Screenings"
            else IF(Type=CONST(Tests))"Job Tests";

            trigger OnValidate()
            begin
                case Type of Type::Skills: begin
                    if JobSkills.Get(Code)then begin
                        Description:=JobSkills.Description;
                        "Job Levels":=JobSkills.Level;
                    end;
                end;
                Type::Certificates: begin
                    if JobCertificates.Get(Code)then Description:=JobCertificates.Description;
                end;
                Type::Screenings: begin
                    if JobScreening.Get(Code)then Description:=JobScreening.Description;
                end;
                Type::Tests: begin
                    if JobTests.Get(Code)then Description:=JobTests.Description;
                end;
                end;
            end;
        }
        field(4; Description; Text[250])
        {
            Editable = false;
        }
        field(5; "Job Levels";Enum "Job Level")
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "Job Template", Type, Code)
        {
            Clustered = true;
        }
    }
    var JobSkills: Record "Job Skills";
    JobCertificates: Record "Job Certificates";
    JobScreening: Record "Job Screenings";
    JobTests: Record "Job Tests";
}
