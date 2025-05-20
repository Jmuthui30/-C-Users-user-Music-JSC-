page 50046 APINextOfKin
{
    APIGroup = 'PowerAppsAPI';
    APIPublisher = 'PowerAppsDeveloper';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiNextOfKin';
    DelayedInsert = true;
    EntityName = 'NextOfKin';
    EntitySetName = 'NextOfKins';
    PageType = API;
    SourceTable = "Employee Kins";
    ODataKeyFields = SystemId;
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(SystemId; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(SurName; Rec.SurName)
                {
                    Caption = 'Surname';
                }
                field("OtherNames"; Rec."Other Names")
                {
                    Caption = 'Other Names';
                }
                field(Relationship; Rec.Relationship)
                {
                    Caption = 'Relationship';
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Address';
                }
                field("HomeTelNo"; Rec."Home Tel No")
                {
                    Caption = 'Phone Number';
                }
                field("OfficeTelNo"; Rec."Office Tel No")
                {
                    Caption = 'Alternative Phone Number';
                }
            }
        }
    }
}
