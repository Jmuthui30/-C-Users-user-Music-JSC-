// report 53072 "update Job Appl."
// {
//     UsageCategory = ReportsAndAnalysis;
//     ApplicationArea = All;
//     DefaultRenderingLayout = ApplSub;

//     dataset
//     {
//         dataitem("Job Application"; "Job Application")
//         {
//             RequestFilterFields = "No.", "Recruitment Needs No.", "Job Title", "Applicant No.";
//             column(No_; "No.")
//             {

//             }
//             trigger OnAfterGetRecord()
//             begin




//                 JobAppl.Reset();
//                 InsertCount := 0;
//                 // Set filters for Job Application
//                 JobAppl.SetRange("No.", "Job Application"."No.");
//                 IF JobAppl.FindFirst THEN begin
//                     repeat
//                         // Check if this application already exists in submitted jobs
//                         if not ApplicantSubmittedJob.Get(JobAppl."Recruitment Needs No.") then begin
//                             // Initialize new record
//                             Clear(ApplicantSubmittedJob);
//                             ApplicantSubmittedJob.Init();
//                             ApplicantSubmittedJob."Job code" := JobAppl."No.";
//                             ApplicantSubmittedJob."Applicant Name" := JobAppl."Applicant Name";
//                             ApplicantSubmittedJob."Applicant No." := JobAppl."Applicant No.";
//                             ApplicantSubmittedJob.Gender := JobAppl.Gender;
//                             ApplicantSubmittedJob."Job Title" := JobAppl."Job Title";
//                             ApplicantSubmittedJob."Job Applied Code" := JobAppl."Job Applied Code";
//                             ApplicantSubmittedJob."Recruitment Needs NO" := JobAppl."Recruitment Needs No.";
//                             ApplicantSubmittedJob."Date-Time Created" := JobAppl."Date-Time Created";
//                             //****************************************************************************************
//                             if ApplicantApp.Get(JobAppl."Applicant No.") then begin
//                                 ApplicantSubmittedJob.Age := ApplicantApp.Age;
//                                 ApplicantSubmittedJob."Birth Date" := ApplicantApp."Birth Date";
//                                 ApplicantSubmittedJob."Nationality New" := ApplicantApp."Nationality New";
//                                 ApplicantSubmittedJob.IDNO := ApplicantApp."National ID";
//                                 ApplicantSubmittedJob."Home County" := ApplicantApp."Home County";
//                                 ApplicantSubmittedJob."Ethnic Group" := ApplicantApp."Ethnic Group";
//                                 ApplicantSubmittedJob."Marital Status" := ApplicantApp."Marital Status";
//                                 ApplicantSubmittedJob."Sub Ethnic Group" := ApplicantApp."Sub Ethnic Group";
//                                 ApplicantSubmittedJob.Disability := ApplicantApp.Disability;
//                                 ApplicantSubmittedJob."Disability Description" := ApplicantApp."Disability Description";
//                                 applicantSubmittedJob."NCPWD Certificate No." := ApplicantApp."NCPWD Certificate No.";
//                                 ApplicantSubmittedJob."Dismissal Declaration" := ApplicantApp."Dismissal Declaration";
//                                 ApplicantSubmittedJob."Dismissal Decl. Specification" := ApplicantApp."Dismissal Decl. Specification";
//                                 ApplicantSubmittedJob."Passport Expiry Date" := ApplicantApp."Passport Expiry Date";
//                                 ApplicantSubmittedJob."Passport Issue Date" := ApplicantApp."Passport Issue Date";
//                                 ApplicantSubmittedJob."Passport No." := ApplicantApp."Passport No.";
//                                 ApplicantSubmittedJob."Permit No." := ApplicantApp."Permit No.";
//                                 ApplicantSubmittedJob."Permit Issue Date" := ApplicantApp."Permit Issue Date";
//                                 ApplicantSubmittedJob."Permit Validity Period" := ApplicantApp."Permit Validity Period";
//                                 ApplicantSubmittedJob."Post Code" := ApplicantApp."Post Code";
//                                 ApplicantSubmittedJob."Postal Address" := ApplicantApp."Postal Address new";
//                                 ApplicantSubmittedJob."Physical Address" := ApplicantApp."Physical Address";
//                                 ApplicantSubmittedJob.City := ApplicantApp.City;
//                                 ApplicantSubmittedJob."Mobile Phone No." := ApplicantApp."Mobile Phone No.";
//                                 ApplicantSubmittedJob."Alternative Phone No." := ApplicantApp."Alternative Phone No.";
//                                 ApplicantSubmittedJob."E-Mail" := ApplicantApp."E-Mail";
//                                 ApplicantSubmittedJob."Current Salary" := ApplicantApp."Current Salary";
//                                 ApplicantSubmittedJob."Expected Salary" := ApplicantApp."Expected Salary";
//                                 ApplicantSubmittedJob."Years Of Experience" := ApplicantApp."Years of Experience";
//                                 ApplicantSubmittedJob."First Language (R/W/S)" := ApplicantApp."First Language (R/W/S)";
//                                 ApplicantSubmittedJob."Second Language (R/W/S)" := ApplicantApp."Second Language (R/W/S)";
//                                 ApplicantSubmittedJob."Other Language (R/W/S)" := ApplicantApp."Other Language (R/W/S)";
//                                 ApplicantSubmittedJob."First Language Read" := ApplicantApp."First Language Read";
//                                 ApplicantSubmittedJob."First Language Write" := ApplicantApp."First Language Write";
//                                 ApplicantSubmittedJob."First Language Speak" := ApplicantApp."First Language Speak";
//                                 ApplicantSubmittedJob."Second Language Read" := ApplicantApp."Second Language Read";
//                                 ApplicantSubmittedJob."Second Language Write" := ApplicantApp."Second Language Write";
//                                 ApplicantSubmittedJob."Second Language Speak" := ApplicantApp."Second Language Speak";
//                                 ApplicantSubmittedJob."Other Language Read" := ApplicantApp."Other Language Read";
//                                 ApplicantSubmittedJob."Other Language Write" := ApplicantApp."Other Language Write";
//                                 ApplicantSubmittedJob."Other Language Speak" := ApplicantApp."Other Language Speak";
//                             end;
//                             //****************************************************************************************



