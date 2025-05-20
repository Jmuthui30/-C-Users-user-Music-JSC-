table 51466 "Client Scale Benefits"
{
    // version THL- Client Payroll 1.0
    DrillDownPageID = "Client Scale Benefits";
    LookupPageID = "Client Scale Benefits";

    fields
    {
        field(1; Client; Code[10])
        {
        }
        field(2; Scale; Code[10])
        {
            TableRelation = "Client Salary Scale".Scale WHERE(Client=FIELD(Client));
        }
        field(3; Level; Code[10])
        {
            TableRelation = "Client Salary Level".Level WHERE(Client=FIELD(Client));
        }
        field(4; Earning; Code[10])
        {
            TableRelation = "Client Earnings".Code;

            trigger OnValidate()
            var
                ClientEarning: Record "Client Earnings";
            begin
                ClientEarning.Reset();
                ClientEarning.SetRange(Code, Earning);
                if ClientEarning.FindFirst()then Description:=ClientEarning.Description;
            end;
        }
        field(5; Description; Text[50])
        {
            Editable = false;
        }
        field(6; Amount; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; Client, Scale, Level, Earning)
        {
        }
    }
    fieldgroups
    {
    }
}
