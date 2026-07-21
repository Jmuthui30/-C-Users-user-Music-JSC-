table 52601 "Appraisal Planning Line"
{
    Caption = 'Appraisal Planning Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Plan No."; Code[20])
        {
            Caption = 'Plan No.';
            TableRelation = "Appraisal Planning Header"."No.";
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            Editable = false;
            TableRelation = Employee."No.";
        }
        field(4; "Appraisal Period"; Code[20])
        {
            Caption = 'Appraisal Period';
            Editable = false;
            TableRelation = "Appraisal Periods".Period;
        }
        field(5; "Review Period Code"; Code[20])
        {
            Caption = 'Review Period';
            TableRelation = "Bal Score Preview Periods";
        }
        field(6; "Workplan Code"; Code[50])
        {
            Caption = 'Objective Code';
            TableRelation = "Appraisal Workplan Code".Code;//where("Workplan Code"= field("Department Code"));
            //where( "Workplan Code"= field("Department Code"));
            trigger OnValidate()
            begin
                PopulateWorkplanDetails();
                if xRec."Workplan Code" <> "Workplan Code" then begin
                    Clear("Performance Measure");
                    Clear("Perf. Measure Description");
                    Clear("Initiative Code");
                    Clear("Initiative Description");
                end;
            end;
        }
        field(7; "Workplan Description"; Text[250])
        {
            Caption = 'Objective';
            Editable = false;
        }
        field(8; "Performance Measure"; Code[50])
        {
            Caption = 'Performance Measure';
            TableRelation = "Appraisal Perfomance Measures".Code where("Workplan Code" = field("Workplan Code"));

            trigger OnValidate()
            begin
                PopulatePerformanceMeasureDetails();
            end;
        }
        field(9; "Perf. Measure Description"; Text[250])
        {
            Caption = 'Performance Measure Description';
            Editable = false;
        }
        field(10; "Initiative Code"; Code[50])
        {
            Caption = 'Initiative Code';
            TableRelation = "Strategic Imp Initiatives".Code where(ObjectiveCode = field("Workplan Code"));

            trigger OnValidate()
            begin
                PopulateInitiativeDetails();
            end;
        }
        field(11; "Initiative Description"; Text[250])
        {
            Caption = 'Initiative Description';
        }
        field(12; "Rating Allocation"; Decimal)
        {
            Caption = 'Rating Allocation';
            MinValue = 0;
            MaxValue = 80;

            trigger OnValidate()
            begin
                UpdateWeighting();
                ValidateReviewAllocation();
            end;
        }
        field(13; Target; Decimal)
        {
            Caption = 'Target';
            MinValue = 0;
        }
        field(14; Actual; Decimal)
        {
            Caption = 'Actual';
            Editable = false;
        }
        field(15; "Achieved (%)"; Decimal)
        {
            Caption = 'Achieved (%)';
            Editable = false;
        }
        field(16; "Weighting (%)"; Decimal)
        {
            Caption = 'Weighting (%)';
            Editable = false;
        }
        //Department Code
        field(17; "Department Code"; Code[200])
        {
            Caption = 'Department Code';
        }
    }

    keys
    {
        key(PK; "Plan No.", "Line No")
        {
            Clustered = true;
        }
        key(ReviewPeriod; "Plan No.", "Review Period Code")
        {
        }
    }

    trigger OnInsert()
    begin
        PopulateFromHeader();
        EnsureHeaderEditable();
        UpdateWeighting();
        ValidateReviewAllocation();
    end;

    trigger OnModify()
    begin
        EnsureHeaderEditable();
        UpdateWeighting();
        ValidateReviewAllocation();
    end;

    trigger OnDelete()
    begin
        EnsureHeaderEditable();
    end;

    procedure PopulateFromHeader()
    var
        PlanHeader: Record "Appraisal Planning Header";
    begin
        if "Plan No." = '' then
            exit;

        PlanHeader.Get("Plan No.");
        "Employee No." := PlanHeader."Employee No.";
        "Appraisal Period" := PlanHeader."Appraisal Period";
        "Department Code" := PlanHeader."Directorate Code";
    end;

    procedure UpdateWeighting()
    begin
        if "Rating Allocation" = 0 then
            "Weighting (%)" := 0
        else
            "Weighting (%)" := Round(("Rating Allocation" / 80) * 100, 0.01);

        Actual := 0;
        "Achieved (%)" := 0;
    end;

    procedure ValidateReviewAllocation()
    var
        PlanLine: Record "Appraisal Planning Line";
        TotalAllocation: Decimal;
    begin
        if ("Plan No." = '') or ("Review Period Code" = '') then
            exit;

        PlanLine.Reset();
        PlanLine.SetRange("Plan No.", "Plan No.");
        PlanLine.SetRange("Review Period Code", "Review Period Code");
        PlanLine.SetFilter("Line No", '<>%1', "Line No");
        if PlanLine.FindSet() then
            repeat
                TotalAllocation += PlanLine."Rating Allocation";
            until PlanLine.Next() = 0;

        TotalAllocation += "Rating Allocation";
        if TotalAllocation > 80 then
            Error('Total rating allocation for plan %1 review period %2 cannot exceed 80. Current total would be %3.',
                "Plan No.", "Review Period Code", Round(TotalAllocation, 0.01));
    end;

    local procedure EnsureHeaderEditable()
    var
        PlanHeader: Record "Appraisal Planning Header";
    begin
        if "Plan No." = '' then
            exit;

        PlanHeader.Get("Plan No.");
        PlanHeader.EnsureEditable();
    end;

    local procedure PopulateWorkplanDetails()
    var
        WorkplanCode: Record "Appraisal Workplan Code";
    begin
        Clear("Workplan Description");
        if "Workplan Code" = '' then
            exit;

        WorkplanCode.Get("Workplan Code");
        //setRange("Workplan Code", "Department Code");
        "Workplan Description" := WorkplanCode.Description;
    end;

    local procedure PopulatePerformanceMeasureDetails()
    var
        PerformanceMeasure: Record "Appraisal Perfomance Measures";
    begin
        Clear("Perf. Measure Description");
        if ("Workplan Code" = '') or ("Performance Measure" = '') then
            exit;

        PerformanceMeasure.Get("Workplan Code", "Performance Measure");
        "Perf. Measure Description" := PerformanceMeasure.Description;
    end;

    local procedure PopulateInitiativeDetails()
    var
        Initiative: Record "Strategic Imp Initiatives";
    begin
        Clear("Initiative Description");
        if ("Workplan Code" = '') or ("Initiative Code" = '') then
            exit;

        if Initiative.Get("Workplan Code", CopyStr("Initiative Code", 1, MaxStrLen(Initiative.Code))) then
            "Initiative Description" := Initiative.Initiatives;
    end;
}