//                             if ApplicantSubmittedJob.Insert() then
//                                 InsertCount += 1;
//                         end;
//                     until JobAppl.Next() = 0;
//                 end;
//                 Commit();

//                 // //*********************************************************
//                 ApplicantEmpl.Reset();
//                 ApplicantEmpl.SetRange("Applicant No.", applicantSubmittedJob."Applicant No.");
//                 ApplicantEmpl.SetCurrentKey("From Date"); // Ensure records are sorted (e.g., newest first)
//                 if ApplicantEmpl.FindSet() then begin
//                     EmploymentRecordCount := 0; // Reset the count for each applicant
//                     repeat
//                         EmploymentRecordCount += 1; // Increment the count for each employment record
//                         case EmploymentRecordCount of
//                             1:
//                                 begin
//                                     if ApplicantEmpl."Currently Employment" = true then begin
//                                         applicantSubmittedJob."Current Employer" := true;
//                                         ApplicantSubmittedJob."Sector Of Employement" := ApplicantEmpl.Sector;
//                                         ApplicantSubmittedJob."From Date Employer" := ApplicantEmpl."From Date";
//                                         ApplicantSubmittedJob."To Date Employer" := ApplicantEmpl."To Date";
//                                         applicantSubmittedJob."Substantive Post" := ApplicantEmpl."Substantive Post";
//                                         applicantSubmittedJob."Employment Period" := ApplicantEmpl."Employment Period";
//                                         ApplicantSubmittedJob.Employer := ApplicantEmpl."Employer/Institution Name";
//                                     end;
//                                 end;
//                             2:
//                                 begin
//                                     ApplicantSubmittedJob."Employer 2" := ApplicantEmpl."Employer/Institution Name";
//                                     ApplicantSubmittedJob."From Date Employer 2" := ApplicantEmpl."From Date";
//                                     ApplicantSubmittedJob."To Date Employer 2" := ApplicantEmpl."To Date";
//                                     ApplicantSubmittedJob."Designation Employer 2" := ApplicantEmpl."Sector Specification";
//                                     applicantSubmittedJob."Substantive Post 2" := ApplicantEmpl."Substantive Post";
//                                     applicantSubmittedJob."Employment Period 2" := ApplicantEmpl."Employment Period";
//                                 end;
//                             3:
//                                 begin
//                                     ApplicantSubmittedJob."Employer 3" := ApplicantEmpl."Employer/Institution Name";
//                                     ApplicantSubmittedJob."From Date Employer 3" := ApplicantEmpl."From Date";
//                                     ApplicantSubmittedJob."To Date Employer 3" := ApplicantEmpl."To Date";
//                                     ApplicantSubmittedJob."Designation Employer 3" := ApplicantEmpl."Sector Specification";
//                                     applicantSubmittedJob."Substantive Post 3" := ApplicantEmpl."Substantive Post";
//                                     applicantSubmittedJob."Employment Period 3" := ApplicantEmpl."Employment Period";
//                                 end;
//                             4:
//                                 begin
//                                     ApplicantSubmittedJob."Employer 4" := ApplicantEmpl."Employer/Institution Name";
//                                     ApplicantSubmittedJob."From Date Employer 4" := ApplicantEmpl."From Date";
//                                     ApplicantSubmittedJob."To Date Employer 4" := ApplicantEmpl."To Date";
//                                     ApplicantSubmittedJob."Designation Employer 4" := ApplicantEmpl."Sector Specification";
//                                     applicantSubmittedJob."Substantive Post 4" := ApplicantEmpl."Substantive Post";
//                                     applicantSubmittedJob."Employment Period 4" := ApplicantEmpl."Employment Period";
//                                 end;
//                             5:
//                                 begin
//                                     ApplicantSubmittedJob."Employer 5" := ApplicantEmpl."Employer/Institution Name";
//                                     ApplicantSubmittedJob."From Date Employer 5" := ApplicantEmpl."From Date";
//                                     ApplicantSubmittedJob."To Date Employer 5" := ApplicantEmpl."To Date";
//                                     ApplicantSubmittedJob."Designation Employer 5" := ApplicantEmpl."Sector Specification";
//                                     applicantSubmittedJob."Substantive Post 5" := ApplicantEmpl."Substantive Post";
//                                     applicantSubmittedJob."Employment Period 5" := ApplicantEmpl."Employment Period";
//                                 end;
//                             6:
//                                 begin
//                                     ApplicantSubmittedJob."Employer 6" := ApplicantEmpl."Employer/Institution Name";
//                                     ApplicantSubmittedJob."From Date Employer 6" := ApplicantEmpl."From Date";
//                                     ApplicantSubmittedJob."To Date Employer 6" := ApplicantEmpl."To Date";
//                                     ApplicantSubmittedJob."Designation Employer 6" := ApplicantEmpl."Sector Specification";
//                                     applicantSubmittedJob."Substantive Post 6" := ApplicantEmpl."Substantive Post";
//                                     applicantSubmittedJob."Employment Period 6" := ApplicantEmpl."Employment Period";
//                                 end;
//                             7:
//                                 begin
//                                     ApplicantSubmittedJob."Employer 7" := ApplicantEmpl."Employer/Institution Name";
//                                     ApplicantSubmittedJob."From Date Employer 7" := ApplicantEmpl."From Date";
//                                     ApplicantSubmittedJob."To Date Employer 7" := ApplicantEmpl."To Date";
//                                     ApplicantSubmittedJob."Designation Employer 7" := ApplicantEmpl."Sector Specification";
//                                     applicantSubmittedJob."Substantive Post 7" := ApplicantEmpl."Substantive Post";
//                                     applicantSubmittedJob."Employment Period 7" := ApplicantEmpl."Employment Period";
//                                 end;
//                             8:
//                                 begin
//                                     ApplicantSubmittedJob."Employer 8" := ApplicantEmpl."Employer/Institution Name";
//                                     ApplicantSubmittedJob."From Date Employer 8" := ApplicantEmpl."From Date";
//                                     ApplicantSubmittedJob."To Date Employer 8" := ApplicantEmpl."To Date";
//                                     ApplicantSubmittedJob."Designation Employer 8" := ApplicantEmpl."Sector Specification";
//                                     applicantSubmittedJob."Substantive Post 8" := ApplicantEmpl."Substantive Post";
//                                     applicantSubmittedJob."Employment Period 8" := ApplicantEmpl."Employment Period";
//                                 end;
//                             9:
//                                 begin
//                                     ApplicantSubmittedJob."Employer 9" := ApplicantEmpl."Employer/Institution Name";
//                                     ApplicantSubmittedJob."From Date Employer 9" := ApplicantEmpl."From Date";
//                                     ApplicantSubmittedJob."To Date Employer 9" := ApplicantEmpl."To Date";
//                                     ApplicantSubmittedJob."Designation Employer 9" := ApplicantEmpl."Sector Specification";
//                                     applicantSubmittedJob."Substantive Post 9" := ApplicantEmpl."Substantive Post";
//                                     applicantSubmittedJob."Employment Period 9" := ApplicantEmpl."Employment Period";
//                                 end;
//                             10:
//                                 begin
//                                     ApplicantSubmittedJob."Employer 10" := ApplicantEmpl."Employer/Institution Name";
//                                     ApplicantSubmittedJob."From Date Employer 10" := ApplicantEmpl."From Date";
//                                     ApplicantSubmittedJob."To Date Employer 10" := ApplicantEmpl."To Date";
//                                     ApplicantSubmittedJob."Designation Employer 10" := ApplicantEmpl."Sector Specification";
//                                     applicantSubmittedJob."Substantive Post 10" := ApplicantEmpl."Substantive Post";
//                                     applicantSubmittedJob."Employment Period 10" := ApplicantEmpl."Employment Period";
//                                 end;
//                         end;

