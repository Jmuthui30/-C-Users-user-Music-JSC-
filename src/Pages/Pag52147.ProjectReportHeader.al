page 52147 "Project Report Header"
{
    PageType = Card;
    SourceTable = "Project Report Header";

    layout
    {
        area(content)
        {
            group(General)
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
            part(Control9; "Project Report Details")
            {
                ApplicationArea = All;
                SubPageLink = Project=FIELD(Project);
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
