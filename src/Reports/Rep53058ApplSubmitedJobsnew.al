report 53059 "Appl. Submit J list"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ApplSub;

    dataset
    {
        dataitem("Job Application"; "Job Application")
        {
            RequestFilterFields = "Job Applied Code", "Job Title", "No.", "Recruitment Needs No.";
            DataItemTableView = where(Submitted = filter(true));

            column(No_; "No.")
            {
            }
            column(countNo; countNo) { }
            column(Applicant_No_; "Applicant No.") { }
            column(Applicant_Name; "Applicant Name") { }
            column(IDNO; IDNO) { }
            column(Gender; Gender) { }
            //column()
            column(Job_Applied_Code; "Job Applied Code") { }
            column(Job_Title; "Job Title") { }
            column(Date_Time_Created; "Date-Time Created") { }
            column(Submitted; Submitted) { }
            column(DateofBirth; DateofBirth) { }
            column(Age; Age) { }
            column(HomeCounty; HomeCounty) { }
            column(Disability; Disability) { }
            column(NCPWDCertificateNo; NCPWDCertificateNo) { }
            column(PersonsDisabilityDescrip; PersonsDisabilityDescrip) { }
            column(PostalAddress; PostalAddress) { }
            column(city; city) { }
            column(MobilePhoneNo; MobilePhoneNo) { }
            column(EmailAddress; EmailAddress) { }
            column(BachelorofLaws; BachelorofLaws) { }
            column(PostgraduateDiploma; PostgraduateDiploma) { }
            column(AdmissionNo; AdmissionofNo) { }
            column(DateofAdmission; DateofAdmission) { }
            column(DateofClosureofAdvert; DateofClosureofAdvert) { }
            column(PostAdmissionExperience; PostAdmissionExperience) { }
            column(Otherqualifications; Otherqualifications) { }
            column(CurrentDesignation; CurrentDesignation) { }
            column(CurrentEmployer; CurrentEmployer) { }
            column(StartDate; StartDate) { }
            column(EndDate; EndDate) { }
            column(Years; Years) { }
            column(CurrentSectorofEmployment; CurrentSectorofEmployment)
            {
                OptionMembers = ,Public,Private,Academia,Corporate,Others;
            }
            column(SampleWriting1; SampleWriting1) { }
            column(SampleWriting2; SampleWriting2) { }
            column(SampleWriting3; SampleWriting3) { }
            column(SampleWriting4; SampleWriting4) { }
            column(SampleWriting5; SampleWriting5) { }
            column(NoofSampleWriting; NoofSampleWriting) { }
            column(CurrentPracticingCertificate; CurrentPracticingCertificate) { }
            column(Declarationofincomeandliabilities; Declarationofincomeandliabilities) { }
            column(PE1; PE1) { }
            column(EMP1; EMP1) { }
            column(StartDate1; StartDate1) { }
            column(EndDate1; EndDate1) { }
            column(YEAR1; YEAR1) { }

            column(PE2; PE2) { }
            column(EMP2; EMP2) { }
            column(StartDate2; StartDate2) { }
            column(EndDate2; EndDate2) { }
            column(YEAR2; YEAR2) { }
            column(PE3; PE3) { }
            column(EMP3; EMP3) { }
            column(StartDate3; StartDate3) { }
            column(EndDate3; EndDate3) { }
            column(YEAR3; YEAR3) { }
            column(PE4; PE4) { }
            column(EMP4; EMP4) { }
            column(StartDate4; StartDate4) { }
            column(EndDate4; EndDate4) { }
            column(YEAR4; YEAR4) { }
            column(PE5; PE5) { }
            column(EMP5; EMP5) { }
            column(StartDate5; StartDate5) { }
            column(EndDate5; EndDate5) { }
            column(YEAR5; YEAR5) { }

            column(Ethnic; Ethnic) { }
            column(PostCode; PostCode) { }
            column(BachelorofLawsdate; BachelorofLawsdate) { }
            column(BachelorofLawsInst; BachelorofLawsInst) { }
            column(PostgraduateDiplomaDate; PostgraduateDiplomaDate) { }
            column(PostgraduateDiplomaInst; PostgraduateDiplomaInst) { }
            column(BachelorofOther1; BachelorofOther1) { }
            column(BachelorofOther1Date; BachelorofOther1Date)
            { }
            column(BachelorofOther1Ints; BachelorofOther1Ints) { }
            column(BachelorofOther2; BachelorofOther2) { }
            column(BachelorofOther2Date; BachelorofOther2Date)
            { }
            column(BachelorofOther2Ints; BachelorofOther2Ints) { }
            column(BachelorofOther3; BachelorofOther3) { }
            column(BachelorofOther3Date; BachelorofOther3Date) { }
            column(BachelorofOther3Ints; BachelorofOther3Ints) { }
            column(Othercourse4; Othercourse4) { }
            column(Othercourse4Date; Othercourse4Date) { }
            column(Othercourse4Ints; Othercourse4Ints) { }
            column(Othercourse5; Othercourse5) { }
            column(Othercourse5Date; Othercourse5Date) { }
            column(Othercourse5Ints; Othercourse5Ints) { }
            column(PostgraduateOther; PostgraduateOther) { }
            column(PostgraduateotherDate; PostgraduateotherDate) { }
            column(PostgraduateOtherInst; PostgraduateOtherInst) { }
            column(ProfessionalBodies; ProfessionalBodies) { }
            column(ProfessionalbodesNo; ProfessionalbodesNo) { }
            column(ProfessionalBodiesDate; ProfessionalBodiesDate) { }
            column(ProfessionalBodies1; ProfessionalBodies1) { }
            column(ProfessionalbodesNo1; ProfessionalbodesNo1) { }
            column(ProfessionalBodiesDate1; ProfessionalBodiesDate1) { }
            column(RelevantCourse; RelevantCourse) { }
            column(RelevantCourseInt; RelevantCourseInt) { }
            column(RelevantCourseDate; RelevantCourseDate) { }
            column(Grade1; Grade1) { }
            column(Grade2; Grade2) { }
            column(Grade3; Grade3) { }
            column(Grade4; Grade4) { }
            column(Grade5; Grade5) { }
            trigger OnAfterGetRecord()
            begin
                countNo := countNo + 1;
                SharePointIntergration.Reset();
                SharePointIntergration.SetRange(SharePointIntergration."Document No", "Job Application"."Applicant No.");
                if SharePointIntergration.Find('-') then begin
                    SampleWriting1 := SharePointIntergration.Description;

                end;
                //*****************************************************************************************
                Clear(RelevantCourse);
                Clear(RelevantCourseInt);
                Clear(RelevantCourseDate);
                RelevantCoursesTrainings.Reset();
                RelevantCoursesTrainings.SetRange(RelevantCoursesTrainings."Source No", "Applicant No.");
                if RelevantCoursesTrainings.FindFirst() then begin
                    RelevantCourse := RelevantCoursesTrainings."Name of the Course";
                    RelevantCourseInt := RelevantCoursesTrainings."University/College/Institution";
                    RelevantCourseDate := RelevantCoursesTrainings."To Date";
                end;
                //*************************************************************************************
                Clear(AdmissionofNo);
                Clear(CurrentPracticingCertificate);
                Clear(DateofAdmission);
                Clear(PostAdmissionExperience);
                ApplicantProfessionalBodies.Reset();
                ApplicantProfessionalBodies.SetRange(ApplicantProfessionalBodies."Applicant No.", "Applicant No.");
                ApplicantProfessionalBodies.SetRange(ApplicantProfessionalBodies.Code, 'LSK');
                if ApplicantProfessionalBodies.FindFirst() then begin // 

                    AdmissionofNo := ApplicantProfessionalBodies."Membership/Registration No.";
                    CurrentPracticingCertificate := ApplicantProfessionalBodies."Membership/Registration No.";
                    DateofAdmission := ApplicantProfessionalBodies."Date of Admission";

                end;

                //*****************************************************************
                ClearCurrentlyEmploymentHistoryFields();
                ApplicantCurrentEmployment.Reset();
                ApplicantCurrentEmployment.SetRange(ApplicantCurrentEmployment."Applicant No.", "Job Application"."Applicant No.");
                ApplicantCurrentEmployment.SetRange("Currently Employment", true);

                if ApplicantCurrentEmployment.FindFirst() then begin
                    // repeat
                    StartDate := ApplicantCurrentEmployment."From Date";
                    EndDate := ApplicantCurrentEmployment."To Date";
                    CurrentEmployer := ApplicantCurrentEmployment."Employer/Institution Name";
                    CurrentSectorofEmployment := ApplicantCurrentEmployment.Sector;
                    Years := ApplicantCurrentEmployment."Employment Period";
                    CurrentDesignation := ApplicantCurrentEmployment."Substantive Post";


                    // until ApplicantCurrentEmployment.Next() = 0;
                end;

                //************************************************************************************************
                ClearEmploymentHistoryFields();
                // ClearCurrentlyEmploymentHistoryFields();
                ApplicantCurrentEmployment.Reset();
                ApplicantCurrentEmployment.SetCurrentKey(ApplicantCurrentEmployment."From Date");
                ApplicantCurrentEmployment.SetRange(ApplicantCurrentEmployment."Applicant No.", "Job Application"."Applicant No.");
                ApplicantCurrentEmployment.SetRange("Currently Employment", false);
                ApplicantCurrentEmployment.SetAscending("From Date", false);
                if ApplicantCurrentEmployment.Find('-') then begin
                    repeat
                        ClearEmploymentHistoryFields();
                        if ApplicantCurrentEmployment."Currently Employment" = false then begin

                            if ApplicantCurrentEmployment.Next() <> 0 then begin
                                // First record
                                PE1 := ApplicantCurrentEmployment."Substantive Post";
                                EMP1 := ApplicantCurrentEmployment."Employer/Institution Name";
                                StartDate1 := ApplicantCurrentEmployment."From Date";
                                EndDate1 := ApplicantCurrentEmployment."To Date";
                                YEAR1 := ApplicantCurrentEmployment."Employment Period";

                                // Second record (if exists)
                                if ApplicantCurrentEmployment.Next() <> 0 then begin
                                    PE2 := ApplicantCurrentEmployment."Substantive Post";
                                    EMP2 := ApplicantCurrentEmployment."Employer/Institution Name";
                                    StartDate2 := ApplicantCurrentEmployment."From Date";
                                    EndDate2 := ApplicantCurrentEmployment."To Date";
                                    YEAR2 := ApplicantCurrentEmployment."Employment Period";


                                    if ApplicantCurrentEmployment.Next() <> 0 then begin
                                        PE3 := ApplicantCurrentEmployment."Substantive Post";
                                        EMP3 := ApplicantCurrentEmployment."Employer/Institution Name";
                                        StartDate3 := ApplicantCurrentEmployment."To Date";
                                        EndDate3 := ApplicantCurrentEmployment."From Date";
                                        YEAR3 := ApplicantCurrentEmployment."Employment Period";
                                        if ApplicantCurrentEmployment.Next() <> 0 then begin
                                            PE4 := ApplicantCurrentEmployment."Substantive Post";
                                            EMP4 := ApplicantCurrentEmployment."Employer/Institution Name";
                                            StartDate4 := ApplicantCurrentEmployment."To Date";
                                            EndDate4 := ApplicantCurrentEmployment."From Date";
                                            YEAR4 := ApplicantCurrentEmployment."Employment Period";
                                            if ApplicantCurrentEmployment.Next() <> 0 then begin
                                                PE5 := ApplicantCurrentEmployment."Substantive Post";
                                                EMP5 := ApplicantCurrentEmployment."Employer/Institution Name";
                                                StartDate5 := ApplicantCurrentEmployment."To Date";
                                                EndDate5 := ApplicantCurrentEmployment."From Date";
                                                YEAR5 := ApplicantCurrentEmployment."Employment Period";
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    until ApplicantCurrentEmployment.Next() = 0;

                end;

                //*******************************************

                //*******************************************************************************education



                ClearApplicantsQualification();
                ApplicantsQualification.Reset();
                ApplicantsQualification.SetCurrentKey(ApplicantsQualification."From Date");
                ApplicantsQualification.SetRange(ApplicantsQualification."Employee No.", "Applicant No.");
                //   ApplicantsQualification.SetRange(ApplicantsQualification."Qualification Type", ApplicantsQualification."Qualification Type"::Academic);
                ApplicantsQualification.SetAscending("From Date", false);
                if ApplicantsQualification.FindLast() then begin
                    repeat
                        ClearApplicantsQualification();

                        if ApplicantsQualification.Next() <> 0 then begin
                            // if (QualificationApp."Education Level" <> 'BACHELORS') or (QualificationApp."Education Level" <> 'MASTERS') then begin
                            QualificationApp.Reset();
                            QualificationApp.SetRange(QualificationApp.Code, ApplicantsQualification."Qualification Code");
                            if QualificationApp.Find('-') then
                                BachelorofOther2 := QualificationApp.Description;
                            BachelorofOther2Date := ApplicantsQualification."To Date";
                            BachelorofOther2Ints := ApplicantsQualification."Institution/Company";
                            Grade3 := ApplicantsQualification."Grade/Class";
                            // end;

                            if ApplicantsQualification.Next() <> 0 then begin
                                //  if (QualificationApp."Education Level" <> 'BACHELORS') or (QualificationApp."Education Level" <> 'MASTERS') then begin

                                QualificationApp.Reset();
                                QualificationApp.SetRange(QualificationApp.Code, ApplicantsQualification."Qualification Code");
                                if QualificationApp.Find('-') then
                                    BachelorofOther3 := QualificationApp.Description;
                                BachelorofOther3Date := ApplicantsQualification."To Date";
                                BachelorofOther3Ints := ApplicantsQualification."Institution/Company";
                                Grade3 := ApplicantsQualification."Grade/Class";
                                // end;

                                if ApplicantsQualification.Next() <> 0 then begin

                                    //   if (QualificationApp."Education Level" <> 'BACHELORS') or (QualificationApp."Education Level" <> 'MASTERS') then begin

                                    QualificationApp.Reset();
                                    QualificationApp.SetRange(QualificationApp.Code, ApplicantsQualification."Qualification Code");
                                    if QualificationApp.Find('-') then
                                        Othercourse4 := QualificationApp.Description;
                                    Othercourse4Date := ApplicantsQualification."To Date";
                                    Othercourse4Ints := ApplicantsQualification."Institution/Company";
                                    Grade4 := ApplicantsQualification."Grade/Class";
                                    //  end;


                                    if ApplicantsQualification.Next() <> 0 then begin

                                        // if (QualificationApp."Education Level" <> 'BACHELORS') or (QualificationApp."Education Level" <> 'MASTERS') then begin

                                        QualificationApp.Reset();
                                        QualificationApp.SetRange(QualificationApp.Code, ApplicantsQualification."Qualification Code");
                                        if QualificationApp.Find('-') then
                                            Othercourse5 := QualificationApp.Description;
                                        Othercourse5Date := ApplicantsQualification."To Date";
                                        Othercourse5Ints := ApplicantsQualification."Institution/Company";
                                        Grade5 := ApplicantsQualification."Grade/Class";
                                        // end;

                                    end;
                                end;

                            end;
                        end;

                    until ApplicantsQualification.Next() = 0;


                end;
                ///


                Clear(BachelorofOther1);
                Clear(BachelorofOther1Date);
                Clear(BachelorofOther1Ints);
                Clear(Grade1);
                ApplicantsQualification.Reset();
                ApplicantsQualification.SetRange(ApplicantsQualification."Employee No.", "Applicant No.");
                //  ApplicantsQualification.SetRange(ApplicantsQualification."Qualification Type", ApplicantsQualification."Qualification Type"::Academic);
                if ApplicantsQualification.FindFirst() then begin
                    if QualificationApp."Education Level" = 'MASTERS' then begin
                        QualificationApp.Reset();
                        QualificationApp.SetCurrentKey("Education Level");
                        QualificationApp.SetRange(QualificationApp.Code, ApplicantsQualification."Qualification Code");
                        if QualificationApp.Find('-') then
                            BachelorofOther1 := QualificationApp.Description;
                        BachelorofOther1Date := ApplicantsQualification."To Date";
                        BachelorofOther1Ints := ApplicantsQualification."Institution/Company";
                        Grade1 := ApplicantsQualification."Grade/Class";
                    end;
                end;


                //*******************************************************************************************************************
                Clear(BachelorofLaws);
                Clear(BachelorofLawsdate);
                Clear(BachelorofLawsInst);
                Clear(Grade2);
                ApplicantsQualification.Reset();
                ApplicantsQualification.SetRange(ApplicantsQualification."Employee No.", "Applicant No.");
                if ApplicantsQualification.FindFirst() then begin
                    if QualificationApp."Education Level" = 'BACHELORS' then begin
                        QualificationApp.Reset();
                        QualificationApp.SetRange(QualificationApp.Code, ApplicantsQualification."Qualification Code");
                        if QualificationApp.Find('-') then
                            BachelorofLaws := QualificationApp.Description;//ApplicantsQualification."Area of Specialization";
                    end;
                    BachelorofLawsdate := ApplicantsQualification."To Date";
                    BachelorofLawsInst := ApplicantsQualification."Institution/Company";
                    Grade2 := ApplicantsQualification."Grade/Class";

                end;

                //***************************************************************************************************************


                //    (ApplicantsQualification."Qualification Code" <= '39999') then
                Clear(PostgraduateDiploma);
                Clear(PostgraduateDiplomaDate);
                Clear(PostgraduateDiplomaInst);
                ApplicantsQualification.Reset();
                ApplicantsQualification.SetRange(ApplicantsQualification."Employee No.", "Applicant No.");
                ApplicantsQualification.SetRange(ApplicantsQualification."Qualification Code", 'PDL');
                if ApplicantsQualification.FindFirst() then begin
                    PostgraduateDiploma := ApplicantsQualification.Qualification;//'Postgraduate Diploma in Law';//ApplicantsQualification."Area of Specialization";
                    PostgraduateDiplomaDate := ApplicantsQualification."To Date";
                    PostgraduateDiplomaInst := ApplicantsQualification."Institution/Company";
                end; // Note: '-' not in quotespplicants
                Clear(PostgraduateOther);
                Clear(PostgraduateotherDate);
                Clear(PostgraduateOtherInst);
                ApplicantsQualification.Reset();
                ApplicantsQualification.SetCurrentKey(ApplicantsQualification."From Date");
                ApplicantsQualification.SetRange(ApplicantsQualification."Employee No.", "Applicant No.");
                ApplicantsQualification.SetRange(ApplicantsQualification."Qualification Type", ApplicantsQualification."Qualification Type"::Professional);
                if ApplicantsQualification.FindFirst() then begin
                    if ApplicantsQualification."Qualification Code" <> 'PDL' then begin
                        QualificationApp.Reset();
                        QualificationApp.SetRange(QualificationApp.Code, ApplicantsQualification."Qualification Code");
                        if QualificationApp.Find('-') then
                            PostgraduateOther := QualificationApp.Description;//'Postgraduate Diploma in Law';//ApplicantsQualification."Area of Specialization";
                    end;
                    PostgraduateotherDate := ApplicantsQualification."To Date";
                    PostgraduateOtherInst := ApplicantsQualification."Institution/Company";
                    // Note: '-' not in quotespplicants
                end;
                //***************************************************************************************
                Clearappbodies();
                ApplicantProfessionalBodies.Reset();
                ApplicantProfessionalBodies.SetCurrentKey(ApplicantProfessionalBodies."Date of Admission");
                ApplicantProfessionalBodies.SetRange(ApplicantProfessionalBodies."Applicant No.", "Applicant No.");
                if ApplicantProfessionalBodies.Find('-') then begin // 
                    if ApplicantProfessionalBodies.Code <> 'LSK' then begin
                        repeat
                            Clearappbodies();
                            if ApplicantProfessionalBodies.Next() <> 0 then begin
                                ProfessionalBodies := ApplicantProfessionalBodies.Name;
                                ProfessionalbodesNo := ApplicantProfessionalBodies."Membership/Registration No.";
                                ProfessionalBodiesDate := ApplicantProfessionalBodies."Date of Admission";
                                ProfessionalBodiesType := ApplicantProfessionalBodies."Membership Type";
                                if ApplicantProfessionalBodies.Next() <> 0 then begin
                                    ProfessionalBodies1 := ApplicantProfessionalBodies.Name;
                                    ProfessionalbodesNo1 := ApplicantProfessionalBodies."Membership/Registration No.";
                                    ProfessionalBodiesDate1 := ApplicantProfessionalBodies."Date of Admission";
                                    ProfessionalBodiesType1 := ApplicantProfessionalBodies."Membership Type";

                                end;
                            end;

                        until ApplicantProfessionalBodies.Next() = 0;

                    end;

                end;



                //***************************************************************************************************
                ApplicantApp.Reset();
                ApplicantApp.SetRange(ApplicantApp."No.", "Applicant No.");
                if ApplicantApp.Find('-') then begin
                    IDNO := ApplicantApp."National ID";
                    DateofBirth := ApplicantApp."Birth Date";
                    Age := HRDatesExt.DetermineDatesDiffrence(ApplicantApp."Birth Date", Today);
                    HomeCounty := ApplicantApp."Home County";
                    Disability := ApplicantApp.Disability;
                    PostalAddress := ApplicantApp."Postal Address new";
                    MobilePhoneNo := ApplicantApp."Mobile Phone No.";
                    EmailAddress := LowerCase(ApplicantApp."E-Mail");
                    NCPWDCertificateNo := ApplicantApp."NCPWD Certificate No.";
                    PersonsDisabilityDescrip := ApplicantApp."Disability Description";
                    city := ApplicantApp.City;
                    Ethnic := ApplicantApp."Ethnic Group";
                    PostCode := ApplicantApp."Post Code";

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
                    // field(Name; SourceExpression)
                    // {

                    // }
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

            //Type = Excel;
            Type = RDLC;
            LayoutFile = './Reports/SSRS/ApplSubmitNew_list.RDLC';

            Caption = 'Job Submitted';
        }
    }
    var
        ProfessionalBodies: Text[1000];
        ProfessionalbodesNo: Code[100];
        ProfessionalBodiesType: Code[1000];
        ProfessionalBodiesDate: Date;
        ProfessionalBodies1: Text[1000];
        ProfessionalbodesNo1: Code[100];
        ProfessionalBodiesType1: Code[1000];
        ProfessionalBodiesDate1: Date;
        QualificationApp: Record Qualification;
        PostgraduateOther: Text[1000];
        PostgraduateDiplomaDate: Date;
        PostgraduateDiplomaInst: Text[2000];
        PostgraduateotherDate: Date;
        PostgraduateOtherInst: Text[2000];
        BachelorofOther1: Text[1000];
        Grade1: Text[1000];
        Grade2: Text[1000];
        Grade3: Text[1000];
        Grade4: Text[1000];
        Grade5: Text[1000];
        BachelorofOther1Date: Date;
        BachelorofOther1Ints: Text[1000];
        BachelorofOther2Date: Date;
        BachelorofOther2Ints: Text[1000];
        BachelorofOther3Date: Date;
        BachelorofOther3Ints: Text[1000];
        BachelorofOther2: Text[1000];
        BachelorofOther3: Text[1000];
        BachelorofLawsdate: Date;

        Othercourse4: Text[1000];
        Othercourse4Date: Date;
        Othercourse4Ints: Text[1000];
        Othercourse5: Text[1000];
        Othercourse5Date: Date;
        Othercourse5Ints: Text[1000];

        BachelorofLawsInst: Text[1000];
        QualCode: Integer;
        Counter: Integer;
        city: Text[2000];
        EmplNo1: Boolean;
        PE1: Code[200];
        EMP1: Code[1000];
        StartDate1: Date;
        EndDate1: Date;
        YEAR1: Text[1000];
        PE2: Code[200];
        EMP2: Code[1000];
        StartDate2: Date;
        EndDate2: Date;
        YEAR2: Text[1000];
        PE3: Code[200];
        EMP3: Code[1000];
        StartDate3: Date;
        EndDate3: Date;
        YEAR3: Text[1000];
        PE4: Code[200];
        EMP4: Code[1000];
        StartDate4: Date;
        EndDate4: Date;
        YEAR4: Text[1000];
        PE5: Code[200];
        EMP5: Code[1000];
        StartDate5: Date;
        EndDate5: Date;
        YEAR5: Text[1000];
        NCPWDCertificateNo: Code[1000];
        PersonsDisabilityDescrip: text[1000];

        HRDatesExt: Codeunit "HR Dates Mgt";
        SharePointIntergration: Record "SharePoint Intergration";
        RelevantCoursesTrainings: Record "Relevant Courses & Trainings";
        ApplicantProfessionalBodies: Record "Applicant Professional Bodies";
        //Applicant Professional Bodies
        ApplicantCurrentEmployment: Record "Applicant Current Employment";
        ApplicantsQualification: Record "Applicants Qualification";
        ApplicantApp: Record Applicant;
        RecrmntNeed: Record "Recruitment Needs";
        myInt: Integer;
        countNo: Integer;
        IDNO: Code[100];
        DateofBirth: Date;
        Age: Text[100];
        HomeCounty: Text[100];
        Disability: Boolean;
        PostalAddress: Integer;
        MobilePhoneNo: Code[200];
        EmailAddress: Code[200];
        BachelorofLaws: Text[1000];
        PostgraduateDiploma: Text[1000];
        AdmissionofNo: Code[1000];
        DateofAdmission: Date;
        DateofClosureofAdvert: Date;
        PostAdmissionExperience: Text[100];
        Otherqualifications: Text[1000];
        CurrentDesignation: Text[1000];
        CurrentEmployer: Text[1000];
        StartDate: Date;
        EndDate: Date;
        Years: Text[100];
        PostAdmissionExperienc: Text[2000];

        CurrentSectorofEmployment: Option;
        //'Public,Private,Academia,Corporate,Others';

        // OptionMembers = Public,Private,Academia,Corporate,Others;
        SampleWriting1: Text[1000];
        SampleWriting2: Text[1000];
        SampleWriting3: Text[1000];
        SampleWriting4: Text[1000];
        SampleWriting5: Text[1000];
        NoofSampleWriting: Integer;
        CurrentPracticingCertificate: Text[1000];
        Declarationofincomeandliabilities: Text[1000];
        PublicOfficersDeclarationyears: Text;
        Ethnic: Text[1000];

        PostCode: Code[500];
        Dates: Codeunit "HR Dates Mgt";
        RelevantCourse: Text[1000];
        RelevantCourseDate: Date;
        RelevantCourseInt: Text[1000];

    local procedure ClearEmploymentHistoryFields()
    begin
        Clear(PE1);
        Clear(EMP1);
        Clear(StartDate1);
        Clear(EndDate1);
        Clear(YEAR1);
        Clear(PE2);
        Clear(EMP2);
        Clear(StartDate2);
        Clear(EndDate2);
        Clear(YEAR2);
        Clear(PE3);
        Clear(EMP3);
        Clear(StartDate3);
        Clear(EndDate3);
        Clear(YEAR3);
        Clear(PE4);
        Clear(EMP4);
        Clear(StartDate4);
        Clear(EndDate4);
        Clear(YEAR4);
        Clear(PE5);
        Clear(EMP5);
        Clear(StartDate5);
        Clear(EndDate5);
        Clear(YEAR5);

    end;

    local procedure ClearCurrentlyEmploymentHistoryFields()
    begin
        Clear(StartDate);
        Clear(EndDate);
        Clear(CurrentDesignation);
        Clear(CurrentEmployer);
        Clear(CurrentSectorofEmployment);
        Clear(Years);

    end;

    local procedure ClearApplicantsQualification()
    begin
        Clear(BachelorofOther1);
        Clear(BachelorofOther1Date);
        Clear(BachelorofOther1Ints);
        Clear(BachelorofOther2);
        Clear(BachelorofOther2Date);
        Clear(BachelorofOther2Ints);
        Clear(BachelorofOther3);
        Clear(BachelorofOther3Date);
        Clear(BachelorofOther3Ints);
        Clear(Othercourse4);
        Clear(Othercourse4Date);
        Clear(Othercourse4Ints);
        Clear(Othercourse5);
        Clear(Othercourse5Date);
        Clear(Othercourse5Ints);
        Clear(Grade2);
        Clear(Grade3);
        Clear(Grade1);
        Clear(Grade4);
    end;

    local procedure Clearappbodies()
    begin
        Clear(ProfessionalbodesNo);
        Clear(ProfessionalbodesNo1);
        Clear(ProfessionalBodies);
        Clear(ProfessionalBodies1);
        Clear(ProfessionalBodiesDate);
        Clear(ProfessionalBodiesDate1);
        Clear(ProfessionalBodiesType);
        Clear(ProfessionalBodiesType1);
    end;
}