//                         if EmploymentRecordCount = 10 then
//                             break;
//                     until ApplicantEmpl.Next() = 0;

//                     // Only modify once after all updates
//                     if EmploymentRecordCount > 0 then
//                         ApplicantSubmittedJob.Modify();
//                 end;
//                 //*********************************************end of applicant employment history
//                 // //*********************************************************************************education


//                 ApplicantsQual.Reset();
//                 ApplicantsQual.SetRange("Employee No.", applicantSubmittedJob."Applicant No.");
//                 ApplicantsQual.SetCurrentKey("From Date"); // Ensure records are sorted (e.g.,
//                 if ApplicantsQual.FindSet() then begin
//                     if ApplicantsQual."Qualification Type" = ApplicantsQual."Qualification Type"::Academic then begin
//                         repeat
//                             if (ApplicantsQual."Qualification Code" = 'KACE') or (ApplicantsQual."Qualification Code" = 'KCE') then begin
//                                 ApplicantSubmittedJob."Area of Specialization" := ApplicantsQual.Description;
//                                 ApplicantSubmittedJob."Institution/Company" := ApplicantsQual."Institution/Company";
//                                 ApplicantSubmittedJob."From Date" := ApplicantsQual."From Date";
//                                 ApplicantSubmittedJob."To Date" := ApplicantsQual."To Date";
//                                 ApplicantSubmittedJob."Grade/Class" := ApplicantsQual."Grade/Class";
//                             end;


//                             if ApplicantsQual."Qualification Code" = 'KCSE' then begin
//                                 ApplicantSubmittedJob."Area of Specialization 1" := ApplicantsQual.Description;
//                                 ApplicantSubmittedJob."Institution/Company 1" := ApplicantsQual."Institution/Company";
//                                 ApplicantSubmittedJob."From Date 1" := ApplicantsQual."From Date";
//                                 ApplicantSubmittedJob."To Date 1" := ApplicantsQual."To Date";
//                                 ApplicantSubmittedJob."Grade/Class 1" := ApplicantsQual."Grade/Class";
//                             end;


//                             if ApplicantsQual."Qualification Code" = '70000..79999' then begin
//                                 ApplicantSubmittedJob."Area of Specialization 3" := ApplicantsQual.Description;
//                                 ApplicantSubmittedJob."Institution/Company 3" := ApplicantsQual."Institution/Company";
//                                 ApplicantSubmittedJob."From Date 3" := ApplicantsQual."From Date";
//                                 ApplicantSubmittedJob."To Date 3" := ApplicantsQual."To Date";
//                                 ApplicantSubmittedJob."Grade/Class 3" := ApplicantsQual."Grade/Class";
//                             end;


//                             if ApplicantsQual."Qualification Code" = '50000..59999' then begin
//                                 ApplicantSubmittedJob."Institution/Company 4" := ApplicantsQual."Institution/Company";
//                                 ApplicantSubmittedJob."From Date 4" := ApplicantsQual."From Date";
//                                 ApplicantSubmittedJob."To Date 4" := ApplicantsQual."To Date";
//                                 ApplicantSubmittedJob."Grade/Class 4" := ApplicantsQual."Grade/Class";
//                                 ApplicantSubmittedJob."Area of Specialization 4" := ApplicantsQual.Description;
//                             end;
//                             if ApplicantsQual."Qualification Code" = '40000..49999' then begin
//                                 applicantSubmittedJob."Area of Specialization 5" := ApplicantsQual.Description;
//                                 ApplicantSubmittedJob."Institution/Company 5" := ApplicantsQual."Institution/Company";
//                                 ApplicantSubmittedJob."From Date 5" := ApplicantsQual."From Date";
//                                 ApplicantSubmittedJob."To Date 5" := ApplicantsQual."To Date";
//                                 ApplicantSubmittedJob."Grade/Class 5" := ApplicantsQual."Grade/Class";
//                             end;



