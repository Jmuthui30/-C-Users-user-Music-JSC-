table 51646 "Training Nominees"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.")then begin
                    "Staff Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    if Emp."Company E-Mail" <> '' then "Email Address":=Emp."Company E-Mail"
                    else
                        "Email Address":=Emp."E-Mail";
                end;
            end;
        }
        field(3; "Staff Name"; Text[100])
        {
        }
        field(4; "Email Address"; Text[80])
        {
        }
    }
    keys
    {
        key(Key1; "No.", "Employee No.")
        {
        }
    }
    fieldgroups
    {
    }
    var Emp: Record Employee;
}
