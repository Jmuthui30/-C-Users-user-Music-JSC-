page 50044 "Employee Master Api"
{
    APIGroup = 'PowerAppsAPI';
    APIPublisher = 'PowerAppsDeveloper';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'employeeMasterApi';
    DelayedInsert = true;
    EntityName = 'employeeMaster';
    EntitySetName = 'employeeMasters';
    PageType = API;
    SourceTable = "Employee";
    ODataKeyFields = SystemId;
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(Address; Rec.Address)
                {
                    Caption = 'Place of residence';
                }
                field("Address2"; Rec."Address 2")
                {
                    Caption = 'Address-Address 2';
                }
                field("PhoneNo"; Rec."Phone No.")
                {
                    Caption = 'Phone Number';
                }
                field("EMail"; Rec."E-Mail")
                {
                    Caption = 'Email';
                }
            }
        }
    }
}
