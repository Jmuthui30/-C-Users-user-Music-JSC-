xmlport 52110 "Staff Organization Mapping"
{
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
    textelement(Root)
    {
    tableelement("Staff Organization Mapping";
    "Staff Organization Mapping")
    {
    XmlName = 'StaffOrganizationMapping';

    fieldattribute(StaffID;
    "Staff Organization Mapping"."Staff ID")
    {
    }
    fieldattribute(Name;
    "Staff Organization Mapping".Name)
    {
    }
    fieldattribute(UnitCode;
    "Staff Organization Mapping"."Unit Code")
    {
    }
    fieldattribute(BranchCode;
    "Staff Organization Mapping"."Branch Code")
    {
    }
    }
    }
    }
    trigger OnPostXmlPort()
    begin
        Message('Import Completed.');
    end;
    trigger OnPreXmlPort()
    begin
        StaffMapping.Reset;
        StaffMapping.DeleteAll;
    end;
    var StaffMapping: Record "Staff Organization Mapping";
}
