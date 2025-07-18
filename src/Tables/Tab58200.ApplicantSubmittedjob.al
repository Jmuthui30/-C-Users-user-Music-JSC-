table 58200 "Applicant Submitted Job"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job code"; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(211; "Applicant No."; Code[50])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Job Title"; Text[1000]) { DataClassification = ToBeClassified; }
        field(3; "Applicant Name"; text[1000]) { DataClassification = ToBeClassified; }
        field(4; IDNO; code[20]) { DataClassification = ToBeClassified; }
        field(5; "Birth Date"; Date) { DataClassification = ToBeClassified; }
        field(6; Age; text[50]) { DataClassification = ToBeClassified; }
        field(7; Gender; Enum "Employee Gender")
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Position Applied For"; Text[200])
        {
        }

        field(9; "Postal Address"; Integer)
        {
            Caption = 'Address';
        }

        field(10; "Physical Address"; Text[250])
        {
            Caption = 'Address 2';
        }
        field(11; City; Text[30])
        {
            Caption = 'City';
            trigger OnValidate()
            begin
            end;
        }
        field(12; "Post Code"; Code[20])
        {
            TableRelation = "Post Code".Code;
            trigger OnValidate()
            var
                countyrreg: Record "Post Code";
            begin
            end;
        }
        field(13; "Home County"; Text[30])
        {
            TableRelation = Counties;
        }
        field(16; "Alternative Phone No."; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(17; "Mobile Phone No."; Text[30])
        {
            ExtendedDatatype = PhoneNo;
        }
        field(18; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;
        }


        field(100; "Created Date"; DateTime)
        {
        }
        field(101; "Vacancy No."; Code[20])
        {
        }

        field(222; "Nationality New"; Code[30])
        {
            // OptionMembers = Kenyan,Others;
            TableRelation = "Country/Region".Code;
        }
        field(376; "Ethnic Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(386; "Sub Ethnic Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(103; "Passport Issue Date"; Date)
        {
        }
        field(104; "Passport Expiry Date"; Date)
        {
        }
        field(105; "Permit No."; Code[20])
        {
        }
        field(106; "Permit Issue Date"; Date)
        {
        }
        field(107; "Permit Validity Period"; Date)
        {
            Editable = true;
        }
        field(108; Disability; Boolean)
        {
        }
        field(109; "NCPWD Certificate No."; Code[20])
        {
        }
        field(110; "Criminal Declaration"; Boolean)
        {
            Caption = 'Have you ever been convicted of, or cautioned for, any criminal offence or are any other proceedings pending against you?';

            trigger OnValidate()
            begin
            end;
        }
        field(111; "Criminal Decl. Specification"; Text[250])
        {
            Caption = 'Please Give Details of the case and any penalty for each offence';
        }
        field(112; "Dismissal Declaration"; Boolean)
        {
            Caption = 'Have you ever been dismissed or otherwise removed from the Judicial service, Public Service or other engagement?';

            trigger OnValidate()
            begin
            end;
        }
        field(113; "Dismissal Decl. Specification"; Text[250])
        {
            Caption = 'Please Give Details';
        }

        field(119; "Certificate of Admission"; MediaSet)
        {
            Caption = 'Certificate of Admission to the Roll of Advocates (Where Applicable)';
        }
        field(120; "Final Declaration"; Boolean)
        {
            Caption = 'I certify that the particulars given on this form are correct and understand that any incorrect/misleading information may lead to disqualification/ legal action ';
        }

        field(124; "Disability Description"; Text[2000])
        {
            Caption = 'Description';
        }
        field(125; "Nationality Specification"; Text[50])
        {
        }
        field(126; "Current Salary"; Decimal)
        {
        }
        field(127; "Expected Salary"; Decimal)
        {
        }


        field(282; "Personal Title"; Option)
        {
            OptionCaption = ',Mr,Mrs,Ms,Dr,Prof,Other';
            OptionMembers = ,Mr,Mrs,Ms,Dr,Prof,Other;
        }
        field(302; "First Language (R/W/S)"; Code[100])
        {
            DataClassification = CustomerContent;
            TableRelation = Language.Code;
        }
        field(287; "First Language Read"; Boolean)
        {
        }
        field(288; "First Language Write"; Boolean)
        {
        }
        field(289; "First Language Speak"; Boolean)
        {
        }
        field(303; "Second Language (R/W/S)"; Code[100])
        {
            DataClassification = CustomerContent;
            TableRelation = Language.Code;
        }

        field(290; "Second Language Read"; Boolean)
        {
        }
        field(300; "Second Language Write"; Boolean)
        {
        }
        field(301; "Second Language Speak"; Boolean)
        {
        }


        field(312; "Other Language (R/W/S)"; Code[1000])
        {
            DataClassification = CustomerContent;
            //TableRelation = Language.Code;
        }
        field(313; "Other Language Read"; Boolean)
        {
        }
        field(314; "Other Language Write"; Boolean)
        {
        }
        field(315; "Other Language Speak"; Boolean)
        {
        }

        field(317; "Nationality Name"; Code[100])
        {
            TableRelation = "Country/Region".Code;
        }




        //*************************************************************************Education
        field(22; "Qualification Code"; Code[2000])
        {
            Caption = 'ACademic Code';
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
            end;
        }
        field(25; "Area of Specialization"; Text[1000])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(26; "Institution/Company"; Text[1000])
        {
            Caption = 'Institution';
            DataClassification = ToBeClassified;
        }

        field(27; "Grade/Class"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }
        field(23; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(24; "To Date"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
            end;
        }
        //***************************************************************************************Academ 1
        field(28; "Qualification Code 1"; Code[2000])
        {
            Caption = 'ACademic Code';
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
            end;
        }
        field(20; "From Date 1"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(21; "To Date 1"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
            end;
        }
        field(922; "Area of Specialization 1"; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(923; "Institution/Company 1"; Text[1000])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }
        field(924; "Grade/Class 1"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }


        //***************************************************************************************Academ 2
        field(29; "Qualification Code 2"; Code[2000])
        {
            Caption = 'ACademic Code';
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
            end;
        }
        field(32; "Area of Specialization 2"; Text[1000])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(33; "Institution/Company 2"; Text[1000])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }

        field(34; "Grade/Class 2"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }
        field(30; "From Date 2"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(31; "To Date 2"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
            end;
        }


        //******************************************************************************************Academ 3
        field(35; "Qualification Code 3"; Code[2000])
        {
            Caption = 'ACademic Code';
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
            end;
        }
        field(36; "From Date 3"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(37; "To Date 3"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
            end;
        }

        field(38; "Area of Specialization 3"; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(39; "Institution/Company 3"; Text[1000])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }

        field(40; "Grade/Class 3"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }
        //*********************************************************************** acadec 4
        field(41; "Qualification Code 4"; Code[2000])
        {
            Caption = 'ACademic Code';
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
            end;
        }
        field(42; "From Date 4"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(43; "To Date 4"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
            end;
        }

        field(44; "Area of Specialization 4"; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(45; "Institution/Company 4"; Text[1000])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }

        field(46; "Grade/Class 4"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }
        //****************************************************************************
        //*********************************************************************** acadec 5
        field(541; "Qualification Code 5"; Code[2000])
        {
            Caption = 'ACademic Code';
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
            end;
        }
        field(542; "From Date 5"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(543; "To Date 5"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
            end;
        }

        field(544; "Area of Specialization 5"; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(545; "Institution/Company 5"; Text[1000])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }

        field(546; "Grade/Class 5"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }
        //****************************************************************************
        field(47; "Qualification Code 6"; Text[2000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(48; "From Date 6"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(49; "To Date 6"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
            begin
            end;
        }
        field(50; "Area of Specialization 6"; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(51; "Institution/Company 6"; Text[1000])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }
        field(52; "Grade/Class 6"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }
        //*******************************************************************************************academic 7
        field(53; "Qualification Code 7"; Text[2000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(54; "From Date 7"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(55; "To Date 7"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
            end;
        }
        field(56; "Area of Specialization 7"; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(57; "Institution/Company 7"; Text[1000])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }
        field(58; "Grade/Class 7"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }
        //*******************************************************************************************academic 8
        field(59; "Qualification Code 8"; Text[2000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(760; "From Date 8"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(761; "To Date 8"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
            end;
        }
        field(762; "Area of Specialization 8"; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(963; "Institution/Company 8"; Text[1000])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }
        field(964; "Grade/Class 8"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }
        //*******************************************************************************************academic 9
        field(965; "Qualification Code 9"; Text[2000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(766; "From Date 9"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        field(777; "To Date 9"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
            end;
        }
        field(768; "Area of Specialization 9"; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        FIELD(969; "Institution/Company 9"; Text[1000])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }
        FIELD(970; "Grade/Class 9"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }
        //*******************************************************************************************academic 10
        field(971; "Qualification Code 10"; Text[2000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        FIELD(980; "From Date 10"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        FIELD(981; "To Date 10"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
            end;
        }
        FIELD(982; "Area of Specialization 10"; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        FIELD(983; "Institution/Company 10"; Text[1000])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }
        FIELD(984; "Grade/Class 10"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }
        //*******************************************************************************************academic 11
        field(985; "Qualification Code 11"; Text[2000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        FIELD(986; "From Date 11"; Date)
        {
            Caption = 'From Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            end;
        }
        FIELD(987; "To Date 11"; Date)
        {
            Caption = 'To Date';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
            end;
        }
        FIELD(988; "Area of Specialization 11"; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        FIELD(989; "Institution/Company 11"; Text[1000])
        {
            Caption = 'Institution/Company';
            DataClassification = ToBeClassified;
        }
        FIELD(990; "Grade/Class 11"; Text[1000])
        {
            Caption = 'Grade/Class';
            DataClassification = ToBeClassified;
        }
        //*******************************************************************************************academic END
        field(60; "Professional Qualification"; text[1000]) { DataClassification = ToBeClassified; }
        field(61; "Professional Institution"; text[1000]) { DataClassification = ToBeClassified; }
        field(62; "Professional From Date"; Date) { DataClassification = ToBeClassified; }

        field(63; "Professional To Date"; Date) { DataClassification = ToBeClassified; }
        field(70; "Professional Name"; Text[1000])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(71; "Professional Reg No."; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(78; "Professional Date of Admission"; Date)
        {
            DataClassification = ToBeClassified;
        }

        Field(763; "Area of Specialization PROF"; Text[1000])
        {
            Caption = 'Area of Specialization';
            DataClassification = ToBeClassified;
        }

        //******************************************************************************************** Professional
        field(64; "Professional Qualification 2"; text[1000]) { DataClassification = ToBeClassified; }
        field(65; "Professional Institution 2"; text[1000]) { DataClassification = ToBeClassified; }
        field(66; "Professional From Date 2"; Date) { DataClassification = ToBeClassified; }

        field(67; "Professional To Date 2"; Date) { DataClassification = ToBeClassified; }
        field(92; "Professional Name 2"; Text[1000])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(91; "Professional Reg No. 2"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(98; "Professional Date of Admn 2"; Date)
        {
            DataClassification = ToBeClassified;
        }

        Field(764; "Area of Specialization PROF 2"; Text[1000])
        {
            Caption = 'Area of Specialization';
            DataClassification = ToBeClassified;
        }
        //*********************************************************************************************Profession2
        field(68; "Professional Qualification 3"; text[1000]) { DataClassification = ToBeClassified; }
        field(69; "Professional Institution 3"; text[1000]) { DataClassification = ToBeClassified; }
        field(72; "Professional From Date 3"; Date) { DataClassification = ToBeClassified; }

        field(73; "Professional To Date 3"; Date)
        { DataClassification = ToBeClassified; }
        Field(767; "Area of Specialization PROF 3"; Text[1000])
        {
            Caption = 'Area of Specialization';
            DataClassification = ToBeClassified;
        }
        field(492; "Professional Name 3"; Text[1000])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(498; "Professional Date of Admn 3"; Date)
        {
            DataClassification = ToBeClassified;
        }
        //**************************************************************** professional bodies
        field(781; "Professional Code"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Professional Bodies"; text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Membership No."; code[100])
        {
            DataClassification = ToBeClassified;
        }

        field(82; "Admission Date"; Date) { DataClassification = ToBeClassified; }
        field(79; "Professional Membership Type"; Code[200])
        {
            DataClassification = ToBeClassified;
        }

        //******************************************************************************Professional Bodies 3
        field(782; "Professional Code 2"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(83; "Professional Bodies 2"; text[1000]) { DataClassification = ToBeClassified; }

        field(84; "Membership No. 2"; code[100]) { DataClassification = ToBeClassified; }
        field(85; "Admission Date 2"; Date) { DataClassification = ToBeClassified; }
        field(99; "Professional Membership Type 2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        //******************************************************************************Professional Bodies4
        field(783; "Professional Code 3"; code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(86; "Professional Bodies 3"; text[1000]) { DataClassification = ToBeClassified; }

        field(87; "Membership No. 3"; code[100]) { DataClassification = ToBeClassified; }
        field(88; "Admission Date 3"; Date) { DataClassification = ToBeClassified; }
        field(93; "Professional Membership Type 3"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        //******************************************************************************Relevant  Course
        field(132; "Name of the Course"; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(140; "Name Course"; code[100]) { DataClassification = ToBeClassified; }
        field(141; "Course Int"; text[1000]) { DataClassification = ToBeClassified; }
        field(142; "From Date course"; Date) { DataClassification = ToBeClassified; }
        field(143; "To Date course"; Date) { DataClassification = ToBeClassified; }
        field(144; "Duration course"; text[1000]) { DataClassification = ToBeClassified; }
        //******************************************************************************Relevant  Course2

        field(131; "Name of the Course 2"; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(145; "Name Course 2"; code[100]) { DataClassification = ToBeClassified; }
        field(146; "Course Int 2"; text[1000]) { DataClassification = ToBeClassified; }
        field(147; "From Date course 2"; Date) { DataClassification = ToBeClassified; }
        field(148; "To Date course 2"; Date) { DataClassification = ToBeClassified; }
        field(149; "Duration course 2"; text[1000]) { DataClassification = ToBeClassified; }
        //******************************************************************************Relevant  Course 3

        field(133; "Name of the Course 3"; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(150; "Name Course 3"; code[100]) { DataClassification = ToBeClassified; }
        field(151; "Course Int 3"; text[1000]) { DataClassification = ToBeClassified; }
        field(152; "From Date course 3"; Date) { DataClassification = ToBeClassified; }
        field(153; "To Date course 3"; Date) { DataClassification = ToBeClassified; }
        field(154; "Duration course 3"; text[1000]) { DataClassification = ToBeClassified; }
        //*******************************************************************************************employee

        field(305; "Sector Of Employement"; Option)
        {
            OptionCaption = 'Public,Private,Academia,Corporate,Others;';
            OptionMembers = Public,Private,Academia,Corporate,Others;
        }
        field(307; "Substantive Post"; Text[2048])
        {
        }
        field(328; "Employment Period"; Text[500])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(170; "Employer"; code[100]) { DataClassification = ToBeClassified; }
        field(171; "Designation Employer"; code[100]) { DataClassification = ToBeClassified; }
        field(172; "From Date Employer"; Date) { DataClassification = ToBeClassified; }
        field(173; "To Date Employer"; Date) { DataClassification = ToBeClassified; }
        field(308; "Current Employer"; boolean)
        {
            DataClassification = ToBeClassified;
        }
        //*******************************************************************************************employee
        field(174; "Employer 2"; code[100]) { DataClassification = ToBeClassified; }
        field(175; "Designation Employer 2"; code[100]) { DataClassification = ToBeClassified; }
        field(176; "From Date Employer 2"; Date) { DataClassification = ToBeClassified; }
        field(177; "To Date Employer 2"; Date) { DataClassification = ToBeClassified; }
        field(337; "Substantive Post 2"; Text[2048])
        {
        }
        field(338; "Employment Period 2"; Text[500])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(375; "Sector Of Employement 2"; Option)
        {
            OptionCaption = ',Public,Private,Academia,Corporate,Others (Specify),';
            OptionMembers = ,Public,Private,Academia,Corporate,Others;
        }

        //*******************************************************************************************employee
        field(178; "Employer 3"; code[100]) { DataClassification = ToBeClassified; }
        field(179; "Designation Employer 3"; code[100]) { DataClassification = ToBeClassified; }
        field(182; "From Date Employer 3"; Date) { DataClassification = ToBeClassified; }
        field(183; "To Date Employer 3"; Date) { DataClassification = ToBeClassified; }
        field(347; "Substantive Post 3"; Text[2048])
        {
        }
        field(348; "Employment Period 3"; Text[500])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(385; "Sector Of Employement 3"; Option)
        {
            OptionCaption = ',Public,Private,Academia,Corporate,Others (Specify),';
            OptionMembers = ,Public,Private,Academia,Corporate,Others;
        }

        //*******************************************************************************************employee
        field(180; "Employer 4"; code[100]) { DataClassification = ToBeClassified; }
        field(181; "Designation Employer 4"; code[100]) { DataClassification = ToBeClassified; }
        field(184; "From Date Employer 4"; Date) { DataClassification = ToBeClassified; }
        field(185; "To Date Employer 4"; Date) { DataClassification = ToBeClassified; }
        field(377; "Substantive Post 4"; Text[2048])
        {
        }
        field(349; "Employment Period 4"; Text[500])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(395; "Sector Of Employement 4"; Option)
        {
            OptionCaption = ',Public,Private,Academia,Corporate,Others (Specify),';
            OptionMembers = ,Public,Private,Academia,Corporate,Others;
        }
        //*************************************************************************************************************5
        field(186; "Employer 5"; code[100]) { DataClassification = ToBeClassified; }
        field(187; "Designation Employer 5"; code[100]) { DataClassification = ToBeClassified; }
        field(188; "From Date Employer 5"; Date) { DataClassification = ToBeClassified; }
        field(189; "To Date Employer 5"; Date) { DataClassification = ToBeClassified; }
        field(397; "Substantive Post 5"; Text[2048])
        {
        }
        field(350; "Employment Period 5"; Text[500])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(398; "Sector Of Employement 5"; Option)
        {
            OptionCaption = ',Public,Private,Academia,Corporate,Others (Specify),';
            OptionMembers = ,Public,Private,Academia,Corporate,Others;
        }
        //*******************************************************************************************employee 6
        field(190; "Employer 6"; code[100]) { DataClassification = ToBeClassified; }
        field(191; "Designation Employer 6"; code[100]) { DataClassification = ToBeClassified; }
        field(192; "From Date Employer 6"; Date) { DataClassification = ToBeClassified; }
        field(193; "To Date Employer 6"; Date) { DataClassification = ToBeClassified; }
        field(399; "Substantive Post 6"; Text[2048])
        {
        }
        field(351; "Employment Period 6"; Text[500])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(400; "Sector Of Employement 6"; Option)
        {
            OptionCaption = ',Public,Private,Academia,Corporate,Others (Specify),';
            OptionMembers = ,Public,Private,Academia,Corporate,Others;
        }
        //*******************************************************************************************employee 7
        field(194; "Employer 7"; code[100]) { DataClassification = ToBeClassified; }
        field(195; "Designation Employer 7"; code[100]) { DataClassification = ToBeClassified; }
        field(196; "From Date Employer 7"; Date) { DataClassification = ToBeClassified; }
        field(197; "To Date Employer 7"; Date) { DataClassification = ToBeClassified; }
        field(401; "Substantive Post 7"; Text[2048])
        {
        }
        field(352; "Employment Period 7"; Text[500])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(402; "Sector Of Employement 7"; Option)
        {
            OptionCaption = ',Public,Private,Academia,Corporate,Others (Specify),';
            OptionMembers = ,Public,Private,Academia,Corporate,Others;
        }
        //*******************************************************************************************employee 8
        field(198; "Employer 8"; code[100]) { DataClassification = ToBeClassified; }
        field(199; "Designation Employer 8"; code[100]) { DataClassification = ToBeClassified; }
        field(200; "From Date Employer 8"; Date) { DataClassification = ToBeClassified; }
        field(201; "To Date Employer 8"; Date) { DataClassification = ToBeClassified; }
        field(403; "Substantive Post 8"; Text[2048])
        {
        }
        field(353; "Employment Period 8"; Text[500])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(404; "Sector Of Employement 8"; Option)
        {
            OptionCaption = ',Public,Private,Academia,Corporate,Others (Specify),';
            OptionMembers = ,Public,Private,Academia,Corporate,Others;
        }
        //*******************************************************************************************employee 9
        field(202; "Employer 9"; code[100]) { DataClassification = ToBeClassified; }
        field(203; "Designation Employer 9"; code[100]) { DataClassification = ToBeClassified; }
        field(204; "From Date Employer 9"; Date) { DataClassification = ToBeClassified; }
        field(205; "To Date Employer 9"; Date) { DataClassification = ToBeClassified; }
        field(405; "Substantive Post 9"; Text[2048])
        {
        }
        field(354; "Employment Period 9"; Text[500])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(406; "Sector Of Employement 9"; Option)
        {
            OptionCaption = ',Public,Private,Academia,Corporate,Others (Specify),';
            OptionMembers = ,Public,Private,Academia,Corporate,Others;
        }
        //*******************************************************************************************employee 10
        field(206; "Employer 10"; code[100]) { DataClassification = ToBeClassified; }
        field(207; "Designation Employer 10"; code[100]) { DataClassification = ToBeClassified; }
        field(208; "From Date Employer 10"; Date) { DataClassification = ToBeClassified; }
        field(209; "To Date Employer 10"; Date) { DataClassification = ToBeClassified; }
        field(407; "Substantive Post 10"; Text[2048])
        {
        }
        field(355; "Employment Period 10"; Text[500])
        {
            trigger OnValidate()
            begin
            end;
        }
        field(408; "Sector Of Employement 10"; Option)
        {
            OptionCaption = ',Public,Private,Academia,Corporate,Others (Specify),';
            OptionMembers = ,Public,Private,Academia,Corporate,Others;
        }

        //*******************************************************************************************employee END    

        field(320; "Submitted Date"; Date)
        {
        }
        field(321; "Submitted Time"; Time)
        {
        }
        field(322; "Recruitment Needs NO"; Code[100])
        {
        }
        field(224; "Date-Time Created"; DateTime)
        {
            Caption = 'Date-Time Created';
            Editable = false;
        }
        field(225; Submitted; Boolean)
        {
            Caption = 'Submitted';
        }
        field(226; "Job Applied Code"; Code[50])
        {
            Caption = 'Job Applied Code';
            trigger OnValidate()
            var
            begin

            end;
        }
        field(90; "Marital Status"; Enum MaritalStatus)
        {
        }
        field(89; "Passport No."; Code[10])
        {
        }
        field(254; "Years Of Experience"; Decimal)
        {
        }
        FIELD(255; "SAMPLE1"; Text[1000])
        {
            Caption = 'SAMPLE1';
            DataClassification = ToBeClassified;
        }
        field(256; "SAMPLE2"; Text[1000])
        {
            Caption = 'SAMPLE2';
            DataClassification = ToBeClassified;
        }
        field(257; "SAMPLE3"; Text[1000])
        {
            Caption = 'SAMPLE3';
            DataClassification = ToBeClassified;
        }
        field(258; "SAMPLE4"; Text[1000])
        {
            Caption = 'SAMPLE4';
            DataClassification = ToBeClassified;
        }
        field(259; "SAMPLE5"; Text[1000])
        {
            Caption = 'SAMPLE5';
            DataClassification = ToBeClassified;
        }
        field(260; "AUDITEDY1"; Text[1000])
        {
            Caption = 'AUDITEDY1';
            DataClassification = ToBeClassified;
        }
        field(261; "AUDITEDY2"; Text[1000])
        {
            Caption = 'AUDITEDY2';
            DataClassification = ToBeClassified;
        }
        field(262; "AUDITEDY3"; Text[1000])
        {
            Caption = 'AUDITEDY3';
            DataClassification = ToBeClassified;
        }
        field(263; "AUDITEDY4"; Text[1000])
        {
            Caption = 'AUDITEDY4';
            DataClassification = ToBeClassified;
        }
        field(264; "AUDITEDY5"; Text[1000])
        {
            Caption = 'AUDITEDY5';
            DataClassification = ToBeClassified;
        }








    }

    keys
    {
        key(Key1; "Job code")
        {
            Clustered = true;
        }
        key(Key2; "Job Title", "Applicant Name", "Applicant No.")
        {
        }


    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}