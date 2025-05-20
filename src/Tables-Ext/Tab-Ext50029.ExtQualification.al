tableextension 50029 "ExtQualification" extends Qualification
{
    fields
    {
        // Add changes to table fields here
        field(50000; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Qualification,"Job Grade";
        }
        field(50001; "Qualification Type"; Enum "Qualification Types")
        {
            DataClassification = CustomerContent;
        }
        field(50002; "Education Level"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Education Levels";

            trigger OnValidate()
            begin
                if EducationLevels.Get(Rec."Education Level") then begin
                    Rec."Education Level Desc" := EducationLevels.Description;
                    Rec.Level := EducationLevels.level;
                end
            end;
        }
        field(50003; "Education Level Desc"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(50004; Level; Integer)
        {
            DataClassification = CustomerContent;
        }

        field(52001; "Field of Study"; Code[50])
        {
            TableRelation = "Field of Study";
            DataClassification = CustomerContent;
            Caption = 'Field of Study';
        }
        // field(52002; "Education Level"; Enum "Education Level")
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Education Level';
        // }
        // modify(Description)
        // {
        //     Width = 2000;
        // }
        field(52002; "Description new"; Text[2000])
        { }
    }
    var
        EducationLevels: Record "Education Levels";
}
