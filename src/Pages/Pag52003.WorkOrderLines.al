page 52003 "Work Order Lines"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    AutoSplitKey = true;
    MultipleNewLines = false;
    SourceTable = "Work Order Lines";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Fault Area Code"; Rec."Fault Area Code")
                {
                    ApplicationArea = All;
                }
                field("Fault Code"; Rec."Fault Code")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Start Date"; Rec."Scheduled Start Date")
                {
                    ApplicationArea = All;
                }
                field("Scheduled End Date"; Rec."Scheduled End Date")
                {
                    ApplicationArea = All;
                }
                field("Response Date"; Rec."Response Date")
                {
                    ApplicationArea = All;
                }
                field("Response Time"; Rec."Response Time")
                {
                    ApplicationArea = All;
                }
                field("Response Time (Hours)"; Rec."Response Time (Hours)")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Caption = 'Line Amount';
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maintenance Acc Code"; Rec."Maintenance Acc Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                end;
            }
        }
    }
}
