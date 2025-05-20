table 51635 "Training Lines"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Type of Training"; Option)
        {
            OptionCaption = ' ,Academic,Professional,Technical';
            OptionMembers = " ", Academic, Professional, Technical;
        }
        field(4; Description; Text[50])
        {
        }
        field(5; Institution; Text[30])
        {
        }
        field(6; "Start Date"; Date)
        {
        }
        field(7; "End Date"; Date)
        {
        }
        field(8; "Total Hours"; Integer)
        {
        }
        field(9; Achievement; Text[30])
        {
        }
    }
    keys
    {
        key(Key1; "No.", "Line No.")
        {
        }
    }
    fieldgroups
    {
    }
}
