codeunit 51608 "Onboarding Management"
{
    // version THL- HRM 1.0
    // Author     : Vincent Okoth
    // Upgraded By : Henry Ngari
    // Year: 2021
    // 
    // THL OBJECT RANGES:
    // ***********************
    // Basic Finance: 50000 - 50010 (Bundled with Starter Pack)
    // QuantumJumps Payroll:  51423 - 51499 = 76
    // Advanced Finance: 52100 - 52199 = 99
    // QuantumJumps HR: 51600 - 51799 = 199
    // QuantumJumps Procumement: 51800 - 51899 = 99
    // ***********************
    // EasyPFA: 51900 - 52099 = 199
    // Investment: 52100 - 52199 = 99
    // DynamicsHMIS: 52200 - 52299 = 99
    // EasyProperty: 52300 - 52399 = 99
    // Insurance: 61423 - 61622 = 199
    // Sacco:   61623 - 62422 = ***
    // ***********************
    trigger OnRun()
    begin
    end;

    var
        Text000: Label 'Are you offering this applicant a Job?';
        Text001: Label 'Did this applicant accept the Job Offer?';
        Text002: Label 'Did this applicant reject the Job Offer?';
        NAVEmp: Record Employee;
        Emp: Record "Employee Master";
        AppQualifications: Record "Applicants Qualification";
        EmpQualifications: Record "HR_Employee Qualifications";
        Text003: Label 'Has this applicant reported to work?';
        ApplicantMaster: Record "Applicant Master";
        Text004: Label 'The applicant did not show up for work?';
        PromotionHistory: Codeunit "Promotion History";

    [EventSubscriber(ObjectType::Table, 51630, 'OnInsertApplicant', '', false, false)]
    procedure InsertApplicantMaster(var Applicant: Record Applicant)
    var
        EmployeeMaster: Record "Applicant Master";
        EmployeeMaster2: Record "Applicant Master";
    begin
        EmployeeMaster.Init;
        EmployeeMaster."No." := Applicant."No.";
        EmployeeMaster."Resource No." := Applicant."Resource No.";
        if not EmployeeMaster2.Get(Applicant."No.") then
            EmployeeMaster.Insert
        else begin
            EmployeeMaster2."Resource No." := Applicant."Resource No.";
        end;
    end;

    [EventSubscriber(ObjectType::Table, 51630, 'OnDeleteApplicant', '', false, false)]
    procedure DeleteApplicantMaster(var Applicant: Record Applicant)
    var
        EmployeeMaster: Record "Applicant Master";
    begin
        if EmployeeMaster.Get(Applicant."No.") then EmployeeMaster.Delete;
    end;

    procedure MakeOffer(var Applicant: Record Applicant)
    begin
        if Confirm(Text000, true) = true then begin
            Applicant."Offer Status" := Applicant."Offer Status"::"Offer Made";
            Applicant.Modify;
        end;
    end;

    procedure OfferAccepted(var Applicant: Record Applicant)
    begin
        if Confirm(Text001, true) = true then begin
            Applicant."Offer Status" := Applicant."Offer Status"::"Accepted Offer";
            Applicant.Modify;
        end;
    end;

    procedure OfferRejected(var Applicant: Record Applicant)
    begin
        if Confirm(Text002, true) = true then begin
            Applicant."Offer Status" := Applicant."Offer Status"::"Rejected Offer";
            Applicant.Modify;
        end;
    end;

    procedure ReportedToWork(var Applicant: Record Applicant)
    begin
        Applicant.TestField(Applicant."Employment Date");
        if Confirm(Text003, true) = true then begin
            ConvertToEmployee(Applicant);
            Applicant."Offer Status" := Applicant."Offer Status"::"Reported to Work";
            Applicant.Modify;
        end;
    end;

    procedure ConvertToEmployee(var Applicant: Record Applicant)
    begin
        If Applicant."Applicant Type" = Applicant."Applicant Type"::External then
            CreateStaffCardForExternalApplicant(Applicant)
        else
            PromotionHistory.ProcessPromotion_Second(Applicant."Staff ID", Applicant."Employment Date", 'Recruitment', Applicant."Position Applied For");
    end;

    local procedure CreateStaffCardForExternalApplicant(var Applicant: Record Applicant)
    begin
        NAVEmp.Init();
        NAVEmp."First Name" := Applicant."First Name";
        NAVEmp."Middle Name" := Applicant."Middle Name";
        NAVEmp."Last Name" := Applicant."Last Name";
        NAVEmp.Initials := Applicant.Initials;
        // NAVEmp.Address:=Applicant."Postal Address";
        NAVEmp."Address 2" := Applicant."Physical Address";
        NAVEmp."Alt. Address Code" := Applicant."Alt. Address Code";
        NAVEmp."Alt. Address End Date" := Applicant."Alt. Address End Date";
        NAVEmp."Alt. Address Start Date" := Applicant."Alt. Address Start Date";
        NAVEmp."Birth Date" := Applicant."Birth Date";
        NAVEmp."Cause of Absence Filter" := Applicant."Cause of Absence Filter";
        NAVEmp."Cause of Inactivity Code" := Applicant."Cause of Inactivity Code";
        NAVEmp.City := Applicant.City;
        NAVEmp.Comment := Applicant.Comment;
        NAVEmp."Company E-Mail" := Applicant."Company E-Mail";
        NAVEmp."Country/Region Code" := Applicant."Country/Region Code";
        NAVEmp.County := Applicant."Home County";
        NAVEmp.Gender := Applicant.Gender;
        NAVEmp."E-Mail" := Applicant."E-Mail";
        NAVEmp."Global Dimension 1 Code" := Applicant."Global Dimension 1 Code";
        NAVEmp."Global Dimension 2 Code" := Applicant."Global Dimension 2 Code";
        NAVEmp.Image := Applicant.Image;
        NAVEmp."Job Title" := Applicant."Position Applied For";
        NAVEmp."Phone No." := Applicant."Mobile Phone No.";
        NAVEmp."Mobile Phone No." := Applicant."Mobile Phone No.";
        NAVEmp."Job Title" := Applicant."Position Applied For";
        NAVEmp.Insert(true);
        //Create Employee Master
        ApplicantMaster.Reset;
        ApplicantMaster.SetRange("No.", Applicant."No.");
        if ApplicantMaster.FindFirst then begin
            if Emp.Get(NAVEmp."No.") then begin
                Emp."Pays Tax" := ApplicantMaster."Pays Tax";
                Emp."ID Number" := ApplicantMaster."ID Number";
                Emp."Passport No." := ApplicantMaster."Passport No.";
                Emp.County := ApplicantMaster.County;
                Emp."Employee Group" := ApplicantMaster."Employee Group";
                Emp."Document Type" := ApplicantMaster."Document Type";
                Emp."Driving License No" := ApplicantMaster."Driving License No";
                Emp."Ethnic Group" := ApplicantMaster."Ethnic Group";
                Emp."Exit Interview Date" := ApplicantMaster."Exit Interview Date";
                Emp."Exit Interview Done By" := ApplicantMaster."Exit Interview Done By";
                Emp."Full / Part Time" := ApplicantMaster."Full / Part Time";
                Emp."Global Dimension 1 Code" := ApplicantMaster."Global Dimension 1 Code";
                Emp."Global Dimension 2 Code" := ApplicantMaster."Global Dimension 2 Code";
                Emp."Global Dimension 3 Code" := ApplicantMaster."Global Dimension 3 Code";
                Emp."HELB No" := ApplicantMaster."HELB No";
                Emp."ID Number" := ApplicantMaster."ID Number";
                Emp."SHIF No" := ApplicantMaster."SHIF No";
                Emp."Marital Status" := ApplicantMaster."Marital Status";
                Emp."NSSF No" := ApplicantMaster."NSSF No";
                Emp.Modify(true);
            end;
            //Create Qualification Lines
            AppQualifications.Reset();
            AppQualifications.SetRange("Employee No.", ApplicantMaster."No.");
            if AppQualifications.FindSet() then begin
                repeat
                    EmpQualifications.Init();
                    EmpQualifications."Employee No." := Emp."No.";
                    EmpQualifications."Line No." := AppQualifications."Line No.";
                    EmpQualifications."Qualification Type" := AppQualifications."Qualification Type";
                    EmpQualifications.Validate("Qualification Code", AppQualifications."Qualification Code");
                    EmpQualifications."From Date" := AppQualifications."From Date";
                    EmpQualifications."To Date" := AppQualifications."To Date";
                    EmpQualifications.Type := AppQualifications.Type;
                    EmpQualifications."Institution/Company" := AppQualifications."Institution/Company";
                    EmpQualifications.Description := AppQualifications.Description;
                    EmpQualifications.Address := AppQualifications.Address;
                    EmpQualifications."Employee Status" := AppQualifications."Employee Status";
                    EmpQualifications."Score ID" := AppQualifications."Score ID";
                    EmpQualifications.Comment := AppQualifications.Comment;
                    EmpQualifications."Expiration Date" := AppQualifications."Expiration Date";
                    EmpQualifications.Insert(true);
                until AppQualifications.Next() = 0;
            end;
        end;
        PromotionHistory.ProcessPromotion_First(NAVEmp."No.", Applicant."Employment Date", 'Recruitment', Applicant."Position Applied For");
    end;

    procedure NoShow(var Applicant: Record Applicant)
    begin
        if Confirm(Text004, true) = true then begin
            Applicant."Offer Status" := Applicant."Offer Status"::"Rejected Offer";
            Applicant.Modify;
        end;
    end;

    procedure InvitationEmail(var ShortlistedApplicant: Record Applicant)
    var
        mail: Codeunit "Email Message";
        email: Codeunit Email;
        Body: Text;
    begin
        Body := 'Hello, ' + ShortlistedApplicant."First Name";
        Body += '<br><br>';
        Body += 'Thank you for your interest in the ' + ShortlistedApplicant."Position Applied For" + ' Position at Judicial Service Commission.';
        Body += '<br><br>';
        Body += 'We are pleased to invite you for a panel interview:';
        Body += '<br>';
        Body += '<ul>';
        Body += '<li>Venue: Virtual or Physical</li>';
        Body += '<li>Date & Time: </li>';
        Body += '<br>';
        Body += '</ul>';
        Body += 'Kindly acknowledge the receipt of this e-mail and confirm your availability.';
        Body += '<br><br>';
        Body += 'Regards,';
        Body += '<br>';
        Body += '<b>Human Resources and Administration</b>';
        Body += '<br>';
        Body += 'Judicial Service Commission | 13th Floor CBK Pension Towers, Harambee Avenue, Nairobi';
        Body += '<br>';
        Body += 'T: + 234 (1) 2715005 ext 1023| W: www.jsc.';
        mail.Create(ShortlistedApplicant."E-Mail", 'Invitation for Interview', Body, true);
        email.OpenInEditorModally(mail)// email.Send(mail);
    end;

    procedure RejectionEmail(var ShortlistedApplicant: Record Applicant)
    var
        mail: Codeunit "Email Message";
        email: Codeunit Email;
        Body: Text;
    begin
        Body := 'Dear, ' + ShortlistedApplicant."First Name";
        Body += '<br><br>';
        Body += 'We will like you to know that we appreciate your interest in the ' + ShortlistedApplicant."Position Applied for" + ' Position at Judicial Service Commission.';
        Body += '<br><br>';
        Body += 'However, we regret to inform you that your application was unsuccessful, as we have had to make a difficult choice between many candidates for the position.';
        Body += '<br>';
        Body += 'We do appreciate you taking the time to apply for the role and also encourage you to apply for other openings at the company in the future.';
        Body += 'Again, thank you so much for your time.';
        Body += '<br><br>';
        Body += 'Kind Regards,';
        Body += '<br>';
        Body += '<b>Human Resources and Administration</b>';
        Body += '<br>';
        Body += 'Judicial Service Commission | 13th Floor CBK Pension Towers, Harambee Avenue, Nairobi';
        Body += '<br>';
        Body += 'T: + 234 (1) 2715005 ext 1023| W: www.jsc.';
        mail.Create(ShortlistedApplicant."E-Mail", 'Regret', Body, true);
        email.OpenInEditorModally(mail)// email.Send(mail);
    end;

    procedure MedicalTestInvite(var ShortlistedApplicant: Record Applicant)
    var
        mail: Codeunit "Email Message";
        email: Codeunit Email;
        Body: Text;
    begin
        Body := 'Dear Candidate,';
        Body += '<br><br>';
        Body += 'This e-mail serves to inform you that you have been scheduled for a Pre-employment Medical Examination at <b>(NAME OF FACILITY), (ADDRESS OF MEDICAL FACILITY)</b>.';
        Body += '<br><br>';
        Body += '<b>Date:</b>';
        Body += '<br><br>';
        Body += '<b>Time:</b>';
        Body += '<br><br>';
        Body += 'At the venue, please inform them that you are from <b>Judicial Service Commission</b> and that you are there for a Pre-employment Medical Assessment.';
        Body += '<br><br>';
        Body += 'Please ensure you have some form of Identification.';
        Body += '<br><br>';
        Body += 'Once you have completed the test kindly inform HR by replying to this e-mail.';
        Body += '<br><br>';
        Body += 'Please do not hesitate to contact us if there is any further challenge.';
        Body += '<br><br>';
        Body += 'Kindly acknowledge receipt of this email.';
        Body += '<br><br>';
        Body += 'Regards,';
        Body += '<br>';
        Body += '<b>Recruitment Team</b>';
        Body += '<br>';
        Body += 'Judicial Service Commission | 13th Floor CBK Pension Towers, Harambee Avenue, Nairobi';
        Body += '<br>';
        Body += 'T: + 234 (1) 2715005 ext 1023| W: www.jsc.';
        mail.Create(ShortlistedApplicant."E-Mail", 'Pre-employment Medical Test', Body, true);
        email.OpenInEditorModally(mail)// email.Send(mail);
    end;
}
