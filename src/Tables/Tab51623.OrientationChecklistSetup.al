table 51623 "Orientation Checklist Setup"
{
    // version THL- HRM 1.0
    DrillDownPageID = "Orientation Checklist Setup";
    LookupPageID = "Orientation Checklist Setup";

    fields
    {
        field(1; Item; Code[10])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; Timeline; Option)
        {
            OptionCaption = 'Prior to Start Date,First Day';
            OptionMembers = "Prior to Start Date", "First Day";
        }
    }
    keys
    {
        key(Key1; Item)
        {
        }
    }
    fieldgroups
    {
    }
}
