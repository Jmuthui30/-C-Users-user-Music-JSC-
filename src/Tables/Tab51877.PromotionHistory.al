table 51877 "Promotion History"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Position; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if CompanyJobs.Get(Position)then "Postion Description":=CompanyJobs.Name;
            end;
        }
        field(3; "Postion Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "HR Remarks"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Position Closed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Last Modified"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No", Position, "Start Date")
        {
        }
    }
    fieldgroups
    {
    }
    var CompanyJobs: Record "Company Jobs";
}
