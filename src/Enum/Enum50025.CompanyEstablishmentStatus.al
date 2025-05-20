enum 50025 "Company Establishment Status"
{
    Extensible = true;

    value(0; Open)
    {
    Caption = 'Open';
    }
    value(1; "Pending Approval")
    {
    Caption = 'Pending Approval';
    }
    value(2; Released)
    {
    Caption = 'Approved';
    }
    value(3; Rejected)
    {
    Caption = 'Rejected';
    }
}
