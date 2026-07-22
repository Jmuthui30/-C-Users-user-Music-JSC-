report 51608 "Training Needs Form"
{
    // version THL- HRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Training Needs Form test.rdlc';

    dataset
    {
        dataitem(Header; "Training Needs Header")
        {
            //PrintOnlyIfDetail = false;
            RequestFilterFields = "No.";

            column(Logo; CompInfo.Picture)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(Address; CompInfo.Address)
            {
            }
            column(Address2; CompInfo."Address 2")
            {
            }
            column(City; CompInfo.City)
            {
            }
            column(Country; CompInfo."Country/Region Code")
            {
            }
            column(DateOfCounsel; Header.Date)
            {
            }
            column(EmployeeName; Header."Employee Name")
            {
            }
            column(Gender; Header.Gender)
            {
            }
            column(EmployeeFileNo; Header."Employee No")
            {
            }
            column(Location; Location)
            {
            }
            column(Department; Header."Global Dimension 1 Code")
            {
            }
            column(DateEmployed; Header."Employment Date")
            {
            }
            column(NoOfYearsInCompany; NoOfYearsInCompany)
            {
            }
            column(ConfirmationStatus; Header."Comfirmation Status")
            {
            }
            column(Position_Designation; Header."Job Title")
            {
            }
            column(GradeLevelOfCounsellee; Header."Grade Level")
            {
            }
            column(DateOfLastTraining; Header."Date of Last Training")
            {
            }
            column(NoOfMonthsYearsInCurrentJob; Header."No of Months/Years in Job")
            {
            }
            column(JobFunction; Header."Job Function")
            {
            }
            column(Skills; Header."Current Employee Skills")
            {
            }
            column(Missing; Header."Missing Competencies")
            {
            }
            column(Required; Header."Required Skills")
            {
            }
            column(CommentsHoD; Header.Comments1)
            {
            }
            column(CommentsHR; Header.Comments2)
            {
            }
            column(IssueDescription; '')
            {
            }
            //Employee Training Needs
            dataitem(Lines; "Employee Training Needs")
            {
                dataitemlink = "Document No." = field("No.");
                RequestFilterFields = "Document No.", "Employee No.";

                column(TrainingNeed; Lines."Employee No.")
                {
                }
                // "Line No."                       Integer (PK2)
                column(TrainingNeedDescription; Lines.Description)
                {
                }
                column(TrainingNeedStatus; Lines.Status)
                {
                }
                column(ReferenceNo; Lines."Reference No.")
                {
                }
                column(DocumentNo; Lines."Document No.")
                {
                }


            }
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
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        GradeLevel: Text;
        Location: Text;
        NoOfYearsInCompany: Text;
}
