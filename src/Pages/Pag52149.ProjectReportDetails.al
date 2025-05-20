page 52149 "Project Report Details"
{
    PageType = ListPart;
    SourceTable = "Project Report Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Amount By Project"; Rec."Amount By Project")
                {
                    ApplicationArea = All;
                }
                field("Amount Other Projects"; Rec."Amount Other Projects")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Annual Budget"; Rec."Annual Budget")
                {
                    ApplicationArea = All;
                }
                field("Budget Usage (%)"; Rec."Budget Usage (%)")
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
