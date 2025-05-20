table 50011 "Employee Information_Data"
{
    fields
    {
        field(1; "Payroll No."; Code[10])
        {
        }
        field(2; "Full Names"; Text[80])
        {
        }
        field(3; Gender; Text[30])
        {
        }
        field(4; "Job Title"; Text[30])
        {
        }
        field(5; Location; Text[30])
        {
        }
        field(6; "Department Code"; Code[20])
        {
        }
        field(7; "Date of Birth"; Date)
        {
        }
        field(8; "Joined Company"; Date)
        {
        }
        field(9; "ID Number"; Code[10])
        {
        }
        field(10; "PIN Number"; Code[20])
        {
        }
        field(11; "NSSF No."; Code[10])
        {
        }
        field(12; "SHIF No."; Code[10])
        {
        }
        field(13; Bank; Text[50])
        {
        }
        field(14; "Bank Code"; Code[10])
        {
        }
        field(15; "Branch Code"; Code[10])
        {
        }
        field(16; "Bank A/C"; Text[30])
        {
        }
        field(17; "Residential Address"; Text[30])
        {
        }
        field(18; "Remaining Leave Days"; Integer)
        {
        }
        field(19; "CSR Hours So far"; Integer)
        {
        }
        field(20; "Phone No."; Text[30])
        {
        }
        field(21; "Email Address"; Text[80])
        {
        }
        field(22; "Medical Outpatient Balance"; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; "Payroll No.")
        {
        }
    }
    fieldgroups
    {
    }
}
