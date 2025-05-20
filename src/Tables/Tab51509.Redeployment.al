table 51509 "Redeployment"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if EmpRec.Get("Employee No")then begin
                    "From Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "From Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    //"From Dimension 3 Code" := EmpRec."Global Dimension 3 Code";
                    "From Grade":=EmpRec.Scale;
                    "From Level":=EmpRec.Level;
                    "From Establishment":=EmpRec.Position;
                    "From Title":=EmpRec."Job Title";
                end;
                if NAVemp.Get("Employee No")then "Name":=NAVemp.FullName();
            end;
        }
        field(3; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "From Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=FILTER(1));
        }
        field(5; "From Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=FILTER(2));
        }
        field(6; "From Establishment"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "From Title"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "From Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "From Level"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            OptionCaption = 'New,Approved,Old Line Manager Notified,New Line Manager Notified,Redeployment Letter Sent,Redeployment Completed,Stepped Down';
            OptionMembers = New, Approved, "Old Line Manager Notified", "New Line Manager Notified", "Redeployment Letter Sent", "Redeployment Completed", "Stepped Down";
            DataClassification = ToBeClassified;
        }
        field(11; "To Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,1';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=FILTER(1));
        }
        field(12; "To Dimension 2 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            CaptionClass = '1,1,2';
            Editable = true;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=FILTER(2));
        }
        field(13; "To Establishment"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = Positions;

            trigger OnValidate()
            begin
                if Job.Get("To Establishment")then begin
                    "To Title":=Job.Description;
                    "To Grade":=Job.Scale;
                    "To Level":=Job.Level;
                end;
            end;
        }
        field(14; "To Title"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "To Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "Salary Scale";
        }
        field(16; "To Level"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "Salary Level";
        }
        field(17; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Select; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Selected By":=UserId;
            end;
        }
        field(20; "Selected By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Date Approved"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Date Old Line Manager Notified"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Date New Line Manager Notified"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Date Redeployment Letter Sent"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Date Redeployment Completed"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Old Line Manager"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where(Status=const(Active));
        }
        field(27; "New Line Manager"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where(Status=const(Active));
        }
    }
    keys
    {
        key("No."; "No.")
        {
            Clustered = true;
        }
    }
    var Emp: Record Employee;
    EmpRec: Record "Employee Master";
    NAVEmp: Record Employee;
    Job: Record Positions;
    trigger OnInsert()
    var
        myInt: Integer;
        Redep: Record Redeployment;
        recCode: text[20];
        counters: Integer;
        startpad: text;
    begin
        startpad:='RDP';
        Redep.RESET;
        IF Redep.FINDLAST THEN BEGIN
            RECCode:=Redep."No.";
            RECCode:=DELSTR(RECCode, 1, 4);
            EVALUATE(counters, RECCode);
        END;
        // IF COUNTERS = 0 THEN
        counters:=counters + 1;
        RECCode:=(PADSTR('', 8 - STRLEN(FORMAT(counters)), '0') + FORMAT(counters));
        "No.":=startpad + RECCode;
        "Created Date":=Today;
        "Created By":=UserId;
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
