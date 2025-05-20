table 51835 "Fuel Card"
{
    fields
    {
        field(1; "Card No."; Code[10])
        {
        }
        field(2; "Card Name"; Text[30])
        {
        }
        field(3; "Issuer Name"; Text[50])
        {
        }
        field(4; "Issue Date"; Date)
        {
        }
        field(5; "Expiry Date"; Date)
        {
        }
        field(6; "Credit Balance"; Decimal)
        {
            CalcFormula = Sum("Fuel Card Entries".Amount WHERE("Card No"=FIELD("Card No."), Date=FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(7; Status; Option)
        {
            OptionCaption = 'Active,Inactivate';
            OptionMembers = Active, Inactivate;
        }
        field(8; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }
    keys
    {
        key(Key1; "Card No.")
        {
        }
    }
    fieldgroups
    {
    }
}
