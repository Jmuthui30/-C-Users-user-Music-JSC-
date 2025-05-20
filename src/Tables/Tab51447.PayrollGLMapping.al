table 51447 "Payroll GL Mapping"
{
    fields
    {
        field(1; Group; Code[20])
        {
            TableRelation = "Employee Groups";

            trigger OnValidate()
            begin
                if EmployeeGroups.Get(Group)then "Group Name":=EmployeeGroups.Description;
            end;
        }
        field(2; Type; Option)
        {
            OptionCaption = 'Earning,Deduction';
            OptionMembers = Earning, Deduction;
        }
        field(3; "ED Code"; Code[20])
        {
            TableRelation = IF(Type=CONST(Earning))Earnings
            ELSE IF(Type=CONST(Deduction))Deductions;

            trigger OnValidate()
            begin
                if Type = Type::Earning then begin
                    if EarningsRec.Get("ED Code")then "ED Name":=EarningsRec.Description;
                end
                else
                begin
                    if DeductionsRec.Get("ED Code")then "ED Name":=DeductionsRec.Description;
                end;
            end;
        }
        field(4; "Group Name"; Text[30])
        {
        }
        field(5; "ED Name"; Text[30])
        {
        }
        field(6; "Employee G/L Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(7; "Employer G/L Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
    }
    keys
    {
        key(Key1; Group, Type, "ED Code")
        {
        }
    }
    fieldgroups
    {
    }
    var EmployeeGroups: Record "Employee Groups";
    EarningsRec: Record Earnings;
    DeductionsRec: Record Deductions;
}