//                             if ApplicantsQual."Qualification Code" = '30000..39999' then begin
//                                 applicantSubmittedJob."Area of Specialization 6" := ApplicantsQual.Description;
//                                 applicantSubmittedJob."Qualification Code 6" := ApplicantsQual."Qualification Code";
//                                 ApplicantSubmittedJob."Institution/Company 6" := ApplicantsQual."Institution/Company";
//                                 ApplicantSubmittedJob."From Date 6" := ApplicantsQual."From Date";
//                                 ApplicantSubmittedJob."To Date 6" := ApplicantsQual."To Date";
//                                 ApplicantSubmittedJob."Grade/Class 6" := ApplicantsQual."Grade/Class";
//                             end;




//                             if ApplicantsQual."Qualification Code" = '60000..60009' then begin
//                                 applicantSubmittedJob."Area of Specialization 2" := ApplicantsQual.Description;
//                                 ApplicantSubmittedJob."Institution/Company 2" := ApplicantsQual."Institution/Company";
//                                 ApplicantSubmittedJob."From Date 2" := ApplicantsQual."From Date";
//                                 ApplicantSubmittedJob."To Date 2" := ApplicantsQual."To Date";
//                                 ApplicantSubmittedJob."Grade/Class 2" := ApplicantsQual."Grade/Class";
//                             end;

//                             if ApplicantsQual."Qualification Code" = '20000..29999' then begin
//                                 applicantSubmittedJob."Area of Specialization 8" := ApplicantsQual.Description;
//                                 ApplicantSubmittedJob."Institution/Company 8" := ApplicantsQual."Institution/Company";
//                                 ApplicantSubmittedJob."From Date 8" := ApplicantsQual."From Date";
//                                 ApplicantSubmittedJob."To Date 8" := ApplicantsQual."To Date";
//                                 ApplicantSubmittedJob."Grade/Class 8" := ApplicantsQual."Grade/Class";
//                             end;

//                             if ApplicantsQual."Qualification Code" = '10000..19999' then begin
//                                 applicantSubmittedJob."Area of Specialization 9" := ApplicantsQual.Description;
//                                 ApplicantSubmittedJob."Institution/Company 9" := ApplicantsQual."Institution/Company";
//                                 ApplicantSubmittedJob."From Date 9" := ApplicantsQual."From Date";
//                                 ApplicantSubmittedJob."To Date 9" := ApplicantsQual."To Date";
//                                 ApplicantSubmittedJob."Grade/Class 9" := ApplicantsQual."Grade/Class";
//                             end;

//                             if ApplicantsQual."Qualification Code" = '80000..89999' then begin

//                                 applicantSubmittedJob."Area of Specialization 10" := ApplicantsQual.Description;
//                                 ApplicantSubmittedJob."Institution/Company 10" := ApplicantsQual."Institution/Company";
//                                 ApplicantSubmittedJob."From Date 10" := ApplicantsQual."From Date";
//                                 ApplicantSubmittedJob."To Date 10" := ApplicantsQual."To Date";
//                                 ApplicantSubmittedJob."Grade/Class 10" := ApplicantsQual."Grade/Class";
//                             end;

//                         until ApplicantsQual.Next() = 0;
//                     end;


//                     // Only modify once after all updates
//                     if EducationRecordCount > 0 then
//                         ApplicantSubmittedJob.Modify();
//                 end;
//                 //*********************************************end of applicant education history

//                 ApplicantsQual.Reset();
//                 ApplicantsQual.SetRange("Employee No.", applicantSubmittedJob."Applicant No.");
//                 if ApplicantsQual.FindSet() then begin
//                     ProfessionalRecordCount := 0;
//                     if ApplicantsQual."Qualification Type" = ApplicantsQual."Qualification Type"::Professional then begin
//                         repeat
//                             ProfessionalRecordCount += 1; // Increment the count for each education record
//                             case ProfessionalRecordCount of
//                                 1:
//                                     begin
//                                         applicantSubmittedJob."Professional Qualification" := ApplicantsQual."Qualification Code";
//                                         qualificationApp.Get(ApplicantSubmittedJob."Professional Qualification");
//                                         ApplicantSubmittedJob."Professional Name" := qualificationApp.Description;
//                                         ApplicantSubmittedJob."Professional Institution" := ApplicantsQual."Institution/Company";
//                                         ApplicantSubmittedJob."Professional From Date" := ApplicantsQual."From Date";
//                                         ApplicantSubmittedJob."Professional Date of Admission" := ApplicantsQual."To Date";
//                                         ApplicantSubmittedJob."Area of Specialization PROF" := ApplicantsQual."Area of Specialization";

//                                     end;
//                                 2:
//                                     begin
//                                         applicantSubmittedJob."Professional Qualification 2" := ApplicantsQual."Qualification Code";
//                                         qualificationApp.Get(ApplicantSubmittedJob."Professional Qualification 2");
//                                         ApplicantSubmittedJob."Professional Name 2" := qualificationApp.Description;
//                                         ApplicantSubmittedJob."Professional Institution 2" := ApplicantsQual."Institution/Company";
//                                         ApplicantSubmittedJob."Professional From Date 2" := ApplicantsQual."From Date";
//                                         ApplicantSubmittedJob."Professional Date of Admn 2" := ApplicantsQual."To Date";
//                                         ApplicantSubmittedJob."Area of Specialization PROF 2" := ApplicantsQual."Area of Specialization";
//                                     end;
//                                 3:
//                                     begin
//                                         applicantSubmittedJob."Professional Qualification 3" := ApplicantsQual."Qualification Code";
//                                         qualificationApp.Get(ApplicantSubmittedJob."Professional Qualification 3");
//                                         ApplicantSubmittedJob."Professional Name 3" := qualificationApp.Description;
//                                         ApplicantSubmittedJob."Professional Institution 3" := ApplicantsQual."Institution/Company";
//                                         ApplicantSubmittedJob."Professional From Date 3" := ApplicantsQual."From Date";
//                                         ApplicantSubmittedJob."Professional Date of Admn 3" := ApplicantsQual."To Date";
//                                         ApplicantSubmittedJob."Area of Specialization PROF 3" := ApplicantsQual."Area of Specialization";
//                                     end;

