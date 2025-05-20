report 52203 "Long Listing Report"
{
    ApplicationArea = All;
    Caption = 'Long Listing Report';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/New Long Listing Report.rdlc';

    dataset
    {
        dataitem(Applicant; Applicant)
        {
            RequestFilterFields = "No.", "Date Filter";

            column(logo; CompInfo.Picture)
            {
            }
            column(No; "No.")
            {
            }
            column(PassportNo; "Passport No.")
            {
            }
            column(FullName; FullName)
            {
            }
            column(Gender; Gender)
            {
            }
            column(BirthDate; "Birth Date")
            {
            }
            column(Age; Age)
            {
            }
            column(Home_County; "Home County")
            {
            }
            column(Disability; Disability)
            {
            }
            column(NationalID; "National ID")
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
            column(CountryRegionCode; "Country/Region Code")
            {
            }
            column(HomeCounty; "Home County")
            {
            }
            column(PostalAddress; "Postal Address")
            {
            }
            column(MobilePhoneNo; "Mobile Phone No.")
            {
            }
            column(EMail; "E-Mail")
            {
            }
            // column(CurrentEmployment;CurrentEmployment){}
            column(Years_Of_Relevant_Experience; "Years Of Relevant Experience")
            {
            }
            column(Years_Of_Experience; "Years Of Experience")
            {
            }
            column(Vacancy_No_; "Vacancy No.")
            {
            }
            column(Total_Interview_Marks; "Total Interview Marks")
            {
            }
            column(Applicant_Type; "Applicant Type")
            {
            }
            column(City; City)
            {
            }
            column(Portal_ID; "Portal ID")
            {
            }
            column(Physical_Address; "Physical Address")
            {
            }
            column(Passport_Issue_Date; "Passport Issue Date")
            {
            }
            column(Passport_Expiry_Date; "Passport Expiry Date")
            {
            }
            column(Permit_Issue_Date; "Permit Issue Date")
            {
            }
            column(Permit_Validity_Period; "Permit Validity Period")
            {
            }
            column(Staff_No_; "Staff No.")
            {
            }
            column(Job_ID; "Job ID")
            {
            }
            column(Nationality; Nationality)
            {
            }
            column(Profession; Profession)
            {
            }
            column(Position_Applied_For; "Position Applied For")
            {
            }
            column(NCPWD_Certificate_No_; "NCPWD Certificate No.")
            {
            }
            column(Permit_No_; "Permit No.")
            {
            }
            column(Marital_Status; "Marital Status")
            {
            }
            column(Ethnic_Group; "Ethnic Group")
            {
            }
            column(Alternative_Phone_No_; "Alternative Phone No.")
            {
            }
            column(Current_Salary; "Current Salary")
            {
            }
            column(Expected_Salary; "Expected Salary")
            {
            }
            column(Birth_Date; "Birth Date")
            {
            }
            column(Dismissal_Declaration; "Dismissal Declaration")
            {
            }
            column(Criminal_Declaration_Specification; "Criminal Decl. Specification")
            {
            }
            column(Highest_Level_Of_Education; "Highest Level Of Education")
            {
            IncludeCaption = true;
            }
            column(Final_Declaration; "Final Declaration")
            {
            }
            column(Curriculum_Vitae; "Curriculum Vitae")
            {
            }
            dataitem("Applicant Language"; "Applicant Language")
            {
                DataItemTableView = sorting(Description);
                DataItemLink = "Applicant No."=field("No.");

                column(Code; Code)
                {
                IncludeCaption = true;
                }
                column(Description; Description)
                {
                IncludeCaption = true;
                }
                column(LApplicant_No_; "Applicant No.")
                {
                }
                dataitem("Applicant Current Employment"; "Applicant Current Employment")
                {
                    DataItemLink = "Applicant No."=field("Applicant No.");

                    column(Employer_Institution_Name; "Employer/Institution Name")
                    {
                    IncludeCaption = true;
                    }
                    column(Applicant_No_; "Applicant No.")
                    {
                    }
                    column(Substantive_Post; "Substantive Post")
                    {
                    }
                    column(Sector; Sector)
                    {
                    }
                    column(Sector_Specification; "Sector Specification")
                    {
                    }
                    column(Terms_of_Service; "Terms of Service")
                    {
                    }
                    column(Terms_of_Service_Specfication; "Terms of Service Specfication")
                    {
                    }
                    column(Employment_No_; "Employment No.")
                    {
                    }
                    column(Employment_Period; "Employment Period")
                    {
                    }
                    column(Currently_Employment; "Currently Employment")
                    {
                    }
                    column(Job_Grade; "Job Grade")
                    {
                    }
                    column(From_Date; "From Date")
                    {
                    }
                    column(To_Date; "To Date")
                    {
                    }
                    column(Gross_Salary__KSH_; "Gross Salary (KSH)")
                    {
                    }
                    column(Expected_Salary__KSH_; "Expected Salary (KSH)")
                    {
                    }
                    column(Testimonial_Link; "Testimonial Link")
                    {
                    }
                    dataitem("Academic Applicants Qualification"; "Applicants Qualification")
                    {
                        DataItemTableView = where("Qualification Type"=const(1));
                        //DataItemLinkReference = Applicant;
                        DataItemLink = "Employee No."=field("Applicant No.");

                        column(Qualification_Code; "Qualification Code")
                        {
                        }
                        column(Qualification_Type; "Qualification Type")
                        {
                        }
                        column(Duration; Duration)
                        {
                        }
                        column(Employee_No_; "Employee No.")
                        {
                        }
                        column(AFrom_Date; "From Date")
                        {
                        }
                        column(ATo_Date; "To Date")
                        {
                        }
                        column(CDescription; Description)
                        {
                        }
                        column(Attachment_Link; "Attachment Link")
                        {
                        }
                        dataitem("Professional Applicants Qualification"; "Applicants Qualification")
                        {
                            DataItemTableView = where("Qualification Type"=filter(<>1));
                            DataItemLinkReference = Applicant;
                            DataItemLink = "Employee No."=field("No.");

                            column(PQualification_Code; "Qualification Code")
                            {
                            }
                            column(PQualification_Type; "Qualification Type")
                            {
                            }
                            column(PDuration; Duration)
                            {
                            }
                            column(PEmployee_No_; "Employee No.")
                            {
                            }
                            column(PFrom_Date; "From Date")
                            {
                            }
                            column(PTo_Date; "To Date")
                            {
                            }
                            column(PDescription; Description)
                            {
                            }
                            column(Pttachment_Link; "Attachment Link")
                            {
                            }
                            dataitem("Recruitment Needs"; "Recruitment Needs")
                            {
                                DataItemLink = "Job ID"=field("Job ID");
                                DataItemLinkReference = Applicant;

                                column(No_; "No.")
                                {
                                }
                                column(RJob_ID; "Job ID")
                                {
                                }
                                column(No__Of_Applicants; "No. Of Applicants")
                                {
                                }
                                column(No__Of_Positions; "No. Of Positions")
                                {
                                }
                                dataitem("Titles of Sample Writings"; "Titles of Sample Writings")
                                {
                                    column(Title; Title)
                                    {
                                    }
                                    column(SWAttachment_Link; "Attachment Link")
                                    {
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    requestpage
    {
        SaveValues = true;

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
