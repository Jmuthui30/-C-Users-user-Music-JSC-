page 59908 "HR Leave Management"
{
    ApplicationArea = All;
    Caption = 'Leave Management Cues';
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
