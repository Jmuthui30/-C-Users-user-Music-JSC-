report 53072 "update Job Appl."
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ApplSub;

    dataset
    {
        dataitem("Job Application"; "Job Application")
        {
            RequestFilterFields = "No.", "Recruitment Needs No.", "Job Title", "Applicant No.";
            column(No_; "No.")
            {

            }
            trigger OnAfterGetRecord()
            begin



                IF CONFIRM('Update all applicant job records?', TRUE) = FALSE THEN EXIT;
                JobAppl.Reset();
                InsertCount := 0;
                // Set filters for Job Application
                JobAppl.SetRange("No.", "Job Application"."No.");
                IF JobAppl.FindFirst THEN begin
                    repeat
                        // Check if this application already exists in submitted jobs
                        if not ApplicantSubmittedJob.Get(JobAppl."Recruitment Needs No.") then begin
                            // Initialize new record
                            Clear(ApplicantSubmittedJob);
                            ApplicantSubmittedJob.Init();
                            ApplicantSubmittedJob."Job code" := JobAppl."No.";
                            ApplicantSubmittedJob."Applicant Name" := JobAppl."Applicant Name";
                            ApplicantSubmittedJob."Applicant No." := JobAppl."Applicant No.";
                            ApplicantSubmittedJob.Gender := JobAppl.Gender;
                            ApplicantSubmittedJob."Job Title" := JobAppl."Job Title";
                            ApplicantSubmittedJob."Job Applied Code" := JobAppl."Job Applied Code";
                            ApplicantSubmittedJob."Recruitment Needs NO" := JobAppl."Recruitment Needs No.";
                            ApplicantSubmittedJob."Date-Time Created" := JobAppl."Date-Time Created";
                            //****************************************************************************************
                            if ApplicantApp.Get(JobAppl."Applicant No.") then begin
                                ApplicantSubmittedJob.Age := ApplicantApp.Age;
                                ApplicantSubmittedJob."Birth Date" := ApplicantApp."Birth Date";
                                ApplicantSubmittedJob."Nationality New" := ApplicantApp."Nationality New";
                                ApplicantSubmittedJob.IDNO := ApplicantApp."National ID";
                                ApplicantSubmittedJob."Home County" := ApplicantApp."Home County";
                                ApplicantSubmittedJob."Ethnic Group" := ApplicantApp."Ethnic Group";
                                ApplicantSubmittedJob."Marital Status" := ApplicantApp."Marital Status";
                                ApplicantSubmittedJob."Sub Ethnic Group" := ApplicantApp."Sub Ethnic Group";
                                ApplicantSubmittedJob.Disability := ApplicantApp.Disability;
                                ApplicantSubmittedJob."Disability Description" := ApplicantApp."Disability Description";
                                ApplicantSubmittedJob."Dismissal Declaration" := ApplicantApp."Dismissal Declaration";
                                ApplicantSubmittedJob."Dismissal Decl. Specification" := ApplicantApp."Dismissal Decl. Specification";
                                ApplicantSubmittedJob."Passport Expiry Date" := ApplicantApp."Passport Expiry Date";
                                ApplicantSubmittedJob."Passport Issue Date" := ApplicantApp."Passport Issue Date";
                                ApplicantSubmittedJob."Passport No." := ApplicantApp."Passport No.";
                                ApplicantSubmittedJob."Permit No." := ApplicantApp."Permit No.";
                                ApplicantSubmittedJob."Permit Issue Date" := ApplicantApp."Permit Issue Date";
                                ApplicantSubmittedJob."Permit Validity Period" := ApplicantApp."Permit Validity Period";
                                ApplicantSubmittedJob."Post Code" := ApplicantApp."Post Code";
                                ApplicantSubmittedJob."Postal Address" := ApplicantApp."Postal Address new";
                                ApplicantSubmittedJob."Physical Address" := ApplicantApp."Physical Address";
                                ApplicantSubmittedJob.City := ApplicantApp.City;
                                ApplicantSubmittedJob."Mobile Phone No." := ApplicantApp."Mobile Phone No.";
                                ApplicantSubmittedJob."Alternative Phone No." := ApplicantApp."Alternative Phone No.";
                                ApplicantSubmittedJob."E-Mail" := ApplicantApp."E-Mail";
                                ApplicantSubmittedJob."Current Salary" := ApplicantApp."Current Salary";
                                ApplicantSubmittedJob."Expected Salary" := ApplicantApp."Expected Salary";
                                ApplicantSubmittedJob."Years Of Experience" := ApplicantApp."Years of Experience";
                                ApplicantSubmittedJob."First Language (R/W/S)" := ApplicantApp."First Language (R/W/S)";
                                ApplicantSubmittedJob."Second Language (R/W/S)" := ApplicantApp."Second Language (R/W/S)";
                                ApplicantSubmittedJob."Other Language (R/W/S)" := ApplicantApp."Other Language (R/W/S)";
                                ApplicantSubmittedJob."First Language Read" := ApplicantApp."First Language Read";
                                ApplicantSubmittedJob."First Language Write" := ApplicantApp."First Language Write";
                                ApplicantSubmittedJob."First Language Speak" := ApplicantApp."First Language Speak";
                                ApplicantSubmittedJob."Second Language Read" := ApplicantApp."Second Language Read";
                                ApplicantSubmittedJob."Second Language Write" := ApplicantApp."Second Language Write";
                                ApplicantSubmittedJob."Second Language Speak" := ApplicantApp."Second Language Speak";
                                ApplicantSubmittedJob."Other Language Read" := ApplicantApp."Other Language Read";
                                ApplicantSubmittedJob."Other Language Write" := ApplicantApp."Other Language Write";
                                ApplicantSubmittedJob."Other Language Speak" := ApplicantApp."Other Language Speak";
                            end;
                            //****************************************************************************************



                            if ApplicantSubmittedJob.Insert() then
                                InsertCount += 1;
                        end;
                    until JobAppl.Next() = 0;
                end;
                Commit();

                // //*********************************************************
                ApplicantEmpl.Reset();
                ApplicantEmpl.SetRange("Applicant No.", applicantSubmittedJob."Applicant No.");
                ApplicantEmpl.SetCurrentKey("From Date"); // Ensure records are sorted (e.g., newest first)
                if ApplicantEmpl.FindSet() then begin
                    EmploymentRecordCount := 0; // Reset the count for each applicant
                    repeat
                        EmploymentRecordCount += 1; // Increment the count for each employment record
                        case EmploymentRecordCount of
                            1:
                                begin
                                    ApplicantSubmittedJob.Employer := ApplicantEmpl."Applicant No.";
                                    ApplicantSubmittedJob."Sector Of Employement" := ApplicantEmpl.Sector;
                                    ApplicantSubmittedJob."Designation Employer" := ApplicantEmpl."Sector Specification";
                                    ApplicantSubmittedJob."From Date Employer" := ApplicantEmpl."From Date";
                                    ApplicantSubmittedJob."To Date Employer" := ApplicantEmpl."To Date";
                                end;
                            2:
                                begin
                                    ApplicantSubmittedJob."Employer 2" := ApplicantEmpl."Applicant No.";
                                    ApplicantSubmittedJob."From Date Employer 2" := ApplicantEmpl."From Date";
                                    ApplicantSubmittedJob."To Date Employer 2" := ApplicantEmpl."To Date";
                                    ApplicantSubmittedJob."Designation Employer 2" := ApplicantEmpl."Sector Specification";
                                end;
                            3:
                                begin
                                    ApplicantSubmittedJob."Employer 3" := ApplicantEmpl."Applicant No.";
                                    ApplicantSubmittedJob."From Date Employer 3" := ApplicantEmpl."From Date";
                                    ApplicantSubmittedJob."To Date Employer 3" := ApplicantEmpl."To Date";
                                    ApplicantSubmittedJob."Designation Employer 3" := ApplicantEmpl."Sector Specification";
                                end;
                            4:
                                begin
                                    ApplicantSubmittedJob."Employer 4" := ApplicantEmpl."Applicant No.";
                                    ApplicantSubmittedJob."From Date Employer 4" := ApplicantEmpl."From Date";
                                    ApplicantSubmittedJob."To Date Employer 4" := ApplicantEmpl."To Date";
                                    ApplicantSubmittedJob."Designation Employer 4" := ApplicantEmpl."Sector Specification";
                                end;
                        end;

                        if EmploymentRecordCount = 4 then
                            break;
                    until ApplicantEmpl.Next() = 0;

                    // Only modify once after all updates
                    if EmploymentRecordCount > 0 then
                        ApplicantSubmittedJob.Modify();
                end;
                //*********************************************end of applicant employment history
                //*********************************************************************************education
                ApplicantsQual.Reset();
                ApplicantsQual.SetRange("Employee No.", applicantSubmittedJob."Applicant No.");
                ApplicantsQual.SetCurrentKey("From Date"); // Ensure records are sorted (e.g.,
                // newest first)
                if ApplicantsQual.FindSet() then begin
                    EducationRecordCount := 0;
                    if ApplicantsQual."Qualification Type" = ApplicantsQual."Qualification Type"::Academic then begin
                        repeat
                            EducationRecordCount += 1; // Increment the count for each education record
                            case EducationRecordCount of
                                1:
                                    begin
                                        ApplicantSubmittedJob."Qualification Code" := ApplicantsQual.Description;
                                        ApplicantSubmittedJob."Institution/Company" := ApplicantsQual."Institution/Company";
                                        ApplicantSubmittedJob."From Date" := ApplicantsQual."From Date";
                                        ApplicantSubmittedJob."To Date" := ApplicantsQual."To Date";
                                        ApplicantSubmittedJob."Grade/Class" := ApplicantsQual."Grade/Class";
                                        applicantSubmittedJob."Area of Specialization" := ApplicantsQual."Area of Specialization";
                                    end;
                                2:
                                    begin
                                        ApplicantSubmittedJob."Qualification Code 2" := ApplicantsQual.Description;
                                        ApplicantSubmittedJob."Institution/Company 2" := ApplicantsQual."Institution/Company";
                                        ApplicantSubmittedJob."From Date 2" := ApplicantsQual."From Date";
                                        ApplicantSubmittedJob."To Date 2" := ApplicantsQual."To Date";
                                        ApplicantSubmittedJob."Grade/Class 2" := ApplicantsQual."Grade/Class";
                                        applicantSubmittedJob."Area of Specialization 2" := ApplicantsQual."Area of Specialization";
                                    end;
                                3:
                                    begin
                                        ApplicantSubmittedJob."Qualification Code 3" := ApplicantsQual.Description;
                                        ApplicantSubmittedJob."Institution/Company 3" := ApplicantsQual."Institution/Company";
                                        ApplicantSubmittedJob."From Date 3" := ApplicantsQual."From Date";
                                        ApplicantSubmittedJob."To Date 3" := ApplicantsQual."To Date";
                                        ApplicantSubmittedJob."Grade/Class 3" := ApplicantsQual."Grade/Class";
                                        applicantSubmittedJob."Area of Specialization 3" := ApplicantsQual."Area of Specialization";
                                    end;
                                4:
                                    begin
                                        ApplicantSubmittedJob."Qualification Code 4" := ApplicantsQual.Description;
                                        ApplicantSubmittedJob."Institution/Company 4" := ApplicantsQual."Institution/Company";
                                        ApplicantSubmittedJob."From Date 4" := ApplicantsQual."From Date";
                                        ApplicantSubmittedJob."To Date 4" := ApplicantsQual."To Date";
                                        ApplicantSubmittedJob."Grade/Class 4" := ApplicantsQual."Grade/Class";
                                        applicantSubmittedJob."Area of Specialization 4" := ApplicantsQual."Area of Specialization";
                                    end;
                            end;
                            if EducationRecordCount = 4 then
                                break;
                        until ApplicantsQual.Next() = 0;
                    end;


                    // Only modify once after all updates
                    if EducationRecordCount > 0 then
                        ApplicantSubmittedJob.Modify();
                end;
                //*********************************************end of applicant education history

                ApplicantsQual.Reset();
                ApplicantsQual.SetRange("Employee No.", applicantSubmittedJob."Applicant No.");
                ApplicantsQual.SetCurrentKey("From Date"); // Ensure records are sorted (e.g.,
                // newest first)
                if ApplicantsQual.FindSet() then begin
                    ProfessionalRecordCount := 0;
                    if ApplicantsQual."Qualification Type" = ApplicantsQual."Qualification Type"::Professional then begin
                        repeat
                            ProfessionalRecordCount += 1; // Increment the count for each education record
                            case ProfessionalRecordCount of
                                1:
                                    begin
                                        applicantSubmittedJob."Professional Qualification" := ApplicantsQual."Qualification Code";
                                        ApplicantSubmittedJob."Professional Institution" := ApplicantsQual."Institution/Company";
                                        ApplicantSubmittedJob."Professional From Date" := ApplicantsQual."From Date";
                                        ApplicantSubmittedJob."Professional Date of Admission" := ApplicantsQual."To Date";
                                        ApplicantSubmittedJob."Professional Name" := ApplicantsQual."Area of Specialization";
                                    end;
                                2:
                                    begin
                                        ApplicantSubmittedJob."Professional Qualification 2" := ApplicantsQual."Qualification Code";
                                        ApplicantSubmittedJob."Professional Institution 2" := ApplicantsQual."Institution/Company";
                                        ApplicantSubmittedJob."Professional From Date 2" := ApplicantsQual."From Date";
                                        ApplicantSubmittedJob."Professional Date of Admn 2" := ApplicantsQual."To Date";
                                        ApplicantSubmittedJob."Professional Name 2" := ApplicantsQual."Area of Specialization";
                                    end;
                                3:
                                    begin
                                        ApplicantSubmittedJob."Professional Qualification 3" := ApplicantsQual."Qualification Code";
                                        ApplicantSubmittedJob."Professional Institution 3" := ApplicantsQual."Institution/Company";
                                        ApplicantSubmittedJob."Professional From Date 3" := ApplicantsQual."From Date";
                                        //ApplicantSubmittedJob.proff := ApplicantsQual."To Date";
                                        // ApplicantSubmittedJob."Professional Name 3" := ApplicantsQual."Area of Specialization";
                                    end;

                            end;
                            if ProfessionalRecordCount = 3 then
                                break;

                        until ApplicantsQual.Next() = 0;
                    end;
                    // Only modify once after all updates
                    if ProfessionalRecordCount > 0 then
                        applicantSubmittedJob.Modify();
                end;
                //*************************************************************************************** ApplicantProfessionalBodies
                ApplicantProfessionalBodies.Reset();
                ApplicantProfessionalBodies.SetRange("Applicant No.", applicantSubmittedJob."Applicant No.");
                // newest first)
                if ApplicantProfessionalBodies.FindSet() then begin
                    ProfessionalBodiesRecordCount := 0; // Reset the count for each applicant
                    repeat
                        ProfessionalBodiesRecordCount += 1; // Increment the count for each professional bodies record
                        case ProfessionalBodiesRecordCount of
                            1:
                                begin
                                    ApplicantSubmittedJob."Professional Bodies" := ApplicantProfessionalBodies.Code;
                                    ApplicantSubmittedJob."Admission Date" := ApplicantProfessionalBodies."Date of Admission";
                                    ApplicantSubmittedJob."Membership No." := ApplicantProfessionalBodies."Membership/Registration No.";
                                end;
                            2:
                                begin
                                    applicantSubmittedJob."Professional Bodies 2" := ApplicantProfessionalBodies.Code;
                                    ApplicantSubmittedJob."Admission Date 2" := ApplicantProfessionalBodies."Date of Admission";
                                    ApplicantSubmittedJob."Membership No. 2" := ApplicantProfessionalBodies."Membership/Registration No.";
                                end;
                            3:
                                begin
                                    ApplicantSubmittedJob."Professional Bodies 3" := ApplicantProfessionalBodies.Code;
                                    ApplicantSubmittedJob."Admission Date 3" := ApplicantProfessionalBodies."Date of Admission";
                                    ApplicantSubmittedJob."Membership No. 3" := ApplicantProfessionalBodies."Membership/Registration No.";
                                end;

                        end;

                        if ProfessionalBodiesRecordCount = 3 then
                            break;
                    until ApplicantProfessionalBodies.Next() = 0;
                    /// Only modify once after all updates

                    if ProfessionalBodiesRecordCount > 0 then
                        ApplicantSubmittedJob.Modify();
                end;
                //*************************************************************************************** Relevant Courses & Trainings
                RelevantCourse.Reset();
                RelevantCourse.SetRange("Source No", applicantSubmittedJob."Applicant No.");
                RelevantCourse.SetCurrentKey("From Date"); // Ensure records are sorted (e.g.,
                // newest first)
                if RelevantCourse.FindSet() then begin
                    courseRecordCount := 0; // Reset the count for each applicant
                    repeat
                        courseRecordCount += 1; // Increment the count for each relevant course record
                        case courseRecordCount of
                            1:
                                begin
                                    ApplicantSubmittedJob."Name Course" := RelevantCourse."Source No";
                                    ApplicantSubmittedJob."Name of the Course" := RelevantCourse."Name of the Course";
                                    ApplicantSubmittedJob."Course Int" := RelevantCourse."University/College/Institution";
                                    ApplicantSubmittedJob."From Date course" := RelevantCourse."From Date";
                                    ApplicantSubmittedJob."To Date course" := RelevantCourse."To Date";
                                    ApplicantSubmittedJob."Duration course" := RelevantCourse.Duration;
                                end;
                            2:
                                begin
                                    ApplicantSubmittedJob."Name Course 2" := RelevantCourse."Source No";
                                    ApplicantSubmittedJob."Name of the Course 2" := RelevantCourse."Name of the Course";
                                    ApplicantSubmittedJob."Course Int 2" := RelevantCourse."University/College/Institution";
                                    ApplicantSubmittedJob."From Date course 2" := RelevantCourse."From Date";
                                    ApplicantSubmittedJob."To Date course 2" := RelevantCourse."To Date";
                                    ApplicantSubmittedJob."Duration course 2" := RelevantCourse.Duration;
                                end;
                            3:
                                begin
                                    ApplicantSubmittedJob."Name Course 3" := RelevantCourse."Source No";
                                    ApplicantSubmittedJob."Name of the Course 3" := RelevantCourse."Name of the Course";
                                    ApplicantSubmittedJob."Course Int 3" := RelevantCourse."University/College/Institution";
                                    ApplicantSubmittedJob."From Date course 3" := RelevantCourse."From Date";
                                    //ApplicantSubmittedJob.proff := RelevantCourse.ToDate;
                                end;

                        end;
                        if courseRecordCount = 3 then
                            break;
                    until RelevantCourse.Next() = 0;
                    if courseRecordCount > 0 then
                        ApplicantSubmittedJob.Modify();
                end;


                //     Commit();
                Message('%1 applicant job records updated successfully.', ApplicantSubmittedJob.Count);

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
        layout(ApplSub)
        {
            Type = RDLC;
            LayoutFile = './Reports/SSRS/UpDateJob.RDLC';
            Caption = 'Job Submitted';
        }
    }

    var
        ApplicantSubmittedJob: record "Applicant Submitted Job";
        ApplicantApp: record Applicant;
        JobAppl: record "Job Application";
        ApplicantEmpl: record "Applicant Current Employment";
        ApplicantsQual: record "Applicants Qualification";
        ApplicantProfessionalBodies: record "Applicant Professional Bodies";
        RelevantCourse: record "Relevant Courses & Trainings";
        QualificationApp: Record Qualification;
        InsertCount: Integer;
        EmploymentRecordCount: Integer; // Variable to track the number of employment records processed
        EducationRecordCount: Integer; // Variable to track the number of education records processed
        ProfessionalRecordCount: Integer;
        ProfessionalBodiesRecordCount: Integer; // Variable to track the number of professional bodies records processed
        courseRecordCount: Integer; // Variable to track the number of relevant courses records processed
}