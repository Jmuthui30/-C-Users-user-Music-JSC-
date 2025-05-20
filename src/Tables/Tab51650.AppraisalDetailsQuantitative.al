table 51650 "Appraisal Details Quantitative"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
        }
        field(2; "Review Start Date"; Date)
        {
        }
        field(3; "Review End Date"; Date)
        {
        }
        field(4; "No."; Code[10])
        {
        }
        field(5; Deliverable; Text[250])
        {
        }
        field(6; "Further Explanation"; Text[250])
        {
        }
        field(7; "Marks Base"; Decimal)
        {
        }
        field(8; "Score (Appraisee)"; Decimal)
        {
        }
        field(9; "Score (Reviewer)"; Decimal)
        {
        }
        field(10; Timeline; Text[100])
        {
        }
    }
    keys
    {
        key(Key1; "Employee No", "Review Start Date", "Review End Date", "No.")
        {
        }
    }
    fieldgroups
    {
    }
    var UserSetup: Record "User Setup";
    EmpRec: Record "Employee Master";
    NAVemp: Record Employee;
    AppraisalSetup: Record "Appraisal Setup";
    Text000: Label 'Your are not mapped to an employee account. Kindly contact the system administrator.';
    Text001: Label 'Appraisal has not been opened for any period. Kindly contact the HR department';
    PerformanceMgt: Codeunit "Performance Management";
    Text002: Label 'A closed appraisal form cannot be modified.';
}
