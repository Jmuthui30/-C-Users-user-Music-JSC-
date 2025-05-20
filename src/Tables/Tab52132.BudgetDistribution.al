table 52132 "Budget Distribution"
{
    fields
    {
        field(1; "GL Account"; Code[10])
        {
            trigger OnValidate()
            begin
                if GLAcc.Get("GL Account")then Description:=GLAcc.Name;
            end;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; Department; Code[10])
        {
            trigger OnValidate()
            begin
                GLSetup.Get;
                if DimValue.Get(GLSetup."Global Dimension 1 Code", Department)then "Dept Name":=DimValue.Name;
            end;
        }
        field(4; "Dept Name"; Text[50])
        {
        }
        field(5; Branch; Code[10])
        {
            trigger OnValidate()
            begin
                GLSetup.Get;
                if DimValue.Get(GLSetup."Global Dimension 2 Code", Branch)then "Branch Name":=DimValue.Name;
            end;
        }
        field(6; "Branch Name"; Text[30])
        {
        }
        field(7; "SI Code"; Code[10])
        {
            trigger OnValidate()
            begin
                GLSetup.Get;
                if DimValue.Get(GLSetup."Shortcut Dimension 3 Code", "SI Code")then "Strategic Initiative":=DimValue.Name;
            end;
        }
        field(8; "Strategic Initiative"; Text[30])
        {
        }
        field(9; Amount; Decimal)
        {
        }
        field(10; Budget; Code[10])
        {
            TableRelation = "G/L Budget Name";
        }
        field(11; Date; Date)
        {
        }
    }
    keys
    {
        key(Key1; "GL Account", Department, Branch, "SI Code", Budget, Date)
        {
        }
    }
    fieldgroups
    {
    }
    var DimValue: Record "Dimension Value";
    GLSetup: Record "General Ledger Setup";
    GLAcc: Record "G/L Account";
}
