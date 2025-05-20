table 51677 "Leave Adjustment Details"
{
    Caption = 'Leave Adjustment Details';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(4; "Employee No."; Code[20])
        {
            TableRelation = Employee;
        }
        field(6; "Processed Date"; Date)
        {
        }
        field(7; "Employee Name"; Text[30])
        {
            Editable = false;
        }
        field(8; "Leave Code"; Code[20])
        {
            TableRelation = "Employee Leave Application";
        }
        field(9; "No. Of Leaves"; Decimal)
        {
        }
        field(10; "Department Code"; Code[20])
        {
        }
    }
    keys
    {
        key(Key1; "No.", "Employee No.", "Leave Code")
        {
        }
    }
    var gRecEmployee: Record Employee;
    gRecLeaveAdjustmentHeader: Record "Leave Adjustment Header";
}
