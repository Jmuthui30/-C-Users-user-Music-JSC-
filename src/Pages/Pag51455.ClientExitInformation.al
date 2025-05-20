page 51455 "Client Exit Information"
{
    // version THL- Client Payroll 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Client Employee Master";

    layout
    {
        area(content)
        {
            group("Exit Infromation")
            {
                field("Departure Date"; Rec."Departure Date")
                {
                    ApplicationArea = All;
                }
                field("Served Notice Period"; Rec."Served Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    ApplicationArea = All;
                }
                field("Exit Interview Done By"; Rec."Exit Interview Done By")
                {
                    ApplicationArea = All;
                }
                field("Allow Re-Employment in Future"; Rec."Allow Re-Employment in Future")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
