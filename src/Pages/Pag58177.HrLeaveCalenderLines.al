page 58177 HrLeaveCalenderLines
{
    ApplicationArea = All;
    Caption = 'HrLeaveCalenderLines';
    PageType = Card;
    SourceTable = "Customized Calendar Change";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                
                field("Additional Source Code"; Rec."Additional Source Code")
                {
                    ToolTip = 'Specifies the calendar entry.';
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ToolTip = 'Specifies which base calendar was used as the basis.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the date.';
                }
                field(Day; Rec.Day)
                {
                    ToolTip = 'Specifies the day of the week.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the entry to be applied.';
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field(Nonworking; Rec.Nonworking)
                {
                    ToolTip = 'Specifies the date entry as a nonworking day. You can also remove the check mark to return the status to working day.';
                }
                
            }
        }
    }
}
