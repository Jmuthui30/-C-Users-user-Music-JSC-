report 53010 "THE COURT OF APPEAL"
{

    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'THE COURT OF APPEAL';
    RDLCLayout = './Reports/SSRS/THE COURT OF APPEAL.rdl';

    dataset
    {
        dataitem("Recruitment Needs"; "Recruitment Needs")
        {
            column(No_; "No.")
            {

            }
            column(Description; Description)
            {

            }
            column(Vacancy_Announcement; "Vacancy Announcement") { }
            column(Memo_Ref_No_; "Memo Ref No.") { }
            column(Positions; Positions) { }
            column(Terms_of_Service_; "Terms of Service:") { }
            column(Remuneration_; "Remuneration:") { }
            column(Job_Purpose; "Job Purpose") { }
            column(Reporting_Responsibilities; "Reporting Responsibilities") { }
            column(Area_Of_Deployment; "Area Of Deployment") { }
            column(Key_Duties___Responsibilities_; "Key Duties & Responsibilities:") { }
            column(Job_Academic_and_Professional; "Job Academic and Professional") { }
            column(Terms_and_Conditions; "Terms and Conditions") { }
            column(Terms_and_Conditions_2; "Terms and Conditions 2") { }
            column(Terms_and_Conditions_3; "Terms and Conditions 3") { }
            column(Constitution_Requirement; "Constitution Requirement")
            { }

            dataitem(Academic_Prof_; "Job Qualifications")
            {//DataItemTableView = SORTING(Code)ORDER(Descending)WHERE("Institution Code"=FILTER(<>''));
                DataItemLink = "Job Id" = field("Job ID");
                DataItemTableView = where("Qualification Type" = filter(Academic), "Qualification Code" = filter(> 0));
                column(Academic_Prof_Code; "Qualification Code") { }
                column(Academic_Prof_Job_Id; "Job Id") { }
                column(Academic_Prof_Qualification; Qualification) { }
                column(Academic_Prof_Qualification_Type; "Qualification Type") { }
                column(Academic_Prof_Area_of_Specialization; "Area of Specialization") { }
            }
            dataitem("Job Qualifications"; "Job Qualifications")
            {

                DataItemLink = "Job Id" = field("Job ID");
                DataItemTableView = where("Qualification Type" = filter(Academic | Professional), "Qualification Code" = filter(> 0));
                column(Qualification_Code; "Qualification Code") { }
                column(Job_Id; "Job Id") { }
                column(Qualification; Qualification) { }
                column(Qualification_Type; "Qualification Type") { }
                column(Area_of_Specialization; "Area of Specialization") { }
            }
            dataitem(Job_Q; "Job Qualifications")
            {

                DataItemLink = "Job Id" = field("Job ID");
                DataItemTableView = where("Qualification Type" = filter(Competency), "Qualification Code" = filter(> 0));
                column(Job_QQualification_Code; "Qualification Code") { }
                column(Job_QQualification_Type; "Qualification Type") { }
                column(Job_QArea_of_Specialization; "Area of Specialization") { }
            }

            dataitem("Titles of Sample Writings"; "Titles of Sample Writings")
            {                //   DataItemLink = "Code"=FIELD(Code);
                DataItemLink = "Source No" = field("No.");
                column(Source_No; "Source No") { }

            }
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
                    // field(Name; )
                    // {

                    // }
                }
            }
        }


    }



    var
        myInt: Integer;
}