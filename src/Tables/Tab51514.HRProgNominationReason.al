table 51514 "HR_Prog Nomination Reason"
{
    DrillDownPageId = "HR_Prog Nomination Reason";
    LookupPageId = "HR_Prog Nomination Reason";

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Cause for Nomination"; Option)
        {
            OptionCaption = 'Pay Anomaly,Retention,Skills/Competency Improvement';
            OptionMembers = "Pay Anomaly", Retention, "Skills/Competency Improvement";
            Caption = '';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
        }
    }
    fieldgroups
    {
    }
    var Jobs: Record Positions;
    Employee: Record Employee;
}
