page 52117 "Employee Customer AC Mapping"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Employee Customer Account Mapping';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Customer Mapping";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Customer AC"; Rec."Customer AC")
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
            action("Send to EFT")
            {
                ApplicationArea = All;
                Image = Create;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = report "Create Employee Customer AC";
            }
        }
    }
}
