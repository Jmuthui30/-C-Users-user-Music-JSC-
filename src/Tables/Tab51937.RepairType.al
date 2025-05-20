table 51937 "Repair Type"
{
    DataClassification = CustomerContent;
    LookupPageId = "Repair Type";
    DrillDownPageId = "Repair Type";

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
            Clustered = true;
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
