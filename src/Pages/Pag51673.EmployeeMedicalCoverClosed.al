page 51673 "Employee Medical Cover-Closed"
{
    // version THL- HRM 1.0
    Caption = 'Historical Employee Medical Cover';
    PageType = Card;
    SourceTable = "Employee Medical Cover";

    layout
    {
        area(content)
        {
            group("Employee Medical Cover")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field(Scale; Rec.Scale)
                {
                    ApplicationArea = All;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                }
                field("Cover Type"; Rec."Cover Type")
                {
                    ApplicationArea = All;
                }
                field(Cover; Rec.Cover)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Policy Start Date"; Rec."Policy Start Date")
                {
                    ApplicationArea = All;
                }
                field("Policy End Date"; Rec."Policy End Date")
                {
                    ApplicationArea = All;
                }
                field("Cover Status"; Rec."Cover Status")
                {
                    ApplicationArea = All;
                }
            }
            group("Financial Statistics")
            {
                field("Cover Amount"; Rec."Cover Amount")
                {
                    ApplicationArea = All;
                }
                field(Expenditure; Rec.Expenditure)
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control17; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
