page 50041 "API Car Brand"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'APIpublisher';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiCarBrand';
    DelayedInsert = true;
    EntityName = 'carBrand';
    EntitySetName = 'carBrand';
    EntitySetCaption = 'carBrand';
    PageType = API;
    SourceTable = "Car Brand";
    ODataKeyFields = SystemId;
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(country; Rec.Country)
                {
                    Caption = 'Country';
                }
            }
            part(carModels; "API Car Model")
            {
                Caption = 'car Models';
                EntityName = 'carModel';
                EntitySetName = 'carModels';
                SubPageLink = "Brand Id"=Field(SystemId);
            }
        }
    }
}
