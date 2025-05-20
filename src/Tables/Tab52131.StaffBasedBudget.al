table 52131 "Staff Based Budget"
{
    fields
    {
        field(1; Budget; Code[10])
        {
            TableRelation = "G/L Budget Name" where(Status=const(Open));
            NotBlank = true;
        }
        field(2; "Staff No."; Code[20])
        {
            NotBlank = true;
            TableRelation = "Staff Organization Mapping"."Staff ID";

            trigger OnValidate()
            begin
                If StaffMapping.Get("Staff No.")then begin
                    "Staff Name":=StaffMapping.Name;
                    Validate(Department, StaffMapping."Unit Code");
                    Validate(Branch, StaffMapping."Branch Code");
                end;
            end;
        }
        field(3; "Staff Name"; Text[100])
        {
            Editable = false;
        }
        field(4; Department; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                GLSetup.GET;
                Dim.GET(GLSetup."Global Dimension 1 Code", Department);
                "Dept Name":=Dim.Name;
            end;
        }
        field(5; "Dept Name"; Text[50])
        {
            Editable = false;
        }
        field(6; Branch; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                GLSetup.GET;
                Dim.GET(GLSetup."Global Dimension 2 Code", Branch);
                "Branch Name":=Dim.Name;
            end;
        }
        field(7; "Branch Name"; Text[30])
        {
            Editable = false;
        }
        field(8; "SI Code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));

            trigger OnValidate()
            begin
                GLSetup.GET;
                Dim.GET(GLSetup."Shortcut Dimension 3 Code", "SI Code");
                "Strategic Initiative":=Dim.Name;
            end;
        }
        field(9; "Strategic Initiative"; Text[30])
        {
            Editable = false;
        }
        field(10; "Budget Line Account"; Code[20])
        {
            TableRelation = "G/L Account" where("Income/Balance"=const("Income Statement"), Blocked=const(false), "Direct Posting"=const(true), "Account Type"=const(Posting));

            trigger OnValidate()
            begin
                if GLAcc.Get("Budget Line Account")then Description:=GLAcc.Name;
            end;
        }
        field(11; Description; Text[100])
        {
            Editable = false;
        }
        field(12; Amount; Decimal)
        {
        }
        field(13; Status;Enum "Document Status")
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; Budget, "Staff No.", "SI Code", "Budget Line Account")
        {
        }
    }
    fieldgroups
    {
    }
    var StaffMapping: Record "Staff Organization Mapping";
    GLSetup: Record "General Ledger Setup";
    Dim: Record "Dimension Value";
    GLAcc: Record "G/L Account";
}
