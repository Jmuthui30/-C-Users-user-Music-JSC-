report 53077 "Update Submit Appl."
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ApplSub;
    ProcessingOnly = true; // Add this since it's a processing report

    dataset
    {
        dataitem("Job Application"; "Job Application")
        {
            RequestFilterFields = "No.", "Recruitment Needs No.", "Job Title", "Applicant No.";

            column(No_; "No.")
            {
                // Add caption for better readability
                Caption = 'Application Number';
            }

            trigger OnPreDataItem()
            begin
                // Initialize counters
                TotalRecordsProcessed := 0;
                TotalRecordsInserted := 0;

                // Add progress dialog
                if GuiAllowed then
                    ProgressDialog.Open('Processing Job Applications...\Current Record: #1#####');
            end;

            trigger OnAfterGetRecord()
            begin
                TotalRecordsProcessed += 1;

                if GuiAllowed then
                    ProgressDialog.Update(1, "No.");

                ProcessJobApplication();
            end;

            trigger OnPostDataItem()
            begin
                if GuiAllowed then begin
                    ProgressDialog.Close();
                    Message('%1 job applications processed successfully.\%2 records inserted.',
                           TotalRecordsProcessed, TotalRecordsInserted);
                end;
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Job Application Update Report';
        AboutText = 'This report updates the Applicant Submitted Job table with data from Job Applications and related records.';

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(OverwriteExisting; OverwriteExistingRecords)
                    {
                        ApplicationArea = All;
                        Caption = 'Overwrite Existing Records';
                        ToolTip = 'Specify whether to overwrite existing records in the Applicant Submitted Job table.';
                    }

                    field(ValidateData; ValidateDataBeforeInsert)
                    {
                        ApplicationArea = All;
                        Caption = 'Validate Data Before Insert';
                        ToolTip = 'Specify whether to validate required fields before inserting records.';
                    }
                }
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
        ApplicantSubmittedJob: Record "Applicant Submitted Job";
        ApplicantApp: Record Applicant;
        ApplicantEmpl: Record "Applicant Current Employment";
        ApplicantsQual: Record "Applicants Qualification";
        ApplicantProfessionalBodies: Record "Applicant Professional Bodies";
        RelevantCourse: Record "Relevant Courses & Trainings";
        QualificationApp: Record Qualification;
        ProgressDialog: Dialog;

        // Options
        OverwriteExistingRecords: Boolean;
        ValidateDataBeforeInsert: Boolean;

        // Counters
        TotalRecordsProcessed: Integer;
        TotalRecordsInserted: Integer;

        // Constants for maximum records
        MaxEmploymentRecords: Integer;
        MaxEducationRecords: Integer;
        MaxProfessionalRecords: Integer;
        MaxProfessionalBodiesRecords: Integer;
        MaxCourseRecords: Integer;

    local procedure ProcessJobApplication()
    begin
        // Initialize constants
        InitializeConstants();

        // Check if record already exists
        if ApplicantSubmittedJob.Get("Job Application"."Recruitment Needs No.") then begin
            if not OverwriteExistingRecords then
                exit;
        end else begin
            Clear(ApplicantSubmittedJob);
            ApplicantSubmittedJob.Init();
        end;

        // Populate basic job application data
        PopulateBasicJobData();

        // Populate applicant personal data
        if ApplicantApp.Get("Job Application"."Applicant No.") then
            PopulateApplicantPersonalData();

        // Validate data if required
        if ValidateDataBeforeInsert then
            if not ValidateRequiredFields() then
                exit;

        // Insert or modify record
        if not ApplicantSubmittedJob.Get("Job Application"."Recruitment Needs No.") then begin
            if ApplicantSubmittedJob.Insert() then
                TotalRecordsInserted += 1;
        end else begin
            ApplicantSubmittedJob.Modify();
        end;

        // Process related data
        ProcessEmploymentHistory();
        ProcessEducationHistory();
        ProcessProfessionalQualifications();
        ProcessProfessionalBodies();
        ProcessRelevantCourses();

        Commit();
    end;

    local procedure InitializeConstants()
    begin
        MaxEmploymentRecords := 10;
        MaxEducationRecords := 10;
        MaxProfessionalRecords := 3;
        MaxProfessionalBodiesRecords := 3;
        MaxCourseRecords := 3;
    end;

    local procedure PopulateBasicJobData()
    begin
        ApplicantSubmittedJob."Job code" := "Job Application"."No.";
        ApplicantSubmittedJob."Applicant Name" := "Job Application"."Applicant Name";
        ApplicantSubmittedJob."Applicant No." := "Job Application"."Applicant No.";
        ApplicantSubmittedJob.Gender := "Job Application".Gender;
        ApplicantSubmittedJob."Job Title" := "Job Application"."Job Title";
        ApplicantSubmittedJob."Job Applied Code" := "Job Application"."Job Applied Code";
        ApplicantSubmittedJob."Recruitment Needs NO" := "Job Application"."Recruitment Needs No.";
        ApplicantSubmittedJob."Date-Time Created" := "Job Application"."Date-Time Created";
    end;

    local procedure PopulateApplicantPersonalData()
    begin
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

        // Passport information
        ApplicantSubmittedJob."Passport Expiry Date" := ApplicantApp."Passport Expiry Date";
        ApplicantSubmittedJob."Passport Issue Date" := ApplicantApp."Passport Issue Date";
        ApplicantSubmittedJob."Passport No." := ApplicantApp."Passport No.";

        // Permit information
        ApplicantSubmittedJob."Permit No." := ApplicantApp."Permit No.";
        ApplicantSubmittedJob."Permit Issue Date" := ApplicantApp."Permit Issue Date";
        ApplicantSubmittedJob."Permit Validity Period" := ApplicantApp."Permit Validity Period";

        // Address information
        ApplicantSubmittedJob."Post Code" := ApplicantApp."Post Code";
        ApplicantSubmittedJob."Postal Address" := ApplicantApp."Postal Address new";
        ApplicantSubmittedJob."Physical Address" := ApplicantApp."Physical Address";
        ApplicantSubmittedJob.City := ApplicantApp.City;

        // Contact information
        ApplicantSubmittedJob."Mobile Phone No." := ApplicantApp."Mobile Phone No.";
        ApplicantSubmittedJob."Alternative Phone No." := ApplicantApp."Alternative Phone No.";
        ApplicantSubmittedJob."E-Mail" := ApplicantApp."E-Mail";

        // Salary and experience
        ApplicantSubmittedJob."Current Salary" := ApplicantApp."Current Salary";
        ApplicantSubmittedJob."Expected Salary" := ApplicantApp."Expected Salary";
        ApplicantSubmittedJob."Years Of Experience" := ApplicantApp."Years of Experience";

        // Language skills
        PopulateLanguageSkills();
    end;

    local procedure PopulateLanguageSkills()
    begin
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

    local procedure ValidateRequiredFields(): Boolean
    begin
        if ApplicantSubmittedJob."Applicant No." = '' then begin
            Message('Applicant No. is required for job application %1', ApplicantSubmittedJob."Job code");
            exit(false);
        end;

        if ApplicantSubmittedJob."Job Title" = '' then begin
            Message('Job Title is required for job application %1', ApplicantSubmittedJob."Job code");
            exit(false);
        end;

        exit(true);
    end;

    local procedure ProcessEmploymentHistory()
    var
        EmploymentRecordCount: Integer;
    begin
        ApplicantEmpl.Reset();
        ApplicantEmpl.SetRange("Applicant No.", ApplicantSubmittedJob."Applicant No.");
        ApplicantEmpl.SetCurrentKey("To Date");

        if ApplicantEmpl.FindSet() then begin
            EmploymentRecordCount := 0;
            repeat
                EmploymentRecordCount += 1;
                PopulateEmploymentRecord(EmploymentRecordCount);

                if EmploymentRecordCount >= MaxEmploymentRecords then
                    break;
            until ApplicantEmpl.Next() = 0;

            if EmploymentRecordCount > 0 then
                ApplicantSubmittedJob.Modify();
        end;
    end;

    local procedure PopulateEmploymentRecord(RecordNumber: Integer)
    begin
        case RecordNumber of
            1:
                begin
                    if ApplicantEmpl."Currently Employment" then
                        ApplicantSubmittedJob."Current Employer" := true;
                    ApplicantSubmittedJob."Sector Of Employement" := ApplicantEmpl.Sector;
                    ApplicantSubmittedJob."From Date Employer" := ApplicantEmpl."From Date";
                    ApplicantSubmittedJob."To Date Employer" := ApplicantEmpl."To Date";
                    ApplicantSubmittedJob."Substantive Post" := ApplicantEmpl."Substantive Post";
                    ApplicantSubmittedJob."Employment Period" := ApplicantEmpl."Employment Period";
                    ApplicantSubmittedJob.Employer := ApplicantEmpl."Employer/Institution Name";
                end;
            2:
                begin
                    ApplicantSubmittedJob."Employer 2" := ApplicantEmpl."Employer/Institution Name";
                    ApplicantSubmittedJob."From Date Employer 2" := ApplicantEmpl."From Date";
                    ApplicantSubmittedJob."To Date Employer 2" := ApplicantEmpl."To Date";
                    ApplicantSubmittedJob."Designation Employer 2" := ApplicantEmpl."Sector Specification";
                    ApplicantSubmittedJob."Substantive Post 2" := ApplicantEmpl."Substantive Post";
                    ApplicantSubmittedJob."Employment Period 2" := ApplicantEmpl."Employment Period";
                end;
        // Continue for remaining employment records...
        end;
    end;

    local procedure ProcessEducationHistory()
    var
        EducationRecordCount: Integer;
    begin
        ApplicantsQual.Reset();
        ApplicantsQual.SetRange("Employee No.", ApplicantSubmittedJob."Applicant No.");
        ApplicantsQual.SetRange("Qualification Type", ApplicantsQual."Qualification Type"::Academic);
        ApplicantsQual.SetCurrentKey("To Date");

        if ApplicantsQual.FindSet() then begin
            EducationRecordCount := 0;
            repeat
                EducationRecordCount += 1;
                PopulateEducationRecord(EducationRecordCount);

                if EducationRecordCount >= MaxEducationRecords then
                    break;
            until ApplicantsQual.Next() = 0;

            if EducationRecordCount > 0 then
                ApplicantSubmittedJob.Modify();
        end;
    end;

    local procedure PopulateEducationRecord(RecordNumber: Integer)
    begin
        case RecordNumber of
            1:
                begin
                    ApplicantSubmittedJob."Qualification Code" := ApplicantsQual."Qualification Code";
                    if QualificationApp.Get(ApplicantSubmittedJob."Qualification Code") then
                        if (QualificationApp.Code = 'KACE') or (QualificationApp.Code = 'KCE') then
                            ApplicantSubmittedJob."Area of Specialization" := QualificationApp.Description;
                    ApplicantSubmittedJob."Institution/Company" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."From Date" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."To Date" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Grade/Class" := ApplicantsQual."Grade/Class";
                end;
        // Continue for remaining education records...
        end;
    end;

    local procedure ProcessProfessionalQualifications()
    var
        ProfessionalRecordCount: Integer;
    begin
        ApplicantsQual.Reset();
        ApplicantsQual.SetRange("Employee No.", ApplicantSubmittedJob."Applicant No.");
        ApplicantsQual.SetRange("Qualification Type", ApplicantsQual."Qualification Type"::Professional);

        if ApplicantsQual.FindSet() then begin
            ProfessionalRecordCount := 0;
            repeat
                ProfessionalRecordCount += 1;
                PopulateProfessionalRecord(ProfessionalRecordCount);

                if ProfessionalRecordCount >= MaxProfessionalRecords then
                    break;
            until ApplicantsQual.Next() = 0;

            if ProfessionalRecordCount > 0 then
                ApplicantSubmittedJob.Modify();
        end;
    end;

    local procedure PopulateProfessionalRecord(RecordNumber: Integer)
    begin
        case RecordNumber of
            1:
                begin
                    ApplicantSubmittedJob."Professional Qualification" := ApplicantsQual."Qualification Code";
                    if QualificationApp.Get(ApplicantSubmittedJob."Professional Qualification") then
                        ApplicantSubmittedJob."Professional Name" := QualificationApp.Description;
                    ApplicantSubmittedJob."Professional Institution" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."Professional From Date" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."Professional Date of Admission" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Area of Specialization PROF" := ApplicantsQual."Area of Specialization";
                end;
        // Continue for remaining professional records...
        end;
    end;

    local procedure ProcessProfessionalBodies()
    var
        ProfessionalBodiesRecordCount: Integer;
    begin
        ApplicantProfessionalBodies.Reset();
        ApplicantProfessionalBodies.SetRange("Applicant No.", ApplicantSubmittedJob."Applicant No.");

        if ApplicantProfessionalBodies.FindSet() then begin
            ProfessionalBodiesRecordCount := 0;
            repeat
                ProfessionalBodiesRecordCount += 1;
                PopulateProfessionalBodiesRecord(ProfessionalBodiesRecordCount);

                if ProfessionalBodiesRecordCount >= MaxProfessionalBodiesRecords then
                    break;
            until ApplicantProfessionalBodies.Next() = 0;

            if ProfessionalBodiesRecordCount > 0 then
                ApplicantSubmittedJob.Modify();
        end;
    end;

    local procedure PopulateProfessionalBodiesRecord(RecordNumber: Integer)
    begin
        case RecordNumber of
            1:
                begin
                    ApplicantSubmittedJob."Professional Bodies" := ApplicantProfessionalBodies.Name;
                    ApplicantSubmittedJob."Professional Code" := ApplicantProfessionalBodies.Code;
                    ApplicantSubmittedJob."Admission Date" := ApplicantProfessionalBodies."Date of Admission";
                    ApplicantSubmittedJob."Membership No." := ApplicantProfessionalBodies."Membership/Registration No.";
                    ApplicantSubmittedJob."Professional Membership Type" := ApplicantProfessionalBodies."Membership Type";
                end;
        // Continue for remaining professional bodies records...
        end;
    end;

    local procedure ProcessRelevantCourses()
    var
        CourseRecordCount: Integer;
    begin
        RelevantCourse.Reset();
        RelevantCourse.SetRange("Source No", ApplicantSubmittedJob."Applicant No.");
        RelevantCourse.SetCurrentKey("From Date");

        if RelevantCourse.FindSet() then begin
            CourseRecordCount := 0;
            repeat
                CourseRecordCount += 1;
                PopulateCourseRecord(CourseRecordCount);

                if CourseRecordCount >= MaxCourseRecords then
                    break;
            until RelevantCourse.Next() = 0;

            if CourseRecordCount > 0 then
                ApplicantSubmittedJob.Modify();
        end;
    end;

    local procedure PopulateCourseRecord(RecordNumber: Integer)
    begin
        case RecordNumber of
            1:
                begin
                    ApplicantSubmittedJob."Name Course" := RelevantCourse."Source No";
                    ApplicantSubmittedJob."Name of the Course" := RelevantCourse."Name of the Course";
                    ApplicantSubmittedJob."Course Int" := RelevantCourse."University/College/Institution";
                    ApplicantSubmittedJob."From Date course" := RelevantCourse."From Date";
                    ApplicantSubmittedJob."To Date course" := RelevantCourse."To Date";
                    ApplicantSubmittedJob."Duration course" := RelevantCourse.Duration;
                end;
        // Continue for remaining course records...
        end;
    end;
}