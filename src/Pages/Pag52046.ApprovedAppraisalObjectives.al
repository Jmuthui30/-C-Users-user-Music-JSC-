page 52046 "Approved Appraisal Objectives"
{
    CardPageID = "HOD Appraisal Objectives Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Appraisal Objectives";
    SourceTableView = WHERE(Status=CONST(Released));

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
                field("Objective No"; Rec."Objective No")
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
                field("Department Code"; Rec."Department Code")
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
    //"HOD Created" := TRUE;
    end;
    trigger OnNextRecord(Steps: Integer): Integer begin
    //"HOD Created" := TRUE;
    end;
    trigger OnOpenPage()
    begin
    //SETRANGE("Appraisee ID",USERID);
    end;
}
