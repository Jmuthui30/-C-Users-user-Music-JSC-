table 51934 "Amount Limit Type"
{
    Caption = 'Amount Limit Setup';
    DataClassification = CustomerContent;
    LookupPageId = "Amount Limit Type";
    DrillDownPageId = "Amount Limit Type";

    fields
    {
        field(1; Code; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; Amount; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; Code)
        {
        }
    }
    var myInt: Integer;
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
