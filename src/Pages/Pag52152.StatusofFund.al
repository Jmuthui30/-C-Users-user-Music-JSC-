page 52152 "Status of Fund"
{
    DeleteAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Status of Fund";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Fund; Rec.Fund)
                {
                    ApplicationArea = All;
                }
                field("Fund Name"; Rec."Fund Name")
                {
                    ApplicationArea = All;
                }
                field(Project; Rec.Project)
                {
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field(FY; Rec.FY)
                {
                    ApplicationArea = All;
                }
                field("Total Allotment"; Rec."Total Allotment")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Commitment"; Rec."Total Commitment")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Obligation"; Rec."Total Obligation")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Disbursement"; Rec."Total Disbursement")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Open Commitment"; Rec."Total Open Commitment")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total ULO"; Rec."Total ULO")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Fund Status Report")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Status of Fund Report";
            }
        }
    }
}
