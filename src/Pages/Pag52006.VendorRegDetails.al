page 52006 "Vendor Reg Details"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    AutoSplitKey = true;
    MultipleNewLines = false;
    SourceTable = "Vendor Reg Details";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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
