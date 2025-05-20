page 51878 "Cost Periods"
{
    // version THL- PRM 1.0
    DeleteAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Cost Period";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("New Fiscal Year"; Rec."New Fiscal Year")
                {
                    ApplicationArea = All;
                }
                field("Analysis Date"; Rec."Analysis Date")
                {
                    ApplicationArea = All;
                }
                field("Fuel Cost"; Rec."Fuel Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Mileage"; Rec."Total Mileage")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Closed By"; Rec."Closed By")
                {
                    ApplicationArea = All;
                }
                field("Closed on Date"; Rec."Closed on Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control13; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Create New Periods")
            {
                ApplicationArea = All;
                Image = AccountingPeriods;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Create Cost Period";
            }
        }
    }
}
