page 50063 "Imprest Budget Analysis"
{
    ApplicationArea = All;
    Caption = 'Imprest Budget Analysis';
    PageType = List;
    SourceTable = "Imprest Budget Analysis";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Budget Line"; Rec."Budget Line")
                {
                }
                field("Budget Period Start"; "Budget Period Start")
                {
                }
                field("Budget Period End"; "Budget Period End")
                {
                }
                // "Budget Date Filter"
                field("Budget Date Filter"; Rec."Budget Date Filter")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Amount on Budget"; Rec."Amount on Budget")
                {
                    Visible = false;
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    Visible = false;
                }
                field("Available Balance"; Rec."Available Balance")
                {
                }
                field("Amount Required"; Rec."Amount Required")
                {
                }
                field("Budget Availability"; Rec."Budget Availability")
                {
                }
            }
        }
    }
}
