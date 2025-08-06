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
                ProcessJobApplication("Job Application");

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
        ApplicantSubmittedJob: Record "Applicant Submitted Job";
        ApplicantApp: Record Applicant;
        ApplicantEmpl: Record "Applicant Current Employment";
        ApplicantsQual: Record "Applicants Qualification";
        ApplicantProfessionalBodies: Record "Applicant Professional Bodies";
        RelevantCourse: Record "Relevant Courses & Trainings";
        QualificationApp: Record Qualification;
        MaxEmploymentRecords: Integer;
        MaxEducationRecords: Integer;
        MaxProfessionalRecords: Integer;
        MaxProfessionalBodiesRecords: Integer;
        MaxCourseRecords: Integer;
        HRDatesExt: Codeunit "HR Dates Mgt";
        Dates: Codeunit "HR Dates Mgt";
        AGEFORMT: Date;
        Recruitment: record "Recruitment Needs";

    local procedure ProcessJobApplication(JobApp: Record "Job Application")
    var
        ApplicantSubmittedJob: Record "Applicant Submitted Job";
        ApplicantApp: Record Applicant;
    begin
        // Check if record already exists to prevent duplicates
        if ApplicantSubmittedJob.Get(JobApp."Recruitment Needs No.") then
            exit;

        // Initialize and populate the submitted job record
        InitializeSubmittedJobRecord(ApplicantSubmittedJob, JobApp);

        // Get applicant details and populate additional fields
        if ApplicantApp.Get(JobApp."Applicant No.") then
            PopulateApplicantDetails(ApplicantSubmittedJob, ApplicantApp);
        //if ApplicantApp.Get(JobApp."Recruitment Needs No.") then
        // ProcessClosedDate(ApplicantSubmittedJob, Recruitment);

        // Insert the record
        if ApplicantSubmittedJob.Insert() then begin
            // Process related data
            ProcessEmploymentHistory(ApplicantSubmittedJob);
            ProcessEducationHistory(ApplicantSubmittedJob);
            ProcessProfessionalQualifications(ApplicantSubmittedJob);
            UpdateApplicantSamplesFromSharePoint(ApplicantSubmittedJob);
            ProcessRelevantCourses(ApplicantSubmittedJob);
            ProcessProfessionalBodies(ApplicantSubmittedJob);
            // ProcessDateCalc(ApplicantSubmittedJob);

            //ProcessPostADmin(ApplicantSubmittedJob);

            Commit();
        end;


    end;

    local procedure InitializeSubmittedJobRecord(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; JobApp: Record "Job Application")
    var
        ApplicantName: text[1000];
    begin
        Clear(ApplicantSubmittedJob);
        ApplicantSubmittedJob.Init();
        ApplicantSubmittedJob."Job code" := JobApp."No.";
        ApplicantName := JobApp."Applicant Name";
        ApplicantSubmittedJob."Applicant Name" := FORMAT(UpperCase(COPYSTR(ApplicantName, 1, 1))) + LowerCase(COPYSTR(ApplicantName, 2));
        ApplicantSubmittedJob."Applicant No." := JobApp."Applicant No.";
        ApplicantSubmittedJob.Gender := JobApp.Gender;
        ApplicantSubmittedJob."Job Title" := JobApp."Job Title";
        ApplicantSubmittedJob."Job Applied Code" := JobApp."Job Applied Code";
        ApplicantSubmittedJob."Recruitment Needs NO" := JobApp."Recruitment Needs No.";
        ApplicantSubmittedJob."Date-Time Created" := JobApp."Date-Time Created";
        ApplicantSubmittedJob."Closed Date" := JobApp."Closed Date";
    end;

    local procedure PopulateApplicantDetails(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantApp: Record Applicant)
    var
        HomeCounty: text[1000];
        EthnicGroup: text[1000];
        SubEthnicGroup: text[1000];
        VarAge: Decimal;
        AgeYears: integer;
        AgeText: text;
    begin

        ApplicantSubmittedJob.Age := (HRDatesExt.DetermineDatesDiffrence(ApplicantApp."Birth Date", Today));
        AgeYears := StrPos(ApplicantSubmittedJob.Age, 'Y');
        if AgeYears > 1 then begin
            AgeText := CopyStr(ApplicantSubmittedJob.Age, 1, AgeYears - 1);
            ApplicantSubmittedJob.Age := DelChr(AgeText, '=', ',') + ' Y';
            Evaluate(ApplicantSubmittedJob.Age, AgeText)
        end else
            ApplicantSubmittedJob.Age := '0';

        ApplicantSubmittedJob."Birth Date" := ApplicantApp."Birth Date";
        ApplicantSubmittedJob."Nationality New" := ApplicantApp."Nationality New";
        ApplicantSubmittedJob.IDNO := ApplicantApp."National ID";
        HomeCounty := ApplicantApp."Home County";
        ApplicantSubmittedJob."Home County" := FORMAT(UpperCase(COPYSTR(HomeCounty, 1, 1))) + LowerCase(COPYSTR(HomeCounty, 2));
        EthnicGroup := LowerCase(ApplicantApp."Ethnic Group"); // Force all lowercase first
        ApplicantSubmittedJob."Ethnic Group" := FORMAT(UpperCase(COPYSTR(EthnicGroup, 1, 1))) + COPYSTR(EthnicGroup, 2);

        ApplicantSubmittedJob."Marital Status" := ApplicantApp."Marital Status";
        SubEthnicGroup := LowerCase(ApplicantApp."Sub Ethnic Group");
        ApplicantSubmittedJob."Sub Ethnic Group" := FORMAT(UpperCase(COPYSTR(SubEthnicGroup, 1, 1))) + LowerCase(COPYSTR(SubEthnicGroup, 2));
        // ApplicantSubmittedJob."Sub Ethnic Group" := ApplicantApp."Sub Ethnic Group";

        // Disability Information
        ApplicantSubmittedJob.Disability := ApplicantApp.Disability;
        if ApplicantApp.Disability then
            applicantSubmittedJob."Disability T" := 'Yes'

        else
            applicantSubmittedJob."Disability T" := 'No';
        ApplicantSubmittedJob."Disability Description" := ApplicantApp."Disability Description";
        ApplicantSubmittedJob."NCPWD Certificate No." := ApplicantApp."NCPWD Certificate No.";
        ApplicantSubmittedJob."Dismissal Declaration" := ApplicantApp."Dismissal Declaration";
        ApplicantSubmittedJob."Dismissal Decl. Specification" := ApplicantApp."Dismissal Decl. Specification";

        // Passport and Permit Information
        ApplicantSubmittedJob."Passport Expiry Date" := ApplicantApp."Passport Expiry Date";
        ApplicantSubmittedJob."Passport Issue Date" := ApplicantApp."Passport Issue Date";
        ApplicantSubmittedJob."Passport No." := ApplicantApp."Passport No.";
        ApplicantSubmittedJob."Permit No." := ApplicantApp."Permit No.";
        ApplicantSubmittedJob."Permit Issue Date" := ApplicantApp."Permit Issue Date";
        ApplicantSubmittedJob."Permit Validity Period" := ApplicantApp."Permit Validity Period";

        // Contact Information
        ApplicantSubmittedJob."Post Code" := ApplicantApp."Post Code";
        ApplicantSubmittedJob."Postal Address" := ApplicantApp."Postal Address new";
        ApplicantSubmittedJob."Physical Address" := ApplicantApp."Physical Address";
        ApplicantSubmittedJob.City := ApplicantApp.City;
        ApplicantSubmittedJob."Mobile Phone No." := ApplicantApp."Mobile Phone No.";
        ApplicantSubmittedJob."Alternative Phone No." := ApplicantApp."Alternative Phone No.";
        ApplicantSubmittedJob."E-Mail" := ApplicantApp."E-Mail";

        // Salary and Experience
        ApplicantSubmittedJob."Current Salary" := ApplicantApp."Current Salary";
        ApplicantSubmittedJob."Expected Salary" := ApplicantApp."Expected Salary";
        ApplicantSubmittedJob."Submitted Date" := ApplicantApp."Submitted Date";
        ApplicantSubmittedJob."Submitted Time" := ApplicantApp."Submitted Time";
        // ApplicantSubmittedJob."Years Of Experience" := ApplicantApp."Years of Experience";

        // Languages
        PopulateLanguageInformation(ApplicantSubmittedJob, ApplicantApp);
    end;

    local procedure PopulateLanguageInformation(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantApp: Record Applicant)
    begin
        // First Language
        ApplicantSubmittedJob."First Language (R/W/S)" := ApplicantApp."First Language (R/W/S)";
        ApplicantSubmittedJob."First Language Read" := ApplicantApp."First Language Read";
        ApplicantSubmittedJob."First Language Write" := ApplicantApp."First Language Write";
        ApplicantSubmittedJob."First Language Speak" := ApplicantApp."First Language Speak";

        // Second Language
        ApplicantSubmittedJob."Second Language (R/W/S)" := ApplicantApp."Second Language (R/W/S)";
        ApplicantSubmittedJob."Second Language Read" := ApplicantApp."Second Language Read";
        ApplicantSubmittedJob."Second Language Write" := ApplicantApp."Second Language Write";
        ApplicantSubmittedJob."Second Language Speak" := ApplicantApp."Second Language Speak";

        // Other Language
        ApplicantSubmittedJob."Other Language (R/W/S)" := ApplicantApp."Other Language (R/W/S)";
        ApplicantSubmittedJob."Other Language Read" := ApplicantApp."Other Language Read";
        ApplicantSubmittedJob."Other Language Write" := ApplicantApp."Other Language Write";
        ApplicantSubmittedJob."Other Language Speak" := ApplicantApp."Other Language Speak";
    end;

    local procedure ProcessEmploymentHistory(var ApplicantSubmittedJob: Record "Applicant Submitted Job")
    var
        ApplicantEmpl: Record "Applicant Current Employment";
        RecordCount: Integer;
    begin
        ApplicantEmpl.Reset();
        ApplicantEmpl.SetRange("Applicant No.", ApplicantSubmittedJob."Applicant No.");
        ApplicantEmpl.SetCurrentKey(ApplicantEmpl."To Date");
        ApplicantEmpl.SetAscending("To Date", false);
        if ApplicantEmpl.FindSet() then begin
            repeat
                RecordCount += 1;
                SetEmploymentRecord(ApplicantSubmittedJob, ApplicantEmpl, RecordCount);
            until (ApplicantEmpl.Next() = 0) or (RecordCount >= 10);

            if RecordCount > 0 then
                ApplicantSubmittedJob.Modify();
        end;
    end;

    local procedure SetEmploymentRecord(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment"; RecordNumber: Integer)
    begin
        case RecordNumber of
            1:
                SetEmployerFields(ApplicantSubmittedJob, ApplicantEmpl);
            2:
                SetEmployer2Fields(ApplicantSubmittedJob, ApplicantEmpl);
            3:
                SetEmployer3Fields(ApplicantSubmittedJob, ApplicantEmpl);
            4:
                SetEmployer4Fields(ApplicantSubmittedJob, ApplicantEmpl);
            5:
                SetEmployer5Fields(ApplicantSubmittedJob, ApplicantEmpl);
            6:
                SetEmployer6Fields(ApplicantSubmittedJob, ApplicantEmpl);
            7:
                SetEmployer7Fields(ApplicantSubmittedJob, ApplicantEmpl);
            8:
                SetEmployer8Fields(ApplicantSubmittedJob, ApplicantEmpl);
            9:
                SetEmployer9Fields(ApplicantSubmittedJob, ApplicantEmpl);
            10:
                SetEmployer10Fields(ApplicantSubmittedJob, ApplicantEmpl);
        end;
    end;

    local procedure SetEmployerFields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    var
        EmploymentDate: Date;
        YearPos: integer;
        YearText: text;
        Years: text;
    begin

        ApplicantSubmittedJob."From Date Employer" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Substantive Post" := ApplicantEmpl."Substantive Post";

        ApplicantSubmittedJob.Employer := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."Employment Period" := ApplicantEmpl."Employment Period";

        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement" := ApplicantEmpl.Sector;
        YearPos := StrPos(ApplicantEmpl."Employment Period", 'Y');
        if YearPos > 1 then begin
            YearPos := StrPos(ApplicantEmpl."Employment Period", 'Y');
            YearText := CopyStr(ApplicantEmpl."Employment Period", 1, YearPos - 1);
            Years := DelChr(YearText, '=', ',') + 'Y';
            Evaluate(ApplicantSubmittedJob."Employment Period Year", YearText);// Extract the year from the employment period text
        end else
            ApplicantSubmittedJob."Employment Period Year" := 0;
        ApplicantSubmittedJob."Years Of Experience" := ApplicantSubmittedJob."Years Of Experience" + ApplicantSubmittedJob."Employment Period Year";
        // ApplicantSubmittedJob."Employment Period" := ApplicantEmpl."Employment Period";
        // ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
    END;

    local procedure SetEmployer2Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    var
        EmploymentDate: Date;
        YearPos2: integer;
        YearText2: text;
        Years2: text;
    begin
        ApplicantSubmittedJob."Employer 2" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 2" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 2" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 2" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 2" := ApplicantEmpl."Substantive Post";

        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 2" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 2" := ApplicantEmpl.Sector;
        ApplicantSubmittedJob."Employment Period 2" := ApplicantEmpl."Employment Period";
        // ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        //**************************
        YearPos2 := StrPos(ApplicantEmpl."Employment Period", 'Y');
        if YearPos2 > 1 then begin
            YearPos2 := StrPos(ApplicantEmpl."Employment Period", 'Y');
            YearText2 := CopyStr(ApplicantEmpl."Employment Period", 1, YearPos2 - 1);
            Years2 := DelChr(YearText2, '=', ',') + 'Y';
            Evaluate(ApplicantSubmittedJob."Employment Period Year 2", YearText2)
        end else
            ApplicantSubmittedJob."Employment Period Year 2" := 0;
        //*******************************
        ApplicantSubmittedJob."Years Of Experience" := ApplicantSubmittedJob."Years Of Experience" + ApplicantSubmittedJob."Employment Period Year 2";

    end;

    local procedure SetEmployer3Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    var
        EmploymentDate: Date;
        YearValue: Integer;
        YearPos3: integer;
        YearText3: text;
        Years3: text;
    begin
        ApplicantSubmittedJob."Employer 3" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 3" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 3" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 3" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 3" := ApplicantEmpl."Substantive Post";


        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 3" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 3" := ApplicantEmpl.Sector;
        //************************************
        // Convert text to date first, then extract year
        YearPos3 := StrPos(ApplicantEmpl."Employment Period", 'Y');
        if YearPos3 > 1 then begin
            ApplicantSubmittedJob."Employment Period 3" := ApplicantEmpl."Employment Period";
            YearPos3 := StrPos(ApplicantEmpl."Employment Period", 'Y');
            YearText3 := CopyStr(ApplicantEmpl."Employment Period", 1, YearPos3 - 1);
            Years3 := DelChr(YearText3, '=', ',') + 'Y';
            Evaluate(ApplicantSubmittedJob."Employment Period Year 3", YearText3);
        end else
            ApplicantSubmittedJob."Employment Period year 3" := 0;
        ApplicantSubmittedJob."Years Of Experience" := ApplicantSubmittedJob."Years Of Experience" + ApplicantSubmittedJob."Employment Period Year 3";
        // ApplicantSubmittedJob."Employment Period 3" := ApplicantEmpl."Employment Period";
        // ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
    end;

    local procedure SetEmployer4Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    var
        EmploymentDate: Date;
        YearPos4: integer;
        YearText4: text;
        Years4: text;
    begin
        ApplicantSubmittedJob."Employer 4" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 4" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 4" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 4" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 4" := ApplicantEmpl."Substantive Post";

        ApplicantSubmittedJob."Employment Period 4" := ApplicantEmpl."Employment Period";
        // ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 4" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 4" := ApplicantEmpl.Sector;
        //*****88888
        YearPos4 := StrPos(ApplicantEmpl."Employment Period", 'Y');
        if YearPos4 > 1 then begin
            YearPos4 := StrPos(ApplicantEmpl."Employment Period", 'Y');
            YearText4 := CopyStr(ApplicantEmpl."Employment Period", 1, YearPos4 - 1);
            Years4 := DelChr(YearText4, '=', ',') + 'Y';
            Evaluate(ApplicantSubmittedJob."Employment Period Year 4", YearText4);
        end else
            ApplicantSubmittedJob."Employment Period year 4" := 0;
        ApplicantSubmittedJob."Years Of Experience" := ApplicantSubmittedJob."Years Of Experience" + ApplicantSubmittedJob."Employment Period Year 4";
    end;

    local procedure SetEmployer5Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    var
        EmploymentDate: Date;
        YearPos5: integer;
        YearText5: text;
        Years5: text;
    begin
        ApplicantSubmittedJob."Employer 5" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 5" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 5" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 5" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 5" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 5" := ApplicantEmpl."Employment Period";
        // ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";

        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 5" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 5" := ApplicantEmpl.Sector;
        //*****88888
        YearPos5 := StrPos(ApplicantEmpl."Employment Period", 'Y');
        if YearPos5 > 1 then begin
            YearPos5 := StrPos(ApplicantEmpl."Employment Period", 'Y');
            YearText5 := CopyStr(ApplicantEmpl."Employment Period", 1, YearPos5 - 1);
            Years5 := DelChr(YearText5, '=', ',') + 'Y';
            Evaluate(ApplicantSubmittedJob."Employment Period Year 5", YearText5);
        end else
            ApplicantSubmittedJob."Employment Period year 5" := 0;
        ApplicantSubmittedJob."Years Of Experience" := ApplicantSubmittedJob."Years Of Experience" + ApplicantSubmittedJob."Employment Period Year 5";


    end;

    local procedure SetEmployer6Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    var
        EmploymentDate: Date;
        YearPos6: integer;
        YearText6: text;
        Years6: text;
    begin
        ApplicantSubmittedJob."Employer 6" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 6" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 6" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 6" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 6" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 6" := ApplicantEmpl."Employment Period";
        // ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 6" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 6" := ApplicantEmpl.Sector;
        //*****88888
        YearPos6 := StrPos(ApplicantEmpl."Employment Period", 'Y');
        if YearPos6 > 1 then begin
            YearPos6 := StrPos(ApplicantEmpl."Employment Period", 'Y');
            YearText6 := CopyStr(ApplicantEmpl."Employment Period", 1, YearPos6 - 1);
            Years6 := DelChr(YearText6, '=', ',') + 'Y';
            Evaluate(ApplicantSubmittedJob."Employment Period Year 6", YearText6)
        end else
            ApplicantSubmittedJob."Employment Period year 6" := 0;
        ApplicantSubmittedJob."Years Of Experience" := ApplicantSubmittedJob."Years Of Experience" + ApplicantSubmittedJob."Employment Period Year 6";


    end;

    local procedure SetEmployer7Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    var
        EmploymentDate: Date;
        YearPos7: integer;
        YearText7: text;
        Years7: text;
    begin
        ApplicantSubmittedJob."Employer 7" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 7" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 7" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 7" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 7" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 7" := ApplicantEmpl."Employment Period";
        // ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 7" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 7" := ApplicantEmpl.Sector;
        //*****88888
        YearPos7 := StrPos(ApplicantEmpl."Employment Period", 'Y');
        if YearPos7 > 1 then begin
            YearPos7 := StrPos(ApplicantEmpl."Employment Period", 'Y');
            YearText7 := CopyStr(ApplicantEmpl."Employment Period", 1, YearPos7 - 1);
            Years7 := DelChr(YearText7, '=', ',') + 'Y';
            Evaluate(ApplicantSubmittedJob."Employment Period Year 7", YearText7)
        end else
            ApplicantSubmittedJob."Employment Period Year 7" := 0;

        ApplicantSubmittedJob."Years Of Experience" := ApplicantSubmittedJob."Years Of Experience" + ApplicantSubmittedJob."Employment Period Year 7";




    end;

    local procedure SetEmployer8Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    var
        EmploymentDate: Date;
        YearPos8: integer;
        YearText8: text;
        Years8: text;
    begin
        ApplicantSubmittedJob."Employer 8" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 8" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 8" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 8" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 8" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 8" := ApplicantEmpl."Employment Period";
        // ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 8" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 8" := ApplicantEmpl.Sector;
        //*****88888
        YearPos8 := StrPos(ApplicantEmpl."Employment Period", 'Y');
        if YearPos8 > 1 then begin
            YearPos8 := StrPos(ApplicantEmpl."Employment Period", 'Y');
            YearText8 := CopyStr(ApplicantEmpl."Employment Period", 1, YearPos8 - 1);
            Years8 := DelChr(YearText8, '=', ',') + 'Y';
            Evaluate(ApplicantSubmittedJob."Employment Period Year 8", YearText8);
        end else
            ApplicantSubmittedJob."Employment Period Year 8" := 0;
        ApplicantSubmittedJob."Years Of Experience" := ApplicantSubmittedJob."Years Of Experience" + ApplicantSubmittedJob."Employment Period Year 8";

    end;

    local procedure SetEmployer9Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    var
        EmploymentDate: Date;
        YearPos9: integer;
        YearText9: text;
        Years9: text;
    begin
        ApplicantSubmittedJob."Employer 9" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 9" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 9" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 9" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 9" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 9" := ApplicantEmpl."Employment Period";
        // ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 9" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 9" := ApplicantEmpl.Sector;
        //*****88888
        YearPos9 := StrPos(ApplicantEmpl."Employment Period", 'Y');
        if YearPos9 > 1 then begin
            YearPos9 := StrPos(ApplicantEmpl."Employment Period", 'Y');
            YearText9 := CopyStr(ApplicantEmpl."Employment Period", 1, YearPos9 - 1);
            Years9 := DelChr(YearText9, '=', ',') + 'Y';
            Evaluate(ApplicantSubmittedJob."Employment Period Year 9", YearText9);
        end else
            ApplicantSubmittedJob."Employment Period Year 9" := 0;
        ApplicantSubmittedJob."Years Of Experience" := ApplicantSubmittedJob."Years Of Experience" + ApplicantSubmittedJob."Employment Period Year 9";

    end;

    local procedure SetEmployer10Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    var
        EmploymentDate: Date;
        YearPos10: integer;
        YearText10: text;
        Years10: text;
    begin
        ApplicantSubmittedJob."Employer 10" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 10" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 10" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 10" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 10" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 10" := ApplicantEmpl."Employment Period";
        // ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 10" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 10" := ApplicantEmpl.Sector;
        //*****88888
        YearPos10 := StrPos(ApplicantEmpl."Employment Period", 'Y');
        if YearPos10 > 1 then begin
            YearPos10 := StrPos(ApplicantEmpl."Employment Period", 'Y');
            YearText10 := CopyStr(ApplicantEmpl."Employment Period", 1, YearPos10 - 1);
            Years10 := DelChr(YearText10, '=', ',') + 'Y';
            Evaluate(ApplicantSubmittedJob."Employment Period Year  10", YearText10);
        end else
            ApplicantSubmittedJob."Employment Period Year  10" := 0;
        ApplicantSubmittedJob."Years Of Experience" := ApplicantSubmittedJob."Years Of Experience" + ApplicantSubmittedJob."Employment Period Year  10";


    end;

    local procedure ProcessEducationHistory(var ApplicantSubmittedJob: Record "Applicant Submitted Job")
    var
        ApplicantsQual: Record "Applicants Qualification";
        HasAnyEducationRecord: Boolean;
    begin
        ApplicantsQual.Reset();
        ApplicantsQual.SetRange("Employee No.", ApplicantSubmittedJob."Applicant No.");
        ApplicantsQual.SetRange("Qualification Type", ApplicantsQual."Qualification Type"::Academic);
        if ApplicantsQual.FindSet() then begin
            repeat

                // Handle KACE or KCE qualifications
                if (ApplicantsQual."Qualification Code" = 'KACE') then begin
                    ApplicantSubmittedJob.Description := ApplicantsQual.Description;
                    ApplicantSubmittedJob."Area of Specialization" := ApplicantsQual."Area of Specialization";
                    ApplicantSubmittedJob."Institution/Company" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."From Date" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."To Date" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Grade/Class" := ApplicantsQual."Grade/Class";
                end;
                //KCE qualifications
                if (ApplicantsQual."Qualification Code" = 'KCE') then begin
                    ApplicantSubmittedJob."Description 11" := ApplicantsQual.Description;
                    ApplicantSubmittedJob."Area of Specialization 11" := ApplicantsQual."Area of Specialization";
                    applicantSubmittedJob."Institution/Company 11" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."From Date 11" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."To Date 11" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Grade/Class 11" := ApplicantsQual."Grade/Class";

                end;

                // Handle KCSE qualifications
                if (ApplicantsQual."Qualification Code" = 'KCSE') then begin
                    ApplicantSubmittedJob."Description 1" := ApplicantsQual.Description;
                    ApplicantSubmittedJob."Area of Specialization 1" := ApplicantsQual."Area of Specialization";
                    ApplicantSubmittedJob."Institution/Company 1" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."From Date 1" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."To Date 1" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Grade/Class 1" := ApplicantsQual."Grade/Class";
                end;

                // Handle qualifications in 30000-39999 range (corrected logic)
                if (ApplicantsQual."Qualification Code" >= '30000') and (ApplicantsQual."Qualification Code" <= '39999') then begin
                    ApplicantSubmittedJob."Description 6" := ApplicantsQual.Description;
                    ApplicantSubmittedJob."Area of Specialization 6" := ApplicantsQual."Area of Specialization";
                    ApplicantSubmittedJob."Qualification Code 6" := ApplicantsQual."Qualification Code";
                    ApplicantSubmittedJob."Institution/Company 6" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."From Date 6" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."To Date 6" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Grade/Class 6" := ApplicantsQual."Grade/Class";
                end;
                if (ApplicantsQual."Qualification Code" >= '70000') and (ApplicantsQual."Qualification Code" <= '79999') then begin
                    ApplicantSubmittedJob."Description 3" := ApplicantsQual.Description;
                    ApplicantSubmittedJob."Area of Specialization 3" := ApplicantsQual."Area of Specialization";
                    ApplicantSubmittedJob."Institution/Company 3" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."From Date 3" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."To Date 3" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Grade/Class 3" := ApplicantsQual."Grade/Class";
                end;
                if (ApplicantsQual."Qualification Code" >= '50000') and (ApplicantsQual."Qualification Code" <= '59999') then begin
                    ApplicantSubmittedJob."Institution/Company 4" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."From Date 4" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."To Date 4" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Grade/Class 4" := ApplicantsQual."Grade/Class";
                    ApplicantSubmittedJob."Area of Specialization 4" := ApplicantsQual."Area of Specialization";
                    ApplicantSubmittedJob."Description 4" := ApplicantsQual.Description;
                end;
                if (ApplicantsQual."Qualification Code" >= '40000') and (ApplicantsQual."Qualification Code" <= '49999') then begin
                    applicantSubmittedJob."Area of Specialization 5" := ApplicantsQual."Area of Specialization";
                    ApplicantSubmittedJob."Institution/Company 5" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."From Date 5" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."To Date 5" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Grade/Class 5" := ApplicantsQual."Grade/Class";
                    ApplicantSubmittedJob."Description 5" := ApplicantsQual.Description;
                end;
                if (ApplicantsQual."Qualification Code" >= '60000') and (ApplicantsQual."Qualification Code" <= '60009') then begin
                    applicantSubmittedJob."Area of Specialization 2" := ApplicantsQual.Description;
                    ApplicantSubmittedJob."Institution/Company 2" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."From Date 2" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."To Date 2" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Grade/Class 2" := ApplicantsQual."Grade/Class";
                end;
                if (ApplicantsQual."Qualification Code" >= '20000') and (ApplicantsQual."Qualification Code" <= '29999') then begin
                    applicantSubmittedJob."Area of Specialization 8" := ApplicantsQual."Area of Specialization";
                    ApplicantSubmittedJob."Institution/Company 8" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."From Date 8" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."To Date 8" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Grade/Class 8" := ApplicantsQual."Grade/Class";
                    ApplicantSubmittedJob."Description 8" := ApplicantsQual.Description;
                end;
                if (ApplicantsQual."Qualification Code" >= '10000') and (ApplicantsQual."Qualification Code" <= '19999') then begin
                    applicantSubmittedJob."Area of Specialization 9" := ApplicantsQual."Area of Specialization";
                    ApplicantSubmittedJob."Institution/Company 9" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."From Date 9" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."To Date 9" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Grade/Class 9" := ApplicantsQual."Grade/Class";
                    ApplicantSubmittedJob."Description 9" := ApplicantsQual.Description;
                end;
                if (ApplicantsQual."Qualification Code" >= '80000') and (ApplicantsQual."Qualification Code" <= '89999') then begin
                    applicantSubmittedJob."Area of Specialization 10" := ApplicantsQual."Area of Specialization";
                    ApplicantSubmittedJob."Institution/Company 10" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."From Date 10" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."To Date 10" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Grade/Class 10" := ApplicantsQual."Grade/Class";
                    ApplicantSubmittedJob."Description 10" := ApplicantsQual.Description;
                end;

            until ApplicantsQual.Next() = 0;
            ApplicantSubmittedJob.Modify();
        end;
    end;



    local procedure ProcessProfessionalQualifications(var ApplicantSubmittedJob: Record "Applicant Submitted Job")
    var
        ApplicantsQual: Record "Applicants Qualification";
        QualificationApp: Record Qualification;
        RecordCount: Integer;
    begin
        ApplicantsQual.Reset();
        ApplicantsQual.SetRange("Employee No.", ApplicantSubmittedJob."Applicant No.");
        ApplicantsQual.SetRange("Qualification Type", ApplicantsQual."Qualification Type"::Professional);

        if ApplicantsQual.FindSet() then begin
            repeat
                RecordCount += 1;
                SetProfessionalQualificationFields(ApplicantSubmittedJob, ApplicantsQual, QualificationApp, RecordCount);
            until (ApplicantsQual.Next() = 0) or (RecordCount >= 3);

            if RecordCount > 0 then
                ApplicantSubmittedJob.Modify();
        end;
    end;

    local procedure SetProfessionalQualificationFields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantsQual: Record "Applicants Qualification"; var QualificationApp: Record Qualification; RecordNumber: Integer)
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
                    applicantSubmittedJob."Professional To Date" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Area of Specialization PROF" := ApplicantsQual."Area of Specialization";
                    // ApplicantSubmittedJob."Duration course" := ApplicantsQual.Duration;
                end;
            2:
                begin
                    ApplicantSubmittedJob."Professional Qualification 2" := ApplicantsQual."Qualification Code";
                    if QualificationApp.Get(ApplicantSubmittedJob."Professional Qualification 2") then
                        ApplicantSubmittedJob."Professional Name 2" := QualificationApp.Description;
                    ApplicantSubmittedJob."Professional Institution 2" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."Professional From Date 2" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."Professional Date of Admn 2" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Professional To Date 2" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Area of Specialization PROF 2" := ApplicantsQual."Area of Specialization";
                    // ApplicantSubmittedJob."Duration course 2" := ApplicantsQual.Duration;
                end;
            3:
                begin
                    ApplicantSubmittedJob."Professional Qualification 3" := ApplicantsQual."Qualification Code";
                    if QualificationApp.Get(ApplicantSubmittedJob."Professional Qualification 3") then
                        ApplicantSubmittedJob."Professional Name 3" := QualificationApp.Description;
                    ApplicantSubmittedJob."Professional Institution 3" := ApplicantsQual."Institution/Company";
                    ApplicantSubmittedJob."Professional From Date 3" := ApplicantsQual."From Date";
                    ApplicantSubmittedJob."Professional Date of Admn 3" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Professional To Date 3" := ApplicantsQual."To Date";
                    ApplicantSubmittedJob."Area of Specialization PROF 3" := ApplicantsQual."Area of Specialization";
                    // ApplicantSubmittedJob."Duration course 3" := ApplicantsQual.Duration;

                end;
        end;
    end;

    local procedure UpdateApplicantSamplesFromSharePoint(var ApplicantSubmittedJob: Record "Applicant Submitted Job")
    var
        SharePointIntegration: Record "SharePoint Intergration";
        SampleUpdated: Boolean;
    begin
        SharePointIntegration.Reset();
        SharePointIntegration.SetRange(SharePointIntegration."Document No", ApplicantSubmittedJob."Applicant No.");

        if not SharePointIntegration.FindSet() then
            exit;

        SampleUpdated := false;

        repeat
            case true of
                SharePointIntegration.Description.StartsWith('SAMPLE1'):
                    begin
                        ApplicantSubmittedJob.SAMPLE1 := SharePointIntegration.Description;
                        SampleUpdated := true;
                    end;
                SharePointIntegration.Description.StartsWith('SAMPLE2'):
                    begin
                        ApplicantSubmittedJob.SAMPLE2 := SharePointIntegration.Description;
                        SampleUpdated := true;
                    end;
                SharePointIntegration.Description.StartsWith('SAMPLE3'):
                    begin
                        ApplicantSubmittedJob.SAMPLE3 := SharePointIntegration.Description;
                        SampleUpdated := true;
                    end;
                SharePointIntegration.Description.StartsWith('SAMPLE4'):
                    begin
                        ApplicantSubmittedJob.SAMPLE4 := SharePointIntegration.Description;
                        SampleUpdated := true;
                    end;
                SharePointIntegration.Description.StartsWith('SAMPLE5'):
                    begin
                        ApplicantSubmittedJob.SAMPLE5 := SharePointIntegration.Description;
                        SampleUpdated := true;
                    end;
            end;
        until SharePointIntegration.Next() = 0;

        // Only modify once after all updates
        if SampleUpdated then
            ApplicantSubmittedJob.Modify();
    end;

    local procedure ProcessProfessionalBodies(var ApplicantSubmittedJob: Record "Applicant Submitted Job")
    var
        ProfessionalBodiesRecordCount: Integer;
    begin

        ApplicantProfessionalBodies.Reset();
        ApplicantProfessionalBodies.SetRange("Applicant No.", applicantSubmittedJob."Applicant No.");
        // newest first)
        if ApplicantProfessionalBodies.FindSet() then begin
            ProfessionalBodiesRecordCount := 0;

            repeat
                // Handle LSK specifically first
                if ApplicantProfessionalBodies.Code = 'LSK' then begin
                    ApplicantSubmittedJob."Professional Bodies" := ApplicantProfessionalBodies.Name;
                    ApplicantSubmittedJob."Professional Code" := ApplicantProfessionalBodies.Code;
                    ApplicantSubmittedJob."Admission Date" := ApplicantProfessionalBodies."Date of Admission";
                    ApplicantSubmittedJob."Membership No." := ApplicantProfessionalBodies."Membership/Registration No.";
                    ApplicantSubmittedJob."Professional Membership Type" := ApplicantProfessionalBodies."Membership Type";
                    ApplicantSubmittedJob."Post Admission Period" := HRDatesExt.DetermineDatesDiffrence(ApplicantProfessionalBodies."Date of Admission", ApplicantSubmittedJob."Closed Date");
                end else if ApplicantProfessionalBodies.Code <> 'LSK' then begin
                    // Handle non-LSK professional bodies
                    ProfessionalBodiesRecordCount += 1;

                    case ProfessionalBodiesRecordCount of
                        1:
                            begin
                                ApplicantSubmittedJob."Professional Bodies 2" := ApplicantProfessionalBodies.Name;
                                ApplicantSubmittedJob."Professional Code 2" := ApplicantProfessionalBodies.Code; // Fixed field name
                                ApplicantSubmittedJob."Admission Date 2" := ApplicantProfessionalBodies."Date of Admission";
                                ApplicantSubmittedJob."Membership No. 2" := ApplicantProfessionalBodies."Membership/Registration No.";
                                ApplicantSubmittedJob."Professional Membership Type 2" := ApplicantProfessionalBodies."Membership Type"; // Fixed assignment
                            end;
                        2:
                            begin
                                ApplicantSubmittedJob."Professional Bodies 3" := ApplicantProfessionalBodies.Name;
                                ApplicantSubmittedJob."Professional Code 3" := ApplicantProfessionalBodies.Code;
                                ApplicantSubmittedJob."Admission Date 3" := ApplicantProfessionalBodies."Date of Admission";
                                ApplicantSubmittedJob."Membership No. 3" := ApplicantProfessionalBodies."Membership/Registration No.";
                                ApplicantSubmittedJob."Professional Membership Type 3" := ApplicantProfessionalBodies."Membership Type";
                            end;
                    end;

                    // Break after processing 2 non-LSK records
                    if ProfessionalBodiesRecordCount = 2 then
                        break;
                end;

            until ApplicantProfessionalBodies.Next() = 0;

            // Modify the record once after all updates
            ApplicantSubmittedJob.Modify();
        end;

    end;


    local procedure ProcessRelevantCourses(var ApplicantSubmittedJob: Record "Applicant Submitted Job")
    var
        CourseRecordCount: Integer;
    begin

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
                            ApplicantSubmittedJob."Duration course" := Dates.DetermineDatesDiffrence(RelevantCourse."From Date", RelevantCourse."To Date");
                        end;
                    2:
                        begin
                            ApplicantSubmittedJob."Name Course 2" := RelevantCourse."Source No";
                            ApplicantSubmittedJob."Name of the Course 2" := RelevantCourse."Name of the Course";
                            ApplicantSubmittedJob."Course Int 2" := RelevantCourse."University/College/Institution";
                            ApplicantSubmittedJob."From Date course 2" := RelevantCourse."From Date";
                            ApplicantSubmittedJob."To Date course 2" := RelevantCourse."To Date";
                            ApplicantSubmittedJob."Duration course 2" := Dates.DetermineDatesDiffrence(RelevantCourse."From Date", RelevantCourse."To Date");
                        end;
                    3:
                        begin
                            ApplicantSubmittedJob."Name Course 3" := RelevantCourse."Source No";
                            ApplicantSubmittedJob."Name of the Course 3" := RelevantCourse."Name of the Course";
                            ApplicantSubmittedJob."Course Int 3" := RelevantCourse."University/College/Institution";
                            ApplicantSubmittedJob."From Date course 3" := RelevantCourse."From Date";
                            ApplicantSubmittedJob."To Date course 3" := RelevantCourse."To Date";
                            applicantSubmittedJob."Duration course 3" := Dates.DetermineDatesDiffrence(RelevantCourse."From Date", RelevantCourse."To Date");

                        end;

                end;
                if courseRecordCount = 3 then
                    break;
            until RelevantCourse.Next() = 0;
            if courseRecordCount > 0 then
                ApplicantSubmittedJob.Modify();
        end;
    end;

    local procedure ProcessDateCalc(var ApplicantSubmittedJob: Record "Applicant Submitted Job")
    var
        FromDate: Date;
        dateDecemal: Decimal;
        ApplicantEmpl: Record "Applicant Current Employment";
    begin
        FromDate := 0D;


        ApplicantEmpl.Reset();
        ApplicantEmpl.SetRange("Applicant No.", ApplicantSubmittedJob."Applicant No.");
        ApplicantEmpl.SetCurrentKey(ApplicantEmpl."To Date");
        ApplicantEmpl.SetAscending("To Date", false);
        if ApplicantEmpl.FindLast() then begin
            repeat
                dateDecemal += Round(((ApplicantEmpl."To Date" - ApplicantEmpl."From Date") / 365), 0.01, '=');
            until (ApplicantEmpl.Next() = 0)

         ;
        end;
        ApplicantSubmittedJob."Years Of Experience 1" := Format(dateDecemal);
        ApplicantSubmittedJob.Modify();

    end;

    // local procedure ProcessClosedDate(var JobApplication: Record "Job Application"; Recruitment: record "Recruitment Needs")
    // var
    // ApplicantSubmittedJob: record "Applicant Submitted Job";
    // begin
    //     Recruitment.Reset();
    //     Recruitment.SetRange(Recruitment."No.", JobApplication."Recruitment Needs No.");
    //     if Recruitment.Find() then begin
    //         if ApplicantSubmittedJob.Get()
    //    // ApplicantSubmittedJob."Closed Date" := Recruitment."End Date";
    //    // ApplicantSubmittedJob.Modify();
    //     end;

    // end;

    // local procedure ProcessPostADmin(var ApplicantSubmittedJob: Record "Applicant Submitted Job")
    // var
    //     ApplicantsQual: Record "Applicant Professional Bodies";
    //     QualificationApp: Record Qualification;
    //     RecordCount: Integer;
    // begin
    //     ApplicantsQual.Reset();
    //     ApplicantsQual.SetRange("Applicant No.", ApplicantSubmittedJob."Applicant No.");
    //     ApplicantsQual.SetRange(Code, 'LSK');
    //     if ApplicantsQual.Find('-') then begin
    //         // repeat
    //         //  Message('date Admin is +', ApplicantsQual."Date of Admission");
    //         ApplicantSubmittedJob."Admission Date" := ApplicantsQual."Date of Admission";
    //         IF ApplicantsQual.Get(ApplicantSubmittedJob."Recruitment Needs NO") then
    //             ApplicantSubmittedJob."Post Admission Period" := HRDatesExt.DetermineDatesDiffrence(ApplicantsQual."Date of Admission", ApplicantSubmittedJob."Closed Date"); //Round(((ApplicantSubmittedJob."Closed Date" - ApplicantsQual."Date of Admission") / 365), 0.01, '=');
    //         ApplicantSubmittedJob.Modify();
    //         // until (ApplicantsQual.Next() = 0)


    //     end;
    // end;
}
