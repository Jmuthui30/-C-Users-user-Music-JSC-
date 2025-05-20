page 50016 "Training Plan"
{
    ApplicationArea = All;
    Caption = 'Training Plan';
    PageType = Card;
    SourceTable = "Training Needs";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("Financial Year Code"; Rec."Financial Year Code")
                {
                    ToolTip = 'Specifies the value of the Financial Year Code field.';
                }
                field("Calender Start Date"; Rec."Calender Start Date")
                {
                    ToolTip = 'Specifies the value of the Calender Start Date field.';
                }
                field("Calendar End Date"; Rec."Calendar End Date")
                {
                    ToolTip = 'Specifies the value of the Calendar End Date field.';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.';
                }
                field("Created Date Time"; Rec."Created Date Time")
                {
                    ToolTip = 'Specifies the value of the Created Date Time field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field(Venue; Rec.Venue)
                {
                    ToolTip = 'Specifies the value of the Venue field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field.';
                }
            }
            part("Planning Details"; "Training Plan Lines")
            {
                ApplicationArea = All;
                Caption = 'Lines';
                SubPageLink = Code=field(Code);
            }
        }
    }
}
