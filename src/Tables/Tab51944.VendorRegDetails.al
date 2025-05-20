table 51944 "Vendor Reg Details"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Vend Reg No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Description"; text[100])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Vend Reg No", "Line No.")
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
