table 51653 "Positions"
{
    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Approved Postions"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Occupied Positions"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Vacant Positions"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Reports To"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Positions;
        }
        field(7; "Job Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Scale; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale";
        }
        field(9; Level; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Level";
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Approved,Unapproved,Open,Pending Approval';
            OptionMembers = Approved, Unapproved, Open, "Pending Approval";
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(13; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(14; "Probation Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Unionizable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Housing Eligibility"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'None,House,House Allowance,Both';
            OptionMembers = "None", House, "House Allowance", Both;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
        }
    }
    fieldgroups
    {
    }
}
