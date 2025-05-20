table 52138 "User Budget Roles"
{
    fields
    {
        field(1; "User ID"; Code[50])
        {
        }
        field(2; "Department Codes"; Text[250])
        {
        }
        field(3; "Branch Codes"; Text[250])
        {
        }
        field(4; "SI Codes"; Text[30])
        {
        }
        field(5; "Budget Acounts Range"; Text[30])
        {
        }
        field(6; Role; Option)
        {
            OptionCaption = 'Maker,Approver';
            OptionMembers = Maker, Approver;
        }
    }
    keys
    {
        key(Key1; "User ID")
        {
        }
    }
    fieldgroups
    {
    }
}
