page 59912 "Performance Management Cues"
{
    ApplicationArea = All;
    Caption = 'Performance Management Cues';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "HR Management Cue";

    layout
    {
        area(Content)
        {


            cuegroup(EmployeeAppraisal)
            {
                Caption = 'Performance Management';
                field("Employee Appraisal"; Rec."Employee Appraisal")
                {
                    Caption = 'All Appraisal List';
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
