table 52104 "Employee Customer Mapping"
{
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            // TableRelation = Employee;
            TableRelation = Employee;
        }
        field(2; "Customer AC"; Code[20])
        {
            TableRelation = Customer;
        }
        field(3; "Account Type"; Option)
        {
            OptionCaption = 'Travels,Advances';
            OptionMembers = Travels, Advances;
        }
    }
    keys
    {
        key(Key1; "Account Type", "Employee No.")
        {
        }
    }
    fieldgroups
    {
    }
}
