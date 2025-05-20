report 52025 "Applicant Submitted Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/Applicant Submitted Report.rdl';

    dataset
    {
        dataitem(Applicant; Applicant)
        {
            DataItemTableView = where(Submitted = filter(true));
            column(Company_Name; CompanyInfo.Name)
            {
            }
            column(Company_Logo; CompanyInfo.Picture)
            {
            }
            column(Address; CompanyInfo.Address)
            {
            }
            column(City; CompanyInfo.City)
            {
            }
            column(Phone_No; CompanyInfo."Phone No.")
            {
            }
            column(PostCode; CompanyInfo."Post Code")
            {
            }
            column(Email; CompanyInfo."E-Mail")
            {
            }
            column(Website; CompanyInfo."Home Page")
            {
            }


            column(No_; "No.")
            {

            }
            column(FullName; FullName)
            {

            }
            column(Mobile_Phone_No_; "Mobile Phone No.")
            { }
            column(National_ID; "National ID")
            { }
            column(E_Mail; "E-Mail")
            { }
            column(Applicant_Type; "Applicant Type")
            { }
            column(Recruitment_Needs_NO; "Recruitment Needs NO")
            { }
            column(Position_Applied_For; "Position Applied For")
            { }
            column(Job_ID; "Job ID")
            { }
            column(Gender; Gender)
            { }
            column(Nationality_New; "Nationality New")
            { }
            column(Last_Date_Modified; "Last Date Modified")
            { }
            column(Submitted; Submitted)
            { }
            column(Submitted_Date; "Submitted Date")
            { }
            column(countNo; countNo) { }
            trigger OnAfterGetRecord()
            begin
                countNo := countNo + 1;
            end;
        }
    }


    trigger OnPreReport()
    begin

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        countNo: Integer;
}