//                             end;
//                             if ProfessionalRecordCount = 3 then
//                                 break;

//                         until ApplicantsQual.Next() = 0;
//                     end;
//                     // Only modify once after all updates
//                     if ProfessionalRecordCount > 0 then
//                         applicantSubmittedJob.Modify();
//                 end;
//                 //*************************************************************************************** ApplicantProfessionalBodies
//                 ApplicantProfessionalBodies.Reset();
//                 ApplicantProfessionalBodies.SetRange("Applicant No.", applicantSubmittedJob."Applicant No.");
//                 // newest first)
//                 if ApplicantProfessionalBodies.FindSet() then begin
//                     ProfessionalBodiesRecordCount := 0; // Reset the count for each applicant
//                     repeat
//                         ProfessionalBodiesRecordCount += 1; // Increment the count for each professional bodies record
//                         case ProfessionalBodiesRecordCount of
//                             1:
//                                 begin
//                                     ApplicantSubmittedJob."Professional Bodies" := ApplicantProfessionalBodies.Name;
//                                     applicantSubmittedJob."Professional Code" := ApplicantProfessionalBodies.Code;
//                                     ApplicantSubmittedJob."Admission Date" := ApplicantProfessionalBodies."Date of Admission";
//                                     ApplicantSubmittedJob."Membership No." := ApplicantProfessionalBodies."Membership/Registration No.";
//                                     ApplicantSubmittedJob."Professional Membership Type" := ApplicantProfessionalBodies."Membership Type";

//                                 end;
//                             2:
//                                 Begin
//                                     ApplicantSubmittedJob."Professional Bodies 2" := ApplicantProfessionalBodies.Name;
//                                     ApplicantSubmittedJob."Professional Code" := ApplicantProfessionalBodies.Code;
//                                     ApplicantSubmittedJob."Admission Date 2" := ApplicantProfessionalBodies."Date of Admission";
//                                     ApplicantSubmittedJob."Membership No. 2" := ApplicantProfessionalBodies."Membership/Registration No.";
//                                     ApplicantSubmittedJob."Professional Membership Type 2" := ApplicantProfessionalBodies."Membership/Registration No.";
//                                 End;
//                             3:
//                                 begin
//                                     ApplicantSubmittedJob."Professional Bodies 3" := ApplicantProfessionalBodies.Name;
//                                     ApplicantSubmittedJob."Professional Code 3" := ApplicantProfessionalBodies.Code;
//                                     ApplicantSubmittedJob."Admission Date 3" := ApplicantProfessionalBodies."Date of Admission";
//                                     ApplicantSubmittedJob."Membership No. 3" := ApplicantProfessionalBodies."Membership/Registration No.";
//                                     ApplicantSubmittedJob."Professional Membership Type 3" := ApplicantProfessionalBodies."Membership Type";
//                                 End;

//                         end;

//                         if ProfessionalBodiesRecordCount = 3 then
//                             break;
//                     until ApplicantProfessionalBodies.Next() = 0;
//                     /// Only modify once after all updates

//                     if ProfessionalBodiesRecordCount > 0 then
//                         ApplicantSubmittedJob.Modify();
//                 end;
//                 //*************************************************************************************** Relevant Courses & Trainings
//                 RelevantCourse.Reset();
//                 RelevantCourse.SetRange("Source No", applicantSubmittedJob."Applicant No.");
//                 RelevantCourse.SetCurrentKey("From Date"); // Ensure records are sorted (e.g.,
//                 // newest first)
//                 if RelevantCourse.FindSet() then begin
//                     courseRecordCount := 0; // Reset the count for each applicant
//                     repeat
//                         courseRecordCount += 1; // Increment the count for each relevant course record
//                         case courseRecordCount of
//                             1:
//                                 begin
//                                     ApplicantSubmittedJob."Name Course" := RelevantCourse."Source No";
//                                     ApplicantSubmittedJob."Name of the Course" := RelevantCourse."Name of the Course";
//                                     ApplicantSubmittedJob."Course Int" := RelevantCourse."University/College/Institution";
//                                     ApplicantSubmittedJob."From Date course" := RelevantCourse."From Date";
//                                     ApplicantSubmittedJob."To Date course" := RelevantCourse."To Date";
//                                     ApplicantSubmittedJob."Duration course" := RelevantCourse.Duration;
//                                 end;
//                             2:
//                                 begin
//                                     ApplicantSubmittedJob."Name Course 2" := RelevantCourse."Source No";
//                                     ApplicantSubmittedJob."Name of the Course 2" := RelevantCourse."Name of the Course";
//                                     ApplicantSubmittedJob."Course Int 2" := RelevantCourse."University/College/Institution";
//                                     ApplicantSubmittedJob."From Date course 2" := RelevantCourse."From Date";
//                                     ApplicantSubmittedJob."To Date course 2" := RelevantCourse."To Date";
//                                     ApplicantSubmittedJob."Duration course 2" := RelevantCourse.Duration;
//                                 end;
//                             3:
//                                 begin
//                                     ApplicantSubmittedJob."Name Course 3" := RelevantCourse."Source No";
//                                     ApplicantSubmittedJob."Name of the Course 3" := RelevantCourse."Name of the Course";
//                                     ApplicantSubmittedJob."Course Int 3" := RelevantCourse."University/College/Institution";
//                                     ApplicantSubmittedJob."From Date course 3" := RelevantCourse."From Date";
//                                     ApplicantSubmittedJob."To Date course 3" := RelevantCourse."To Date";
//                                     applicantSubmittedJob."Duration course 3" := RelevantCourse.Duration;

