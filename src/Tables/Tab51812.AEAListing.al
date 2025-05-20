table 51812 "AEA Listing"
{
    // version THL- PRM 1.0
    DrillDownPageID = "TDY Locations";
    LookupPageID = "TDY Locations";

    fields
    {
        field(1; Location; Code[20])
        {
            TableRelation = "Travel Locations";

            trigger OnValidate()
            begin
                Locations.Get(Rec.Location);
                Rec.International:=Locations.International;
            end;
        }
        field(2; "Job Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Client Salary Scale".Scale;
        }
        field(3; International; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Currency; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Currency;
        }
        field(5; "Maximum Perdiem Rate"; Decimal)
        {
            trigger OnValidate()
            begin
                Rec.Total:=Rec."Maximum Perdiem Rate" + Rec."M&IE";
            end;
        }
        field(6; "M&IE"; Decimal)
        {
            trigger OnValidate()
            begin
                Rec.Validate("Maximum Perdiem Rate");
            end;
        }
        field(7; Total; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Rec.Validate("Maximum Perdiem Rate");
            end;
        }
    }
    keys
    {
        key(Key1; Location, "Job Group")
        {
        }
    }
    fieldgroups
    {
    }
    var Locations: Record "Travel Locations";
}
