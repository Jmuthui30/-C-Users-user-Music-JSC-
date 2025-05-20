tableextension 51425 "ExtG_L Budget Name" extends "G/L Budget Name"
{
    fields
    {
        field(50000; "Department Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(50001; Status;Enum "Document Status")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    trigger OnBeforeInsert()
    begin
        if Status <> Status::Open then Status:=Status::Open;
    end;
}
