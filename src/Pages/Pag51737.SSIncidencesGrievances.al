page 51737 "SS Incidences/Grievances"
{
    // version THL- HRM 1.0
    Caption = 'Incidence/Grievances';
    CardPageID = "SS Incidence/Grievance";
    PageType = List;
    ModifyAllowed = false;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "User Grievances";

    layout
    {
        area(content)
        {
            repeater("Employee Details")
            {
                Editable = false;

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
        area(processing)
        {
            action("Report Incidence")
            {
                ApplicationArea = All;
                Image = Confirm;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = Rec.Status = Rec.Status::New;

                trigger OnAction()
                begin
                    if Confirm(Text000, false) = true then begin
                        Rec.Status:=Rec.Status::Reported;
                        Rec.Modify;
                        Message(Text001);
                    end;
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status:=Rec.Status::New;
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange(Rec."Created By", UserId);
    end;
    var Text000: Label 'Are you sure you want to report this incidence?';
    Text001: Label 'Your incidence report has been submitted.';
}
