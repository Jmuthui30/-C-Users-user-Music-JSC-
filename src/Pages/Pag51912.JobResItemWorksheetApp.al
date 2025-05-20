page 51912 "Job Res. & Item Worksheet -App"
{
    Caption = 'MTF3';
    DataCaptionExpression = Rec.Caption;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Job Task";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Task Type"; Rec."Job Task Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WIP Method"; Rec."WIP Method")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Worksheet Requisition-Approval")
            {
                ApplicationArea = All;
                Caption = 'Lines';
                SubPageLink = "Job No."=FIELD("Job No."), "Job Task No."=FIELD("Job Task No."), "WorkSheet Type"=CONST(Job);
                SubPageView = WHERE(Posted=CONST(false), Status=CONST("Pending Approval"));
            }
        }
    }
    actions
    {
    }
    var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines";
}
