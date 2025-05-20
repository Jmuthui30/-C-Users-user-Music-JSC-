report 51420 "Applicant Profile"
{
    ApplicationArea = All;
    Caption = 'Applicant Profile';
    UsageCategory = ReportsAndAnalysis;
    RDLCLayout = './Reports/SSRS/Applicant Profile.rdlc';

    dataset
    {
        dataitem(Applicant; Applicant)
        {
            column(Logo; CompInfo.Picture)
            {
            }
            column(Age; Age)
            {
            }
            column(AltAddressCode; "Alt. Address Code")
            {
            }
            column(AltAddressEndDate; "Alt. Address End Date")
            {
            }
            column(AltAddressStartDate; "Alt. Address Start Date")
            {
            }
            column(AlternativePhoneNo; "Alternative Phone No.")
            {
            }
            column(AnnualGrossSalary; "Annual Gross Salary")
            {
            }
            column(AnnualLeaveDays; "Annual Leave Days")
            {
            }
            column(ApplicantType; "Applicant Type")
            {
            }
            column(ApplicationLetter; "Application Letter")
            {
            }
            column(BirthDate; "Birth Date")
            {
            }
            column(CauseofInactivityCode; "Cause of Inactivity Code")
            {
            }
            column(CertificateofAdmission; "Certificate of Admission")
            {
            }
            column(City; City)
            {
            }
            column(ClosingTime; "Closing Time")
            {
            }
            column(Comment; Comment)
            {
            }
            column(CompanyEMail; "Company E-Mail")
            {
            }
            column(ContractTerminationNotice; "Contract Termination Notice")
            {
            }
            column(ContractType; "Contract Type")
            {
            }
            column(CostCenterCode; "Cost Center Code")
            {
            }
            column(CostObjectCode; "Cost Object Code")
            {
            }
            column(CountryRegionCode; "Country/Region Code")
            {
            }
            column(CreatedDate; "Created Date")
            {
            }
            column(CriminalDeclSpecification; "Criminal Decl. Specification")
            {
            }
            column(CriminalDeclaration; "Criminal Declaration")
            {
            }
            column(CurrentSalary; "Current Salary")
            {
            }
            column(CurrentExpectedSalary; "Current/Expected Salary")
            {
            }
            column(CurriculumVitae; "Curriculum Vitae")
            {
            }
            column(DaysWorkedPerWeek; "Days Worked Per Week")
            {
            }
            column(DeclarationDate; "Declaration Date")
            {
            }
            column(Disability; Disability)
            {
            }
            column(DisabilityDescription; "Disability Description")
            {
            }
            column(DismissalDeclSpecification; "Dismissal Decl. Specification")
            {
            }
            column(DismissalDeclaration; "Dismissal Declaration")
            {
            }
            column(EMail; "E-Mail")
            {
            }
            column(EmploymentDate; "Employment Date")
            {
            }
            column(EmplymtContractCode; "Emplymt. Contract Code")
            {
            }
            column(EthnicGroup; "Ethnic Group")
            {
            }
            column(ExitInterviewDate; "Exit Interview Date")
            {
            }
            column(ExitInterviewDoneBy; "Exit Interview Done By")
            {
            }
            column(ExpectedSalary; "Expected Salary")
            {
            }
            column(Extension; Extension)
            {
            }
            column(FaxNo; "Fax No.")
            {
            }
            column(FinalDeclaration; "Final Declaration")
            {
            }
            column(FirstName; "First Name")
            {
            }
            column(FullPartTime; "Full / Part Time")
            {
            }
            column(Gender; Gender)
            {
            }
            column(GenderSpecification; "Gender Specification")
            {
            }
            column(GlobalDimension1Code; "Global Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code; "Global Dimension 2 Code")
            {
            }
            column(GlobalDimension3Code; "Global Dimension 3 Code")
            {
            }
            column(GroundsforTermCode; "Grounds for Term. Code")
            {
            }
            column(HELBNo; "HELB No")
            {
            }
            column(HighestLevelOfEducation; "Highest Level Of Education")
            {
            }
            column(HomeCounty; "Home County")
            {
            }
            column(HoursWorkedPerWeek; "Hours Worked Per Week")
            {
            }
            column(IdentificationDocument; "Identification Document")
            {
            }
            column(Image; Image)
            {
            }
            column(InactiveDate; "Inactive Date")
            {
            }
            column(Initials; Initials)
            {
            }
            column(Interview; Interview)
            {
            }
            column(JobID; "Job ID")
            {
            }
            column(LastDateModified; "Last Date Modified")
            {
            }
            column(LastName; "Last Name")
            {
            }
            column(LeaveNoticePeriod; "Leave Notice Period")
            {
            }
            column(LinkedIn; LinkedIn)
            {
            }
            column(LunchBreakDuration; "Lunch Break Duration")
            {
            }
            column(LunchEndTime; "Lunch End Time")
            {
            }
            column(LunchStartTime; "Lunch Start Time")
            {
            }
            column(ManagerNo; "Manager No.")
            {
            }
            column(MaritalStatus; "Marital Status")
            {
            }
            column(MediacalExamination; "Mediacal Examination")
            {
            }
            column(MiddleName; "Middle Name")
            {
            }
            column(MobilePhoneNo; "Mobile Phone No.")
            {
            }
            column(NCPWDCertificateNo; "NCPWD Certificate No.")
            {
            }
            column(SHIFNo; "SHIF No")
            {
            }
            column(NSSFNo; "NSSF No")
            {
            }
            column(NationalID; "National ID")
            {
            }
            column(Nationality; Nationality)
            {
            }
            column(NationalitySpecification; "Nationality Specification")
            {
            }
            column(No; "No.")
            {
            }
            column(NoSeries; "No. Series")
            {
            }
            column(OfferSignedBy; "Offer Signed By")
            {
            }
            column(OfferStatus; "Offer Status")
            {
            }
            column(OfficeLocation; "Office Location")
            {
            }
            column(Pager; Pager)
            {
            }
            column(PassportExpiryDate; "Passport Expiry Date")
            {
            }
            column(PassportIssueDate; "Passport Issue Date")
            {
            }
            column(PassportNo; "Passport No.")
            {
            }
            column(PassportPhoto; "Passport Photo")
            {
            }
            column(PaysTax; "Pays Tax")
            {
            }
            column(PermitIssueDate; "Permit Issue Date")
            {
            }
            column(PermitNo; "Permit No.")
            {
            }
            column(PermitValidityPeriod; "Permit Validity Period")
            {
            }
            column(PhysicalAddress; "Physical Address")
            {
            }
            column(Picture; Picture)
            {
            }
            column(PortalID; "Portal ID")
            {
            }
            column(PositionAppliedFor; "Position Applied For")
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(PostalAddress; "Postal Address")
            {
            }
            column(ProbationPeriod; "Probation Period")
            {
            }
            column(ProbationTerminationNotice; "Probation Termination Notice")
            {
            }
            column(Profession; Profession)
            {
            }
            column(ReportingTime; "Reporting Time")
            {
            }
            column(ResourceNo; "Resource No.")
            {
            }
            column(SalaryCurrency; "Salary Currency")
            {
            }
            column(SalespersPurchCode; "Salespers./Purch. Code")
            {
            }
            column(SearchName; "Search Name")
            {
            }
            column(Shortlisting; Shortlisting)
            {
            }
            column(Signature; Signature)
            {
            }
            column(SocialSecurityNo; "Social Security No.")
            {
            }
            column(StaffID; "Staff ID")
            {
            }
            column(StaffNo; "Staff No.")
            {
            }
            column(StatisticsGroupCode; "Statistics Group Code")
            {
            }
            column(Status; Status)
            {
            }
            column(TerminationDate; "Termination Date")
            {
            }
            column(Testimonials; Testimonials)
            {
            }
            column(Title; Title)
            {
            }
            column(TotalAbsenceBase; "Total Absence (Base)")
            {
            }
            column(TotalInterviewMarks; "Total Interview Marks")
            {
            }
            column(UnionCode; "Union Code")
            {
            }
            column(UnionMembershipNo; "Union Membership No.")
            {
            }
            column(VacancyNo; "Vacancy No.")
            {
            }
            column(WeekEndDay; "Week End Day")
            {
            }
            column(WeekStartDay; "Week Start Day")
            {
            }
            column(YearsOfExperience; "Years Of Experience")
            {
            }
            column(YearsOfRelevantExperience; "Years Of Relevant Experience")
            {
            }
        }
        dataitem("Relevant Courses & Trainings"; "Relevant Courses & Trainings")
        {
            column(Name_of_the_Course; "Name of the Course")
            {
            }
            column(University_College_Institution; "University/College/Institution")
            {
            }
            column(R_From_Date; "From Date")
            {
            }
            column(R_To_Date; "To Date")
            {
            }
            column(Duration; Duration)
            {
            }
            column(R_Attachment_Link; "Attachment Link")
            {
            }
        }
        dataitem("Applicant Current Employment"; "Applicant Current Employment")
        {
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
        }
        dataitem("Applicant Language"; "Applicant Language")
        {
            column(Code; Code)
            {
            }
            column(Description; Description)
            {
            }
        }
        dataitem("Titles of Sample Writings"; "Titles of Sample Writings")
        {
            column(TTitle; Title)
            {
            }
            column(SWAttachment_Link; "Attachment Link")
            {
            }
        }
        dataitem("Applicants Qualification"; "Applicants Qualification")
        {
            column(Qualification_Code; "Qualification Code")
            {
            }
            column(Qualification_Type; "Qualification Type")
            {
            }
            column(A_Area_of_Specialization; "Area of Specialization")
            {
            }
            column(A_Grade_Class; "Grade/Class")
            {
            }
            column(A_From_Date; "From Date")
            {
            }
            column(A_To_Date; "To Date")
            {
            }
            column(Attachment_Link; "Attachment Link")
            {
            }
            column(A_Type; Type)
            {
            }
            column(A_Institution_Company; "Institution/Company")
            {
            }
            column(A_Score_ID; "Score ID")
            {
            }
        }
        dataitem("Professional Applicants Qualification"; "Applicants Qualification")
        {
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
            column(Grade_Class; "Grade/Class")
            {
            }
            column(Area_of_Specialization; "Area of Specialization")
            {
            }
            column(Type; Type)
            {
            }
            column(Institution_Company; "Institution/Company")
            {
            }
            column(Score_ID; "Score ID")
            {
            }
        }
        dataitem("Applicant Professional Bodies"; "Applicant Professional Bodies")
        {
            column(Ap_Code; Code)
            {
            }
            column(Name; Name)
            {
            }
            column(Membership_Registration_No_; "Membership/Registration No.")
            {
            }
            column(Date_of_Admission; "Date of Admission")
            {
            }
            column(Membership_Type; "Membership Type")
            {
            }
            column(Ap_Status; Status)
            {
            }
            column(Ap_Attachment_Link; "Attachment Link")
            {
            }
        }
        dataitem("Job Qualifications"; "Job Qualifications")
        {
            column(AreaofSpecialization; "Area of Specialization")
            {
            }
            column(EducationCode; "Education Code")
            {
            }
            column(EducationLevel; "Education Level")
            {
            }
            column(QJobId; "Job Id")
            {
            }
            column(Level; Level)
            {
            }
            column(Mandatory; Mandatory)
            {
            }
            column(Priority; Priority)
            {
            }
            column(Qualification; Qualification)
            {
            }
            column(QualificationCode; "Qualification Code")
            {
            }
            column(QualificationType; "Qualification Type")
            {
            }
            column(ScoreID; "Score ID")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
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
