page 51741 "Incidences/Grievances"
{
    // version THL- HRM 1.0
    Caption = 'Incidences/Grievances';
    CardPageID = "Incidence/Grievance";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;
    SourceTable = "User Grievances";

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
        area(Processing)
        {
            action("Report Incidence")
            {
                ApplicationArea = All;
                Image = Confirm;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = Rec.Status = Rec.Status::Reported;

                trigger OnAction()
                begin
                    Rec.TestField("Remarks HR");
                    if Confirm(Text000, false) = true then begin
                        Rec.Closed:=true;
                        Rec."Closed By":=UserId;
                        Rec."Closed Date":=Today;
                        Rec.Status:=Rec.Status::Closed;
                        Rec.Modify;
                    end;
                end;
            }
        }
    }
    var Text000: Label 'Are you sure you want to Close/Resolve this incidence?';
}
