page 52875 "Employee Change Lists new"
{
    CardPageId = "Employee Change Card";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Change Request";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field(Name; Name) { }
                field(Status; Status) { }
                field("Approval Status"; "Approval Status") { }
                field("ID No."; "ID No.") { }
                field(Gender; Gender) { }
                field("Last Name"; "Last Name") { }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {

                trigger OnAction()
                begin

                end;
            }
        }
    }
}