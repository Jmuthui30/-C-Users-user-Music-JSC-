report 53072 "update Job Appl."
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem("Applicant Submitted Job"; "Applicant Submitted Job")
        {
            RequestFilterFields = "Job code";
            column(Job_code; "Job code")
            {

            }
            trigger OnAfterGetRecord()
            begin
                ApplicantApp.Reset();
                // ApplicantApp.SetRange(ApplicantApp."No.", "Applicant No.");
                //if ApplicantApp.Get() then begin
                Init;
                IDNO := ApplicantApp."National ID";
                "Birth Date" := ApplicantApp."Birth Date";
                Age := ApplicantApp.Age;
                "Home County" := ApplicantApp."Home County";
                Disability := ApplicantApp.Disability;
                "Postal Address" := ApplicantApp."Postal Address new";
                "Mobile Phone No." := ApplicantApp."Mobile Phone No.";
                "E-Mail" := LowerCase(ApplicantApp."E-Mail");
                "NCPWD Certificate No." := ApplicantApp."NCPWD Certificate No.";
                "Disability Description" := ApplicantApp."Disability Description";
                city := ApplicantApp.City;
                "Ethnic Group" := ApplicantApp."Ethnic Group";
                "Post Code" := ApplicantApp."Post Code";
                Insert;


                //end;
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
        layout(LayoutName)
        {
            Type = Excel;
            LayoutFile = 'mySpreadsheet.xlsx';
        }
    }

    var
        myInt: Integer;
        AppQ: Record "Applicants Qualification";
        ApplicantApp: record Applicant;
}