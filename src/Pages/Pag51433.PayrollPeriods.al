page 51433 "Payroll Periods"
{
    // version THL- Payroll 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Payroll Period";

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
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                }
                field("Date Locked"; Rec."Date Locked")
                {
                    ApplicationArea = All;
                }
                field("Pay Date"; Rec."Pay Date")
                {
                    ApplicationArea = All;
                }
                field("Close Pay"; Rec."Close Pay")
                {
                    ApplicationArea = All;
                }
                field("P.A.Y.E"; Rec."P.A.Y.E")
                {
                    ApplicationArea = All;
                }
                field("Basic Pay"; Rec."Basic Pay")
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
            systempart(Control15; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Create Periods")
            {
                ApplicationArea = All;
                Image = CreateYear;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Create Payroll Period";
            }
            action("Close Pay Period")
            {
                ApplicationArea = All;
                Caption = 'Close Pay Period';
                Image = ClosePeriod;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if not Confirm('You are about to close the current Pay period. Do you wish to continue?', false)then exit;
                    ClosePayPeriod.GetCurrentPeriod(Rec);
                    ClosePayPeriod.Run;
                end;
            }
        }
    }
    var ClosePayPeriod: Report "Close Pay period";
}
