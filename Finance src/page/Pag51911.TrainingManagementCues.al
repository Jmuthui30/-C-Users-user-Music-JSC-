page 59911 "Training Management Cues"
{
    ApplicationArea = All;
    Caption = 'Training Management Cues';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "HR Management Cue";

    layout
    {
        area(Content)
        {

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
