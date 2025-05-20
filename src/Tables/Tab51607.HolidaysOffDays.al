table 51607 "Holidays_Off Days"
{
    fields
    {
        field(1; Date; Date)
        {
            NotBlank = true;

            trigger OnValidate()
            begin
                GeneralOptions.Get;
                if not CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code", Date, Description)then Error('You can only enter a holiday or weekend');
            end;
        }
        field(2; Description; Text[150])
        {
        }
        field(3; "Employee No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if NAVEmp.Get("Employee No.")then begin
                    "Employee Name":=NAVEmp."First Name" + ' ' + NAVEmp."Middle Name" + ' ' + NAVEmp."Last Name";
                end;
            end;
        }
        field(4; "Employee Name"; Text[50])
        {
        }
        field(5; "Leave Type"; Code[20])
        {
            TableRelation = "Leave Setup";
        }
        field(6; "Maturity Date"; Date)
        {
        }
        field(7; "No. of Days"; Decimal)
        {
        }
        field(8; "Reason for Off"; Text[250])
        {
        }
        field(9; "Approved to Work"; Code[20])
        {
            TableRelation = Employee;
        }
    }
    keys
    {
        key(Key1; Date)
        {
        }
    }
    fieldgroups
    {
    }
    var GeneralOptions: Record "QuantumJumps HR Setup";
    CalendarMgmt: Codeunit "AL Calendar Management";
    NAVEmp: Record Employee;
}
