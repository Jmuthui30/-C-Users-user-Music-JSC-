table 51606 "QuantumJumps User Setup"
{
    // version THL- HRM 1.0
    DrillDownPageId = "QuantumJumps User Setup";

    fields
    {
        field(1; "User ID"; Code[50])
        {
        }
        field(2; "Employee No"; Code[20])
        {
            TableRelation = Employee;
        }
        field(3; Signature; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(4; "In Management"; Boolean)
        {
        }
        field(5; "Immediate Supervisor"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(6; Picture; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
    }
    keys
    {
        key(Key1; "User ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
