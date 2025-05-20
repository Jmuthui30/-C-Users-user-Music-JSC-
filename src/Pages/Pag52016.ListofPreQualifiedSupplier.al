page 52016 "List of Pre-Qualified Supplier"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Prequalified Suppliers";

    layout
    {
        area(content)
        {
            repeater(Control13)
            {
                ShowCaption = false;

                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
                field("Physical Address"; Rec."Physical Address")
                {
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                }
                field("Telephone No"; Rec."Telephone No")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
                field("Contact Person"; Rec."Contact Person")
                {
                    ApplicationArea = All;
                }
                field("KBA Bank Code"; Rec."KBA Bank Code")
                {
                    ApplicationArea = All;
                }
                field("KBA Branch Code"; Rec."KBA Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Pre Qualified"; Rec."Pre Qualified")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
