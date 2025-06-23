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
                    }
                    grid(OptionsGrid2)
                    {
                        field(ShowGender; ShowGender)
                        {
                            ApplicationArea = All;
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