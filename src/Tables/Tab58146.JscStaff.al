table 58146 JscStaff
{
    Caption = 'JscStaff'; 
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Pf No."; code[20])
        {
            Caption = 'Pf No.';
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; Designation; Text[100])
        {
            Caption = 'Designation';
        }
    }
    keys
    {
        key(PK; "Pf No.")
        {
            Clustered = true;
        }
    }
}