//                                 end;

//                         end;
//                         if courseRecordCount = 3 then
//                             break;
//                     until RelevantCourse.Next() = 0;
//                     if courseRecordCount > 0 then
//                         ApplicantSubmittedJob.Modify();
//                 end;
//                 //*************************************************************************************** Sample Code for Commit
//                 SharePointIntergration.Reset();
//                 SharePointIntergration.SetRange(SharePointIntergration."Document No", applicantSubmittedJob."Applicant No.");
//                 // newest first)
//                 if SharePointIntergration.FindSet() then begin
//                     repeat

//                         if SharePointIntergration.Description = 'SAMPLE1*' then
//                             applicantSubmittedJob.SAMPLE1 := SharePointIntergration.Description;

//                         if SharePointIntergration.Description = 'SAMPLE2*' then
//                             applicantSubmittedJob.SAMPLE2 := SharePointIntergration.Description;
//                         if SharePointIntergration.Description = 'SAMPLE3*' then
//                             applicantSubmittedJob.SAMPLE3 := SharePointIntergration.Description;
//                         if SharePointIntergration.Description = 'SAMPLE4*' then
//                             applicantSubmittedJob.SAMPLE4 := SharePointIntergration.Description;
//                         if SharePointIntergration.Description = 'SAMPLE5*' then
//                             applicantSubmittedJob.SAMPLE5 := SharePointIntergration.Description;

//                         ApplicantSubmittedJob.Modify();

//                     until SharePointIntergration.Next() = 0;
//                 end;

//                 //     Commit();
//                 // Message('%1 applicant job records updated successfully.', ApplicantSubmittedJob.Count);

//             end;

//         }
//     }

//     requestpage
//     {
//         AboutTitle = 'Teaching tip title';
//         AboutText = 'Teaching tip content';
//         layout
//         {
//             area(Content)
//             {
//                 group(GroupName)
//                 {

//                 }
//             }
//         }

//         actions
//         {
//             area(processing)
//             {

//             }
//         }
//     }

//     rendering
//     {
//         layout(ApplSub)
//         {
//             Type = RDLC;
//             LayoutFile = './Reports/SSRS/UpDateJob.RDLC';
//             Caption = 'Job Submitted';
//         }
//     }

//     var
//         SharePointIntergration: record "SharePoint Intergration";
//         ApplicantSubmittedJob: record "Applicant Submitted Job";
//         ApplicantApp: record Applicant;
//         JobAppl: record "Job Application";
//         ApplicantEmpl: record "Applicant Current Employment";
//         ApplicantsQual: record "Applicants Qualification";
//         ApplicantProfessionalBodies: record "Applicant Professional Bodies";
//         RelevantCourse: record "Relevant Courses & Trainings";
//         QualificationApp: Record Qualification;
//         InsertCount: Integer;
//         EmploymentRecordCount: Integer; // Variable to track the number of employment records processed
//         EducationRecordCount: Integer; // Variable to track the number of education records processed
//         ProfessionalRecordCount: Integer;
//         ProfessionalBodiesRecordCount: Integer; // Variable to track the number of professional bodies records processed
//         courseRecordCount: Integer; // Variable to track the number of relevant courses records processed
//                                     // Helper function to set common qualification fields


