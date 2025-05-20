page 50040 "API Car Model"
{
    APIGroup = 'apiGroup';
    APIPublisher = 'APIpublisher';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'apiCarModel';
    DelayedInsert = true;
    EntityName = 'carModel';
    EntitySetName = 'carModels';
    EntitySetCaption = 'CarModels';
    PageType = API;
    SourceTable = "Car Model";
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
                field(brandId; Rec."Brand Id")
                {
                    Caption = 'Brand Id';
                }
                field(power; Rec.Power)
                {
                    Caption = 'Power';
                }
                field(fuelType; Rec."Fuel Type")
                {
                    Caption = 'Fuel Type';
                }
            }
        }
    }
}
