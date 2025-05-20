report 53001 "Submited Applicants list"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'submited Applicant list';
    RDLCLayout = './Reports/SSRS/Job submited List.rdl';

    dataset
    {
        dataitem(Applicant; Applicant)
        {
            DataItemTableView = where(Submitted = filter(true));
            column(Logo; CompInfo.Picture)
            { }
            column(Addres; CompInfo.Address)
            { }
            column(Comp_Email; CompInfo."E-Mail")
            { }
            column(CompInfo; CompInfo."Post Code")
            { }
            column(No_; "No.")
            { }
            column(Job_ID; "Job ID") { }
            column(Recruitment_Needs_NO; "Recruitment Needs NO") { }
            column(FullName; FullName) { }
            column(National_ID; "National ID") { }
            column(Gender; Gender) { }
            column(Birth_Date; "Birth Date") { }
            column(Age; Age) { }
            column(Home_County; "Home County") { }
            column(Disability; Disability) { }
            column(Postal_Address; "Postal Address") { }
            column(Mobile_Phone_No_; "Mobile Phone No.") { }
            column(E_Mail; "E-Mail") { }
            column(Certificate_of_Admission; "Certificate of Admission") { }
            column(Submitted; Submitted) { }
            column(Submitted_Date; "Submitted Date") { }
            column(Submitted_Time; "Submitted Time") { }
            column(Vacancy_No_; "Vacancy No.") { }
            column(Position_Applied_For; "Position Applied For") { }
            column(Status; Status) { }

            column(Highest_Level_Of_Education; "Highest Level Of Education") { }
            column(Years_Of_Experience; "Years Of Experience") { }
            trigger OnAfterGetRecord()
            begin
                ApplicantQual.Reset();
                ApplicantQual.SetRange(ApplicantQual."Employee No.", "Employment No.");
                if ApplicantQual.Find('-') then begin

                    BachelorofLawsLLBdegree := ApplicantQual."Qualification Code";
                end;

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


    }

    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        CompInfo: Record "Company Information";
        Address: Text[200];
        BachelorofLawsLLBdegree: Code[500];
        ApplicantQual: Record "Applicants Qualification";
}