page 52206 "Prepayments List"
{
    CardPageID = "Prepayment Header";
    DeleteAllowed = false;
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Amortization Header";
    SourceTableView = WHERE(Type=CONST(Prepayment));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Prepayment Amount"; Rec."Prepayment Amount")
                {
                    ApplicationArea = All;
                }
                field("No of Periods"; Rec."No of Periods")
                {
                    ApplicationArea = All;
                }
                field("Starting Period"; Rec."Starting Period")
                {
                    ApplicationArea = All;
                }
                field("Ending Period"; Rec."Ending Period")
                {
                    ApplicationArea = All;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Expensed Amount"; Rec."Expensed Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Periods Expensed"; Rec."Periods Expensed")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Outstanding Perods"; Rec."Outstanding Perods")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1000000026; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Prepayments Schedule")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Prepayment Schedule";
            }
        }
    }
}
