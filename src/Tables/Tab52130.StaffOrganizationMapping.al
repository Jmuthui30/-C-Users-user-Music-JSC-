table 52130 "Staff Organization Mapping"
{
    fields
    {
        field(1; "Staff ID"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Name; Text[100])
        {
        }
        field(3; "Unit Code"; Code[10])
        {
            trigger OnValidate()
            begin
                GLSetup.GET;
                Dim.GET(GLSetup."Global Dimension 1 Code", "Unit Code");
                Unit:=Dim.Name;
            end;
        }
        field(4; Unit; Text[30])
        {
        }
        field(5; "Branch Code"; Code[10])
        {
            trigger OnValidate()
            begin
                GLSetup.Get;
                Dim.Get(GLSetup."Global Dimension 2 Code", "Branch Code");
                Branch:=Dim.Name;
            end;
        }
        field(6; Branch; Text[30])
        {
        }
    }
    keys
    {
        key(Key1; "Staff ID")
        {
        }
    }
    fieldgroups
    {
    }
    var GLSetup: Record "General Ledger Setup";
    Dim: Record "Dimension Value";
}
