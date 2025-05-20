page 51740 "Incidence/Grievance"
{
    // version THL- HRM 1.0
    Caption = 'Incidence/Grievance';
    PageType = Card;
    SourceTable = "User Grievances";
    UsageCategory = Lists;
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group("Employee Details")
            {
                Editable = false;

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
                    Editable = false;
                }
                field("Incident Date"; Rec."Incident Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Incident Location"; Rec."Incident Location")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Incidence Outcome"; Rec."Incidence Outcome")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Incident Time"; Rec."Incident Time")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Work place Controller"; Rec."Work place Controller")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Work place Controller Name"; Rec."Work place Controller Name")
                {
                    ApplicationArea = All;
                }
                field("Remarks HR"; Rec."Remarks HR")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = Rec.Status = Rec.Status::Reported;
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
            action("Close/Resolve")
            {
                ApplicationArea = All;
                Image = EndingText;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = Rec.Status = Rec.Status::Reported;

                trigger OnAction()
                begin
                    Rec.TestField("Remarks HR");
                    Rec.TestField(Status, Rec.Status::Reported);
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
