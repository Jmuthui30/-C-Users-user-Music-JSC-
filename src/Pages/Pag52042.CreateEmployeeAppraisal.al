page 52042 "Create Employee Appraisal"
{
    CardPageID = "HOD Appraisal Form";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Appraisals";
    SourceTableView = WHERE(Status=CONST(Open));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                }
                field("No. Supervised (Directly)"; Rec."No. Supervised (Directly)")
                {
                    ApplicationArea = All;
                }
                field("No. Supervised (In-Directly)"; Rec."No. Supervised (In-Directly)")
                {
                    ApplicationArea = All;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field("Agreement With Rating"; Rec."Agreement With Rating")
                {
                    ApplicationArea = All;
                }
                field("General Comments"; Rec."General Comments")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                }
                field("Rating Description"; Rec."Rating Description")
                {
                    ApplicationArea = All;
                }
                field("Appraiser No"; Rec."Appraiser No")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Appraisers Name"; Rec."Appraisers Name")
                {
                    ApplicationArea = All;
                }
                field("Appraisee ID"; Rec."Appraisee ID")
                {
                    ApplicationArea = All;
                }
                field("Appraiser ID"; Rec."Appraiser ID")
                {
                    ApplicationArea = All;
                }
                field("Appraisee Name"; Rec."Appraisee Name")
                {
                    ApplicationArea = All;
                }
                field("Job Group"; Rec."Job Group")
                {
                    ApplicationArea = All;
                }
                field("Appraiser's Job Title"; Rec."Appraiser's Job Title")
                {
                    ApplicationArea = All;
                }
                field("Appraisee's Job Title"; Rec."Appraisee's Job Title")
                {
                    ApplicationArea = All;
                }
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = All;
                }
                field("No. series"; Rec."No. series")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Deapartment Code"; Rec."Deapartment Code")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Category"; Rec."Appraisal Category")
                {
                    ApplicationArea = All;
                }
                field("Wizard Step"; Rec."Wizard Step")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnInit()
    begin
        Rec."HOD Created":=true;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."HOD Created":=true;
    end;
    trigger OnOpenPage()
    begin
    //SETRANGE("Appraisee ID",USERID);
    end;
    var Employee: Record Employee;
    Jobs: Record "Company Jobs";
    EmployeeApp: Record "Employee Appraisals";
    ApprovalMgt: Codeunit "Approvals Mgmt.";
}
