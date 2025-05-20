page 51738 "SS Closed User Grievance"
{
    // version THL- HRM 1.0
    Caption = 'Closed/Resolved Incidences/Grievance';
    PageType = Card;
    SourceTable = "User Grievances";
    SourceTableView = where(Status=const(Closed));
    ModifyAllowed = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group("Employee Details")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field(Manager; Rec.Manager)
                {
                    ApplicationArea = All;
                }
                field("Manager's Name"; Rec."Manager's Name")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
            }
            group("Incidence Details")
            {
                field("Incident Description"; Rec."Incident Description")
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
