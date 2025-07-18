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
            //*************************************************************************************Employment History
            column(Employer; Employer) { }
            column(Sector_Of_Employement; "Sector Of Employement") { }
            column(Substantive_Post; "Substantive Post") { }
            column(From_Date_Employer; "From Date Employer") { }
            column(To_Date_Employer; "To Date Employer") { }
            column(Employment_Period; "Employment Period") { }


            //********************************************************************EMployer 2
            column(Employer_2; "Employer 2") { }
            column(Sector_Of_Employement_2; "Sector Of Employement 2") { }

            column(Substantive_Post_2; "Substantive Post 2") { }
            column(From_Date_Employer_2; "From Date Employer 2") { }
            column(To_Date_Employer_2; "To Date Employer 2") { }
            column(Employment_Period_2; "Employment Period 2") { }

            //********************************************************************Employer 3
            column(Employer_3; "Employer 3") { }
            column(Sector_Of_Employement_3; "Sector Of Employement 3") { }
            column(Substantive_Post_3; "Substantive Post 3") { }
            column(From_Date_Employer_3; "From Date Employer 3") { }
            column(To_Date_Employer_3; "To Date Employer 3") { }
            column(Employment_Period_3; "Employment Period 3") { }
            //********************************************************************Employer 4
            column(Employer_4; "Employer 4") { }
            column(Sector_Of_Employement_4; "Sector Of Employement 4") { }
            column(Substantive_Post_4; "Substantive Post 4") { }
            column(From_Date_Employer_4; "From Date Employer 4") { }
            column(To_Date_Employer_4; "To Date Employer 4") { }
            column(Employment_Period_4; "Employment Period 4") { }
            //********************************************************************end of Employer 4
            column(Employer_5; "Employer 5") { }
            column(Sector_Of_Employement_5; "Sector Of Employement 5") { }
            column(Substantive_Post_5; "Substantive Post 5") { }
            column(From_Date_Employer_5; "From Date Employer 5") { }
            column(To_Date_Employer_5; "To Date Employer 5") { }
            column(Employment_Period_5; "Employment Period 5") { }
            //********************************************************************end of Employer 5
            column(Employer_6; "Employer 6") { }
            column(Sector_Of_Employement_6; "Sector Of Employement 6") { }
            column(Substantive_Post_6; "Substantive Post 6") { }
            column(From_Date_Employer_6; "From Date Employer 6") { }
            column(To_Date_Employer_6; "To Date Employer 6") { }
            column(Employment_Period_6; "Employment Period 6") { }
            //********************************************************************end of Employer 6
            column(Employer_7; "Employer 7") { }
            column(Sector_Of_Employement_7; "Sector Of Employement 7") { }
            column(Substantive_Post_7; "Substantive Post 7") { }
            column(From_Date_Employer_7; "From Date Employer 7") { }
            column(To_Date_Employer_7; "To Date Employer 7") { }
            column(Employment_Period_7; "Employment Period 7") { }
            //********************************************************************end of Employer 7
            column(Employer_8; "Employer 8") { }
            column(Sector_Of_Employement_8; "Sector Of Employement 8") { }
            column(Substantive_Post_8; "Substantive Post 8") { }
            column(From_Date_Employer_8; "From Date Employer 8") { }
            column(To_Date_Employer_8; "To Date Employer 8") { }
            column(Employment_Period_8; "Employment Period 8") { }
            //********************************************************************end of Employer 8
            column(Employer_9; "Employer 9") { }
            column(Sector_Of_Employement_9; "Sector Of Employement 9") { }
            column(Substantive_Post_9; "Substantive Post 9") { }
            column(From_Date_Employer_9; "From Date Employer 9") { }
            column(To_Date_Employer_9; "To Date Employer 9") { }
            column(Employment_Period_9; "Employment Period 9") { }
            //********************************************************************end of Employer 9
            column(Employer_10; "Employer 10") { }
            column(Sector_Of_Employement_10; "Sector Of Employement 10") { }
            column(Substantive_Post_10; "Substantive Post 10") { }
            column(From_Date_Employer_10; "From Date Employer 10") { }
            column(To_Date_Employer_10; "To Date Employer 10") { }
            column(Employment_Period_10; "Employment Period 10") { }
            //*************************************************************************************end of Employment History  

            //*************************************************************************************academic qualifications

            //Kenya Certifcate of Advanced Education

            column(Area_of_Specialization; "Area of Specialization") { }
            column(Institution_Company; "Institution/Company") { }
            column(Grade_Class; "Grade/Class") { }
            column(To_Date; "To Date") { }
            column(From_Date; "From Date") { }


            //*************************************************************************************Postgraduate

            //P


            column(Area_of_Specialization_2; "Area of Specialization 2") { }
            column(Institution_Company_2; "Institution/Company 2") { }
            column(To_Date_2; "To Date 2") { }
            column(From_Date_2; "From Date 2") { }
            column(Grade_Class_2; "Grade/Class 2") { }
            //*************************************************************************************Certificate

            //
            column(Area_of_Specialization_3; "Area of Specialization 3") { }
            column(Institution_Company_3; "Institution/Company 3") { }
            column(To_Date_3; "To Date 3") { }
            column(From_Date_3; "From Date 3") { }
            column(Grade_Class_3; "Grade/Class 3") { }
            //*************************************************************************************Diploma


            column(Area_of_Specialization_4; "Area of Specialization 4") { }
            column(Institution_Company_4; "Institution/Company 4") { }
            column(To_Date_4; "To Date 4") { }
            column(From_Date_4; "From Date 4") { }
            column(Grade_Class_4; "Grade/Class 4") { }
            //*************************************************************************************HIGHERDIPLOMA


            column(Area_of_Specialization_5; "Area of Specialization 5") { }
            column(Institution_Company_5; "Institution/Company 5") { }
            column(To_Date_5; "To Date 5") { }
            column(From_Date_5; "From Date 5") { }
            column(Grade_Class_5; "Grade/Class 5") { }
            //*************************************************************************************Degree

            column(Area_of_Specialization_6; "Area of Specialization 6") { }
            column(Institution_Company_6; "Institution/Company 6") { }
            column(To_Date_6; "To Date 6") { }
            column(From_Date_6; "From Date 6") { }
            column(Grade_Class_6; "Grade/Class 6") { }
            //*************************************************************************************Masters
            column(Area_of_Specialization_8; "Area of Specialization 8") { }
            column(Institution_Company_8; "Institution/Company 8") { }
            column(To_Date_8; "To Date 8") { }
            column(From_Date_8; "From Date 8") { }
            column(Grade_Class_8; "Grade/Class 8") { }
            //************************************************************************************PhD (Doctor of Philosophy)

            column(Area_of_Specialization_9; "Area of Specialization 9") { }
            column(Institution_Company_9; "Institution/Company 9") { }
            column(To_Date_9; "To Date 9") { }
            column(From_Date_9; "From Date 9") { }
            column(Grade_Class_9; "Grade/Class 9") { }
            //*************************************************************************************Artisan Certificate

            column(Area_of_Specialization_10; "Area of Specialization 10") { }
            column(Institution_Company_10; "Institution/Company 10") { }
            column(To_Date_10; "To Date 10") { }
            column(From_Date_10; "From Date 10") { }
            column(Grade_Class_10; "Grade/Class 10") { }

            //*************************************************************************************end of academic qualifications

            //*************************************************************************************professional qualifications

            column(Professional_Name; "Professional Name") { }
            column(Area_of_Specialization_PROF; "Area of Specialization PROF") { }
            column(Professional_Institution; "Professional Institution") { }
            column(Professional_From_Date; "Professional From Date") { }
            column(Professional_Date_of_Admission; "Professional Date of Admission") { }
            //*************************************************************************************

            column(Professional_Name_2; "Professional Name 2") { }
            column(Area_of_Specialization_PROF_2; "Area of Specialization PROF 2") { }
            column(Professional_Institution_2; "Professional Institution 2") { }
            column(Professional_From_Date_2; "Professional From Date 2") { }
            column(Professional_Date_of_Admn_2; "Professional Date of Admn 2") { }
            //*************************************************************************************

            column(Professional_Name_3; "Professional Name 3") { }
            column(Area_of_Specialization_PROF_3; "Area of Specialization PROF 3") { }
            column(Professional_Institution_3; "Professional Institution 3") { }

            column(Professional_From_Date_3; "Professional From Date 3") { }
            column(Professional_Date_of_Admn_3; "Professional Date of Admn 3") { }
            //*************************************************************************************

            Column(Professional_Bodies; "Professional Bodies") { }
            Column(Admission_Date; "Admission Date") { }
            Column(Membership_No; "Membership No.") { }
            Column(Professional_Membership_Type; "Professional Membership Type") { }
            //***********************************

            Column(Professional_Bodies_2; "Professional Bodies 2") { }
            Column(Admission_Date_2; "Admission Date 2") { }
            Column(Membership_No__2; "Membership No. 2") { }
            Column(Professional_Membership_Type_2; "Professional Membership Type 2") { }
            //**********************************************************************************

            Column(Professional_Bodies_3; "Professional Bodies 3") { }
            Column(Admission_Date_3; "Admission Date 3") { }
            Column(Membership_No__3; "Membership No. 3") { }
            Column(Professional_Membership_Type_3; "Professional Membership Type 3") { }
            //**********************************************************************************COURSECO

            Column(Name_of_the_Course; "Name of the Course") { }
            Column(Course_Int; "Course Int") { }
            Column(From_Date_course; "From Date course") { }
            Column(To_Date_course; "To Date course") { }
            Column(Duration_course; "Duration course") { }
            //**************************************************************8

            Column(Name_of_the_Course_2; "Name of the Course 2") { }
            Column(Course_Int_2; "Course Int 2") { }
            Column(From_Date_course_2; "From Date course 2") { }
            Column(To_Date_course_2; "To Date course 2") { }
            Column(Duration_course_2; "Duration course 2") { }
            //*************************************************************

            Column(Name_of_the_Course_3; "Name of the Course 3") { }
            Column(Course_Int_3; "Course Int 3") { }
            Column(From_Date_course_3; "From Date course 3") { }
            Column(To_Date_course_3; "To Date course 3") { }
            Column(Duration_course_3; "Duration course 3") { }
            //*************************************************************
            Column(SAMPLE1; SAMPLE1) { }
            Column(SAMPLE2; SAMPLE2) { }
            Column(SAMPLE3; SAMPLE3) { }
            Column(SAMPLE4; SAMPLE4) { }
            Column(SAMPLE5; SAMPLE5) { }
            //*************************************************************


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



                    }
                    grid(OptionsGrid1)
                    {
                        field(ShowDateOfBirth; ShowDateOfBirth)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Date of Birth';
                            ToolTip = 'Specifies whether to show the Date of Birth column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Birth Date"));
                                InitalizeFieldIds(Appl.FieldNo(Age));

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

                    }
                    grid(OptionsGrid2)
                    {
                        field(showMobilePhoneNo; showMobilePhoneNo)
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

                        field(showAlternativePhoneNo; showAlternativePhoneNo)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Alternative Phone No.';
                            ToolTip = 'Specifies whether to show the Alternative Phone No. column';
                            Trigger OnValidate()
                            var
                            begin

                                InitalizeFieldIds(Appl.FieldNo("Alternative Phone No."));

                            end;
                        }
                    }

                    grid(OptionsGrid3)
                    {
                        field(showEmail; showEmail)
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

                        field(showPhysicalAddress; showPhysicalAddress)
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
                    }
                    grid(OptionsGrid4)
                    {
                        field(showPostalAddress; showPostalAddress)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Postal Address';
                            ToolTip = 'Specifies whether to show the Postal Address column';
                            Trigger OnValidate()
                            var
                            begin


                                InitalizeFieldIds(Appl.FieldNo("Post Code"));
                                InitalizeFieldIds(Appl.FieldNo(City));

                            end;
                        }
                        field(showPostCode; showPostCode)
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


                    field(showDisability; showDisability)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Disability';
                        ToolTip = 'Specifies whether to show the Disability column';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo(Disability));
                            InitalizeFieldIds(Appl.FieldNo("Disability Description"));
                            InitalizeFieldIds(Appl.FieldNo("NCPWD Certificate No."));

                        end;
                    }


                    field(showDismissalDeclaration; showDismissalDeclaration)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Dismissal Declaration';
                        ToolTip = 'Specifies whether to show the Dismissal Declaration column';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo("Dismissal Declaration"));
                            InitalizeFieldIds(Appl.FieldNo("Dismissal Decl. Specification"));

                        end;
                    }

                    field(ShowEthnicGroup; ShowEthnicGroup)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Ethnic Group';
                        ToolTip = 'Specifies whether to show the Ethnic Group column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Ethnic Group"));
                            InitalizeFieldIds(Appl.FieldNo("Sub Ethnic Group"));
                        end;
                    }

                    grid(OptionsGrid40)
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



                group(employmentHistory)
                {

                    field(ShowEmploymentHistory; ShowEmploymentHistory)
                    {
                        ApplicationArea = All;
                        Caption = 'Current Employment History';
                        ToolTip = 'Specifies whether to show the Employment History columns';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo(Employer));
                            InitalizeFieldIds(Appl.FieldNo("From Date Employer"));
                            InitalizeFieldIds(Appl.FieldNo("To Date Employer"));
                            InitalizeFieldIds(Appl.FieldNo("Designation Employer"));
                            initalizeFieldIds(Appl.FieldNo("Sector Of Employement"));
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
                            initalizeFieldIds(Appl.FieldNo("Sector Of Employement 2"));

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
                            initalizeFieldIds(Appl.FieldNo("Sector Of Employement 3"));

                        end;
                    }
                    field(ShowEmploymentHistory4; ShowEmploymentHistory4)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Employment History 4';
                        ToolTip = 'Specifies whether to show the Employment History 4 columns';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo("Employer 4"));
                            InitalizeFieldIds(Appl.FieldNo("From Date Employer 4"));
                            InitalizeFieldIds(Appl.FieldNo("To Date Employer 4"));
                            InitalizeFieldIds(Appl.FieldNo("Designation Employer 4"));
                            initalizeFieldIds(Appl.FieldNo("Sector Of Employement 4"));

                        end;
                    }
                    field(ShowEmploymentHistory5; ShowEmploymentHistory5)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Employment History 5';
                        ToolTip = 'Specifies whether to show the Employment History 5 columns';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo("Employer 5"));
                            InitalizeFieldIds(Appl.FieldNo("From Date Employer 5"));
                            InitalizeFieldIds(Appl.FieldNo("To Date Employer 5"));
                            InitalizeFieldIds(Appl.FieldNo("Designation Employer 5"));
                            initalizeFieldIds(Appl.FieldNo("Sector Of Employement 5"));

                        end;
                    }
                    FIELD(ShowEmploymentHistory6; ShowEmploymentHistory6)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Employment History 6';
                        ToolTip = 'Specifies whether to show the Employment History 6 columns';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo("Employer 6"));
                            InitalizeFieldIds(Appl.FieldNo("From Date Employer 6"));
                            InitalizeFieldIds(Appl.FieldNo("To Date Employer 6"));
                            InitalizeFieldIds(Appl.FieldNo("Designation Employer 6"));
                            initalizeFieldIds(Appl.FieldNo("Sector Of Employement 6"));

                        end;
                    }
                    FIELD(ShowEmploymentHistory7; ShowEmploymentHistory7)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Employment History 7';
                        ToolTip = 'Specifies whether to show the Employment History 7 columns';
                        Trigger OnValidate()
                        var
                        begin

                            InitalizeFieldIds(Appl.FieldNo("Employer 7"));
                            InitalizeFieldIds(Appl.FieldNo("From Date Employer 7"));
                            InitalizeFieldIds(Appl.FieldNo("To Date Employer 7"));
                            InitalizeFieldIds(Appl.FieldNo("Designation Employer 7"));
                            initalizeFieldIds(Appl.FieldNo("Sector Of Employement 7"));

                        end;
                    }
                    FIELD(ShowEmploymentHistory8; ShowEmploymentHistory8)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Employment History 8';
                        ToolTip = 'Specifies whether to show the Employment History 8 columns';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Employer 8"));
                            InitalizeFieldIds(Appl.FieldNo("From Date Employer 8"));
                            InitalizeFieldIds(Appl.FieldNo("To Date Employer 8"));
                            InitalizeFieldIds(Appl.FieldNo("Designation Employer 8"));
                            initalizeFieldIds(Appl.FieldNo("Sector Of Employement 8"));
                        end;
                    }
                    FIELD(ShowEmploymentHistory9; ShowEmploymentHistory9)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Employment History 9';
                        ToolTip = 'Specifies whether to show the Employment History 9 columns';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Employer 9"));
                            InitalizeFieldIds(Appl.FieldNo("From Date Employer 9"));
                            InitalizeFieldIds(Appl.FieldNo("To Date Employer 9"));
                            InitalizeFieldIds(Appl.FieldNo("Designation Employer 9"));
                            initalizeFieldIds(Appl.FieldNo("Sector Of Employement 9"));
                        end;
                    }


                }
                group(ACademic)
                {
                    Caption = 'Academic Qualifications';
                    field(ShowACademic; ShowACademic)
                    {
                        ApplicationArea = All;
                        Caption = 'Show KCSE';
                        ToolTip = 'Specifies whether to show the Academic Qualification column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization"));
                            initalizeFieldIds(Appl.FieldNo("Institution/Company"));
                            initalizeFieldIds(Appl.FieldNo("Grade/Class"));
                            InitalizeFieldIds(Appl.FieldNo("From Date"));
                            InitalizeFieldIds(Appl.FieldNo("To Date"));


                        end;
                    }
                    field(ShowACademic2; ShowACademic2)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Postgraduate';
                        ToolTip = 'Specifies whether to show the Academic Qualification column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization 2"));
                            initalizeFieldIds(Appl.FieldNo("Institution/Company 2"));
                            initalizeFieldIds(Appl.FieldNo("Grade/Class 2"));
                            InitalizeFieldIds(Appl.FieldNo("From Date 2"));
                            InitalizeFieldIds(Appl.FieldNo("To Date 2"));

                        end;
                    }
                    field(ShowACademic3; ShowACademic3)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Certificate';
                        ToolTip = 'Specifies whether to show the Academic Qualification column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization 3"));
                            initalizeFieldIds(Appl.FieldNo("Institution/Company 3"));
                            initalizeFieldIds(Appl.FieldNo("Grade/Class 3"));
                            InitalizeFieldIds(Appl.FieldNo("From Date 3"));
                            InitalizeFieldIds(Appl.FieldNo("To Date 3"));


                        end;
                    }
                    field(ShowACademic4; ShowACademic4)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Diploma';
                        ToolTip = 'Specifies whether to show the Academic Qualification column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization 4"));
                            initalizeFieldIds(Appl.FieldNo("Institution/Company 4"));
                            initalizeFieldIds(Appl.FieldNo("Grade/Class 4"));
                            InitalizeFieldIds(Appl.FieldNo("From Date 4"));
                            InitalizeFieldIds(Appl.FieldNo("To Date 4"));


                        end;
                    }
                    field(ShowACademic5; ShowACademic5)
                    {
                        ApplicationArea = All;
                        Caption = 'Show HIGHERDIPLOMA';
                        ToolTip = 'Specifies whether to show the Academic Qualification column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization 5"));
                            initalizeFieldIds(Appl.FieldNo("Institution/Company 5"));
                            initalizeFieldIds(Appl.FieldNo("Grade/Class 5"));
                            InitalizeFieldIds(Appl.FieldNo("From Date 5"));
                            InitalizeFieldIds(Appl.FieldNo("To Date 5"));


                        end;
                    }
                    FIELD(ShowACademic6; ShowACademic6)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Degree';
                        ToolTip = 'Specifies whether to show the Academic Qualification column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization 6"));
                            initalizeFieldIds(Appl.FieldNo("Institution/Company 6"));
                            initalizeFieldIds(Appl.FieldNo("Grade/Class 6"));
                            InitalizeFieldIds(Appl.FieldNo("From Date 6"));
                            InitalizeFieldIds(Appl.FieldNo("To Date 6"));
                        end;
                    }

                    FIELD(ShowACademic8; ShowACademic8)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Masters';
                        ToolTip = 'Specifies whether to show the Academic Qualification column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization 8"));
                            initalizeFieldIds(Appl.FieldNo("Institution/Company 8"));
                            initalizeFieldIds(Appl.FieldNo("Grade/Class 8"));
                            InitalizeFieldIds(Appl.FieldNo("From Date 8"));
                            InitalizeFieldIds(Appl.FieldNo("To Date 8"));

                        end;
                    }
                    FIELD(ShowACademic9; ShowACademic9)
                    {
                        ApplicationArea = All;
                        Caption = 'Show PhD (Doctor of Philosophy)';
                        ToolTip = 'Specifies whether to show the Academic Qualification column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization 9"));
                            initalizeFieldIds(Appl.FieldNo("Institution/Company 9"));
                            initalizeFieldIds(Appl.FieldNo("Grade/Class 9"));
                            InitalizeFieldIds(Appl.FieldNo("From Date 9"));
                            InitalizeFieldIds(Appl.FieldNo("To Date 9"));

                        end;
                    }
                    FIELD(ShowACademic10; ShowACademic10)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Artisan Certificate';
                        ToolTip = 'Specifies whether to show the Academic Qualification column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization 10"));
                            initalizeFieldIds(Appl.FieldNo("Institution/Company 10"));
                            initalizeFieldIds(Appl.FieldNo("Grade/Class 10"));
                            InitalizeFieldIds(Appl.FieldNo("From Date 10"));
                            InitalizeFieldIds(Appl.FieldNo("To Date 10"));

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

                            InitalizeFieldIds(Appl.FieldNo("Professional From Date"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Date of Admission"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Name"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Institution"));
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization PROF"));
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

                            InitalizeFieldIds(Appl.FieldNo("Professional From Date 2"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Date of Admn 2"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Name 2"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Institution 2"));
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization PROF 2"));

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

                            InitalizeFieldIds(Appl.FieldNo("Professional From Date 3"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Date of Admn 3"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Name 3"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Institution 3"));
                            InitalizeFieldIds(Appl.FieldNo("Area of Specialization PROF 3"));

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
                            InitalizeFieldIds(Appl.FieldNo("Professional Code"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Membership Type"));
                        end;
                    }
                    field(ShowProfessionalBodies1; ShowProfessionalBodies1)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Professional Bodies 2';
                        ToolTip = 'Specifies whether to show the Professional Bodies 1 column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Professional Bodies 2"));
                            InitalizeFieldIds(Appl.FieldNo("Membership No. 2"));
                            InitalizeFieldIds(Appl.FieldNo("Admission Date 2"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Code 2"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Membership Type 2"));
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
                            InitalizeFieldIds(Appl.FieldNo("Professional Code 3"));
                            InitalizeFieldIds(Appl.FieldNo("Professional Membership Type 3"));
                        end;


                    }


                }



                group(RelevantCourses)
                {
                    field(ShowRelevantCourse; ShowRelevantCourse)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Relevant Course';
                        ToolTip = 'Specifies whether to show the Relevant Course columns';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Name Course"));
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
                            InitalizeFieldIds(Appl.FieldNo("Name Course 2"));

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
                            InitalizeFieldIds(Appl.FieldNo("Name Course 3"));

                        end;
                    }

                }

                Group(AttachedDoc)
                {
                    Caption = 'Attached Documents';
                    field(showSAMPLE; showSAMPLE)
                    {
                        ApplicationArea = All;
                        Caption = 'Sample';
                        ToolTip = 'Specifies whether to show the Sample 1 column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo(SAMPLE1));
                            InitalizeFieldIds(Appl.FieldNo(SAMPLE2));
                            InitalizeFieldIds(Appl.FieldNo(SAMPLE3));
                            InitalizeFieldIds(Appl.FieldNo(SAMPLE4));
                            InitalizeFieldIds(Appl.FieldNo(SAMPLE5));

                        end;
                    }
                    field(showAUDITEDY; showAUDITEDY)
                    {
                        ApplicationArea = All;
                        Caption = 'AUDITEDY';
                        ToolTip = 'Specifies whether to show the Sample 1 column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo(AUDITEDY1));
                            InitalizeFieldIds(Appl.FieldNo(AUDITEDY2));
                            InitalizeFieldIds(Appl.FieldNo(AUDITEDY3));
                            InitalizeFieldIds(Appl.FieldNo(AUDITEDY4));
                            InitalizeFieldIds(Appl.FieldNo(AUDITEDY5));
                        end;
                    }


                }

                //\end{code}


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
        showSAMPLE: Boolean;
        showAUDITEDY: Boolean;
        ShowEmploymentHistory2: Boolean;
        ShowEmploymentHistory3: Boolean;
        ShowEmploymentHistory4: Boolean;
        ShowEmploymentHistory5: Boolean;
        ShowEmploymentHistory6: Boolean;
        ShowEmploymentHistory7: Boolean;
        ShowEmploymentHistory8: Boolean;
        ShowEmploymentHistory9: Boolean;
        ShowEmploymentHistory10: Boolean;
        showSubEthnicGroup: Boolean;
        showDisabilityDescription: Boolean;
        showDismissalDeclaration: Boolean;
        showDismissalDeclSpecification: Boolean;
        showPhysicalAddress: Boolean;
        showPostCode: Boolean;
        showPostalAddress: Boolean;

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
        ShowACademic4: Boolean;
        ShowACademic5: Boolean;
        ShowACademic6: Boolean;
        ShowACademic7: Boolean;
        ShowACademic8: Boolean;
        ShowACademic9: Boolean;
        ShowACademic10: Boolean;
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