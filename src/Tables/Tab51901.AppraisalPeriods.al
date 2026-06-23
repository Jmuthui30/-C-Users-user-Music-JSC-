table 51901 "Appraisal Periods"
{
    DrillDownPageID = "Appraisal Periods";
    LookupPageID = "Appraisal Periods";

    fields
    {
        field(1; Period; Code[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ValidateFinancialYearDates();
            end;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ValidateFinancialYearDates();
            end;
        } field(5; "Appraisal Category"; Code[20])
        {
            Caption = 'Appraisal Category';
        }
        field(6; Active; Boolean)
        {
            Caption = 'Active';
        }
        field(7; Type; Option)
        {
            OptionCaption = ' ,Mid-Year,Final Year';
            OptionMembers = " ","Mid-Year","Final Year";
            Caption = 'Type';
        }
        field(8; "Appraisal Type"; Option)
        {
            OptionCaption = ' ,Mid-Year,Final Year';
            OptionMembers = " ","Mid-Year","Final Year";
            Caption = 'Appraisal Type';
        }
        field(9; "Submission Due Date"; Date)
        {
            Caption = 'Submission Due Date';
        }
        field(10; Description;Text[250])
        {
            
        }
    }

    keys
    {
        key(Key1; Period)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Period, Description, "Start Date", "End Date")
        {
        }
    }

    var
        InvalidFinancialYearDatesErr: Label 'Appraisal period dates must follow the JSC financial year cycle: start on 1 July and end on 30 June of the following year.';

    local procedure ValidateFinancialYearDates()
    begin
        if ("Start Date" = 0D) or ("End Date" = 0D) then
            exit;

        if "End Date" <= "Start Date" then
            Error(InvalidFinancialYearDatesErr);

        if (Date2DMY("Start Date", 2) <> 7) or (Date2DMY("Start Date", 1) <> 1) then
            Error(InvalidFinancialYearDatesErr);

        if (Date2DMY("End Date", 2) <> 6) or (Date2DMY("End Date", 1) <> 30) then
            Error(InvalidFinancialYearDatesErr);

        if Date2DMY("End Date", 3) <> Date2DMY("Start Date", 3) + 1 then
            Error(InvalidFinancialYearDatesErr);
    end;
}
