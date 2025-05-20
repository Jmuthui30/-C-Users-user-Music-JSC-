report 53057 "Appl. Submit Job Det."
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ApplSubJob;

    dataset
    {
        dataitem("Job Application"; "Job Application")
        {
            RequestFilterFields = "Job Title";
            column(No_; "No.")
            {
            }
            column(countNo; countNo) { }
            column(Applicant_No_; "Applicant No.") { }
            column(Applicant_Name; "Applicant Name") { }
            column(Gender; Gender) { }
            column(Job_Title; "Job Title") { }
            column(Date_Time_Created; "Date-Time Created") { }
            column(Submitted; Submitted) { }


            dataitem(Applicant; Applicant)
            {
                // DataItemTableView = WHERE(Type = CONST(payment), "Tax Relief" = const(false), "Normal Earnings" = const(true));
                //  RequestFilterFields = Company, "Type", "Pay Period Filter", "Payroll Group";

                // DataItemTableView = where("No." = field("Applicant No."));
                DataItemLink = "No." = FIELD("Applicant No.");
                column(No_app; "No.") { }
                column(E_Mail; "E-Mail") { }
                column(Title; Title) { }
                column(National_ID; "National ID") { }
                column(Birth_Date; "Birth Date") { }
                column(Age; Age) { }
                column(Home_County; "Home County") { }
                column(Disability; Disability) { }
                column(Postal_Address_new; "Postal Address new") { }
                column(Mobile_Phone_No_; "Mobile Phone No.") { }
                dataitem("Applicants Qualification"; "Applicants Qualification")
                {
                    //column(Employee_No_;"Employee No.")
                    DataItemLink = "Employee No." = FIELD("No.");
                    column(Qualification_Code; "Qualification Code") { }
                    column(Area_of_Specialization; "Area of Specialization") { }
                }
                dataitem("ACadamic"; "Applicants Qualification")
                {
                    //column(Employee_No_;"Employee No.")
                    DataItemLink = "Employee No." = FIELD("No.");
                    DataItemTableView = where("Qualification Type" = const(Academic));
                    column(ACadamic_Qualification_Code; "Qualification Code") { }
                    column(ACadamic_Area_of_Specialization; "Area of Specialization") { }
                }
                dataitem("Applicant Current Employment"; "Applicant Current Employment")
                {
                    DataItemLink = "Applicant No." = FIELD("No.");
                    column(Employer_Institution_Name; "Employer/Institution Name") { }
                    column(Employment_No_; "Employment No.") { }
                    column(To_Date; "To Date") { }
                    column(From_Date; "From Date") { }
                    column(Employment_Period; "Employment Period") { }
                    column(Currently_Employment; "Currently Employment") { }
                    column(Expected_Salary__KSH_; "Expected Salary (KSH)") { }
                }
                dataitem("Applicant Professional Bodies"; "Applicant Professional Bodies")
                {
                    DataItemLink = "Applicant No." = FIELD("No.");
                    column(Code; Code) { }
                    column(Name; Name) { }
                    column(Membership_Registration_No_; "Membership/Registration No.") { }
                    column(Date_of_Admission; "Date of Admission") { }

                }
                dataitem("SharePoint Intergration"; "SharePoint Intergration")
                {
                    DataItemLink = "Document No" = FIELD("No.");
                    column(Document_No; "Document No") { }
                    column(Description; Description) { }
                    column(SP_URL_Returned; SP_URL_Returned) { }
                }
                dataitem("Relevant Courses & Trainings"; "Relevant Courses & Trainings")
                {
                    DataItemLink = "Source No" = FIELD("No.");
                    column(RName_of_the_Course; "Name of the Course") { }
                    column(RUniversity_College_Institution; "University/College/Institution") { }
                    column(RFrom_Date; "From Date") { }
                    column(RTo_Date; "To Date") { }
                }




            }


            trigger OnAfterGetRecord()
            begin
                countNo := countNo + 1;
            end;

        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {

                    // }
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

    rendering
    {
        layout(ApplSubJob)
        {

            //Type = Excel;
            Type = RDLC;
            LayoutFile = './Reports/SSRS/Appl_Submit_Job.RDLC';

            Caption = 'Applicants Submitted Jobs';
        }
    }

    var
        myInt: Integer;
        countNo: Integer;
}