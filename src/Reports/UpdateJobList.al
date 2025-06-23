report 53072 "update Job Appl."
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ApplSub;

    dataset
    {
        dataitem("Job Application"; "Job Application")
        {
            RequestFilterFields = "Recruitment Needs No.", "Job Title", "No.", "Applicant No.";
            column(No_; "No.")
            {

            }
            trigger OnAfterGetRecord()
            begin
                if not Confirm('Update all applicant job records?') then
                    exit;
                JobAppl.SetCurrentKey("Recruitment Needs No.", "Job Title", "No.");
                JobAppl.SetFilter("Recruitment Needs No.", '<>%1', '');
                if JobAppl.FindSet() then begin
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
                                ApplicantSubmittedJob.IDNO := ApplicantApp."Identification Document";
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
                            if ApplicantSubmittedJob.Insert() then
                                InsertCount += 1;
                        end;
                    until JobAppl.Next() = 0;

                    Commit();
                    Message('%1 applicant job records updated successfully.', ApplicantSubmittedJob.Count);
                end
                else begin
                    Message('No applicant job records found to update.');
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
}