table 51897 "Employee Appraisal Objectives"
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
                            "Appraisee's Job Title":=Employee."Job Title";
                            "Department Code":=Employee."Global Dimension 1 Code";
                            if EmpNav.Get("Employee No")then begin
                                "Job Group":=EmpNav.Scale;
                                "Job ID":=EmpNav.Position;
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
                    Validate("Appraisal Period");
                    AppraisalFormat.Reset;
                    AppraisalFormat.SetRange(AppraisalFormat."Appraisal Code", "Appraisal Type");
                    AppraisalFormat.SetRange(AppraisalFormat."Appraisal Heading Type", AppraisalFormat."Appraisal Heading Type"::Objectives);
                    if AppraisalFormat.Find('-')then repeat AppraisalLines.Init;
                            AppraisalLines."Appraisal No":="Objective No";
                            AppraisalLines."Employee No":="Employee No";
                            // AppraisalLines."No.":=AppraisalFormat."Line No.";
                            AppraisalLines."Appraisal Type":="Appraisal Type";
                            AppraisalLines."Appraisal Period":="Appraisal Period";
                            AppraisalLines.Description:=AppraisalFormat.Value;
                            AppraisalLines."Line No":=AppraisalLines."Line No" + 1000;
                            AppraisalLines."Appraisal Heading Type":=AppraisalFormat."Appraisal Heading Type";
                            AppraisalLines."Appraisal Header":=AppraisalFormat."Appraisal Header";
                            AppraisalLines.Bold:=AppraisalFormat.Bold;
                            if not AppraisalLines.Get(AppraisalLines."Appraisal No", AppraisalLines."Line No")then AppraisalLines.Insert;
                        until AppraisalFormat.Next = 0;
                    EmpAppraisal.Reset;
                    EmpAppraisal.SetRange(EmpAppraisal."Employee No", "Employee No");
                    EmpAppraisal.SetRange(EmpAppraisal."Appraisal Period", "Appraisal Period");
                    if EmpAppraisal.Find('-')then Error('You have already setup objectives for %1 on %2', "Appraisal Period", EmpAppraisal.Date);
                end;
            end;
        }
        field(2; "Appraisal Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Appraisal Types".Code;
        }
        field(3; "Appraisal Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = false;
            TableRelation = "Appraisal Periods".Period;

            trigger OnValidate()
            begin
            /*
                AppraisalFormat.RESET;
                AppraisalFormat.SETRANGE(AppraisalFormat."Appraisal Code","Appraisal Category");
                AppraisalFormat.SETRANGE(AppraisalFormat."Appraisal Heading Type",AppraisalFormat."Appraisal Heading Type"::Objectives);
                IF AppraisalFormat.FIND('-') THEN
                REPEAT
                    AppraisalLines.INIT;
                    AppraisalLines."Appraisal No":="Objective No";
                    AppraisalLines."Employee No":="Employee No";
                   // AppraisalLines."No.":=AppraisalFormat."Line No.";
                    AppraisalLines."Appraisal Type":="Appraisal Category";
                    AppraisalLines."Appraisal Period":="Appraisal Period";
                    AppraisalLines.Description:=AppraisalFormat.Value;
                    AppraisalLines."Line No":=AppraisalLines."Line No"+1000;
                    AppraisalLines."Appraisal Heading Type":=AppraisalFormat."Appraisal Heading Type";
                    AppraisalLines."Appraisal Header":=AppraisalFormat."Appraisal Header";
                    AppraisalLines.Bold:=AppraisalFormat.Bold;
                    IF NOT AppraisalLines.GET(AppraisalLines."Appraisal No",AppraisalLines."Line No") THEN
                    AppraisalLines.INSERT;

                UNTIL AppraisalFormat.NEXT=0;
                */
            end;
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
        field(20; "Objective No"; Code[20])
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
        field(28; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(29; "HOD Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "No of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51897), "Document No."=FIELD("Objective No")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Objective No")
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
        if "Objective No" = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField(HumanResSetup."Appraisal Objective Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Appraisal Objective Nos", xRec."No. series", 0D, "Objective No", "No. series");
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
            Error('There is no Active Appriasal Period');
        if not "HOD Created" then begin
            if UserSetup.Get(UserId)then begin
                UserSetup.TestField("Employee No.");
                UserSetup.TestField("Immediate Supervisor");
                "Appraisee ID":=UserSetup."User ID";
                "Appraiser ID":=UserSetup."Immediate Supervisor";
                if Employee.Get(UserSetup."Employee No.")then begin
                    "Employee No":=Employee."No.";
                    "Appraisee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Appraisee's Job Title":=Employee."Job Title";
                    "Department Code":=Employee."Global Dimension 1 Code";
                    if EmpNav.Get("Employee No")then begin
                        "Job Group":=EmpNav.Scale;
                        "Job ID":=EmpNav.Position;
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
            Validate("Appraisal Period");
            AppraisalFormat.Reset;
            AppraisalFormat.SetRange(AppraisalFormat."Appraisal Code", "Appraisal Type");
            AppraisalFormat.SetRange(AppraisalFormat."Appraisal Heading Type", AppraisalFormat."Appraisal Heading Type"::Objectives);
            if AppraisalFormat.Find('-')then repeat AppraisalLines.Init;
                    AppraisalLines."Appraisal No":="Objective No";
                    AppraisalLines."Employee No":="Employee No";
                    // AppraisalLines."No.":=AppraisalFormat."Line No.";
                    AppraisalLines."Appraisal Type":="Appraisal Type";
                    AppraisalLines."Appraisal Period":="Appraisal Period";
                    AppraisalLines.Description:=AppraisalFormat.Value;
                    AppraisalLines."Line No":=AppraisalLines."Line No" + 1000;
                    AppraisalLines."Appraisal Heading Type":=AppraisalFormat."Appraisal Heading Type";
                    AppraisalLines."Appraisal Header":=AppraisalFormat."Appraisal Header";
                    AppraisalLines.Bold:=AppraisalFormat.Bold;
                    if not AppraisalLines.Get(AppraisalLines."Appraisal No", AppraisalLines."Line No")then AppraisalLines.Insert;
                until AppraisalFormat.Next = 0;
            EmpAppraisal.Reset;
            EmpAppraisal.SetRange(EmpAppraisal."Employee No", "Employee No");
            EmpAppraisal.SetRange(EmpAppraisal."Appraisal Period", "Appraisal Period");
            if EmpAppraisal.Find('-')then Error('You have already setup objectives for %1 on %2', "Appraisal Period", EmpAppraisal.Date);
        end;
    end;
    var Employee: Record Employee;
    EmpNav: Record "Employee Master";
    AppraisalGrades: Record "Appraisal Grades";
    AppraisalLines: Record "Appraisal Objectives Lines";
    AppraisalFormat: Record "Appraisal Formats";
    UserSetup: Record "User Setup";
    UserSetupSup: Record "User Setup";
    AppraisalType: Record "Appraisal Types";
    CompanyJobs: Record "Company Jobs";
    HRsetup: Record "QuantumJumps HR Setup";
    HumanResSetup: Record "QuantumJumps HR Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    EmpAppraisal: Record "Employee Appraisal Objectives";
    ApraisalPeriods: Record "Appraisal Periods";
}
