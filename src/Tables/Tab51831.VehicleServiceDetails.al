table 51831 "Vehicle Service Details"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Service & Check Code"; Code[10])
        {
            TableRelation = "Service & Check Codes";

            trigger OnValidate()
            begin
                if Services.Get("Service & Check Code")then "Service & Check":=Services.Description;
            end;
        }
        field(4; "Service & Check"; Text[30])
        {
        }
        field(5; "Service Details"; Option)
        {
            OptionCaption = ' ,Changed,Checked,Checked & Changed,Done,Replaced';
            OptionMembers = " ", Changed, Checked, "Checked & Changed", Done, Replaced;
        }
        field(6; "Part Number"; Code[10])
        {
        }
        field(7; "TMP MGR Initials"; Code[5])
        {
        }
        field(8; "Rate/Quantity"; Decimal)
        {
            trigger OnValidate()
            begin
                Amount:=Round("Rate/Quantity" * "Unit Price", 0.01);
            end;
        }
        field(9; "Unit Price"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate("Rate/Quantity");
            end;
        }
        field(10; Amount; Decimal)
        {
            Editable = false;
        }
        field(11; Posted; Boolean)
        {
        }
        field(12; "Posted By"; Code[50])
        {
        }
        field(13; "Posted Date"; Date)
        {
        }
    }
    keys
    {
        key(Key1; "No.", "Line No.")
        {
        }
    }
    fieldgroups
    {
    }
    var Services: Record "Service & Check Codes";
}
