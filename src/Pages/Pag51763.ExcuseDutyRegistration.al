page 51763 "Excuse Duty Registration"
{
    // version THL- HRM 1.0
    Caption = 'Excuse Duty Registration';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    UsageCategory = Lists;
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Employee Absence";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a number for the employee.';
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the first day of the employee''s absence registered on this line.';
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last day of the employee''s absence registered on this line.';
                }
                field("Cause of Absence Code"; Rec."Cause of Absence Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a cause of absence code to define the type of absence.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the absence.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity associated with absences, in hours or days.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unit of measure for the absence.';
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity associated with absences, in hours or days.';
                    Visible = false;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if a comment is associated with this entry.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            action("Hospital Visited")
            {
                ApplicationArea = All;
                Caption = 'Hospital Visited';
                Image = Add;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Excuse Duty Hospitals";
                RunPageLink = "Entry No."=FIELD("Entry No.");
            }
            group("A&bsence")
            {
                Caption = 'A&bsence';
                Image = Absence;

                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Human Resource Comment Sheet";
                    RunPageLink = "Table Name"=CONST("Employee Absence"), "Table Line No."=FIELD("Entry No.");
                }
                separator(Separator31)
                {
                }
                action("Overview by &Categories")
                {
                    ApplicationArea = All;
                    Caption = 'Overview by &Categories';
                    Image = AbsenceCategory;
                    RunObject = Page "Absence Overview by Categories";
                    RunPageLink = "Employee No. Filter"=FIELD("Employee No.");
                }
                action("Overview by &Periods")
                {
                    ApplicationArea = All;
                    Caption = 'Overview by &Periods';
                    Image = AbsenceCalendar;
                    RunObject = Page "Absence Overview by Periods";
                }
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        exit(Employee.Get(Rec."Employee No."));
    end;
    var Employee: Record Employee;
}
