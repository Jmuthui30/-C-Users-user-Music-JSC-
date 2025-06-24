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
                group(Options)
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

                    grid(OptionsGrid5)
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
                        field(ShowACademic; ShowACademic)
                        {
                            ApplicationArea = All;
                            Caption = 'Show Academic Qualifications';
                            ToolTip = 'Specifies whether to show the Academic Qualifications column';
                            Trigger OnValidate()
                            var
                            begin

                                //InitalizeFieldIds(Appl.FieldNo());

                            end;
                        }
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
        Appl: Record "Applicant Submitted Job";
        ApplSubmittedJob: record "Applicant Submitted Job";


    local procedure InitalizeFieldIds(fieldNo: Integer)
    begin
        arrayIndex += 1;
        arrFieldIds[arrayIndex] := fieldNo;
    end;
}