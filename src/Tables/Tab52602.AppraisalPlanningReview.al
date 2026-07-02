table 52602 "Appraisal Planning Review"
{
    Caption = 'Appraisal Planning Review';
    DataClassification = CustomerContent;
    LookupPageId = "Appr. Planning Return Reason";

    fields
    {
        field(1; "Plan No."; Code[20])
        {
            Caption = 'Plan No.';
            TableRelation = "Appraisal Planning Header"."No.";
        }
        field(2; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(3; "Action"; Text[100])
        {
            Caption = 'Action';
        }
        field(4; "Action By"; Code[50])
        {
            Caption = 'Action By';
        }
        field(5; "Action At"; DateTime)
        {
            Caption = 'Action At';
        }
        field(6; Comment; Text[250])
        {
            Caption = 'Comment';
        }
        field(7; "Status Before"; Text[50])
        {
            Caption = 'Status Before';
        }
        field(8; "Status After"; Text[50])
        {
            Caption = 'Status After';
        }
    }

    keys
    {
        key(PK; "Plan No.", "Entry No.")
        {
            Clustered = true;
        }
    }
}
