page 56200 "Applicant Submitted Job"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    editable = false;
    SourceTable = "Applicant Submitted Job";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Job code"; "Job code")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; "Applicant Name")
                {
                    ApplicationArea = All;
                }
                field(IDNO; IDNO)
                {
                    ApplicationArea = All;
                }
                // field()
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(update)

            {
                Promoted = true;
                Image = View;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = report "update Job Appl.";
                RunPageMode = View;
                Caption = 'UpDate Job Submitted.';

            }
            action(update1)

            {
                Promoted = true;
                Image = View;
                PromotedCategory = process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Caption = 'UpDate Job Submitted.';
                trigger OnAction()
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
                begin

                    if not Confirm('Update all applicant job records?') then
                        exit;
                    JobAppl.SetFilter("No.", '<>%1', '');
                    if JobAppl.FindSet() then begin
                        repeat
                            // Check if this application already exists in submitted jobs
                            if not ApplicantSubmittedJob.Get(JobAppl."No.") then begin
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
                                    //****************************************************************************************
                                    // if ApplicantEmpl.Get(JobAppl."Applicant No.") then begin
                                    //     ApplicantSubmittedJob.Employer := ApplicantEmpl."Applicant No.";
                                    //     ApplicantSubmittedJob."Sector Of Employement" := ApplicantEmpl.Sector;
                                    //     ApplicantSubmittedJob."Designation Employer" := ApplicantEmpl."Sector Specification";
                                    //     ApplicantSubmittedJob."From Date Employer" := ApplicantEmpl."From Date";
                                    //     ApplicantSubmittedJob."To Date Employer" := ApplicantEmpl."To Date";
                                    //     //Employment History 2
                                    //     ApplicantSubmittedJob."Employer 2" := ApplicantEmpl."Applicant No.";
                                    //     ApplicantSubmittedJob."From Date Employer 2" := ApplicantEmpl."From Date";
                                    //     ApplicantSubmittedJob."To Date Employer 2" := ApplicantEmpl."To Date";
                                    //     ApplicantSubmittedJob."Designation Employer 2" := ApplicantEmpl."Sector Specification";
                                    //     //Employment History 3
                                    //     ApplicantSubmittedJob."Employer 3" := ApplicantEmpl."Applicant No.";
                                    //     ApplicantSubmittedJob."From Date Employer 3" := ApplicantEmpl."From Date";
                                    //     ApplicantSubmittedJob."To Date Employer 3" := ApplicantEmpl."To Date";
                                    //     ApplicantSubmittedJob."Designation Employer 3" := ApplicantEmpl."Sector Specification";
                                    //     //Employment History 4
                                    //     ApplicantSubmittedJob."Employer 4" := ApplicantEmpl."Applicant No.";
                                    //     ApplicantSubmittedJob."From Date Employer 4" := ApplicantEmpl."From Date";
                                    //     ApplicantSubmittedJob."To Date Employer 4" := ApplicantEmpl."To Date";
                                    //     ApplicantSubmittedJob."Designation Employer 4" := ApplicantEmpl."Sector Specification";
                                    //     //end if;
                                    // end;

                                    // //****************************************************************************************
                                    // if ApplicantsQual.Get(JobAppl."Applicant No.") then begin
                                    //     ApplicantSubmittedJob."Qualification Code" := ApplicantsQual."Qualification Code";
                                    //     ApplicantSubmittedJob."Institution/Company" := ApplicantsQual."Institution/Company";
                                    //     ApplicantSubmittedJob."Grade/Class" := ApplicantsQual."Grade/Class";
                                    //     ApplicantSubmittedJob."To Date" := ApplicantsQual."To Date";
                                    //     ApplicantSubmittedJob."From Date" := ApplicantsQual."From Date";
                                    //     ApplicantSubmittedJob."Area of Specialization" := ApplicantsQual."Area of Specialization";
                                    //     //education History 2
                                    //     ApplicantSubmittedJob."Qualification Code 2" := ApplicantsQual."Qualification Code";
                                    //     ApplicantSubmittedJob."Institution/Company 2" := ApplicantsQual."Institution/Company";
                                    //     ApplicantSubmittedJob."Grade/Class 2" := ApplicantsQual."Grade/Class";
                                    //     ApplicantSubmittedJob."To Date 2" := ApplicantsQual."To Date";
                                    //     ApplicantSubmittedJob."From Date 2" := ApplicantsQual."From Date";
                                    //     ApplicantSubmittedJob."Area of Specialization 2" := ApplicantsQual."Area of Specialization";
                                    //     //education History 3
                                    //     ApplicantSubmittedJob."Qualification Code 3" := ApplicantsQual."Qualification Code";
                                    //     ApplicantSubmittedJob."Institution/Company 3" := ApplicantsQual."Institution/Company";
                                    //     ApplicantSubmittedJob."Grade/Class 3" := ApplicantsQual."Grade/Class";
                                    //     ApplicantSubmittedJob."To Date 3" := ApplicantsQual."To Date";
                                    //     ApplicantSubmittedJob."From Date 3" := ApplicantsQual."From Date";
                                    //     ApplicantSubmittedJob."Area of Specialization 3" := ApplicantsQual."Area of Specialization";
                                    //     //education History 4
                                    //     ApplicantSubmittedJob."Qualification Code 4" := ApplicantsQual."Qualification Code";
                                    //     ApplicantSubmittedJob."Institution/Company 4" := ApplicantsQual."Institution/Company";
                                    //     ApplicantSubmittedJob."Grade/Class 4" := ApplicantsQual."Grade/Class";
                                    //     ApplicantSubmittedJob."To Date 4" := ApplicantsQual."To Date";
                                    //     ApplicantSubmittedJob."From Date 4" := ApplicantsQual."From Date";
                                    //     ApplicantSubmittedJob."Area of Specialization 4" := ApplicantsQual."Area of Specialization";
                                    // end;
                                    // //*****************************************************************************************
                                    // if ApplicantProfessionalBodies.Get(JobAppl."Applicant No.") then begin
                                    //     ApplicantSubmittedJob."Professional Bodies" := ApplicantProfessionalBodies.Code;
                                    //     ApplicantSubmittedJob."Professional Name" := ApplicantProfessionalBodies.Name;
                                    //     ApplicantSubmittedJob."Professional Date of Admission" := ApplicantProfessionalBodies."Date of Admission";
                                    //     ApplicantSubmittedJob."Professional Membership Type" := ApplicantProfessionalBodies."Membership Type";
                                    //     ApplicantSubmittedJob."Professional Reg No." := ApplicantProfessionalBodies."Membership/Registration No.";
                                    //     //professional Bodies 2
                                    //     ApplicantSubmittedJob."Professional Bodies 2" := ApplicantProfessionalBodies.Code;
                                    //     ApplicantSubmittedJob."Professional Name 2" := ApplicantProfessionalBodies.Name;
                                    //     ApplicantSubmittedJob."Professional Date of Admn 2" := ApplicantProfessionalBodies."Date of Admission";
                                    //     ApplicantSubmittedJob."Professional Membership Type 2" := ApplicantProfessionalBodies."Membership Type";
                                    //     ApplicantSubmittedJob."Professional Reg No. 2" := ApplicantProfessionalBodies."Membership/Registration No.";
                                    //     //*****************************************************************************************
                                    // End;
                                    // if RelevantCourse.Get(JobAppl."Applicant No.") then begin

                                    //     ApplicantSubmittedJob."Name Course" := RelevantCourse."Source No";
                                    //     ApplicantSubmittedJob."Name of the Course" := RelevantCourse."Name of the Course";
                                    //     ApplicantSubmittedJob."Course Int" := RelevantCourse."University/College/Institution";
                                    //     ApplicantSubmittedJob."To Date course" := RelevantCourse."To Date";
                                    //     ApplicantSubmittedJob."From Date course" := RelevantCourse."From Date";
                                    //     ApplicantSubmittedJob."Duration course" := RelevantCourse.Duration;
                                    //     //relevant course 2
                                    //     ApplicantSubmittedJob."Name Course 2" := RelevantCourse."Source No";
                                    //     ApplicantSubmittedJob."Name of the Course 2" := RelevantCourse."Name of the Course";
                                    //     ApplicantSubmittedJob."Course Int 2" := RelevantCourse."University/College/Institution";
                                    //     ApplicantSubmittedJob."To Date course 2" := RelevantCourse."To Date";
                                    //     ApplicantSubmittedJob."From Date course 2" := RelevantCourse."From Date";
                                    //     ApplicantSubmittedJob."Duration course 2" := RelevantCourse.Duration;
                                    //     //relevant course 3
                                    //     ApplicantSubmittedJob."Name Course 3" := RelevantCourse."Source No";
                                    //     ApplicantSubmittedJob."Name of the Course 3" := RelevantCourse."Name of the Course";
                                    //     ApplicantSubmittedJob."Course Int 3" := RelevantCourse."University/College/Institution";
                                    //     ApplicantSubmittedJob."To Date course 3" := RelevantCourse."To Date";
                                    //     ApplicantSubmittedJob."From Date course 3" := RelevantCourse."From Date";
                                    //     ApplicantSubmittedJob."Duration course 3" := RelevantCourse.Duration;
                                    // Insert the new record
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
    }
}