table 51621 "Staff Orientation Header"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if EmpRec.Get("Employee No")then begin
                    "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                end;
                if NAVemp.Get("Employee No")then begin
                    "Mobile No":=NAVemp."Mobile Phone No.";
                    "Employment Date":=NAVemp."Employment Date";
                    "Employee Name":=NAVemp."Last Name" + ' ' + NAVemp."First Name" + ' ' + NAVemp."Middle Name";
                    "Job Title":=NAVemp."Job Title";
                    Validate(Manager, NAVemp."Manager No.");
                end;
            end;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(4; "Job Title"; Text[50])
        {
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(7; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(8; Manager; Code[20])
        {
            trigger OnValidate()
            begin
                if NAVemp.Get(Manager)then "Manager's Name":=NAVemp."First Name" + ' ' + NAVemp."Last Name";
            end;
        }
        field(9; "Manager's Name"; Text[100])
        {
        }
        field(10; "Created By"; Code[50])
        {
        }
        field(11; "Mobile No"; Text[20])
        {
        }
        field(12; "Employment Date"; Date)
        {
        }
        field(13; "Due Date"; Date)
        {
        }
        field(14; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(15; Closed; Boolean)
        {
            trigger OnValidate()
            begin
            /*"Closed By" := USERID;
                "Closed Date" := TODAY;*/
            end;
        }
        field(16; "Closed By"; Code[50])
        {
        }
        field(17; "Closed Date"; Date)
        {
        }
        field(18; "Hr Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        Date:=Today;
        "Created By":=UserId;
        Status:=Status::Open;
        if not "Hr Created" then begin
            if UserSetup.Get(UserId)then begin
                "Employee No":=UserSetup."Employee No.";
                Validate("Employee No");
            end
            else
                Error(Text000);
        end;
    end;
    var UserSetup: Record "User Setup";
    Text000: Label 'Your are not mapped to an employee account. Kindly contact the system administrator.';
    NAVemp: Record Employee;
    EmpRec: Record "Employee Master";
}
