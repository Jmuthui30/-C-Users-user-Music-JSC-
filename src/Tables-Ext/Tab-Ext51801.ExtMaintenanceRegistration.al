tableextension 51801 "ExtMaintenance Registration" extends "Maintenance Registration"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Next Service Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if FA.Get("FA No.")then begin
                    if MainReg.FindLast()then FA."Next Service Date":=MainReg."Next Service Date";
                    FA.Modify(true);
                end;
            end;
        }
    }
    var FA: Record "Fixed Asset";
    MainReg: Record "Maintenance Registration";
}
