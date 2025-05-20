page 51896 "Service Details"
{
    // version THL- PRM 1.0
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Vehicle Service Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Service & Check Code"; Rec."Service & Check Code")
                {
                    ApplicationArea = All;
                }
                field("Service & Check"; Rec."Service & Check")
                {
                    ApplicationArea = All;
                }
                field("Service Details"; Rec."Service Details")
                {
                    ApplicationArea = All;
                }
                field("Part Number"; Rec."Part Number")
                {
                    ApplicationArea = All;
                }
                field("TMP MGR Initials"; Rec."TMP MGR Initials")
                {
                    ApplicationArea = All;
                }
                field("Rate/Quantity"; Rec."Rate/Quantity")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field(Amount; Rec.Amount)
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
