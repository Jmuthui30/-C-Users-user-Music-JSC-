query 51002 "Banks-BI"
{
    Caption = 'Banks-BI';
    QueryType = Normal;
    elements
    {
        dataitem(BankAccount; "Bank Account")
        {
            column(No; "No.")
            {
            }
            column(Name; Name)
            {
            }
        }
    }

    trigger OnBeforeOpen()
    begin
    end;
}
