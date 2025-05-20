table 51652 "Appraisal Qualitative Details"
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
        field(5; "Focus Area"; Text[30])
        {
        }
        field(6; Deliverable; Text[250])
        {
        }
        field(7; Score; Option)
        {
            OptionCaption = '1-Poor,2-Fair,3-Good,4-Very Good,5-Excellent';
            OptionMembers = "1-Poor", "2-Fair", "3-Good", "4-Very Good", "5-Excellent";
        }
        field(8; Section; Option)
        {
            OptionCaption = 'B,C';
            OptionMembers = B, C;
        }
        field(9; "Maximum Score"; Decimal)
        {
        }
        field(10; "Score/Rating"; Decimal)
        {
        }
        field(11; "Reviewer's Comments"; Text[250])
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
