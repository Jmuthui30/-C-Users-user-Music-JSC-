page 52051 "Procurement Budget Plans"
{
    CardPageID = "Procurement Plan";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "G/L Budget Name";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            //field("Department Filter";"Department Filter")
            //{
            //}
            }
        }
    }
    actions
    {
    }
}
