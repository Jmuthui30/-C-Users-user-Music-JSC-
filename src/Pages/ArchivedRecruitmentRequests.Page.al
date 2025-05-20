page 56136 "Archived Recruitment Requests"
{
    ApplicationArea = All;
    Caption = 'Recruitment';
    CardPageId = "Recruitment Card Archive";
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "Recruitment Needs";
    SourceTableView = where(Status = filter(Archived | Closed));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                }
                field("Job ID"; Rec."Job ID")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field("Memo Ref No."; "Memo Ref No.")
                {
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Positions; Rec.Positions)
                {
                    ToolTip = 'Specifies the value of the Positions field';
                }
                // field("Submitted Applicant Count"; "Submitted Applicant Count")
                // {
                //     ApplicationArea = all;
                //     Caption = 'Applicant Submitted';
                //     ToolTip = 'Specifies the value of the Reason for Recruitment(text) field';
                //     Editable = false;
                // }
                field("Submitted jobs Count"; "Submitted jobs Count")
                {
                    ApplicationArea = all;
                    Caption = 'Applicant Submitted';
                    ToolTip = 'Specifies the value of the Reason for Recruitment(text) field';
                    Editable = false;

                }

                field("Appointment Type Description"; Rec."Appointment Type Description")
                {
                    Caption = 'Employment Terms';
                    ToolTip = 'Specifies the value of the Appointment Type Description field';
                }


                field("Work Station"; "Work Station")
                {
                    ToolTip = 'Specifies the value of the Date Approved field';
                }



                field(Date; Rec.Date)
                {
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }

                field("Advertisment Status"; "Advertisment Status")
                {
                    Caption = 'Status';
                    ToolTip = 'Specifies the value of the Reason for Recruitment(text) field';
                }
                field("Submitted To Portal"; Rec."Submitted To Portal")
                {
                    ToolTip = 'Specifies the value of the Submitted To Portal field';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("List of Applicant submitted")
            {
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = List;
                ToolTip = 'Executes the Remove from Portal action';
                RunObject = Page "Job Applications - Submitted'";
                RunPageLink = Submitted = const(true), "Recruitment Needs No." = field("No.");


            }
        }

    }
}