// }
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

        // Insert the record
        if ApplicantSubmittedJob.Insert() then begin
            // Process related data
            ProcessEmploymentHistory(ApplicantSubmittedJob);
            ProcessEducationHistory(ApplicantSubmittedJob);
            ProcessProfessionalQualifications(ApplicantSubmittedJob);
            UpdateApplicantSamplesFromSharePoint(ApplicantSubmittedJob);
            ProcessRelevantCourses(ApplicantSubmittedJob);
            ProcessProfessionalBodies(ApplicantSubmittedJob);
            Commit();
        end;


    end;

    local procedure InitializeSubmittedJobRecord(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; JobApp: Record "Job Application")
    begin
        Clear(ApplicantSubmittedJob);
        ApplicantSubmittedJob.Init();
        ApplicantSubmittedJob."Job code" := JobApp."No.";
        ApplicantSubmittedJob."Applicant Name" := JobApp."Applicant Name";
        ApplicantSubmittedJob."Applicant No." := JobApp."Applicant No.";
        ApplicantSubmittedJob.Gender := JobApp.Gender;
        ApplicantSubmittedJob."Job Title" := JobApp."Job Title";
        ApplicantSubmittedJob."Job Applied Code" := JobApp."Job Applied Code";
        ApplicantSubmittedJob."Recruitment Needs NO" := JobApp."Recruitment Needs No.";
        ApplicantSubmittedJob."Date-Time Created" := JobApp."Date-Time Created";
    end;

    local procedure PopulateApplicantDetails(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantApp: Record Applicant)
    begin
        // Personal Information
        ApplicantSubmittedJob.Age := HRDatesExt.DetermineDatesDiffrence(ApplicantApp."Birth Date", Today);
        ApplicantSubmittedJob."Birth Date" := ApplicantApp."Birth Date";
        ApplicantSubmittedJob."Nationality New" := ApplicantApp."Nationality New";
        ApplicantSubmittedJob.IDNO := ApplicantApp."National ID";
        ApplicantSubmittedJob."Home County" := ApplicantApp."Home County";
        ApplicantSubmittedJob."Ethnic Group" := ApplicantApp."Ethnic Group";
        ApplicantSubmittedJob."Marital Status" := ApplicantApp."Marital Status";
        ApplicantSubmittedJob."Sub Ethnic Group" := ApplicantApp."Sub Ethnic Group";

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
        //ApplicantSubmittedJob."Years Of Experience" := ApplicantApp."Years of Experience";

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
    begin

        ApplicantSubmittedJob."From Date Employer" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Substantive Post" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period" := ApplicantEmpl."Employment Period";
        ApplicantSubmittedJob.Employer := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement" := ApplicantEmpl.Sector;
    END;

    local procedure SetEmployer2Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    begin
        ApplicantSubmittedJob."Employer 2" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 2" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 2" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 2" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 2" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 2" := ApplicantEmpl."Employment Period";
        ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 2" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 2" := ApplicantEmpl.Sector;

    end;

    local procedure SetEmployer3Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    begin
        ApplicantSubmittedJob."Employer 3" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 3" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 3" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 3" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 3" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 3" := ApplicantEmpl."Employment Period";
        ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 3" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 3" := ApplicantEmpl.Sector;
    end;

    local procedure SetEmployer4Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    begin
        ApplicantSubmittedJob."Employer 4" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 4" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 4" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 4" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 4" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 4" := ApplicantEmpl."Employment Period";
        ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 4" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 4" := ApplicantEmpl.Sector;
    end;

    local procedure SetEmployer5Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    begin
        ApplicantSubmittedJob."Employer 5" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 5" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 5" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 5" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 5" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 5" := ApplicantEmpl."Employment Period";
        ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 5" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 5" := ApplicantEmpl.Sector;
    end;

    local procedure SetEmployer6Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    begin
        ApplicantSubmittedJob."Employer 6" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 6" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 6" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 6" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 6" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 6" := ApplicantEmpl."Employment Period";
        ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 6" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 6" := ApplicantEmpl.Sector;
    end;

    local procedure SetEmployer7Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    begin
        ApplicantSubmittedJob."Employer 7" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 7" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 7" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 7" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 7" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 7" := ApplicantEmpl."Employment Period";
        ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 7" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 7" := ApplicantEmpl.Sector;


    end;

    local procedure SetEmployer8Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    begin
        ApplicantSubmittedJob."Employer 8" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 8" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 8" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 8" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 8" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 8" := ApplicantEmpl."Employment Period";
        ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 8" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 8" := ApplicantEmpl.Sector;
    end;

    local procedure SetEmployer9Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    begin
        ApplicantSubmittedJob."Employer 9" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 9" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 9" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 9" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 9" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 9" := ApplicantEmpl."Employment Period";
        ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 9" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 9" := ApplicantEmpl.Sector;
    end;

    local procedure SetEmployer10Fields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantEmpl: Record "Applicant Current Employment")
    begin
        ApplicantSubmittedJob."Employer 10" := ApplicantEmpl."Employer/Institution Name";
        ApplicantSubmittedJob."From Date Employer 10" := ApplicantEmpl."From Date";
        ApplicantSubmittedJob."To Date Employer 10" := ApplicantEmpl."To Date";
        ApplicantSubmittedJob."Designation Employer 10" := ApplicantEmpl."Sector Specification";
        ApplicantSubmittedJob."Substantive Post 10" := ApplicantEmpl."Substantive Post";
        ApplicantSubmittedJob."Employment Period 10" := ApplicantEmpl."Employment Period";
        ApplicantSubmittedJob."Years Of Experience 1" += ApplicantEmpl."Employment Period";
        if ApplicantEmpl."Applicant No." = '' then
            ApplicantSubmittedJob."Sector Of Employement 10" := ApplicantSubmittedJob."Sector Of Employement"::" "
        else
            ApplicantSubmittedJob."Sector Of Employement 10" := ApplicantEmpl.Sector;
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

    // local procedure SetEducationFields(var ApplicantSubmittedJob: Record "Applicant Submitted Job"; ApplicantsQual: Record "Applicants Qualification"; FieldIndex: Integer)
    // begin
    //     case FieldIndex of

    //         0:
    //             begin
    //                 ApplicantSubmittedJob."Area of Specialization" := ApplicantsQual.Description;
    //                 ApplicantSubmittedJob."Institution/Company" := ApplicantsQual."Institution/Company";
    //                 ApplicantSubmittedJob."From Date" := ApplicantsQual."From Date";
    //                 ApplicantSubmittedJob."To Date" := ApplicantsQual."To Date";
    //                 ApplicantSubmittedJob."Grade/Class" := ApplicantsQual."Grade/Class";
    //             end;
    //         1:
    //             begin
    //                 ApplicantSubmittedJob."Area of Specialization 1" := ApplicantsQual.Description;
    //                 ApplicantSubmittedJob."Institution/Company 1" := ApplicantsQual."Institution/Company";
    //                 ApplicantSubmittedJob."From Date 1" := ApplicantsQual."From Date";
    //                 ApplicantSubmittedJob."To Date 1" := ApplicantsQual."To Date";
    //                 ApplicantSubmittedJob."Grade/Class 1" := ApplicantsQual."Grade/Class";
    //             end;
    //         2:
    //             begin
    //                 ApplicantSubmittedJob."Area of Specialization 2" := ApplicantsQual.Description;
    //                 ApplicantSubmittedJob."Institution/Company 2" := ApplicantsQual."Institution/Company";
    //                 ApplicantSubmittedJob."From Date 2" := ApplicantsQual."From Date";
    //                 ApplicantSubmittedJob."To Date 2" := ApplicantsQual."To Date";
    //                 ApplicantSubmittedJob."Grade/Class 2" := ApplicantsQual."Grade/Class";
    //             end;
    //         3:
    //             begin
    //                 ApplicantSubmittedJob."Area of Specialization 3" := ApplicantsQual.Description;
    //                 ApplicantSubmittedJob."Institution/Company 3" := ApplicantsQual."Institution/Company";
    //                 ApplicantSubmittedJob."From Date 3" := ApplicantsQual."From Date";
    //                 ApplicantSubmittedJob."To Date 3" := ApplicantsQual."To Date";
    //                 ApplicantSubmittedJob."Grade/Class 3" := ApplicantsQual."Grade/Class";
    //             end;
    //         4:
    //             begin
    //                 ApplicantSubmittedJob."Institution/Company 4" := ApplicantsQual."Institution/Company";
    //                 ApplicantSubmittedJob."From Date 4" := ApplicantsQual."From Date";
    //                 ApplicantSubmittedJob."To Date 4" := ApplicantsQual."To Date";
    //                 ApplicantSubmittedJob."Grade/Class 4" := ApplicantsQual."Grade/Class";
    //                 ApplicantSubmittedJob."Area of Specialization 4" := ApplicantsQual.Description;
    //             end;
    //         5:
    //             begin
    //                 ApplicantSubmittedJob."Area of Specialization 5" := ApplicantsQual.Description;
    //                 ApplicantSubmittedJob."Institution/Company 5" := ApplicantsQual."Institution/Company";
    //                 ApplicantSubmittedJob."From Date 5" := ApplicantsQual."From Date";
    //                 ApplicantSubmittedJob."To Date 5" := ApplicantsQual."To Date";
    //                 ApplicantSubmittedJob."Grade/Class 5" := ApplicantsQual."Grade/Class";
    //             end;
    //         6:
    //             begin
    //                 ApplicantSubmittedJob."Area of Specialization 6" := ApplicantsQual.Description;
    //                 ApplicantSubmittedJob."Qualification Code 6" := ApplicantsQual."Qualification Code";
    //                 ApplicantSubmittedJob."Institution/Company 6" := ApplicantsQual."Institution/Company";
    //                 ApplicantSubmittedJob."From Date 6" := ApplicantsQual."From Date";
    //                 ApplicantSubmittedJob."To Date 6" := ApplicantsQual."To Date";
    //                 ApplicantSubmittedJob."Grade/Class 6" := ApplicantsQual."Grade/Class";
    //             end;
    //         8:
    //             begin
    //                 ApplicantSubmittedJob."Area of Specialization 8" := ApplicantsQual.Description;
    //                 ApplicantSubmittedJob."Institution/Company 8" := ApplicantsQual."Institution/Company";
    //                 ApplicantSubmittedJob."From Date 8" := ApplicantsQual."From Date";
    //                 ApplicantSubmittedJob."To Date 8" := ApplicantsQual."To Date";
    //                 ApplicantSubmittedJob."Grade/Class 8" := ApplicantsQual."Grade/Class";
    //             end;
    //         9:
    //             begin
    //                 ApplicantSubmittedJob."Area of Specialization 9" := ApplicantsQual.Description;
    //                 ApplicantSubmittedJob."Institution/Company 9" := ApplicantsQual."Institution/Company";
    //                 ApplicantSubmittedJob."From Date 9" := ApplicantsQual."From Date";
    //                 ApplicantSubmittedJob."To Date 9" := ApplicantsQual."To Date";
    //                 ApplicantSubmittedJob."Grade/Class 9" := ApplicantsQual."Grade/Class";
    //             end;
    //         10:
    //             begin
    //                 ApplicantSubmittedJob."Area of Specialization 10" := ApplicantsQual.Description;
    //                 ApplicantSubmittedJob."Institution/Company 10" := ApplicantsQual."Institution/Company";
    //                 ApplicantSubmittedJob."From Date 10" := ApplicantsQual."From Date";
    //                 ApplicantSubmittedJob."To Date 10" := ApplicantsQual."To Date";
    //                 ApplicantSubmittedJob."Grade/Class 10" := ApplicantsQual."Grade/Class";
    //             end;
    //     end;
    // end;

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
            ProfessionalBodiesRecordCount := 0; // Reset the count for each applicant
            repeat
                ProfessionalBodiesRecordCount += 1; // Increment the count for each professional bodies record
                case ProfessionalBodiesRecordCount of
                    1:
                        begin
                            ApplicantSubmittedJob."Professional Bodies" := ApplicantProfessionalBodies.Name;
                            applicantSubmittedJob."Professional Code" := ApplicantProfessionalBodies.Code;
                            ApplicantSubmittedJob."Admission Date" := ApplicantProfessionalBodies."Date of Admission";
                            ApplicantSubmittedJob."Membership No." := ApplicantProfessionalBodies."Membership/Registration No.";
                            ApplicantSubmittedJob."Professional Membership Type" := ApplicantProfessionalBodies."Membership Type";

                        end;
                    2:
                        Begin
                            ApplicantSubmittedJob."Professional Bodies 2" := ApplicantProfessionalBodies.Name;
                            ApplicantSubmittedJob."Professional Code" := ApplicantProfessionalBodies.Code;
                            ApplicantSubmittedJob."Admission Date 2" := ApplicantProfessionalBodies."Date of Admission";
                            ApplicantSubmittedJob."Membership No. 2" := ApplicantProfessionalBodies."Membership/Registration No.";
                            ApplicantSubmittedJob."Professional Membership Type 2" := ApplicantProfessionalBodies."Membership/Registration No.";
                        End;
                    3:
                        begin
                            ApplicantSubmittedJob."Professional Bodies 3" := ApplicantProfessionalBodies.Name;
                            ApplicantSubmittedJob."Professional Code 3" := ApplicantProfessionalBodies.Code;
                            ApplicantSubmittedJob."Admission Date 3" := ApplicantProfessionalBodies."Date of Admission";
                            ApplicantSubmittedJob."Membership No. 3" := ApplicantProfessionalBodies."Membership/Registration No.";
                            ApplicantSubmittedJob."Professional Membership Type 3" := ApplicantProfessionalBodies."Membership Type";
                        End;

                end;

                if ProfessionalBodiesRecordCount = 3 then
                    break;
            until ApplicantProfessionalBodies.Next() = 0;
            /// Only modify once after all updates

            if ProfessionalBodiesRecordCount > 0 then
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


}
