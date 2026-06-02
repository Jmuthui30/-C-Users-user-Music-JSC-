table 51503 "Bal Score Preview Periods"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Bal Score Preview Periods";
    LookupPageId = "Bal Score Preview Periods";
    Caption = 'Appraisal Review Periods';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Preview Period Type"; Option)
        {
            OptionMembers = " ", "First Period Appraisal", "Full Period Appraisal";
        }
        field(4; "Review Sequence"; Integer)
        {
            DataClassification = ToBeClassified;
            MinValue = 1;
            MaxValue = 99;

            trigger OnValidate()
            var
                ReviewPeriod: Record "Bal Score Preview Periods";
            begin
                if "Review Sequence" <> 0 then begin
                    ReviewPeriod.Reset();
                    ReviewPeriod.SetFilter(Code, '<>%1', Code);
                    ReviewPeriod.SetRange("Review Sequence", "Review Sequence");
                    if ReviewPeriod.FindFirst() then
                        Error('Review sequence %1 is already assigned to review period %2.', "Review Sequence", ReviewPeriod.Code);
                end;

                if "Quarter No." <> "Review Sequence" then
                    "Quarter No." := "Review Sequence";

                SetPreviewPeriodTypeFromSequence();
            end;
        }
        field(5; "Quarter No."; Integer)
        {
            DataClassification = ToBeClassified;
            MinValue = 1;
            MaxValue = 99;

            trigger OnValidate()
            begin
                if "Review Sequence" = 0 then
                    Validate("Review Sequence", "Quarter No.")
                else
                    SetPreviewPeriodTypeFromSequence();
            end;
        }
        field(6; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Closed; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(10; "Final Review Period"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                ReviewPeriod: Record "Bal Score Preview Periods";
            begin
                if "Final Review Period" then begin
                    TestField("Review Sequence");

                    ReviewPeriod.Reset();
                    ReviewPeriod.SetFilter(Code, '<>%1', Code);
                    ReviewPeriod.SetRange("Final Review Period", true);
                    if ReviewPeriod.FindSet() then
                        repeat
                            ReviewPeriod."Final Review Period" := false;
                            ReviewPeriod.SetPreviewPeriodTypeFromSequence();
                            ReviewPeriod.Modify(true);
                        until ReviewPeriod.Next() = 0;
                end;

                SetPreviewPeriodTypeFromSequence();
            end;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
        key(Sequence; "Review Sequence")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Name, "Review Sequence", "Quarter No.", "Final Review Period", "Preview Period Type")
        {
        }
        fieldgroup(Brick; Code, Name, "Review Sequence", "Quarter No.", "Final Review Period", "Preview Period Type")
        {
        }
    }

    procedure SetPreviewPeriodTypeFromSequence()
    begin
        if "Final Review Period" then begin
            "Preview Period Type" := "Preview Period Type"::"Full Period Appraisal";
            exit;
        end;

        if "Review Sequence" = 1 then
            "Preview Period Type" := "Preview Period Type"::"First Period Appraisal"
        else
            "Preview Period Type" := "Preview Period Type"::" ";
    end;
}
