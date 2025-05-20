table 51902 "Employee Appraisals"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if EmpNav.Get("Employee No")then "Job ID":=EmpNav.Position;
                if "HOD Created" then begin
                    UserSetup.Reset;
                    UserSetup.SetRange("Employee No.", "Employee No");
                    if UserSetup.FindFirst then begin
                        UserSetup.TestField("User ID");
                        UserSetup.TestField("Immediate Supervisor");
                        "Appraisee ID":=UserSetup."User ID";
                        "Appraiser ID":=UserSetup."Immediate Supervisor";
                        if Employee.Get(UserSetup."Employee No.")then begin
                            "Employee No":=Employee."No.";
                            "Appraisee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                            if EmpNav.Get("Employee No")then begin
                                "Job Group":=EmpNav.Scale;
                                "Appraisee's Job Title":=EmpNav."Job Title";
                                "Deapartment Code":=EmpNav."Global Dimension 1 Code";
                                AppraisalType.Reset;
                                if AppraisalType.Find('-')then repeat if((EmpNav.Scale >= AppraisalType."Minimum Job Group") and (EmpNav.Scale <= AppraisalType."Maximum Job Group"))then begin
                                            "Appraisal Type":=AppraisalType.Code;
                                            Validate("Appraisal Type");
                                        end;
                                    until AppraisalType.Next = 0;
                            end;
                            if UserSetupSup.Get(UserSetup."Immediate Supervisor")then if Employee.Get(UserSetupSup."Employee No.")then begin
                                    "Appraiser No":=Employee."No.";
                                    "Appraisers Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                                    "Appraiser's Job Title":=Employee."Job Title";
                                end;
                        end;
                    end;
                    EmpAppraisal.Reset;
                    EmpAppraisal.SetRange(EmpAppraisal."Employee No", "Employee No");
                    EmpAppraisal.SetRange(EmpAppraisal."Appraisal Type", "Appraisal Type");
                    EmpAppraisal.SetRange(EmpAppraisal."Appraisal Period", "Appraisal Period");
                    EmpAppraisal.SetRange(EmpAppraisal."Appraisal Category", "Appraisal Category");
                    if EmpAppraisal.Find('-')then Error('You have already created %1 appraisal for %2', "Appraisal Category", "Appraisal Period");
                end;
            end;
        }
        field(2; "Appraisal Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Appraisal Types".Code;

            trigger OnValidate()
            begin
                AppraisalFormat.Reset;
                AppraisalFormat.SetRange(AppraisalFormat."Appraisal Code", "Appraisal Type");
                AppraisalFormat.SetFilter(AppraisalFormat."Appraisal Heading Type", '<>%1', AppraisalFormat."Appraisal Heading Type"::Objectives);
                if AppraisalFormat.Find('-')then repeat AppraisalLines.Init;
                        AppraisalLines."Appraisal No":="Appraisal No";
                        AppraisalLines."Employee No":="Employee No";
                        AppraisalLines."Appraisal Category":="Appraisal Type";
                        AppraisalLines."Appraisal Period":="Appraisal Period";
                        AppraisalLines.Description:=AppraisalFormat.Value;
                        AppraisalLines."Line No":=AppraisalLines."Line No" + 1000;
                        AppraisalLines."Appraisal Heading Type":=AppraisalFormat."Appraisal Heading Type";
                        AppraisalLines.Validate(AppraisalLines."Appraisal Heading Type");
                        AppraisalLines."Appraisal Header":=AppraisalFormat."Appraisal Header";
                        AppraisalLines.Bold:=AppraisalFormat.Bold;
                        if not AppraisalLines.Get(AppraisalLines."Appraisal No", AppraisalLines."Line No")then AppraisalLines.Insert;
                    until AppraisalFormat.Next = 0;
            end;
        }
        field(3; "Appraisal Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = true;
            TableRelation = "Appraisal Periods".Period;
        }
        field(4; "No. Supervised (Directly)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "No. Supervised (In-Directly)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Company Jobs"."Job ID";
        }
        field(7; "Agreement With Rating"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Entirely, Mostly, "To some extent", "Not at all";
        }
        field(8; "General Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Rating; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Appraisal Grades";

            trigger OnValidate()
            begin
                if AppraisalGrades.Get(Rating)then "Rating Description":=AppraisalGrades.Description;
            end;
        }
        field(11; "Rating Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Appraiser No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Employee.Get("Appraiser No")then "Appraisers Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(13; "Appraisers Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Appraisee ID"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Appraiser ID"; Code[40])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; "Appraisee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(17; "Job Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(18; "Appraiser's Job Title"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(19; "Appraisee's Job Title"; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(20; "Appraisal No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(21; "No. series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(28; "Deapartment Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "Appraisal Category"; Text[120])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Appraisal Category"."Appraissal Category";
        }
        field(30; "Wizard Step"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = , "1", "2";
        }
        field(31; "HOD Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "No of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51902), "Document No."=FIELD("Appraiser No")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Appraisal No")
        {
        }
        key(Key2; "Employee No", "Appraisal Type", "Appraisal Period")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Appraisal No" = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField(HumanResSetup."Appraisal Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Appraisal Nos", xRec."No. series", 0D, "Appraisal No", "No. series");
        end;
        Date:=Today;
        Status:=Status::Open;
        ApraisalPeriods.Reset;
        // ApraisalPeriods.SETRANGE(ApraisalPeriods."End Date",0D,);
        if ApraisalPeriods.Find('-')then begin
            repeat if(ApraisalPeriods."Start Date" <= Date) and (ApraisalPeriods."End Date" >= Date)then "Appraisal Period":=ApraisalPeriods.Period;
            until ApraisalPeriods.Next = 0;
        end
        else
            Error('There is NO Active Appraisal Period');
        if not "HOD Created" then begin
            if UserSetup.Get(UserId)then begin
                UserSetup.TestField("Employee No.");
                UserSetup.TestField("Immediate Supervisor");
                "Appraisee ID":=UserSetup."User ID";
                "Appraiser ID":=UserSetup."Immediate Supervisor";
                if Employee.Get(UserSetup."Employee No.")then begin
                    "Employee No":=Employee."No.";
                    "Appraisee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    if EmpNav.Get("Employee No")then begin
                        "Job Group":=EmpNav.Scale;
                        "Appraisee's Job Title":=EmpNav."Job Title";
                        "Deapartment Code":=EmpNav."Global Dimension 1 Code";
                        AppraisalType.Reset;
                        if AppraisalType.Find('-')then repeat if((EmpNav.Scale >= AppraisalType."Minimum Job Group") and (EmpNav.Scale <= AppraisalType."Maximum Job Group"))then begin
                                    "Appraisal Type":=AppraisalType.Code;
                                    Validate("Appraisal Type");
                                end;
                            until AppraisalType.Next = 0;
                    end;
                    if UserSetupSup.Get(UserSetup."Immediate Supervisor")then if Employee.Get(UserSetupSup."Employee No.")then begin
                            "Appraiser No":=Employee."No.";
                            "Appraisers Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                            "Appraiser's Job Title":=Employee."Job Title";
                        end;
                end;
            end;
            EmpAppraisal.Reset;
            EmpAppraisal.SetRange(EmpAppraisal."Employee No", "Employee No");
            EmpAppraisal.SetRange(EmpAppraisal."Appraisal Type", "Appraisal Type");
            EmpAppraisal.SetRange(EmpAppraisal."Appraisal Period", "Appraisal Period");
            EmpAppraisal.SetRange(EmpAppraisal."Appraisal Category", "Appraisal Category");
            if EmpAppraisal.Find('-')then Error('You have already created %1 appraisal for %2', "Appraisal Category", "Appraisal Period");
        end;
    end;
    var Employee: Record Employee;
    EmpNav: Record "Employee Master";
    AppraisalGrades: Record "Appraisal Grades";
    AppraisalLines: Record "Appraisal Lines";
    AppraisalFormat: Record "Appraisal Formats";
    UserSetup: Record "User Setup";
    UserSetupSup: Record "User Setup";
    AppraisalType: Record "Appraisal Types";
    CompanyJobs: Record "Company Jobs";
    HRsetup: Record "QuantumJumps HR Setup";
    HumanResSetup: Record "QuantumJumps HR Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    EmpAppraisal: Record "Employee Appraisals";
    ApraisalPeriods: Record "Appraisal Periods";
    procedure StartWizard2()
    var
        InteractionTmplSetup: Record "Interaction Template Setup";
        Campaign: Record Campaign;
    begin
        "Wizard Step":="Wizard Step"::"1";
        Insert;
    end;
    procedure PerformNextWizardStatus2()
    var
        InteractTmpl: Record "Interaction Template";
    begin
        "Wizard Step":="Wizard Step" + 1;
    end;
    procedure PerformPrevWizardStatus2()
    begin
        "Wizard Step":="Wizard Step" - 1;
    end;
    procedure PerformPostStep2()
    begin
    /*
        CASE "Wizard Step" OF
          "Wizard Step"::"2":
        
            IF "Dial Contact" THEN BEGIN
              IF TAPIManagement.Dial("Contact Via") THEN
                "Dial Contact" := FALSE;
            END ELSE
              ERROR(Text010);
        
        END;
         */
    end;
    procedure CheckStatus2()
    var
        InteractTmpl: Record "Interaction Template";
        Attachment: Record Attachment;
        SalutationFormula: Record "Salutation Formula";
    begin
    /*
        IF "Wizard Step" = "Wizard Step"::"1" THEN BEGIN
          IF "Dial Contact" AND ("Contact Via" = '') THEN
            ERROR(Text013);
          IF Date = 0D THEN
            ErrorMessage(FIELDCAPTION(Date));
          IF Description = '' THEN
            ErrorMessage(FIELDCAPTION(Description));
          IF "Salesperson Code" = '' THEN
            ErrorMessage(FIELDCAPTION("Salesperson Code"));
        END;
        */
    end;
    procedure FinishWizard2(): Boolean var
        SegManagement: Codeunit 5051;
        TempAttachment: Record Attachment temporary;
        SegLine: Record "Employee Appraisals";
    begin
    end;
    procedure StartWizard()
    var
        Opp: Record Opportunity;
    begin
        "Wizard Step":="Wizard Step"::"1";
    end;
    procedure PerformNextWizardStatus()
    begin
        case "Wizard Step" of "Wizard Step"::"1": "Wizard Step":="Wizard Step"::"1";
        end;
    //"Wizard Step" := "Wizard Step" + 1;
    end;
    procedure PerformPrevWizardStatus()
    begin
        case "Wizard Step" of "Wizard Step"::"1": "Wizard Step":="Wizard Step"::"1";
        else
            "Wizard Step":="Wizard Step" - 1;
        end;
    end;
    procedure CheckStatus()
    var
        InteractTmpl: Record "Interaction Template";
        Attachment: Record Attachment;
        SalutationFormula: Record "Salutation Formula";
    begin
    /*
        CASE "Wizard Step" OF
          "Wizard Step"::"1":
            BEGIN
              IF "Contact No." = '' THEN
                ERROR(Text006);
              IF "Interaction Template Code" = '' THEN
                ErrorMessage(FIELDCAPTION("Interaction Template Code"));
              IF"Salesperson Code" = '' THEN
                ErrorMessage(FIELDCAPTION("Salesperson Code"));
              IF Date = 0D THEN
                ErrorMessage(FIELDCAPTION(Date));
              IF Description = '' THEN
                ErrorMessage(FIELDCAPTION(Description));
        
              InteractTmpl.GET("Interaction Template Code");
              IF InteractTmpl."Wizard Action" = InteractTmpl."Wizard Action"::Open THEN
                IF "Attachment No." = 0 THEN
                  ErrorMessage(Attachment.TABLECAPTION);
        
              Cont.GET("Contact No.");
              SalutationFormula.GET(Cont."Salutation Code","Language Code",0);
              SalutationFormula.GET(Cont."Salutation Code","Language Code",1);
            END;
          "Wizard Step"::"2":;
          "Wizard Step"::"3":
            BEGIN
              IF AttachmentTemp.FIND('-') THEN
                AttachmentTemp.CALCFIELDS(Attachment);
              IF ("Correspondence Type" = "Correspondence Type"::"E-Mail") AND
                 ("Attachment No." = 0)
              THEN
                ERROR(Text008);
            END;
          "Wizard Step"::"4":;
        END;
           */
    end;
    procedure FinishWizard(IsFinish: Boolean; var AttachmentTmp: Record Attachment): Boolean var
        SegManagement: Codeunit 5051;
        send: Boolean;
        Flag: Boolean;
    begin
    /*
        Flag := FALSE;
        IF IsFinish THEN
          Flag := TRUE
        ELSE
          Flag := CONFIRM(Text007);
        
        IF Flag THEN BEGIN
          AttachmentTemp.COPY(AttachmentTmp);
          "Attempt Failed" := NOT "Interaction Successful";
          Subject := Description;
          ProcessPostponedAttachment;
          send := (IsFinish AND ("Correspondence Type" <> "Correspondence Type"::" "));
          SegManagement.LogInteraction(Rec,AttachmentTemp,InterLogEntryCommentLineTmp,send,NOT IsFinish)
        END;
        DELETE
         */
    end;
    procedure ErrorMessage(FieldName: Text[1024])
    begin
    //ERROR(Text005,FieldName);
    end;
}
