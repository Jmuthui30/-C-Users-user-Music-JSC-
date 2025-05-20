table 51500 "Bal Score Card Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HumanResSetup.Get;
                    if "Document Type" = "Document Type"::Planning then NoSeriesMgt.TestManual(HumanResSetup."Bal Planning Score Card Nos")
                    else if "Document Type" = "Document Type"::Appraisal then NoSeriesMgt.TestManual(HumanResSetup."Bal Appraisal Score Card Nos");
                    "No. series":='';
                end;
            end;
        }
        field(2; Date; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            Caption = 'Staff Number';
            TableRelation = Employee."No.";
            Editable = false;

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.")then begin
                    "Employee Name":=Emp.FullName();
                    Position:=Emp."Job Title";
                    "Employee's Department":=Emp."Global Dimension 1 Code";
                    "Employee's Branch":=Emp."Global Dimension 2 Code";
                    if NavEmp.Get(Emp."No.")then "Bal Score Emp Categories":=NavEmp."Bal Score Emp Categories";
                end;
            end;
        }
        field(5; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
            Editable = false;
        }
        field(6; Position; Text[100])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Employee's Department"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
            Editable = false;
        }
        field(8; "Employee's Branch"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
            Editable = false;
        }
        field(9; Supervisor; Code[20])
        {
            Caption = 'Staff Number';
            TableRelation = Employee."No.";
            Editable = false;

            trigger OnValidate()
            begin
                if Emp.Get(Supervisor)then begin
                    "Supervisor's Name":=Emp.FullName();
                    "Supervisor's Position":=Emp."Job Title";
                    "Supervisor's Department":=Emp."Global Dimension 1 Code";
                    "Supervisor's Branch":=Emp."Global Dimension 2 Code";
                end;
            end;
        }
        field(10; "Supervisor's Name"; Text[100])
        {
            Editable = false;
            Caption = 'Supervisor';
        }
        field(11; "Supervisor's Position"; Text[100])
        {
            Editable = false;
            Caption = 'Position';
        }
        field(12; "Supervisor's Department"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
            Editable = false;
        }
        field(13; "Supervisor's Branch"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
            Editable = false;
        }
        field(14; "No. series"; Code[10])
        {
            TableRelation = "No. Series";
            Editable = false;
        }
        field(15; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(16; "Plan / Review Period Code"; Code[20])
        {
            Editable = false;
        }
        field(17; "Plan / Review Period"; Text[50])
        {
            Editable = false;
            CalcFormula = Lookup("Bal Score Plan Review Period".Name WHERE(Code=FIELD("Plan / Review Period Code")));
            FieldClass = FlowField;
        }
        field(18; "Document Type"; Option)
        {
            OptionMembers = Planning, Appraisal;
            Editable = false;
        }
        field(19; "Appraisal Doc No"; Code[20])
        {
            TableRelation = "Bal Score Card Header" where("Document Type"=const(Appraisal));
            Editable = false;
        }
        field(20; "Progress Review Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bal Score Preview Periods";
            Editable = false;
        }
        field(21; "Planning Doc No"; Code[20])
        {
            TableRelation = "Bal Score Card Header" where("Document Type"=const(Planning));
            Editable = false;
        }
        field(22; Score; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bal Score Card Lines".Score where(DocNo=field("No."), Type=filter(<>Global)));
            Editable = false;
        }
        field(24; "Rating Score"; Decimal)
        {
            TableRelation = "Bal Score Card Rating";
            MaxValue = 5;
        }
        field(25; Rating; Text[50])
        {
            Editable = false;
            CalcFormula = Lookup("Bal Score Card Rating".Name WHERE(Score=FIELD("Rating Score")));
            FieldClass = FlowField;
        }
        field(26; "Bal Score Emp Categories"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bal Score Emp Categories";
            Editable = false;
            Caption = 'Scoring Category';
        }
        field(27; "Global Score"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bal Score Card Lines".Score where(DocNo=field("No."), Type=const(Global)));
            Editable = false;
        }
        field(28; "Expected Global Score"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bal Score Card Lines"."Expected Max Score" where(DocNo=field("No."), Type=const(Global)));
            Editable = false;
        }
        field(29; "Expected Score"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Bal Score Card Lines"."Expected Max Score" where(DocNo=field("No."), Type=filter(<>Global)));
            Editable = false;
        }
        field(30; "Appraisee Comment"; Text[250])
        {
        }
        field(31; "Appraiser Recommendations"; Text[250])
        {
        }
        field(32; "HR's Review"; Text[250])
        {
        }
        field(33; "Performance Rating"; Code[10])
        {
            Editable = false;
        }
        field(34; "Combined Score"; Decimal)
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    var Emp: Record Employee;
    NavEmp: Record "Employee Master";
    PlanReviewPeriod: Record "Bal Score Plan Review Period";
    HumanResSetup: Record "QuantumJumps HR Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    PreviewPeriod: Record "Bal Score Preview Periods";
    FiscalStart: Date;
    MaturityDate: Date;
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HumanResSetup.Get;
            if "Document Type" = "Document Type"::Planning then begin
                HumanResSetup.TestField("Bal Planning Score Card Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Bal Planning Score Card Nos", xRec."No. series", 0D, "No.", "No. series");
            end;
            if "Document Type" = "Document Type"::Appraisal then begin
                HumanResSetup.TestField("Bal Appraisal Score Card Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Bal Appraisal Score Card Nos", xRec."No. series", 0D, "No.", "No. series");
            end;
        end;
        "Created By":=UserId;
        Date:=Today;
        FindMaturityDate;
        PlanReviewPeriod.Reset();
        PlanReviewPeriod.SetRange(Active, true);
        PlanReviewPeriod.SetRange(FiscalStart, FiscalStart);
        PlanReviewPeriod.SetRange(MaturityDate, MaturityDate);
        if PlanReviewPeriod.FindFirst()then "Plan / Review Period Code":=PlanReviewPeriod.Code;
    end;
    procedure FindMaturityDate()
    var
        AccPeriod: Record "Accounting Period";
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+')then begin
            FiscalStart:=AccPeriod."Starting Date";
            MaturityDate:=CalcDate('1Y', FiscalStart) - 1;
        end;
    end;
}
