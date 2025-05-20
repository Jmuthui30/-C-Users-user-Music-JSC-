table 51505 "Bal Score Plan Review Period"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Bal Score Plan Review Period";
    DrillDownPageId = "Bal Score Plan Review Period";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Active; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; FiscalStart; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; MaturityDate; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Code, Active)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Name, "Start Date", "End Date", Active)
        {
        }
        fieldgroup(Brick; Code, Name, "Start Date", "End Date", Active)
        {
        }
    }
    trigger OnInsert()
    begin
        FindMaturityDate();
    end;
    procedure FindMaturityDate()
    var
        AccPeriod: Record "Accounting Period";
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+')then begin
            FiscalStart:=AccPeriod."Starting Date";
            MaturityDate:=CalcDate('1Y', FiscalStart) - 1;
        end;
    end;
}
