page 51909 "Job Resourse & Item Worksheet"
{
    Caption = 'MTF3';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Document;
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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control10; "Worksheet Requisition")
            {
                ApplicationArea = All;
                SubPageLink = "Job No."=FIELD("Job No."), "Job Task No."=FIELD("Job Task No."), "WorkSheet Type"=CONST(Job);
            }
        }
    }
    actions
    {
    }
    var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines";
}
