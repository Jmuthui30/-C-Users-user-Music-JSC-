table 51429 "Bank Branches"
{
    // version THL- Payroll 1.0
    DrillDownPageID = "Bank Branches";
    LookupPageID = "Bank Branches";

    fields
    {
        field(1; "Bank Code"; Code[10])
        {
            TableRelation = "Commercial Banks";

            trigger OnValidate()
            begin
                if Banks.Get("Bank Code")then "Bank Name":=Banks.Name;
            end;
        }
        field(2; "Branch Code"; Code[10])
        {
        }
        field(3; "Bank Name"; Text[50])
        {
            Editable = false;
        }
        field(4; "Branch Name"; Text[50])
        {
        }
        field(5; "Sort Code"; Code[10])
        {
        }
    }
    keys
    {
        key(Key1; "Bank Code", "Branch Code")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Bank Code", "Bank Name", "Branch Code", "Branch Name")
        {
        }
        fieldgroup(Brick; "Bank Code", "Bank Name", "Branch Code", "Branch Name")
        {
        }
    }
    var Banks: Record "Commercial Banks";
}
