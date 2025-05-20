page 52177 "Staff Organization Mappings"
{
    // version BUDGET
    DeleteAllowed = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = List;
    CardPageId = "Staff Organization Mapping";
    SourceTable = "Staff Organization Mapping";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Staff ID"; Rec."Staff ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Unit Code"; Rec."Unit Code")
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec.Unit)
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
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
            action("Import Procurement Plan")
            {
                ApplicationArea = All;
                Caption = 'Import';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Import;
                RunObject = xmlport "Staff Organization Mapping";
            }
        }
    }
}
