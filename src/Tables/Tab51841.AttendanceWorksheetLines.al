table 51841 "Attendance Worksheet Lines"
{
    // version THL- PRM 1.0
    DrillDownPageID = "Attendance Lines";
    LookupPageID = "Attendance Lines";

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if AttendanceWorksheetHeader.Get("Document No.")then begin
                    "Posting Date":=AttendanceWorksheetHeader."Posting Date";
                    "Shortcut Dimension 1 Code":=AttendanceWorksheetHeader."Shortcut Dimension 1 Code";
                end;
            end;
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,External,Management';
            OptionMembers = " ", External, Management;
        }
        field(4; "Posting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Absent,Late,Overtime';
            OptionMembers = " ", Absent, Late, Overtime;
        }
        field(5; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=CONST(External))"Client Employee Master"."No." WHERE("Global Dimension 1 Code"=FIELD("Shortcut Dimension 1 Code"))
            ELSE IF(Type=CONST(Management))Employee."No.";

            trigger OnValidate()
            begin
                if AttendanceWorksheetHeader.Get("Document No.")then begin
                    AttendanceWorksheetHeader.TestField("Working Date");
                    "Working Date":=AttendanceWorksheetHeader."Working Date";
                    if Type = Type::External then begin
                        AttendanceWorksheetHeader.TestField("Shortcut Dimension 1 Code");
                        if ClientEmployeeMaster.Get("No.")then "Employee Name":=ClientEmployeeMaster."First Name" + ' ' + ClientEmployeeMaster."Middle Name" + ' ' + ClientEmployeeMaster."Last Name";
                    end
                    else if Type = Type::Management then begin
                            if Employee.Get("No.")then "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                        end;
                end;
                if "Posting Type" = Rec."Posting Type"::" " then Error('Posting Type Cannot be Null!');
            end;
        }
        field(6; Present; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Absent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Normal Overtime"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; Hours; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Working Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; Reason; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));
        }
        field(14; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Special Overtime"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Line No")
        {
        }
        key(Key2; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        TestField(Posted, false);
    end;
    trigger OnModify()
    begin
    //TESTFIELD(Posted,FALSE);
    end;
    var AttendanceWorksheetHeader: Record "Attendance Worksheet Header";
    ClientEmployeeMaster: Record "Client Employee Master";
    Employee: Record Employee;
    editable: Boolean;
}
