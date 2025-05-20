report 53055 "Applicant Form"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Applicant Form';
    RDLCLayout = './Reports/SSRS/Applicant Form.rdl';
    dataset
    {
        dataitem(Applicant; Applicant)
        {
            RequestFilterFields = "No.";
            column(Position_Applied_For; "Position Applied For") { }
            column(Vacancy_No_; "Vacancy No.") { }
            column(Title; Title)
            {
            }

            column(Personal_Title; "Personal Title") { }
            column(FullName; FullName)
            {
            }
            //column(No_;"No.")
            column(Submitted_Date; "Submitted Date") { }
            column(Birth_Date; "Birth Date")
            {
            }
            column(Age; Age)
            {
            }
            column(VarAge; VarAge) { }
            column(Gender; Gender)
            {
            }
            column(Nationality_Name; "Nationality Name")
            {
            }
            column(National_ID; "National ID")
            {
            }
            column(Postal_Address_new; "Postal Address new") { }
            column(Nationality_New; "Nationality New") { }
            column(Home_County; "Home County")
            {
            }
            column(Ethnic_Group; "Ethnic Group")
            {
            }
            column(Sub_Ethnic_Group; "Sub Ethnic Group")
            { }
            column(Passport_No_; "Passport No.")
            {
            }
            column(Passport_Issue_Date; "Passport Issue Date")
            {
            }
            column(Passport_Expiry_Date; "Passport Expiry Date")
            {
            }
            column(Permit_No_; "Permit No.")
            {
            }
            column(Permit_Issue_Date; "Permit Issue Date")
            {
            }
            column(Permit_Validity_Period; "Permit Validity Period")
            {
            }
            column(Marital_Status; "Marital Status")
            {
            }
            column(First_Language__R_W_S_; "First Language (R/W/S)")
            {
            }
            column(First_Language_Read; "First Language Read")
            {
            }
            column(First_Language_Speak; "First Language Speak")
            {
            }
            column(First_Language_Write; "First Language Write")
            {
            }
            column(Second_Language__R_W_S_; "Second Language (R/W/S)")
            {
            }
            column(Second_Language_Read; "Second Language Read")
            {
            }
            column(Second_Language_Speak; "Second Language Speak")
            {
            }
            column(SecondLanguageSpeak; SecondLanguageSpeak) { }
            column(Second_Language_Write; "Second Language Write")
            {
            }
            column(Other_Language__R_W_S_; "Other Language (R/W/S)") { }
            column(Other_Language_Read; "Other Language Read") { }
            column(Other_Language_Speak; "Other Language Speak") { }
            column(Other_Language_Write; "Other Language Write") { }
            column(Disability; Disability) { }
            column(Disability_Description; "Disability Description")
            {
            }
            column(NCPWD_Certificate_No_; "NCPWD Certificate No.")
            {
            }
            column(Postal_Address; "Postal Address")
            {
            }
            column(Physical_Address; "Physical Address")
            {
            }
            column(Mobile_Phone_No_; "Mobile Phone No.")
            {
            }
            column(Alternative_Phone_No_; "Alternative Phone No.")
            {
            }
            column(E_Mail; "E-Mail")
            {
            }
            column(Current_Employer; "Current Employer")
            {
            }
            column(Sector_Of_Employement; "Sector Of Employement")
            {
            }
            column(Substantive_Post; "Substantive Post")
            {
            }
            column(Employment_No_; "Employment No.")
            {
            }
            column(Effective_Date_of_Employment; "Effective Date of Employment")
            {
            }
            column(Terms_of_Service; "Terms of Service")
            {
            }
            column(Current_Salary; "Current Salary")
            {
            }
            column(Current_Expected_Salary; "Current/Expected Salary")
            {
            }
            column(Criminal_Declaration; "Criminal Declaration") { }
            column(Criminal_Decl__Specification; "Criminal Decl. Specification") { }
            //  column(Disability_Description;"Disability Description"){}
            column(Dismissal_Declaration; "Dismissal Declaration") { }
            column(City; City) { }
            //column()
            //*************************************************Applicants Qualification (51878)
            dataitem("Academic_Prof"; "Applicants Qualification")
            { //SubPageLink = "Employee No." = field("No."), "Qualification Type" = filter(Academic);
                DataItemLink = "Employee No." = field("No.");
                column(Academic_Qualification_Code; "Qualification Code") { }
                column(Academic_Name; Academic_Name) { }
                column(Academic_Qualification; Qualification) { }
                column(Academic_Area_of_Specialization; "Area of Specialization") { }
                column(Academic_Grade_Class; "Grade/Class") { }
                column(Academic_From_Date; "From Date") { }
                column(Academic_To_Date; "To Date") { }
                column(Academic_Qualification_Type; "Qualification Type") { }
                column(Academic_Institution_Company; "Institution/Company") { }
                trigger OnAfterGetRecord()
                var
                    Academic_QUt: Record Qualification;
                begin
                    Academic_QUt.Reset();
                    Academic_QUt.SetRange(Academic_QUt.Code, Academic_Prof."Qualification Code");
                    if Academic_QUt.FindSet then
                        Academic_Name := Academic_QUt.Description;
                end;

            }
            dataitem("REGISTRATION_MEMBERSHIP"; "Applicant Professional Bodies")
            {
                DataItemLink = "Applicant No." = field("No.");
                column(REGISTRATION_Code; Code) { }
                column(REGISTRATION_Membership_Reg_No_; "Membership/Registration No.") { }
                column(REGISTRATION_Date_of_Admission; "Date of Admission") { }
                column(REGISTRATION_Membership_Type; "Membership Type") { }
                column(REGISTRATION_Status; Status) { }

            }
            dataitem("Relevant_Trainings"; "Relevant Courses & Trainings")
            {
                DataItemLink = "Source No" = field("No.");
                column(Relevant_Name_Course; "Name of the Course") { }
                column(Relevant_Institution; "University/College/Institution") { }
                column(RTFrom_Date; "From Date") { }
                column(RTTo_Date; "To Date") { }
                column(Relevant_Duration; Duration) { }
            }
            dataitem("Applicant_Employment"; "Applicant Current Employment")
            {
                DataItemLink = "Applicant No." = field("No.");
                column(Applicant_Employer_Institution_Name; "Employer/Institution Name") { }
                column(Applicant_Sector; Sector) { }
                column(Applicant_Sector_Specification; "Sector Specification") { }
                column(Applicant_AEFrom_Date; "From Date") { }
                column(Applicant_AETo_Date; "To Date") { }
                column(Applicant_Employment_Period; "Employment Period") { }
                column(Applicant_Expected_Salary__KSH_; "Expected Salary (KSH)") { }
                column(Applicant_Gross_Salary__KSH_; "Gross Salary (KSH)") { }
            }
            dataitem("Titles of Sample Writings"; "Titles of Sample Writings")
            {
                DataItemLink = "Source No" = field("No.");
                column(Sample_Title; Title)
                { }
                column(Sample_Attachment_Link; "Attachment Link") { }
            }
            dataitem("SharePoint Intergration"; "SharePoint Intergration")
            {
                DataItemLink = "Document No" = field("No.");
                column(Document_No; "Document No") { }
                column(Description; Description) { }
                column(SP_URL_Returned; SP_URL_Returned) { }
            }
            trigger OnAfterGetRecord()
            begin

                VarAge := HRDatesExt.DetermineDatesDiffrence("Birth Date", Today);

                if Applicant."Second Language Speak" = true then
                    SecondLanguageSpeak := FormatYesNo(Applicant."Second Language Speak");



                // else
                // Applicant."Second Language Speak" := Format('No');


            end;
            // column()
            // {  
            // }column()
            // {  
            // }column()
            // {  
            // }column()
            // {  
            // }column()
            // {  
            // }
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


    }



    var
        myInt: Integer;
        VarAge: Text[100];
        HRDatesExt: Codeunit "HR Dates Mgt";
        VarYes: Label 'Yes';
        SecondLanguageSpeak: Text[100];
        Academic_Name: Text[2000];

    local procedure FormatYesNo(BoolValue: Boolean): Text
    begin
        if BoolValue then
            exit('Yes')
        else
            exit('No');
    end;
}