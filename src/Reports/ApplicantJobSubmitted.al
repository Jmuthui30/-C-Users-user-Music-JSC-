report 52970 "Applicant job Submitted"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ApplicantJob;

    dataset
    {
        dataitem(ApplicantSubmittedJob; "Applicant Submitted Job")
        {
            RequestFilterFields = "Job code", Gender;
            column(Job_code; "Job code") { }
            column(Job_Title; "Job Title") { }
            column(Applicant_Name; "Applicant Name") { }
            column(IDNO; IDNO) { }
            column(Birth_Date; "Birth Date") { }
            column(Age; Age) { }
            column(Gender; Gender) { }
            column(Home_County; "Home County") { }
            column(Ethnic_Group; "Ethnic Group") { }
            column(Sub_Ethnic_Group; "Sub Ethnic Group") { }
            column(Mobile_Phone_No_; "Mobile Phone No.") { }
            column(Alternative_Phone_No_; "Alternative Phone No.") { }
            column(E_Mail; "E-Mail") { }
            column(Disability; Disability) { }
            column(Disability_Description; "Disability Description") { }
            column(NCPWD_Certificate_No_; "NCPWD Certificate No.") { }
            column(Dismissal_Declaration; "Dismissal Declaration") { }
            column(Dismissal_Decl__Specification; "Dismissal Decl. Specification") { }
            column(Physical_Address; "Physical Address") { }
            column(Postal_Address; "Postal Address") { }
            column(Post_Code; "Post Code") { }
            column(City; City) { }
            column(First_Language__R_W_S_; "First Language (R/W/S)") { }
            column(First_Language_Read; "First Language Read") { }
            column(First_Language_Speak; "First Language Speak") { }
            column(First_Language_Write; "First Language Write") { }
            column(Second_Language__R_W_S_; "Second Language (R/W/S)") { }
            column(Second_Language_Read; "Second Language Read") { }
            column(Second_Language_Speak; "Second Language Speak") { }
            column(Second_Language_Write; "Second Language Write") { }
            column(Other_Language__R_W_S_; "Other Language (R/W/S)") { }
            column(Other_Language_Read; "Other Language Read") { }
            column(Other_Language_Speak; "Other Language Speak") { }
            column(Other_Language_Write; "Other Language Write") { }
            column(Employer; Employer) { }
            column(From_Date_Employer; "From Date Employer") { }
            column(To_Date_Employer; "To Date Employer") { }
            column(Designation_Employer; "Designation Employer") { }
            column(Employer_2; "Employer 2") { }
            column(From_Date_Employer_2; "From Date Employer 2") { }
            column(To_Date_Employer_2; "To Date Employer 2") { }
            column(Designation_Employer_2; "Designation Employer 2") { }
            column(Employer_3; "Employer 3") { }
            column(From_Date_Employer_3; "From Date Employer 3") { }
            column(To_Date_Employer_3; "To Date Employer 3") { }
            column(Designation_Employer_3; "Designation Employer 3") { }
            column(Qualification_Code; "Qualification Code") { }
            column(Grade_Class; "Grade/Class") { }
            column(Institution_Company; "Institution/Company") { }
            column(To_Date; "To Date") { }
            column(From_Date; "From Date") { }
            column(Area_of_Specialization; "Area of Specialization") { }
            column(Qualification_Code_2; "Qualification Code 2") { }
            column(Area_of_Specialization_2; "Area of Specialization 2") { }
            column(Institution_Company_2; "Institution/Company 2") { }
            column(To_Date_2; "To Date 2") { }
            column(From_Date_2; "From Date 2") { }
            column(Grade_Class_2; "Grade/Class 2") { }
            column(Qualification_Code_3; "Qualification Code 3") { }
            column(Area_of_Specialization_3; "Area of Specialization 3") { }
            column(Institution_Company_3; "Institution/Company 3") { }
            column(To_Date_3; "To Date 3") { }
            column(From_Date_3; "From Date 3") { }
            column(Grade_Class_3; "Grade/Class 3") { }
            column(Professional_Qualification; "Professional Qualification") { }
            column(Professional_Institution; "Professional Institution") { }
            column(Professional_From_Date; "Professional From Date") { }
            column(Professional_Date_of_Admission; "Professional Date of Admission") { }
            column(Professional_Name; "Professional Name") { }
            column(Professional_Qualification_2; "Professional Qualification 2") { }
            column(Professional_Institution_2; "Professional Institution 2") { }
            column(Professional_From_Date_2; "Professional From Date 2") { }
            column(Professional_Date_of_Admn_2; "Professional Date of Admn 2") { }
            column(Professional_Name_2; "Professional Name 2") { }
            column(Professional_Qualification_3; "Professional Qualification 3") { }
            column(Professional_Institution_3; "Professional Institution 3") { }
            column(Professional_From_Date_3; "Professional From Date 3") { }
            column(Professional_Bodies; "Professional Bodies") { }
            column(Membership_No_; "Membership No.") { }
            column(Admission_Date; "Admission Date") { }
            column(Professional_Bodies_2; "Professional Bodies 2") { }
            column(Membership_No_2; "Membership No. 2") { }
            column(Admission_Date_2; "Admission Date 2") { }
            column(Professional_Bodies_3; "Professional Bodies 3") { }
            column(Membership_No_3; "Membership No. 3") { }
            column(Admission_Date_3; "Admission Date 3") { }
            column(Name_of_the_Course; "Name of the Course") { }
            column(Course_Int; "Course Int") { }
            column(From_Date_course; "From Date course") { }
            column(To_Date_course; "To Date course") { }
            column(Duration_course; "Duration course") { }
            column(Name_of_the_Course_2; "Name of the Course 2") { }
            column(Course_Int_2; "Course Int 2") { }
            column(From_Date_course_2; "From Date course 2") { }
            column(To_Date_course_2; "To Date course 2") { }
            column(Duration_course_2; "Duration course 2") { }
            column(Name_of_the_Course_3; "Name of the Course 3") { }
            column(Course_Int_3; "Course Int 3") { }
            column(From_Date_course_3; "From Date course 3") { }
            column(To_Date_course_3; "To Date course 3") { }
            column(Duration_course_3; "Duration course 3") { }


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
                    recref.GetTable(ApplicantSubmittedJob);
                    FieldRef := recref.Field(arrFieldIds[arrayIndex]);
                    arrFieldValues[arrayIndex] := fieldref.Value();
                end;
            End;


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
                group(GeneralDetails)
                {
                    grid(OptionsGrid)
                    {
                        field(ShowIDNO; ShowIDNO)
                        {
                            ApplicationArea = All;
                            Caption = 'Show ID No.';
                            ToolTip = 'Specifies whether to show the ID No. column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo(IDNO));

                            end;
                        }
                        field(ShowGender; ShowGender)
                        {
                            ApplicationArea = All;
                            caption = 'Gender';
                            ToolTip = 'Specifies whether to show the';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo(Gender));
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

                                InitalizeFieldIds(Appl.FieldNo("Birth Date"));

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
                        field(ShowSubEthnicGroup; ShowSubEthnicGroup)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Sub Ethnic Group';
                            ToolTip = 'Specifies whether to show the Sub Ethnic Group column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Sub Ethnic Group"));
                            end;
                        }


                    }
                    grid(OptionsGrid1)
                    {
                        field(ShowDisability; ShowDisability)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Disability';
                            ToolTip = 'Specifies whether to show the Disability column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo(Disability));

                            end;
                        }
                        field(ShowNCPWD; ShowNCPWD)
                        {
                            ApplicationArea = All;
                            Caption = 'Show NCPWD Certificate No.';
                            ToolTip = 'Specifies whether to show the NCPWD Certificate No. column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("NCPWD Certificate No."));

                            end;
                        }
                        field(ShowDisabilityDescription; ShowDisabilityDescription)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Disability Description';
                            ToolTip = 'Specifies whether to show the Disability Description column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Disability Description"));

                            end;
                        }
                        field(ShowDismissalDeclaration; ShowDismissalDeclaration)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Dismissal Declaration';
                            ToolTip = 'Specifies whether to show the Dismissal Declaration column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Dismissal Declaration"));

                            end;
                        }
                        field(ShowDismissalDeclSpecification; ShowDismissalDeclSpecification)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Dismissal Decl. Specification';
                            ToolTip = 'Specifies whether to show the Dismissal Decl. Specification column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Dismissal Decl. Specification"));

                            end;
                        }

                    }
                    grid(OptionsGrid2)
                    {
                        field(ShowMobile; ShowMobile)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Mobile Phone No.';
                            ToolTip = 'Specifies whether to show the Mobile Phone No. column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Mobile Phone No."));

                            end;
                        }
                        field(ShowEMail; ShowEMail)
                        {
                            ApplicationArea = All;
                            Caption = 'Show E-Mail';
                            ToolTip = 'Specifies whether to show the E-Mail column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("E-Mail"));

                            end;
                        }
                        field(ShowHomeCounty; ShowHomeCounty)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Home County';
                            ToolTip = 'Specifies whether to show the Home County column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Home County"));

                            end;
                        }

                        field(ShowEthnicGroup; ShowEthnicGroup)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Ethnic Group';
                            ToolTip = 'Specifies whether to show the  Ethnic Group column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo
                                ("Ethnic Group"));
                            end;
                        }


                    }

                    grid(OptionsGrid3)
                    {

                        field(ShowPhysicalAddress; ShowPhysicalAddress)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Physical Address';
                            ToolTip = 'Specifies whether to show the Physical Address column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Physical Address"));

                            end;
                        }
                        field(ShowPostAddress; ShowPostAddress)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Postal Address';
                            ToolTip = 'Specifies whether to show the Postal Address column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Postal Address"));

                            end;
                        }
                        field(ShowPostCode; ShowPostCode)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Post Code';
                            ToolTip = 'Specifies whether to show the Post Code column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Post Code"));

                            end;
                        }



                    }
                    grid(OptionsGrid4)
                    {
                        field(showFirstLanguageRWS; showFirstLanguageRWS)
                        {
                            ApplicationArea = All;
                            Caption = 'Show First Language ';
                            ToolTip = 'Specifies whether to show the First Language Read column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("First Language Read"));
                                InitalizeFieldIds(Appl.FieldNo("First Language Speak"));
                                InitalizeFieldIds(Appl.FieldNo("First Language Write"));
                                InitalizeFieldIds(Appl.FieldNo("First Language (R/W/S)"));

                            end;
                        }
                        field(showSecondLanguageRWS; showSecondLanguageRWS)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Second Language ';
                            ToolTip = 'Specifies whether to show the Second Language (R/W/S) column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Second Language (R/W/S)"));
                                InitalizeFieldIds(Appl.FieldNo("Second Language Read"));
                                InitalizeFieldIds(Appl.FieldNo("Second Language Speak"));
                                InitalizeFieldIds(Appl.FieldNo("Second Language Write"));

                            end;
                        }
                        field(showOtherLanguageRWS; showOtherLanguageRWS)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Other Language ';
                            ToolTip = 'Specifies whether to show the Other Language (R/W/S) column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Other Language (R/W/S)"));
                                InitalizeFieldIds(Appl.FieldNo("Other Language Read"));
                                InitalizeFieldIds(Appl.FieldNo("Other Language Speak"));
                                InitalizeFieldIds(Appl.FieldNo("Other Language Write"));

                            end;
                        }

                    }





                }

                group(ACademic)
                {
                    field(ShowACademic; ShowACademic)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Academic Qualification';
                        ToolTip = 'Specifies whether to show the Academic Qualification column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Qualification Code"));
                            InitalizeFieldIds(Appl.FieldNo("From Date"));
                            InitalizeFieldIds(Appl.FieldNo("To Date"));
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization"));
                            initalizeFieldIds(Appl.FieldNo("Institution/Company"));
                            initalizeFieldIds(Appl.FieldNo("Grade/Class"));
                        end;
                    }
                    field(ShowACademic2; ShowACademic2)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Academic Qualification';
                        ToolTip = 'Specifies whether to show the Academic Qualification column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Qualification Code 2"));
                            InitalizeFieldIds(Appl.FieldNo("From Date 2"));
                            InitalizeFieldIds(Appl.FieldNo("To Date 2"));
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization 2"));
                            initalizeFieldIds(Appl.FieldNo("Institution/Company 2"));
                            initalizeFieldIds(Appl.FieldNo("Grade/Class 2"));
                        end;
                    }

                }
                group(Professional)
                {
                    field(ShowProfessional; ShowProfessional)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Professional Qualification';
                        ToolTip = 'Specifies whether to show the Professional Qualification column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Professional Qualification"));
                            InitalizeFieldIds(Appl.FieldNo("Professional From Date"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Date of Admission"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Name"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Institution"));
                        end;
                    }
                    field(ShowProfessional2; ShowProfessional2)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Professional Qualification 2';
                        ToolTip = 'Specifies whether to show the Professional Qualification 2 column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Professional Qualification 2"));
                            InitalizeFieldIds(Appl.FieldNo("Professional From Date 2"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Date of Admn 2"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Name 2"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Institution 2"));

                        end;
                    }
                    field(ShowProfessional3; ShowProfessional3)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Professional Qualification 3';
                        ToolTip = 'Specifies whether to show the Professional Qualification 3 column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Professional Qualification 3"));
                            InitalizeFieldIds(Appl.FieldNo("Professional From Date 3"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Institution 3"));

                        end;
                    }

                }
                group(professionalBodies)
                {
                    field(ShowProfessionalBodies; ShowProfessionalBodies)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Professional Bodies';
                        ToolTip = 'Specifies whether to show the Professional Bodies column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Professional Bodies"));
                            InitalizeFieldIds(Appl.FieldNo("Membership No."));
                            InitalizeFieldIds(Appl.FieldNo("Admission Date"));
                        end;
                    }
                    field(ShowProfessionalBodies2; ShowProfessionalBodies2)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Professional Bodies 2';
                        ToolTip = 'Specifies whether to show the Professional Bodies 2 column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Professional Bodies 2"));
                            InitalizeFieldIds(Appl.FieldNo("Membership No. 2"));
                            InitalizeFieldIds(Appl.FieldNo("Admission Date 2"));

                        end;
                    }
                    field(ShowProfessionalBodies3; ShowProfessionalBodies3)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Professional Bodies 3';
                        ToolTip = 'Specifies whether to show the Professional Bodies 3 column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Professional Bodies 3"));
                            InitalizeFieldIds(Appl.FieldNo("Membership No. 3"));
                            InitalizeFieldIds(Appl.FieldNo("Admission Date 3"));

                        end;
                    }

                }

                group(employmentHistory)
                {

                    field(ShowEmploymentHistory; ShowEmploymentHistory)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Employment History';
                        ToolTip = 'Specifies whether to show the Employment History columns';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo(Employer));
                            InitalizeFieldIds(Appl.FieldNo("From Date Employer"));
                            InitalizeFieldIds(Appl.FieldNo("To Date Employer"));
                            InitalizeFieldIds(Appl.FieldNo("Designation Employer"));


                        end;
                    }
                    field(ShowEmploymentHistory2; ShowEmploymentHistory2)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Employment History 2';
                        ToolTip = 'Specifies whether to show the Employment History 2 columns';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo("Employer 2"));
                            InitalizeFieldIds(Appl.FieldNo("From Date Employer 2"));
                            InitalizeFieldIds(Appl.FieldNo("To Date Employer 2"));
                            InitalizeFieldIds(Appl.FieldNo("Designation Employer 2"));

                        end;
                    }
                    field(ShowEmploymentHistory3; ShowEmploymentHistory3)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Employment History 3';
                        ToolTip = 'Specifies whether to show the Employment History 3 columns';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo("Employer 3"));
                            InitalizeFieldIds(Appl.FieldNo("From Date Employer 3"));
                            InitalizeFieldIds(Appl.FieldNo("To Date Employer 3"));
                            InitalizeFieldIds(Appl.FieldNo("Designation Employer 3"));

                        end;
                    }
                }

                group(relevantCourses)
                {
                    field(ShowRelevantCourse; ShowRelevantCourse)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Relevant Course';
                        ToolTip = 'Specifies whether to show the Relevant Course columns';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo("Name of the Course"));
                            InitalizeFieldIds(Appl.FieldNo("Course Int"));
                            InitalizeFieldIds(Appl.FieldNo("From Date course"));
                            InitalizeFieldIds(Appl.FieldNo("To Date course"));
                            InitalizeFieldIds(Appl.FieldNo("Duration course"));

                        end;
                    }
                    field(ShowRelevantCourse2; ShowRelevantCourse2)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Relevant Course 2';
                        ToolTip = 'Specifies whether to show the Relevant Course 2 columns';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo("Name of the Course 2"));
                            InitalizeFieldIds(Appl.FieldNo("Course Int 2"));
                            InitalizeFieldIds(Appl.FieldNo("From Date course 2"));
                            InitalizeFieldIds(Appl.FieldNo("To Date course 2"));
                            InitalizeFieldIds(Appl.FieldNo("Duration course 2"));

                        end;
                    }
                    field(ShowRelevantCourse3; ShowRelevantCourse3)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Relevant Course 3';
                        ToolTip = 'Specifies whether to show the Relevant Course 3 columns';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo("Name of the Course 3"));
                            InitalizeFieldIds(Appl.FieldNo("Course Int 3"));
                            InitalizeFieldIds(Appl.FieldNo("From Date course 3"));
                            InitalizeFieldIds(Appl.FieldNo("To Date course 3"));
                            InitalizeFieldIds(Appl.FieldNo("Duration course 3"));

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
                Recref.GetTable(ApplicantSubmittedJob);
                fieldref := recref.Field(arrFieldIds[arrayIndex]);
                arrFieldCaptions[arrayIndex] := FieldRef.Caption();
            end;
            Clear(arrayIndex);
            //Nofcolums := 
        end;
    }

    rendering
    {
        layout(ApplicantJob)
        {
            Type = RDLC;
            LayoutFile = './Reports/SSRS/ApplicantJobSumitted_list.RDLC';
            Caption = 'Job Submitted';
        }
    }
    Trigger OnInitReport()
    var
        fieldref: FieldRef;
    Begin
        compinfo.Get();
        Compinfo.CalcFields(compinfo.Picture);
        // Clear(arrayIndex);
        // for arrayIndex := 1 to 20 do begin
        //     Recref.GetTable(HRMJobApplicationsB);
        //     fieldref := recref.Field(arrFieldIds[arrayIndex]);
        //     arrFieldCaptions[arrayIndex] := FieldRef.Caption();
        // end;
        // Clear(arrayIndex);
        //Nofcolums := 0;
    End;

    var

        ShowEmploymentHistory2: Boolean;
        ShowEmploymentHistory3: Boolean;
        showSubEthnicGroup: Boolean;
        showDisabilityDescription: Boolean;
        showDismissalDeclaration: Boolean;
        showDismissalDeclSpecification: Boolean;
        showPhysicalAddress: Boolean;
        showPostCode: Boolean;

        showFirstLanguageRWS: Boolean;

        showSecondLanguageRWS: Boolean;

        showOtherLanguageRWS: Boolean;


        showAlternativePhoneNo: Boolean;
        showMobilePhoneNo: Boolean;
        showNationalityNew: Boolean;

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
        ShowACademic2: Boolean;
        ShowACademic3: Boolean;
        ShowProfessional: Boolean;
        ShowProfessionalBodies: Boolean;
        ShowProfessional1: Boolean;
        ShowProfessionalBodies1: Boolean;
        ShowProfessional2: Boolean;
        ShowProfessionalBodies2: Boolean;
        ShowProfessional3: Boolean;
        ShowProfessionalBodies3: Boolean;


        ShowRelevantCourse: Boolean;
        ShowEmploymentHistory: Boolean;
        ShowRelevantCourse2: Boolean;

        ShowRelevantCourse3: Boolean;
        ShowRelevantCourse4: Boolean;

        arrayIndex: Integer;
        compinfo: Record "Company Information";
        arrlength: Integer;

        arrFieldIds: array[20] of Integer;
        arrFieldCaptions: array[20] of Text;
        arrFieldValues: array[20] of Text;
        Appl: Record "Applicant Submitted Job";
        ApplSubmittedJob: record "Applicant Submitted Job";


    local procedure InitalizeFieldIds(fieldNo: Integer)
    begin
        arrayIndex += 1;
        arrFieldIds[arrayIndex] := fieldNo;
    end;
}