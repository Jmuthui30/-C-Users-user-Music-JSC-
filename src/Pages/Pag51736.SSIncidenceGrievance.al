page 51736 "SS Incidence/Grievance"
{
    // version THL- HRM 1.0
    Caption = 'Incidence/Grievance';
    PageType = Card;
    SourceTable = "User Grievances";

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
                field(Category; Rec.Category)
                {
                    ApplicationArea = All;
                }
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
        area(processing)
        {
            action("Report Incidence")
            {
                ApplicationArea = All;
                Image = Confirm;
                Promoted = true;
                PromotedIsBig = true;
                Visible = Rec.Status = Rec.Status::New;

                trigger OnAction()
                begin
                    Rec.TestField("Incident Description");
                    Rec.TestField("Incident Date");
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
