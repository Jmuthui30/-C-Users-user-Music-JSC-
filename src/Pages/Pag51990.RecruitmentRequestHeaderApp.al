page 51990 "Recruitment Request Header_App"
{
    DeleteAllowed = false;
    InsertAllowed = true;
    PageType = Card;
    SourceTable = "Recruitment Needs";
    SourceTableView = WHERE(Status = CONST(Released));

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Details)
            {
                Editable = false;

                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field(Positions; Rec.Positions)
                {
                    ApplicationArea = All;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = All;
                }
                field("No Filter"; Rec."No Filter")
                {
                    ApplicationArea = All;
                }
                field("Vacancy Announcement"; Rec."Vacancy Announcement")
                {
                    ApplicationArea = All;
                }
                field("Tems of Service"; Rec."Tems of Service")
                {
                    ApplicationArea = All;
                }
                field("Job Purpose"; Rec."Job Purpose")
                {
                    ApplicationArea = All;
                }
                //field(W)
                field("Area of Deployment"; Rec."Area Of Deployment")
                {
                    ApplicationArea = All;
                }
                field("Reporting Responsibilities"; Rec."Reporting Responsibilities")
                {
                    ApplicationArea = All;
                }
                field("Sample Writings"; Rec."Sample Writings")
                {
                    ApplicationArea = All;
                }
                field("Min. Years of Experience"; Rec."Min. Years of Experience")
                {
                    ApplicationArea = All;
                }
            }
            group("Advertisement Details")
            {
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = All;
                }
                field(Profession; Rec.Profession)
                {
                    ApplicationArea = All;
                }
                field("Advertisement Date"; Rec."Advertisement Date")
                {
                    ApplicationArea = All;
                }
                field("Advertisement Close Date"; Rec."Advertisement Close Date")
                {
                    ApplicationArea = All;
                }
                field("Advertisement Type"; Rec."Advertisement Type")
                {
                    ApplicationArea = All;
                }
                field("Advertisement Status"; Rec."Advertisement Status")
                {
                    ApplicationArea = All;
                }
                field("Documentation Link"; Rec."Documentation Link")
                {
                    ApplicationArea = All;
                }
            }
            group(Dates)
            {
                Editable = false;

                field("Expected Reporting Date"; Rec."Expected Reporting Date")
                {
                    ApplicationArea = All;
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
            group(Administration)
            {
                Editable = false;

                field("Appointment Type"; Rec."Appointment Type")
                {
                    ApplicationArea = All;
                }
                field("Turn Around Time"; Rec."Turn Around Time")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Reason for Recruitment"; Rec."Reason for Recruitment")
                {
                    ApplicationArea = All;
                }
                field("Show Salary"; Rec."Show Salary")
                {
                    ApplicationArea = All;
                }
            }
            group("Salary Details")
            {
                Visible = Rec."Show Salary" = true;
                Enabled = Rec."Show Salary" = true;

                field("Minimum Salary"; Rec."Minimum Salary")
                {
                    ApplicationArea = All;
                }
                field("Maximum Salary"; Rec."Maximum Salary")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Apply)
            {
                Image = Apply;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    RecruitmentMgnt.StaffJobApplication(Rec);
                end;
            }
            action("Postion Advertisement")
            {
                ApplicationArea = All;
                Image = AddAction;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = ((Rec.Status = Rec.Status::Released) AND (Rec.Advertised = false));

                trigger OnAction()
                begin
                    RecruitmentMgnt.CreateRecruitmentNeedNew(Rec);
                end;
            }
            action("Close Advertisement")
            {
                ApplicationArea = All;
                Image = Close;
                Promoted = true;
                PromotedIsBig = true;
                Visible = ((Rec.Status = Rec.Status::Released) AND (Rec.Advertised = true));
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Confirm('Do you wish to close this Requitment Request?', false) = true then begin
                        Rec.Closed := true;
                        Rec.Status := "Document Status"::Closed;
                        rec."Advertisment Status" := AdvertismentStatus::Closed;
                        Rec."Closed By" := UserId;
                        Rec."Closed Date Time" := CreateDateTime(Today, Time);
                        Rec.Modify;
                    end;
                    CurrPage.Update;
                end;
            }
        }
    }
    var
        RecruitmentMgnt: Codeunit "Recruitment Management";
}
