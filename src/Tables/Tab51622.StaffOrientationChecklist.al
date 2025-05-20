table 51622 "Staff Orientation Checklist"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
        }
        field(2; Item; Code[10])
        {
        }
        field(3; Description; Text[250])
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Pending,Completed,Not Applicable';
            OptionMembers = Pending, Completed, "Not Applicable";
        }
        field(5; Timeline; Option)
        {
            OptionCaption = 'Prior to Start Date,First Day';
            OptionMembers = "Prior to Start Date", "First Day";
        }
    }
    keys
    {
        key(Key1; "Employee No", Item)
        {
        }
        key(Key2; Timeline)
        {
        }
    }
    fieldgroups
    {
    }
}
