table 51613 "Appraisal Questions Entries"
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
        field(5; Question; Text[250])
        {
        }
        field(6; "Further Explanation"; Text[250])
        {
        }
        field(7; "Question Type"; Option)
        {
            OptionCaption = 'Single Question,Has Sub-Questions';
            OptionMembers = "Single Question", "Has Sub-Questions";
        }
        field(8; "Sub-Question Instructions"; Text[250])
        {
        }
        field(9; Response; Text[250])
        {
        }
        field(10; "Further Response"; Text[250])
        {
        }
        field(11; "Manager's Remarks"; Text[250])
        {
        }
        field(12; "My Rating"; Code[10])
        {
            TableRelation = "Appraisal Rating";
        }
        field(13; "Manager's Rating"; Code[10])
        {
            TableRelation = "Appraisal Rating";
        }
        field(14; Role; Option)
        {
            OptionCaption = 'Appraisee,Appraiser';
            OptionMembers = Appraisee, Appraiser;
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
    trigger OnDelete()
    begin
        if not PerformanceMgt.CheckAppraisalFormQEditable(Rec)then Error(Text002);
    end;
    trigger OnModify()
    begin
        if not PerformanceMgt.CheckAppraisalFormQEditable(Rec)then Error(Text002);
    end;
    trigger OnRename()
    begin
        if not PerformanceMgt.CheckAppraisalFormQEditable(Rec)then Error(Text002);
    end;
    var UserSetup: Record "User Setup";
    EmpRec: Record "Employee Master";
    NAVemp: Record Employee;
    AppraisalSetup: Record "Appraisal Setup";
    Text000: Label 'Your are not mapped to an employee account. Kindly contact the system administrator.';
    Text001: Label 'Appraisal has not been opened for any period. Kindly contact the HR department';
    PerformanceMgt: Codeunit "Performance Management";
    Text002: Label 'A closed appraisal form cannot be modified.';
}
