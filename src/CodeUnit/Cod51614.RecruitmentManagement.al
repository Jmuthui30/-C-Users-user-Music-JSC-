codeunit 51614 "Recruitment Management"
{
    [ServiceEnabled]
    procedure CreateRecruitmentNeed(var Request: Record "Recruitment Request")
    begin
        if Confirm(StrSubstNo(Text000, Request."No."), false) = true then begin
            Request.TestField(Request.Status, Request.Status::Released);
            RequestLines.Reset();
            RequestLines.SetRange("No.", Request."No.");
            if RequestLines.FindSet() then begin
                repeat
                    RecruitmentNeed.Init();
                    RecruitmentNeed.Validate("Job ID", RequestLines.Position);
                    RecruitmentNeed.Positions := RequestLines."Approved Positions";
                    RecruitmentNeed."Start Date" := RequestLines."Expected Start Date";
                until RequestLines.Next() = 0;
            end;
            Request.Advertised := true;
            if Confirm(StrSubstNo(Text001), false) then begin
                Page.Run(Page::"New Req. Request Header", RecruitmentNeed);
            end
            else begin
                exit;
            end;
        end
        else begin
            exit;
        end;
    end;

    procedure CreateRecruitmentNeedNew(var Request: Record "Recruitment Needs")
    begin
        if Confirm(StrSubstNo(Text000, Request."No."), false) = true then begin
            Request.TestField(Request.Status, Request.Status::Released);
            //RequestLines.Reset();
            //RequestLines.SetRange("No.", Request."No.");
            //if RequestLines.FindSet() then begin
            //repeat
            //RecruitmentNeed.Init();
            //RecruitmentNeed.Validate("Job ID", RequestLines.Position);
            //RecruitmentNeed.Positions := RequestLines."Approved Positions";
            //RecruitmentNeed."Start Date" := RequestLines."Expected Start Date";
            //until RequestLines.Next() = 0;
            //end;
            Request.Advertised := true;
            Request.Modify(true);
            //if Confirm(StrSubstNo(Text001), false) then begin
            //Page.Run(Page::"New Req. Request Header", RecruitmentNeed);
            //end else begin
            // exit;
            //end;
            //end else begin
            //exit;
        end;
    end;

    procedure StaffJobApplication(var RecruitmentNeed: Record "Recruitment Needs")
    begin
        if UserSetup.Get(UserId) then begin
            Emp.Reset();
            Emp.SetRange("No.", UserSetup."Employee No.");
            If Emp.Find('-') then begin
                Emp.Validate("Recruitment Need", RecruitmentNeed."No.");
                Emp.Modify(true);
                Page.Run(Page::"Staff Applicant Card", Emp);
            end
            else
                Error(Text010);
        end;
    end;

    procedure SubmitStaffApplication(var Emp: Record Employee)
    begin
        Applicant2.Reset();
        Applicant2.Setrange("Vacancy No.", Emp."Recruitment Need");
        Applicant2.SetRange("Applicant Type", Applicant2."Applicant Type"::Internal);
        Applicant2.SetRange("Staff ID", Emp."No.");
        if Applicant2.FindFirst() = false then begin
            CreateStaffApplicantCard(Emp);
            Message(Text012);
        end
        else
            Error(Text011);
    end;

    procedure Shortlisting(var RecruitmentNeed: Record "Recruitment Needs")
    begin
        Re_Shortlist(RecruitmentNeed);
        if RecruitmentNeed."Stage Code" <> '' then begin
            StageShortlist.Reset;
            StageShortlist.SetRange("Vacancy No.", RecruitmentNeed."No.");
            StageShortlist.SetRange("Stage Code", RecruitmentNeed."Stage Code");
            StageShortlist.DeleteAll;
            Applicants.Reset;
            Applicants.SetRange("Vacancy No.", RecruitmentNeed."No.");
            Applicants.SetRange("Offer Status", Applicants."Offer Status"::Applicant);
            Applicants.SetRange(Shortlisting, Applicants.Shortlisting::Open);
            Applicants.SetRange(Interview, Applicants.Interview::" ");
            if Applicants.Find('-') then begin
                Qualified_Var := false;
                repeat
                    ShortListCriteria.Reset;
                    ShortListCriteria.SetRange("Vacancy No.", RecruitmentNeed."No.");
                    ShortListCriteria.SetRange("Stage Code", RecruitmentNeed."Stage Code");
                    if ShortListCriteria.Find('-') then begin
                        StageScore := 0;
                        ShortlistingScore := 0;
                        repeat
                            AppQualifications.Reset;
                            AppQualifications.SetRange("Employee No.", Applicants."No.");
                            AppQualifications.SetRange("Qualification Type", ShortListCriteria."Qualification Type");
                            AppQualifications.SetRange("Qualification Code", ShortListCriteria.Qualification);
                            if AppQualifications.FindFirst() then begin
                                Qualified_Var := true;
                                StageScore := StageScore + AppQualifications."Score ID";
                                ShortlistingScore := ShortlistingScore + ShortListCriteria."Desired Score";
                            end;
                        until ShortListCriteria.Next = 0;
                    end;
                    if Qualified_Var = true then begin
                        StageShortlist.Init();
                        StageShortlist."Vacancy No." := RecruitmentNeed."No.";
                        StageShortlist."Stage Code" := RecruitmentNeed."Stage Code";
                        StageShortlist.Applicant := Applicants."No.";
                        StageShortlist."Stage Score" := StageScore;
                        if StageScore < ShortlistingScore then
                            StageShortlist.Qualified := false
                        else
                            StageShortlist.Qualified := true;
                        StageShortlist."First Name" := Applicants."First Name";
                        StageShortlist."Middle Name" := Applicants."Middle Name";
                        StageShortlist."Last Name" := Applicants."Last Name";
                        StageShortlist.Gender := Applicants.Gender;
                        if ApplicantMaster.Get(Applicants."No.") then begin
                            StageShortlist."ID No" := ApplicantMaster."ID Number";
                            StageShortlist."Marital Status" := ApplicantMaster."Marital Status";
                        end;
                        StageShortlist.Insert;
                    end;
                until Applicants.Next = 0;
            end;
            RecCount := 0;
            MyCount := -1;
            StageShortlist.Reset;
            StageShortlist.SetRange("Vacancy No.", RecruitmentNeed."No.");
            StageShortlist.SetRange("Stage Code", RecruitmentNeed."Stage Code");
            if StageShortlist.Find('-') then begin
                RecCount := StageShortlist.Count;
                StageShortlist.SetCurrentKey(StageShortlist."Stage Score");
                StageShortlist.Ascending;
                repeat
                    MyCount := MyCount + 1;
                    PositionCount := RecCount - MyCount;
                    StageShortlist.Position := PositionCount;
                    StageShortlist.Modify;
                until StageShortlist.Next = 0;
            end;
            if Qualified_Var = true then
                Message(Text002)
            else
                Error(StrSubstNo(Text004, RecruitmentNeed."No."));
        end
        else
            Error(Text003);
    end;

    procedure AssignInterviewers(var RecruitmentNeed: Record "Recruitment Needs")
    begin
        RecruitmentNeed.TestField("Interview Committee");
        Applicant.Reset;
        Applicant.SetRange(Shortlisting, Applicant.Shortlisting::Passed);
        Applicant.SetRange(Interview, Applicant.Interview::" ");
        Applicant.SetRange("Offer Status", Applicant."Offer Status"::Applicant);
        Applicant.SetRange("Vacancy No.", RecruitmentNeed."No.");
        if Applicant.FindSet then begin
            repeat
                LineNo := 1000;
                //Delete Existing Lines
                Interview.Reset;
                Interview.SetRange("Vacancy No.", RecruitmentNeed."No.");
                Interview.SetRange("Applicant No", Applicant."No.");
                Interview.DeleteAll;
                CommitteeMembers.Reset;
                CommitteeMembers.SetRange(Committee, RecruitmentNeed."Interview Committee");
                if CommitteeMembers.FindSet then
                    repeat begin
                        //Add Interviewers Lines
                        Interview.Init;
                        Interview."Line No." := LineNo;
                        Interview."Applicant No" := Applicant."No.";
                        Interview.Interviewer := CommitteeMembers.Code;
                        Interview."Interviewer Name" := CommitteeMembers.SurName + ' ' + CommitteeMembers.OtherNames;
                        Interview."Vacancy No." := RecruitmentNeed."No.";
                        Interview.Insert(true);
                        LineNo := LineNo + 100;
                    end;
                    until CommitteeMembers.Next = 0;
            until Applicant.Next = 0;
            Message(Text005);
        end
        else
            Error(Text006);
    end;

    procedure GetQualifiedInterviewees(var RecruitmentNeed: Record "Recruitment Needs")
    begin
        RecruitmentNeed.TestField("Stage Code");
        //Delete Existing Lines
        InterviewStage.Reset;
        InterviewStage.SetRange("Vacancy No.", RecruitmentNeed."No.");
        InterviewStage.SetRange("Stage Code", RecruitmentNeed."Stage Code");
        InterviewStage.DeleteAll;
        GetNoOFInterviewers(RecruitmentNeed);
        Applicant.Reset;
        Applicant.SetRange(Shortlisting, Applicant.Shortlisting::Passed);
        Applicant.SetRange(Interview, Applicant.Interview::" ");
        Applicant.SetRange("Offer Status", Applicant."Offer Status"::Applicant);
        Applicant.SetRange("Vacancy No.", RecruitmentNeed."No.");
        if Applicant.FindSet then begin
            repeat
                Interview.Reset;
                Interview.SetRange("Vacancy No.", RecruitmentNeed."No.");
                Interview.SetRange("Applicant No", Applicant."No.");
                if Interview.FindSet then Interview.TestField(Marks);
                Applicant.CalcFields("Total Interview Marks");
                if Applicant."Total Interview Marks" <> 0 then begin
                    InterviewStage.Init;
                    InterviewStage."Vacancy No." := RecruitmentNeed."No.";
                    InterviewStage."Stage Code" := RecruitmentNeed."Stage Code";
                    InterviewStage.Applicant := Applicant."No.";
                    InterviewStage."Stage Score" := Round(Applicant."Total Interview Marks" / NoOfInterviewers, 0.05);
                    InterviewStage.Qualified := true;
                    InterviewStage."First Name" := Applicant."First Name";
                    InterviewStage."Middle Name" := Applicant."Middle Name";
                    InterviewStage."Last Name" := Applicant."Last Name";
                    InterviewStage.Gender := Applicant.Gender;
                    if ApplicantMaster.Get(Applicant."No.") then begin
                        InterviewStage."ID No" := ApplicantMaster."ID Number";
                        InterviewStage."Marital Status" := ApplicantMaster."Marital Status";
                    end;
                    InterviewStage.Insert(true);
                end;
            until Applicant.Next = 0;
            PositionCounter := 0;
            MyCounter := -1;
            RecCount := 0;
            InterviewStage.Reset;
            InterviewStage.SetRange(InterviewStage."Vacancy No.", RecruitmentNeed."No.");
            InterviewStage.SetRange(InterviewStage."Stage Code", RecruitmentNeed."Stage Code");
            if InterviewStage.FindSet then begin
                RecCount := InterviewStage.Count;
                InterviewStage.SetCurrentKey(InterviewStage."Stage Score");
                InterviewStage.Ascending;
                repeat
                    MyCounter := MyCounter + 1;
                    PositionCounter := RecCount - MyCounter;
                    InterviewStage.Position := PositionCounter;
                    if PositionCounter <= RecruitmentNeed.Positions then begin
                        InterviewStage.Qualified := true;
                        if Applicant.Get(InterviewStage.Applicant) then begin
                            Applicant.Interview := Applicant.Interview::Passed;
                            Applicant.Modify;
                        end;
                    end
                    else if PositionCounter > RecruitmentNeed.Positions then begin
                        InterviewStage.Qualified := false;
                        if Applicant.Get(InterviewStage.Applicant) then begin
                            Applicant.Interview := Applicant.Interview::Failed;
                            Applicant.Modify;
                        end;
                    end;
                    InterviewStage.Modify;
                until InterviewStage.Next = 0;
            end;
            Message('%1', 'Interview Competed Successfully.');
        end
        else
            Message('There was No Applicant Shortlisted for the Interview');
    end;

    local procedure GetNoOFInterviewers(var Need: Record "Recruitment Needs")
    begin
        CommitteeMembers.Reset;
        CommitteeMembers.SetRange(Committee, Need."Interview Committee");
        NoOfInterviewers := CommitteeMembers.Count;
    end;

    procedure Re_Shortlist(Need: Record "Recruitment Needs")
    begin
        Applicant.Reset();
        Applicant.SetRange("Vacancy No.", Need."No.");
        If Applicant.FindSet() then begin
            repeat
                Applicant.Shortlisting := Applicant.Shortlisting::Open;
                Applicant.Interview := Applicant.Interview::" ";
                Applicant."Offer Status" := Applicant."Offer Status"::Applicant;
                Applicant.Modify(true);
            until Applicant.Next() = 0;
        end;
        Need."Shortlisting Conducted" := false;
        Need.Modify(true);
    end;

    procedure CloseShortlisting(Need: Record "Recruitment Needs")
    begin
        if Confirm(StrSubstNo(Text007, Need."No."), false) = true then begin
            Need."Shortlisting Conducted" := true;
            Need.Modify(true);
        end
        else begin
            exit;
        end;
    end;

    procedure CloseInterview(Need: Record "Recruitment Needs")
    begin
        if Confirm(StrSubstNo(Text008, Need."No."), false) = true then begin
            Need."Interview Conducted" := true;
            Need.Modify(true);
        end
        else begin
            exit;
        end;
    end;

    procedure CloseMediacalExamination(Need: Record "Recruitment Needs")
    begin
        if Confirm(StrSubstNo(Text009, Need."No."), false) = true then begin
            Need."Medical Examonation Conducted" := true;
            Need.Modify(true);
        end
        else begin
            exit;
        end;
    end;

    local procedure CreateStaffApplicantCard(var NAVEmp: Record Employee)
    begin
        Applicant.Init();
        Applicant."Staff ID" := NAVEmp."No.";
        Applicant."Applicant Type" := Applicant."Applicant Type"::Internal;
        Applicant.Validate("Vacancy No.", NAVEmp."Recruitment Need");
        Applicant.Validate("Job ID", NAVEmp."Job Id");
        Applicant."First Name" := NAVEmp."First Name";
        Applicant."Middle Name" := NAVEmp."Middle Name";
        Applicant."Last Name" := NAVEmp."Last Name";
        Applicant.Initials := NAVEmp.Initials;
        // Applicant."Postal Address":=NAVEmp.Address;
        Applicant."Physical Address" := NAVEmp."Address 2";
        Applicant."Alt. Address Code" := NAVEmp."Alt. Address Code";
        Applicant."Alt. Address End Date" := NAVEmp."Alt. Address End Date";
        Applicant."Alt. Address Start Date" := NAVEmp."Alt. Address Start Date";
        Applicant."Birth Date" := NAVEmp."Birth Date";
        Applicant."Cause of Absence Filter" := NAVEmp."Cause of Absence Filter";
        Applicant."Cause of Inactivity Code" := NAVEmp."Cause of Inactivity Code";
        Applicant.City := NAVEmp.City;
        Applicant.Comment := NAVEmp.Comment;
        Applicant."Company E-Mail" := NAVEmp."Company E-Mail";
        Applicant."Country/Region Code" := NAVEmp."Country/Region Code";
        Applicant."Home County" := NAVEmp.County;
        Applicant.Gender := NAVEmp.Gender;
        Applicant."E-Mail" := NAVEmp."E-Mail";
        Applicant."Global Dimension 1 Code" := NAVEmp."Global Dimension 1 Code";
        Applicant."Global Dimension 2 Code" := NAVEmp."Global Dimension 2 Code";
        Applicant.Image := NAVEmp.Image;
        Applicant."Position Applied For" := NAVEmp."Job Title";
        Applicant."Job ID" := NAVEmp."Job Id";
        Applicant."Mobile Phone No." := NAVEmp."Phone No.";
        Applicant."Mobile Phone No." := NAVEmp."Mobile Phone No.";
        Applicant.Insert(true);
        //Create Applicant Master
        EmpMaster.Reset;
        EmpMaster.SetRange("No.", NAVEmp."No.");
        if EmpMaster.FindFirst then begin
            ApplicantMaster.Reset();
            ApplicantMaster.SetRange("No.", Applicant."No.");
            if ApplicantMaster.FindFirst() = false then ApplicantMaster.Init();
            ApplicantMaster."Pays Tax" := EmpMaster."Pays Tax";
            ApplicantMaster."ID Number" := EmpMaster."ID Number";
            ApplicantMaster."Passport No." := EmpMaster."Passport No.";
            ApplicantMaster.County := EmpMaster.County;
            ApplicantMaster."Employee Group" := EmpMaster."Employee Group";
            ApplicantMaster."Document Type" := EmpMaster."Document Type";
            ApplicantMaster."Driving License No" := EmpMaster."Driving License No";
            ApplicantMaster."Ethnic Group" := EmpMaster."Ethnic Group";
            ApplicantMaster."Exit Interview Date" := EmpMaster."Exit Interview Date";
            ApplicantMaster."Exit Interview Done By" := EmpMaster."Exit Interview Done By";
            ApplicantMaster."Full / Part Time" := EmpMaster."Full / Part Time";
            ApplicantMaster."Global Dimension 1 Code" := EmpMaster."Global Dimension 1 Code";
            ApplicantMaster."Global Dimension 2 Code" := EmpMaster."Global Dimension 2 Code";
            ApplicantMaster."Global Dimension 3 Code" := EmpMaster."Global Dimension 3 Code";
            ApplicantMaster."HELB No" := EmpMaster."HELB No";
            ApplicantMaster."ID Number" := EmpMaster."ID Number";
            ApplicantMaster."SHIF No" := EmpMaster."SHIF No";
            ApplicantMaster."Marital Status" := EmpMaster."Marital Status";
            ApplicantMaster."NSSF No" := EmpMaster."NSSF No";
            ApplicantMaster.Modify(true);
        end;
        //Create Qualification Lines
        EmpQualifications.Reset();
        EmpQualifications.SetRange("Employee No.", EmpMaster."No.");
        if EmpQualifications.FindSet() then begin
            repeat
                AppQualifications.Init();
                AppQualifications."Employee No." := ApplicantMaster."No.";
                AppQualifications."Line No." := EmpQualifications."Line No.";
                AppQualifications."Qualification Type" := EmpQualifications."Qualification Type";
                AppQualifications.Validate("Qualification Code", EmpQualifications."Qualification Code");
                AppQualifications."From Date" := EmpQualifications."From Date";
                AppQualifications."To Date" := EmpQualifications."To Date";
                AppQualifications.Type := EmpQualifications.Type;
                AppQualifications."Institution/Company" := EmpQualifications."Institution/Company";
                AppQualifications.Description := EmpQualifications.Description;
                AppQualifications.Address := EmpQualifications.Address;
                AppQualifications."Employee Status" := EmpQualifications."Employee Status";
                AppQualifications."Score ID" := EmpQualifications."Score ID";
                AppQualifications.Comment := EmpQualifications.Comment;
                AppQualifications."Expiration Date" := EmpQualifications."Expiration Date";
                AppQualifications.Insert(true);
            until EmpQualifications.Next() = 0;
        end;
        NAVEmp."Application Submited" := true;
        NAVEmp.Modify(true);
    end;

    var
        RecruitmentNeed: Record "Recruitment Needs";
        RequestLines: Record "Recruitment Request Lines";
        Applicant: Record Applicant;
        Applicant2: Record Applicant;
        Committees: Record Committees;
        LineNo: Integer;
        NoOfInterviewers: Integer;
        Interview: Record Interview;
        CommitteeMembers: Record "Committee Board Of Directors";
        Text000: Label 'You are about to advertise Request: %1 Do you wish to Continue?';
        Text001: Label 'Recruitment Need : %1 have been Created;  Do you wish to Open it?';
        Text002: Label 'Shortlisting Competed Successfully.';
        Text003: Label 'You must select the stage you would like to shortlist.';
        Text004: Label '%1 have not received any Qualified Application Yet';
        Text005: Label 'Interviewers have Assigned to the Applicants';
        Text006: Label 'There is no Interviewee For this For this Recruitment Need %1';
        Text007: Label 'You are about to close %1 For Shortlisting Stage, Do you wish to continue?';
        Text008: Label 'You are about to close %1 For Interview Stage, Do you wish to continue?';
        Text009: Label 'You are about to close %1 For Medical Examination Stage, Do you wish to continue?';
        Text010: Label 'Your login has not been mapped to your employee profile. Kindly contact the Administrator.';
        Text011: Label 'You have already submitted your Application for this Position.';
        Text012: Label 'Your Job Application has been Submitted Successfully!!';
        ShortListCriteria: Record "Shortlisting Criteria";
        AppQualifications: Record "Applicants Qualification";
        EmpQualifications: Record "HR_Employee Qualifications";
        Applicants: Record Applicant;
        Qualified_Var: Boolean;
        StageScore: Decimal;
        ShortlistingScore: Decimal;
        StageShortlist: Record "Stage Shortlist";
        MyCount: Integer;
        RecCount: Integer;
        ApplicantMaster: Record "Applicant Master";
        PositionCount: Integer;
        InterviewStage: Record "Interview Stage";
        PositionCounter: Integer;
        MyCounter: Integer;
        UserSetup: Record "User Setup";
        Emp: Record Employee;
        EmpMaster: Record "Employee Master";
}
