page 51929 "Ex Employees Leaves list"
{
    CardPageID = "Ex Employees Leaves Card";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "External Employees Leave";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
                field("Annual Days"; Rec."Annual Days")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Other Leave Days"; Rec."Other Leave Days")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control13; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control14; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Control15; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        //SETRANGE("Posted By", USERID);
        PayrollAttendanceEntries.Reset;
        PayrollAttendanceEntries.SetRange("Document No.", Rec.No);
        PayrollAttendanceEntries.SetRange("Employee No.", Rec."Employee No.");
        PayrollAttendanceEntries.SetRange("Posting Type", PayrollAttendanceEntries."Posting Type"::Annual);
        if PayrollAttendanceEntries.FindSet then LeaveDays:=PayrollAttendanceEntries.Count;
        if Rec."Leave Type" = Rec."Leave Type"::Annual then begin
            ExternalEmployeesLeave.Reset;
            ExternalEmployeesLeave.SetRange(No, Rec.No);
            if ExternalEmployeesLeave.FindFirst then begin
                ExternalEmployeesLeave."Annual Days":=LeaveDays;
                ExternalEmployeesLeave.Modify(true)end;
        end;
    end;
    var PayrollAttendanceEntries: Record "Payroll Attendance Entries";
    ExternalEmployeesLeave: Record "External Employees Leave";
    LeaveDays: Integer;
}
