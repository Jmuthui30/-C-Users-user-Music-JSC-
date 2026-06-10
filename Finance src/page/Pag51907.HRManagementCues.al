page 59907 "HR Management Cues"
{
    ApplicationArea = All;
    Caption = 'HR Management Cues';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "HR Management Cue";

    layout
    {
        area(Content)
        {
            cuegroup(leave)
            {
                Caption = 'Leave Management';
                field("Leave Pending Prepayment"; Rec."All Leave Applications")
                {
                    Caption = 'Leave Applications List';
                    DrillDownPageId = "Leave Application List";
                    ToolTip = 'Specifies the value of the Leave Pending Prepayment field';
                }
                field("Leave Applications"; Rec."Leave Applications")
                {
                    Caption = 'Leave Applications';
                    DrillDownPageId = "Leave Application List";
                    ToolTip = 'Specifies the value of the Leave Applications field';
                }
                field("Leave Pending Approval"; Rec."Leave Pending Approval")
                {
                    Caption = 'Leave Pending Approval';
                    DrillDownPageId = "Leave Application List";
                    ToolTip = 'Specifies the value of the Leave Pending Approval field';
                }
                field("Leave Released"; Rec."Leave Released")
                {
                    Caption = 'Leave Released';
                    DrillDownPageId = "Leave Application List";
                    ToolTip = 'Specifies the value of the Leave Released field';
                }
                field("Leave Rejected"; Rec."Leave Rejected")
                {
                    Caption = 'Leave Rejected';
                    DrillDownPageId = "Leave Application List";
                    ToolTip = 'Specifies the value of the Leave Rejected field';
                }

            }
            // //Employee Appraisal
            cuegroup(EmployeeAppraisal)
            {
                Caption = 'Employee Appraisal';
                field("Employee Appraisal"; Rec."Employee Appraisal")
                {
                    Caption = 'Employee Appraisal';
                    DrillDownPageId = "Appraisal List";
                    ToolTip = 'Specifies the value of the Employee Appraisal field';
                }

                // Open
                field("Employee Appraisal Open"; Rec."Employee Appraisal Open")
                {
                    Caption = 'Employee Appraisal Open';
                    DrillDownPageId = "Appraisal List";
                    ToolTip = 'Specifies the value of the Employee Appraisal Open field';
                }

                //Pending Approval
                field("Employee Appraisal Pending Approval"; Rec."Employee Appraisal Pending")
                {
                    Caption = 'Employee Appraisal Pending Approval';
                    DrillDownPageId = "Appraisal List";
                    ToolTip = 'Specifies the value of the Employee Appraisal Pending Approval field';
                }
                //Released

                field("Employee Appraisal Released"; Rec."Employee Appraisal Released")
                {
                    Caption = 'Employee Appraisal Released';
                    DrillDownPageId = "Appraisal List";
                    ToolTip = 'Specifies the value of the Employee Appraisal Released field';
                }


            }
            // Training Request 
            cuegroup(TrainingRequest)
            {
                Caption = 'Training Request';
                field("Training Request Appl"; Rec."Training Request Appl")
                {
                    Caption = 'Training Request Pending';
                    DrillDownPageId = "Training Request List";
                    ToolTip = 'Specifies the value of the Training Request Pending field';
                }
                field("Training Request Released"; Rec."Training Request Released")
                {
                    Caption = 'Training Request Released';
                    DrillDownPageId = "Training Request List";
                    ToolTip = 'Specifies the value of the Training Request Released field';
                }
                field("Training Request Pending Approval"; Rec."Training Request Pending")
                {
                    Caption = 'Training Request Approval Pending';
                    DrillDownPageId = "Training Request List";
                    ToolTip = 'Specifies the value of the Training Request Approval Pending field';
                }
            }


        }
    }


    trigger OnOpenPage()
    begin
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;

        // Rec.SetRange("User ID Filter", UserId);
    end;
}
