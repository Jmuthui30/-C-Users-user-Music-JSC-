table 52600 "Appraisal Planning Header"
{
    Caption = 'Appraisal Planning Header';
    DataClassification = CustomerContent;
    DrillDownPageId = "Appraisal Planning List";
    LookupPageId = "Appraisal Planning List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'Planning No.';
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Appraisee No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                PopulateEmployeeDetails();
                EnsureUniqueOpenPlan();
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Appraisee Name';
            Editable = false;
        }
        field(4; "Appraisal Period"; Code[20])
        {
            Caption = 'Appraisal Period';
            TableRelation = "Appraisal Periods".Period where(Active = const(true));

            trigger OnValidate()
            begin
                PopulatePeriodDates();
                EnsureUniqueOpenPlan();
            end;
        }
        field(5; "Period Start"; Date)
        {
            Caption = 'Period Start';
            Editable = false;
        }
        field(6; "Period End"; Date)
        {
            Caption = 'Period End';
            Editable = false;
        }
        field(7; "Appraiser No."; Code[20])
        {
            Caption = 'Appraiser No.';
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                PopulateAppraiserDetails();
            end;
        }
        field(8; "Appraiser Name"; Text[100])
        {
            Caption = 'Appraiser Name';
            Editable = false;
        }
        field(9; "Planning Status"; Enum "Appraisal Planning Status")
        {
            Caption = 'Planning Status';
            Editable = false;
        }
        field(10; "Review Round"; Integer)
        {
            Caption = 'Review Round';
            Editable = false;
        }
        field(11; "Actual Appraisal No."; Code[20])
        {
            Caption = 'Actual Appraisal No.';
            Editable = false;
            TableRelation = "Employee Appraisal"."Appraisal No";
        }
        field(12; "Submitted At"; DateTime)
        {
            Caption = 'Submitted At';
            Editable = false;
        }
        field(13; "Submitted By"; Code[50])
        {
            Caption = 'Submitted By';
            Editable = false;
        }
        field(14; "Returned At"; DateTime)
        {
            Caption = 'Returned At';
            Editable = false;
        }
        field(15; "Returned By"; Code[50])
        {
            Caption = 'Returned By';
            Editable = false;
        }
        field(16; "Last Review Reason"; Text[250])
        {
            Caption = 'Last Review Reason';
            Editable = false;
        }
        field(17; "Objectives Agreed At"; DateTime)
        {
            Caption = 'Objectives Agreed At';
            Editable = false;
        }
        field(18; "Appraisal Created At"; DateTime)
        {
            Caption = 'Appraisal Created At';
            Editable = false;
        }
        field(19; "Job Title"; Text[100])
        {
            Caption = 'Job Title';
            Editable = false;
        }
        field(20; "Job Group"; Code[20])
        {
            Caption = 'Job Group';
            Editable = false;
        }
        field(21; "Responsibility Center"; Code[20])
        {
            Caption = 'Responsibility Center';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(22; "Directorate Code"; Code[20])
        {
            Caption = 'Directorate Code';
            Editable = false;
        }
        field(23; "Directorate Name"; Text[100])
        {
            Caption = 'Directorate Name';
            Editable = false;
        }
        field(24; "Appraisee User ID"; Code[50])
        {
            Caption = 'Appraisee User ID';
            Editable = false;
        }
        field(25; "Appraiser User ID"; Code[50])
        {
            Caption = 'Appraiser User ID';
            Editable = false;
        }
        field(26; "Personal Dev. Objectives"; Text[2048])
        {
            Caption = 'Personal Development Objectives';
        }
        field(27; "Core Values Maintained"; Text[2048])
        {
            Caption = 'Core Values Maintained';
        }
        field(28; "Core Values Maintenance"; Text[2048])
        {
            Caption = 'Actions to Maintain Core Values';
        }
        field(29; "Core Values To Develop"; Text[2048])
        {
            Caption = 'Core Values to Develop';
        }
        field(30; "Core Values Development"; Text[2048])
        {
            Caption = 'Actions to Develop Core Values';
        }
        field(31; "Additional Responsibilities"; Text[2048])
        {
            Caption = 'Additional Responsibilities';
        }
        field(32; "Knowledge Innovation"; Text[2048])
        {
            Caption = 'Knowledge and Innovation Contribution';
        }
        field(33; "Employee Agreed"; Boolean)
        {
            Caption = 'Appraisee Agreed';
        }
        field(34; "Appraiser Agreed"; Boolean)
        {
            Caption = 'Appraiser Agreed';
        }
        field(35; "HR Approved By"; Code[50])
        {
            Caption = 'HR Approved By';
            Editable = false;
        }
        field(36; "HR Approved At"; DateTime)
        {
            Caption = 'HR Approved At';
            Editable = false;
        }
        field(37; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(EmployeePeriod; "Employee No.", "Appraisal Period", "Planning Status")
        {
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then
            AssignNoSeries();

        if "Planning Status" = "Planning Status"::Draft then;

        if "Employee No." <> '' then
            PopulateEmployeeDetails();
        if "Appraisal Period" <> '' then
            PopulatePeriodDates();

        EnsureUniqueOpenPlan();
    end;

    trigger OnModify()
    begin
        EnsureUniqueOpenPlan();
    end;

    var
        HRSetup: Record "Human Resources Setup";
        NoSeries: Codeunit "No. Series";

    local procedure AssignNoSeries()
    begin
        HRSetup.Get();
        HRSetup.TestField("Appraisal Objective Nos");

        if NoSeries.AreRelated(HRSetup."Appraisal Objective Nos", xRec."No. Series") then
            "No. Series" := xRec."No. Series"
        else
            "No. Series" := HRSetup."Appraisal Objective Nos";

        "No." := NoSeries.GetNextNo("No. Series", WorkDate());
    end;

    procedure PopulateEmployeeDetails()
    var
        AppraisalReportingMgt: Codeunit "Appraisal Reporting Mgt.";
        Employee: Record Employee;
        ManagerEmployee: Record Employee;
        DirectorateDimensionCode: Code[20];
    begin
        Clear("Employee Name");
        Clear("Job Title");
        Clear("Job Group");
        Clear("Responsibility Center");
        Clear("Directorate Code");
        Clear("Directorate Name");
        Clear("Appraisee User ID");

        if "Employee No." = '' then
            exit;

        Employee.Get("Employee No.");
        "Employee Name" := CopyStr(Employee.FullName(), 1, MaxStrLen("Employee Name"));
        "Job Title" := GetEmployeeJobTitle(Employee);
        "Job Group" := Employee."Salary Scale";
        "Responsibility Center" := Employee."Responsibility Center";
        "Appraisee User ID" := CopyStr(Employee."User ID", 1, MaxStrLen("Appraisee User ID"));

        if AppraisalReportingMgt.TryGetDirectorateSnapshot("Employee No.", DirectorateDimensionCode, "Directorate Code", "Directorate Name") then;

        if ("Appraiser No." = '') and (Employee."Manager/Supervisor" <> '') then
            if ManagerEmployee.Get(Employee."Manager/Supervisor") then
                Validate("Appraiser No.", ManagerEmployee."No.");
    end;

    procedure PopulateAppraiserDetails()
    var
        Employee: Record Employee;
    begin
        Clear("Appraiser Name");
        Clear("Appraiser User ID");

        if "Appraiser No." = '' then
            exit;

        if "Appraiser No." = "Employee No." then
            Error('You cannot select the appraisee as the appraiser.');

        Employee.Get("Appraiser No.");
        "Appraiser Name" := CopyStr(Employee.FullName(), 1, MaxStrLen("Appraiser Name"));
        "Appraiser User ID" := CopyStr(Employee."User ID", 1, MaxStrLen("Appraiser User ID"));
    end;

    procedure PopulatePeriodDates()
    var
        AppraisalPeriod: Record "Appraisal Periods";
    begin
        Clear("Period Start");
        Clear("Period End");

        if "Appraisal Period" = '' then
            exit;

        AppraisalPeriod.Get("Appraisal Period");
        "Period Start" := AppraisalPeriod."Start Date";
        "Period End" := AppraisalPeriod."End Date";
    end;

    procedure EnsureEditable()
    begin
        if not ("Planning Status" in ["Planning Status"::Draft, "Planning Status"::"Returned for Changes"]) then
            Error('Appraisal planning %1 cannot be edited while its status is %2.', "No.", "Planning Status");
    end;

    local procedure EnsureUniqueOpenPlan()
    var
        ExistingPlan: Record "Appraisal Planning Header";
    begin
        if ("Employee No." = '') or ("Appraisal Period" = '') then
            exit;

        if "Planning Status" = "Planning Status"::"Appraisal Created" then
            exit;

        ExistingPlan.Reset();
        ExistingPlan.SetRange("Employee No.", "Employee No.");
        ExistingPlan.SetRange("Appraisal Period", "Appraisal Period");
        ExistingPlan.SetFilter("No.", '<>%1', "No.");
        ExistingPlan.SetFilter("Planning Status", '<>%1', ExistingPlan."Planning Status"::"Appraisal Created");
        if ExistingPlan.FindFirst() then
            Error('Appraisal planning %1 already exists for employee %2 in appraisal period %3.',
                ExistingPlan."No.", "Employee No.", "Appraisal Period");
    end;

    local procedure GetEmployeeJobTitle(EmployeeRecord: Record Employee): Text[100]
    begin
        if EmployeeRecord."Job Position Title" <> '' then
            exit(CopyStr(EmployeeRecord."Job Position Title", 1, 100));

        exit(CopyStr(EmployeeRecord."Job Title", 1, 100));
    end;
}
