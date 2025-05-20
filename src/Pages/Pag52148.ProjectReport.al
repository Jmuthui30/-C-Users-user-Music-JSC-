page 52148 "Project Report"
{
    CardPageID = "Project Report Header";
    PageType = List;
    SourceTable = "Project Report Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Project; Rec.Project)
                {
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                }
                field("Report Start Date"; Rec."Report Start Date")
                {
                    ApplicationArea = All;
                }
                field("Report End Date"; Rec."Report End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
