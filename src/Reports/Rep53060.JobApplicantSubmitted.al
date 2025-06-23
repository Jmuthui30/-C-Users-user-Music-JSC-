report 53060 "Job Applicant Submitted"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ApplSub;

    dataset
    {
        dataitem(JobApplicationReg; "Job Application")
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
            column(BachelorofOther1Date; BachelorofOther1Date) { }
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
            dataitem(IntegerTab; Integer)
            {

                column(Number; Number)
                {

                }
                Column(Caption; arrFieldCaptions[Number])
                {

                }
                Column(Dat; arrFieldValues[Number])
                {


                }
                trigger OnPreDataItem()
                begin
                    IntegerTab.SetRange(Number, 1, arrayIndex);
                end;
            }

            Trigger OnAfterGetRecord()
            var
                Recref: RecordRef;
                FieldRef: FieldRef;
            Begin

                Clear(Recref);
                Clear(FieldRef);
                Clear(arrFieldValues);
                Clear(arrayIndex);
                for arrayIndex := 1 to arrlength do begin
                    recref.GetTable(JobApplicationReg);
                    FieldRef := recref.Field(arrFieldIds[arrayIndex]);
                    arrFieldValues[arrayIndex] := fieldref.Value();
                end;
            End;
        }
    }

    requestpage
    {
        AboutTitle = 'Job Applicant Report Options';
        AboutText = 'Select which fields to include in the report output';

        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(ShowGender; ShowGender)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Gender';
                        ToolTip = 'Specifies whether to show the Gender column';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo(Gender));

                        end;
                    }
                    field(ShowAge; ShowAge)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Age';
                        ToolTip = 'Specifies whether to show the Age column';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo(Age));

                        end;
                    }
                    field(ShowDateOfBirth; ShowDateOfBirth)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Date of Birth';
                        ToolTip = 'Specifies whether to show the Date of Birth column';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo("Date of Birth"));

                        end;

                    }
                    field(ShowIDNO; ShowIDNO)
                    {
                        ApplicationArea = All;
                        Caption = 'Show ID No.';
                        ToolTip = 'Specifies whether to show the Date of Birth column';
                        Trigger OnValidate()
                        var
                        begin

#pragma warning disable AL0133
                            // InitalizeFieldIds(Appl.FieldNo());
#pragma warning restore AL0133

                        end;

                    }




                }
            }
        }
        trigger OnQueryClosePage(CloseAction: Action): Boolean
        var
            fieldref: FieldRef;
            Recref: RecordRef;
        Begin
            compinfo.Get();
            Compinfo.CalcFields(compinfo.Picture);
            arrlength := arrayIndex;
            Clear(arrayIndex);
            for arrayIndex := 1 to arrlength do begin
                Recref.GetTable(JobApplicationReg);
                fieldref := recref.Field(arrFieldIds[arrayIndex]);
                arrFieldCaptions[arrayIndex] := FieldRef.Caption();
            end;
            Clear(arrayIndex);
            //Nofcolums := 
        end;
    }

    rendering
    {
        layout(ApplSub)
        {
            Type = RDLC;
            LayoutFile = './Reports/SSRS/ApplJobSumitted_list.RDLC';
            Caption = 'Job Submitted';
        }
    }

    trigger OnInitReport()
    begin


    end;

    var
        // ApplicantApp: Record Applicant;
        [InDataSet]
        ShowGender: Boolean;
        ShowAge: Boolean;
        ShowDateOfBirth: Boolean;
        ShowIDNO: Boolean;
        ShowHomeCounty: Boolean;
        ShowEthnicGroup: Boolean;
        ShowDisability: Boolean;
        ShowNCPWD: Boolean;
        ShowPostAddress: Boolean;
        ShowMobile: Boolean;
        ShowEMail: Boolean;
        ShowACademic: Boolean;
        ShowProfessional: Boolean;
        ShowProfessionalBodies: Boolean;
        ShowRelevantCourse: Boolean;
        ShowEmploymentHistory: Boolean;
        arrayIndex: Integer;
        compinfo: Record "Company Information";
        arrlength: Integer;

        arrFieldIds: array[20] of Integer;
        arrFieldCaptions: array[20] of Text;
        arrFieldValues: array[20] of Text;
        Appl: Record "Job Application";
        //****************************************************************************************************
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

    local procedure InitalizeFieldIds(fieldNo: Integer)
    begin
        arrayIndex += 1;
        arrFieldIds[arrayIndex] := fieldNo;
    end;
}