page 50018 "Training Plan Lines"
{
    ApplicationArea = All;
    Caption = 'Training Plan Lines';
    PageType = ListPart;
    SourceTable = "Training Plan Line";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Course Code"; Rec."Course Code")
                {
                    ToolTip = 'Specifies the value of the Course Code field.';
                }
                field("Course Description"; Rec."Course Description")
                {
                    ToolTip = 'Specifies the value of the Course Description field.';
                }
                field("Course Provide Code"; Rec."Course Provide Code")
                {
                    ToolTip = 'Specifies the value of the Course Provide Code field.';
                }
                field("Course Provider Name"; Rec."Course Provider Name")
                {
                    ToolTip = 'Specifies the value of the Course Provider Name field.';
                }
                field("Planned End Date"; Rec."Planned End Date")
                {
                    ToolTip = 'Specifies the value of the Planned End Date field.';
                }
                field("Planned Start Date"; Rec."Planned Start Date")
                {
                    ToolTip = 'Specifies the value of the Planned Start Date field.';
                }
            }
        }
    }
}
