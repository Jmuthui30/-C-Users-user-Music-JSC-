page 52292 "Leave Planner Lines"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Leave Planner Lines';
    PageType = ListPart;
    SourceTable = "Leave Planner Lines";

    layout
    {
        area(content)
        {
            repeater(General)

            {
                Field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                }
                field("Line No."; "Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ToolTip = 'Specifies the value of the Employee No. field.';
                    editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    editable = false;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ToolTip = 'Specifies the value of the Leave Type field.';
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ToolTip = 'Specifies the value of the No. of Days field.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field.';
                    Editable = false;
                }
                field("Resumption Date"; Rec."Resumption Date")
                {
                    ToolTip = 'Specifies the value of the Resumption Date field.';
                    Editable = false;
                }

            }
        }
    }
}






