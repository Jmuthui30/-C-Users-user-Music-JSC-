table 51614 "Appraisal SubQuestions Entries"
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
        field(4; "Main Question No."; Code[10])
        {
        }
        field(5; "Sub-Question No."; Code[10])
        {
        }
        field(6; Question; Text[250])
        {
        }
        field(7; "Further Explanation"; Text[250])
        {
        }
        field(8; "Question Type"; Option)
        {
            OptionCaption = 'Single Question,Has Sub-Questions';
            OptionMembers = "Single Question", "Has Sub-Questions";
        }
        field(9; "Sub-Question Instructions"; Text[250])
        {
        }
        field(10; Response; Text[250])
        {
        }
        field(11; "Further Response"; Text[250])
        {
        }
        field(12; "Manager's Remarks"; Text[250])
        {
        }
        field(13; "My Rating"; Code[10])
        {
            TableRelation = "Appraisal Rating";
        }
        field(14; "Manager's Rating"; Code[10])
        {
            TableRelation = "Appraisal Rating";
        }
        field(15; Role; Option)
        {
            OptionCaption = 'Appraisee,Appraiser';
            OptionMembers = Appraisee, Appraiser;
        }
    }
    keys
    {
        key(Key1; "Employee No", "Review Start Date", "Review End Date", "Main Question No.", "Sub-Question No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if not PerformanceMgt.CheckAppraisalFormSubQEditable(Rec)then Error(Text002);
    end;
    trigger OnModify()
    begin
        if not PerformanceMgt.CheckAppraisalFormSubQEditable(Rec)then Error(Text002);
    end;
    trigger OnRename()
    begin
        if not PerformanceMgt.CheckAppraisalFormSubQEditable(Rec)then Error(Text002);
    end;
    var UserSetup: Record "User Setup";
    EmpRec: Record "Employee Master";
    NAVemp: Record Employee;
    AppraisalSetup: Record "Appraisal Setup";
    Text000: Label 'Your are not mapped to an employee account. Kindly contact the system administrator.';
    Text001: Label 'Appraisal has not been opened for any period. Kindly contact the HR department';
    Text002: Label 'A closed appraisal form cannot be modified.';
    PerformanceMgt: Codeunit "Performance Management";
}
