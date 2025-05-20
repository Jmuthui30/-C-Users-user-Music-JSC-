table 51486 "Medical Examination"
{
    DrillDownPageID = "Medical Examination Lines";
    LookupPageID = "Medical Examination Lines";
    DataCaptionFields = "Examiner", "Examiner Name";

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Applicant No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Examiner"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vend.Get(Examiner)then begin
                    "Examiner Name":=Vend.Name;
                end;
            end;
        }
        field(4; "Examiner Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Passed; Boolean)
        {
            trigger OnValidate()
            begin
                if Applicant.Get("Applicant No")then begin
                    if Passed = true then Applicant."Mediacal Examination":=Applicant."Mediacal Examination"::Passed
                    else if Passed = false then Applicant."Mediacal Examination":=Applicant."Mediacal Examination"::Failed;
                    Applicant.Modify(true);
                end;
            end;
        }
        field(7; "Vacancy No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = true;
            TableRelation = "Recruitment Needs"."No.";
        }
    }
    keys
    {
        key(Key1; "Line No.", "Applicant No", Examiner, "Vacancy No.")
        {
        }
    }
    var Vend: Record Vendor;
    Applicant: Record Applicant;
}
