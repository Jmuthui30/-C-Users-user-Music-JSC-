table 52126 "EFT Lines"
{
    fields
    {
        field(1; "EFT No"; Code[20])
        {
            TableRelation = "EFT Header".No WHERE("EFT Generated"=CONST(false));
        }
        field(2; "PV No"; Code[20])
        {
            TableRelation = "PV Header"."No." WHERE(EFT_No=CONST(''));
        }
        field(3; Payee; Text[100])
        {
        }
        field(4; "Vendor Name"; Text[120])
        {
        }
        field(5; "Account No"; Text[30])
        {
        }
        field(6; "Account Name"; Text[100])
        {
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; Description; Text[150])
        {
        }
        field(9; Status; Option)
        {
            OptionCaption = 'Logged,Processed,Failed,Pending,Returned';
            OptionMembers = Logged, Processed, Failed, Pending, Returned;
        }
        field(10; "Sort Code"; Text[30])
        {
        }
        field(11; "Vendor Code"; Text[30])
        {
        }
        field(12; "Bank Account No"; Text[30])
        {
        }
        field(13; "Bank Name"; Text[100])
        {
        }
        field(14; "Payment Response"; Text[250])
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "EFT No", "PV No")
        {
        }
    }
    fieldgroups
    {
    }
}
