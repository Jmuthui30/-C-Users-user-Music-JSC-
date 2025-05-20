page 50045 "Api Dependents"
{
    APIGroup = 'PowerAppsAPI';
    APIPublisher = 'PowerAppsDeveloper';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiDependents';
    DelayedInsert = true;
    EntityName = 'Dependent';
    EntitySetName = 'Dependents';
    PageType = API;
    SourceTable = "Employees Dependants";
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
                    Caption = 'SurName';
                }
                field("OtherNames"; Rec."Other Names")
                {
                    Caption = 'Other Names';
                }
                field(Gender; Rec.Gender)
                {
                    Caption = 'Gender';
                }
                field("DateOfBirth"; Rec."Date Of Birth")
                {
                    Caption = 'Date of Birth';
                }
                field(Relationship; Rec.Relationship)
                {
                    Caption = 'Relationship';
                }
                field("Distribution"; Rec."Distribution %")
                {
                    Caption = 'Share of Benefits%';
                }
            }
        }
    }
}
