page 51739 "SS Closed User Grievances"
{
    // version THL- HRM 1.0
    Caption = 'Closed/Resolved Incidences/Grievances';
    CardPageID = "SS Closed User Grievance";
    PageType = List;
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    UsageCategory = Lists;
    SourceTable = "User Grievances";
    SourceTableView = where(Status=const(Closed));

    layout
    {
        area(content)
        {
            repeater("Employee Details")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    ApplicationArea = All;
                }
                field("Incident Location"; Rec."Incident Location")
                {
                    ApplicationArea = All;
                }
                field("Incidence Outcome"; Rec."Incidence Outcome")
                {
                    ApplicationArea = All;
                }
                field("Incident Time"; Rec."Incident Time")
                {
                    ApplicationArea = All;
                }
                field("Work place Controller"; Rec."Work place Controller")
                {
                    ApplicationArea = All;
                }
                field("Work place Controller Name"; Rec."Work place Controller Name")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control23; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange(Rec."Created By", UserId);
    end;
}
