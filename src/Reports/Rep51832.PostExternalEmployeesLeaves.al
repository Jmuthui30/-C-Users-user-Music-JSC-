report 51832 "Post External Employees Leaves"
{
    ProcessingOnly = true;

    dataset
    {
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group("Employees Details")
                {
                    field("Employee No."; "Employee No.")
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                        TableRelation = "Client Employee Master";
                    }
                }
                group("Type Details")
                {
                    field("Leave Type"; "Leave Type")
                    {
                        ShowMandatory = true;
                        ApplicationArea = All;
                    }
                }
                group(Dates)
                {
                    field("Start Date"; Start_date)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field("End Date"; End_date)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                }
            }
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
        AttendanceManagement."Post External Employees Leaves"("Employee No.", "Leave Type", Start_date, End_date);
    end;
    var Start_date: Date;
    End_date: Date;
    "Leave Type": Option " ", "Sick Off", "Sick Leave", Marternity, Parternity, Annual, "Unpaid Leave";
    "Employee No.": Code[20];
    AttendanceManagement: Codeunit "Attendance - Management";
}
