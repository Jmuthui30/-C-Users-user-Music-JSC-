page 52181 "Budget Category Dist. Lines"
{
    // version BUDGET
    Caption = 'Budget Category Distribution Lines';
    PageType = ListPart;
    SourceTable = "Budget Category Dist. Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field("Category Description"; Rec."Category Description")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Name"; Rec."Unit Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
                field("Strategic Initiative"; Rec."Strategic Initiative")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
                field("Budget Amount"; Rec."Budget Amount")
                {
                    ApplicationArea = All;
                }
                field("Actual Amount"; Rec."Actual Amount")
                {
                    ApplicationArea = All;
                }
                field("Commitment Amount"; Rec."Commitment Amount")
                {
                    ApplicationArea = All;
                }
                field("Available Balance"; Rec."Available Balance")
                {
                    ApplicationArea = All;
                }
                field("Total Category Budget"; Rec."Total Category Budget")
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
