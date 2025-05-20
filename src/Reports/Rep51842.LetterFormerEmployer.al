report 51842 "Letter_Former_Employer"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Letter_Former_Employer.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";

            column(No_Applicants1; Employee."No.")
            {
            }
            column(FirstName_Applicants1; Employee."First Name")
            {
            }
            column(MiddleName_Applicants1; Employee."Middle Name")
            {
            }
            column(LastName_Applicants1; Employee."Last Name")
            {
            }
            column(Initials_Applicants1; Employee.Initials)
            {
            }
            column(HRMNAME; HRMNAME)
            {
            }
            column(HRMTITLE; HRMTITLE)
            {
            }
            column(HRMPHONE; HRMPHONE)
            {
            }
            column(HRMEMAIL; HRMEMAIL)
            {
            }
            column(CompName; CompName)
            {
            }
            column(FromDate; FromDate)
            {
            }
            column(ToDate; ToDate)
            {
            }
            column(PostalAddress; PostalAddress)
            {
            }
            column(JobTitle; JobTitle)
            {
            }
            dataitem("Employee Master"; "Employee Master")
            {
                DataItemLink = "No."=FIELD("No.");

                column(IDNumber_Applicants1; "Employee Master"."ID Number")
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                HRSetup.Get;
                HRSetup.TestField("HR Manager");
                if EmpRec.Get(HRSetup."HR Manager")then begin
                    HRMNAME:=EmpRec."Last Name" + ' ' + EmpRec."First Name" + ' ' + EmpRec."Middle Name";
                    HRMTITLE:=EmpRec."Job Title";
                    HRMPHONE:=EmpRec."Phone No.";
                    HRMEMAIL:=EmpRec."Company E-Mail";
                end;
                EmpHistory.Reset;
                EmpHistory.SetCurrentKey("Employee No.", "Company Name");
                EmpHistory.SetRange("Employee No.", Employee."No.");
                EmpHistory.SetRange(Select, true);
                if EmpHistory.FindFirst then begin
                    CompName:=EmpHistory."Company Name";
                    FromDate:=EmpHistory.From;
                    ToDate:=EmpHistory."To";
                    PostalAddress:=EmpHistory."Postal Address";
                    JobTitle:=EmpHistory."Job Title";
                end
                else
                begin
                    EmpHistory.Reset;
                    EmpHistory.SetCurrentKey("Employee No.", "Company Name");
                    EmpHistory.SetRange("Employee No.", Employee."No.");
                    if EmpHistory.FindLast then begin
                        CompName:=EmpHistory."Company Name";
                        FromDate:=EmpHistory.From;
                        ToDate:=EmpHistory."To";
                        PostalAddress:=EmpHistory."Postal Address";
                        JobTitle:=EmpHistory."Job Title";
                    end;
                end;
            end;
        }
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
    var HRMNAME: Text;
    HRMTITLE: Text;
    HRMPHONE: Text;
    HRMEMAIL: Text;
    HRSetup: Record "QuantumJumps HR Setup";
    EmpRec: Record Employee;
    EmpHistory: Record "Employment History";
    CompName: Text;
    FromDate: Date;
    ToDate: Date;
    PostalAddress: Text;
    JobTitle: Text;
}
