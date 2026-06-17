page 59907 "HR Management Cues"
{
    ApplicationArea = All;
    Caption = 'Recruitment Management Cues';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "HR Management Cue";

    layout
    {
        area(Content)
        {
            Cuegroup(Generalrecriutment)
            {
                caption = 'Recruitment Management';


                field("Recruitment Need"; Rec."Recruitment Need")
                {
                    Caption = 'Recruitment Request List';
                    DrillDownPageId = "Recruitment Request List";
                    ToolTip = 'Specifies the value of the Recruitment Request List field';
                    Image = Checklist;
                }
                field("Recruitment Need Approved"; Rec."Recruitment Need Approved")
                {
                    Caption = ' Recruitment ongoing List';
                    DrillDownPageId = "Approved Recruitment Requests";
                    ToolTip = 'Specifies the value of the Recruitment ongoing List field';
                    Image = Message;
                }
                field("Recruitment Need Closed"; Rec."Recruitment Need Closed")
                {
                    Caption = ' Recruitment Closed List';
                    DrillDownPageId = "Archived Recruitment Requests";
                    ToolTip = 'Specifies the value of the Recruitment Closed List field';
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
