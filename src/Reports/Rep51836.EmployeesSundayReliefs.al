report 51836 "Employees Sunday Reliefs"
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
        AttendanceManagement."Post Sunday Reliefs";
    end;
    var AttendanceManagement: Codeunit "Attendance - Management";
}
