table 50027 "Financial Year Code"
{
    Caption = 'Financial Year Code';
    DataClassification = ToBeClassified;
    LookupPageId = "Financial Year Codes";
    DrillDownPageId = "Financial Year Codes";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(4; "End Dtae"; Date)
        {
            Caption = 'End Dtae';
            DataClassification = CustomerContent;
        }
        field(5; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
