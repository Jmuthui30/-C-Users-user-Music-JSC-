report 51833 "Daily Attendance Posting"
{
    ProcessingOnly = true;

    dataset
    {
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        AttendanceManagement."Post Daily Present Attendance";
    end;
    var AttendanceManagement: Codeunit "Attendance - Management";
}
