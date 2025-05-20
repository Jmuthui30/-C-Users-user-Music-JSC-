table 51842 "Admins"
{
    // version THL- PRM 1.0
    DataPerCompany = false;
    ReplicateData = false;

    fields
    {
        field(3; "User SID"; Guid)
        {
            Caption = 'User SID';
            DataClassification = ToBeClassified;
            TableRelation = User."User Security ID";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnValidate()
            begin
                if User.Get("User SID")then "Full Name":=User."Full Name";
            end;
        }
        field(6; "User ID"; Code[50])
        {
            CalcFormula = Lookup(User."User Name" WHERE("User Security ID"=FIELD("User SID")));
            Caption = 'User ID';
            FieldClass = FlowField;
        }
        field(7; "Full Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));
        }
        field(9; Blocked; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "User SID")
        {
        }
    }
    fieldgroups
    {
    }
    var User: Record User;
}
