table 50023 "Applicant Current Employment"
{
    LookupPageId = "Applicant Current Employment";
    DrillDownPageId = "Applicant Current Employment";

    fields
    {
        field(1; "Applicant No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Applicant."No.";
            NotBlank = true;
        }
        field(2; "From Date"; Date)
        {
            Caption = 'Effective Day of Employment';
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
                If (("From Date" <> 0D) and ("To Date" <> 0D)) then "Employment Period" := Dates.DetermineDatesDiffrence("From Date", "To Date");
                If (("From Date" <> 0D) and "Currently Employment") then "Employment Period" := Dates.DetermineDatesDiffrence("From Date", WorkDate);
            end;
        }
        field(3; "To Date"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;


            trigger OnValidate()
            var
                Error001: Label 'Kindly note To Date %1 cannot be previous From Date %2';
            begin
                /// if "To Date" <= "From Date" then
                //   Error(Error001, "To Date", "From Date");
                // Validate("From Date");
                "Employment Period" := Dates.DetermineDatesDiffrence("From Date", "To Date")
            end;
        }
        field(4; "Employer/Institution Name"; Text[150])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(5; "Postal Address"; Text[400])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Address 2"; Text[400])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Substantive Post"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Key Experience"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Gross Salary (KSH)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Reason For Leaving"; Text[1500])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Comment; Text[2000])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Currently Employment"; Boolean)
        {
            DataClassification = ToBeClassified;
            // trigger OnValidate()
            // var
            //     WorkExperience: Record "Applicant Work Experience";
            // begin
            //     if "Currently Employment" then begin
            //         WorkExperience.Reset();
            //         WorkExperience.SetRange("Applicant No.", "Applicant No.");
            //         WorkExperience.SetRange("Currently Employment", true);
            //         if WorkExperience.FindFirst() then begin
            //             WorkExperience."Currently Employment" := false;
            //             WorkExperience.Modify(true);
            //         end;
            //     end;
            // end;
        }
        field(18; Sector; Option)
        {
            OptionMembers = Public,Private,Academia,Corporate,Others;

            trigger OnValidate()
            begin
                If Sector <> Sector::Others then "Sector Specification" := '';
            end;
        }
        field(19; "Sector Specification"; Text[500])
        {
        }
        field(20; "Employment No."; Code[200])
        {
        }
        field(21; "Job Grade"; Code[200])
        {
            //TableRelation = "Salary Scales";
        }
        field(22; "Terms of Service"; Enum TermsOfService)
        {
            //OptionMembers = Pensionable,Contract,Others;
            trigger OnValidate()
            begin
                If Rec."Terms of Service" <> Rec."Terms of Service"::Others then "Terms of Service Specfication" := '';
            end;
        }
        field(23; "Terms of Service Specfication"; Text[500])
        {
        }
        field(24; "Expected Salary (KSH)"; Decimal)
        {
        }
        field(25; "Employment Period"; Text[500])
        {
            trigger OnValidate()
            begin
                // dayJ:=Date2DMY(ToDate, 1);
                "Employment Period" := Dates.DetermineDatesDiffrence("From Date", "To Date")
            end;
        }
        field(26; "Testimonial Link"; Text[1250])
        {
        }
        field(27; "Line No"; Integer)
        {

        }
        field(28; Number; Integer) { }
    }
    keys
    {
        key(Key1; "Applicant No.", "Employer/Institution Name", "Currently Employment", "Line No")
        {
        }
    }
    var
        Dates: Codeunit "HR Dates Mgt";
        LoginMgmt: Codeunit "QuantumJumps User Management";
}
