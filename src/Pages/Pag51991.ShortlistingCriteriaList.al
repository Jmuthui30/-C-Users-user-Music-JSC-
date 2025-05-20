page 51991 "Shortlisting Criteria List"
{
    CardPageID = "Short List Card";
    Caption = 'Recruitment Criterias';
    DeleteAllowed = false;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "Recruitment Needs";
    SourceTableView = WHERE("Interview Conducted" = CONST(false), Approved = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Control13)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field(Positions; Rec.Positions)
                {
                    ApplicationArea = All;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = All;
                }
                field("Documentation Link"; Rec."Documentation Link")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Turn Around Time"; Rec."Turn Around Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
