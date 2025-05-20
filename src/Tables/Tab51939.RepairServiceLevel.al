table 51939 "Repair Service Level"
{
    DataClassification = CustomerContent;
    LookupPageId = "Repair Service Level";
    DrillDownPageId = "Repair Service Level";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; text[50])
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
