report 51834 "Posting Special Days"
{
    ProcessingOnly = true;

    dataset
    {
    }
    requestpage
    {
        SourceTable = "Client Employee Master";

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
                group("Posting Type")
                {
                    field(Type; Type)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                }
                group(Date)
                {
                    field("Working Date"; Date)
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
        AttendanceManagement."Post External Employees Special Days"("Employee No.", Type, Date);
    end;
    var "Employee No.": Code[20];
    Type: Option " ", Relief, Sunday;
    Date: Date;
    AttendanceManagement: Codeunit "Attendance - Management";
}
