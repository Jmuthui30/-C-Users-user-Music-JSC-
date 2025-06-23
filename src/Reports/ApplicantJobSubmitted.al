report 52970 "Applicant job Submitted"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = ApplicantJob;

    dataset
    {
        dataitem("Applicant Submitted Job"; "Applicant Submitted Job")
        {
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
                    recref.GetTable(ApplSubmittedJob);
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

                            InitalizeFieldIds(Appl.FieldNo("Birth Date"));

                        end;
                    }
                    field(ShowHomeCounty; ShowHomeCounty)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Home County';
                        ToolTip = 'Specifies whether to show the Date of Birth column';
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
                        ToolTip = 'Specifies whether to show the Date of Birth column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Ethnic Group"));
                        end;
                    }

                    field(ShowDisability; ShowDisability)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Disability';
                        ToolTip = 'Specifies whether to show the Date of Birth column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo(Disability));
                        end;
                    }
                    field(ShowDisabilityDescr; ShowDisability)
                    {
                        ApplicationArea = All;
                        Caption = 'Show Disability Description';
                        ToolTip = 'Specifies whether to show the Date of Birth column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("Disability Description"));
                        end;
                    }
                    field(ShowNCPWD; ShowNCPWD)
                    {
                        ApplicationArea = All;
                        Caption = 'Show NCPWD Certificate No.';
                        ToolTip = 'Specifies whether to show the Date of Birth column';
                        Trigger OnValidate()
                        var
                        begin
                            InitalizeFieldIds(Appl.FieldNo("NCPWD Certificate No."));
                        end;
                    }

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
        layout(ApplicantJob)
        {
            Type = RDLC;
            LayoutFile = './Reports/SSRS/ApplicantJobSumitted_list.RDLC';
            Caption = 'Job Submitted';
        }
    }

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