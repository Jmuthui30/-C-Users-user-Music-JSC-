page 50014 "Advertised Recruitment Needs"
{
    CardPageID = "Recruitment Request Header_App";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Recruitment Needs";
    SourceTableView = where(Status=CONST(Released), Advertised=filter(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field("Job Description"; Rec."Job Description")
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Advertisement Status"; Rec."Advertisement Status")
                {
                    ApplicationArea = All;
                }
                field("Advertisement Date"; Rec."Advertisement Date")
                {
                    ApplicationArea = All;
                }
                field("Advertisement Close Date"; Rec."Advertisement Close Date")
                {
                    ApplicationArea = All;
                }
                field("Area of Deployment"; Rec."Area Of Deployment")
                {
                    ApplicationArea = All;
                    Caption = 'Area of Deployment';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Sample Writings"; Rec."Sample Writings")
                {
                    ApplicationArea = All;
                }
                field("Min. Years of Experience"; Rec."Min. Years of Experience")
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
