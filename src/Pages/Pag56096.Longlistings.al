page 56096 "Long listings"
{
    SourceTable = "Recruitment Needs";
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    DelayedInsert = false;
    CardPageId = "Long Listing";
    SourceTableView = WHERE("Shortlisting Conducted"=const(false), Approved=CONST(true));

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
                    Editable = false;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = All;
                    Editable = false;
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
        area(Processing)
        {
            action(Longlist)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Caption = 'Long-List Report';
                Image = Report2;
                RunObject = report 52203;
            }
        }
    }
}
