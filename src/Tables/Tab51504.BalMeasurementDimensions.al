table 51504 "Bal Measurement Dimensions"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Bal Measurement Dimensions";
    DrillDownPageId = "Bal Measurement Dimensions";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Percepective; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bal Score Percipectives";
        }
    }
    keys
    {
        key(Key1; Code, Percepective)
        {
            Clustered = true;
        }
        key(Key2; Percepective, Code)
        {
        }
    }
}
