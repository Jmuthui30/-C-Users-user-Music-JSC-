report 50007 "Staff Changes Report"
{
    ApplicationArea = All;
    Caption = 'Staff Changes Report';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Reports/SSRS/StaffChange.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting(Status, "Emplymt. Contract Code");
            RequestFilterFields = "Employment Date", "Termination Date", "Inactive Date", Status;

            column(Logo; CompInfo.Picture)
            {
            }
            column(No; "No.")
            {
            }
            column(Date_Filter; "Date Filter")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(MiddleName; "Middle Name")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(Employee_No__Filter; "Employee No. Filter")
            {
            }
            column(Status; Status)
            {
            }
            column(Termination_Date; "Termination Date")
            {
            }
            column(Employment_Date; "Employment Date")
            {
            }
            column(Cause_of_Inactivity_Code; "Cause of Inactivity Code")
            {
            }
            dataitem("Client Employee Master"; "Client Employee Master")
            {
                DataItemLink = "No."=field("No.");

                column(Payroll_No_; "Payroll No.")
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var CompInfo: Record "Company Information";
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;
}
