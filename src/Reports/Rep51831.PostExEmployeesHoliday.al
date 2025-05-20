report 51831 "Post Ex Employees Holiday"
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
                group(Control6)
                {
                    ShowCaption = false;

                    field("Document No."; "Document No.")
                    {
                        ShowMandatory = true;
                        ApplicationArea = All;
                    }
                }
                group(Dates)
                {
                    field("Start Date"; Start_Date)
                    {
                        ApplicationArea = All;
                        ShowMandatory = true;
                    }
                    field("End Date"; End_Date)
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
        AttendanceManagement."Post External Employees Holiday"("Document No.", Start_Date, End_Date);
    end;
    var "Document No.": Code[20];
    Start_Date: Date;
    End_Date: Date;
    AttendanceManagement: Codeunit "Attendance - Management";
}
