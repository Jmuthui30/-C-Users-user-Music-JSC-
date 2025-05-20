table 51618 "Internal Memo Setup"
{
    // version THL- HRM 1.0
    DrillDownPageID = "Internal Memo Setup";
    LookupPageID = "Internal Memo Setup";

    fields
    {
        field(1; "Primary Key"; Integer)
        {
        }
        field(2; "Internal Memo Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Activate Email Notification"; Boolean)
        {
        }
        field(4; "Staff Distribution List"; Text[80])
        {
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }
    fieldgroups
    {
    }
}
