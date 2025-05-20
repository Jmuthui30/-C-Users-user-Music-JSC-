table 51829 "Service & Check Codes"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Status; Option)
        {
            OptionCaption = 'Active,Inactive';
            OptionMembers = Active, Inactive;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
}
