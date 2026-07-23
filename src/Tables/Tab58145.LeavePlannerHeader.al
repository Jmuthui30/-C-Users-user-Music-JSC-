table 58145 "Leave Planner Header"
{
    Caption = 'Leave Planner Header';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Leave Period"; Code[20])
        {
            Caption = 'Leave Period';
            DataClassification = CustomerContent;
            TableRelation = "Leave Period"."Leave Period Code";

            trigger OnValidate()
            begin
                LeavePlannerRec.Reset();
                LeavePlannerRec.SetRange("Leave Period", "Leave Period");
                if LeavePlannerRec.FindFirst()
                then
                    Error(LeavePeriodExistsErr, LeavePlannerRec."No.", "Leave Period");
            end;
        }
        field(3; Status; Enum "Approval Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(4; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(5; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        //Send Approval Request
        field(6; "Send Approval Date"; Date)
        {
            Caption = 'Send Approval Date';
            DataClassification = CustomerContent;
        }
        //Approval Date
        field(7; "Approval Date"; Date)
        {
            Caption = 'Approval Date';
            DataClassification = CustomerContent;
        }
        //Approved By
        field(8; "Approved By"; Code[50])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
        }
        //Rejected By
        field(9; "Rejected By"; Code[50])
        {
            Caption = 'Rejected By';
            DataClassification = CustomerContent;
        }
        //Rejected Date
        field(10; "Rejected Date"; Date)
        {
            Caption = 'Rejected Date';
            DataClassification = CustomerContent;
        }
        //Rejected Reason
        field(11; "Rejected Reason"; Text[250])
        {
            Caption = 'Rejected Reason';
            DataClassification = CustomerContent;
        }
        //Comments
        field(12; Comments; Text[250])
        {
            Caption = 'Comments';
            DataClassification = CustomerContent;
        }
        //Created Date Time
        field(13; "Created Date Time"; DateTime)
        {
            Caption = 'Created Date Time';
            DataClassification = CustomerContent;
        }
        //Employee Code
        field(14; "Employee Code"; Code[20])
        {
            Caption = 'Employee Code';
            DataClassification = CustomerContent;
            tableRelation = Employee."No.";
            trigger OnValidate()
            begin
                if EmployeeRec.Get("Employee Code") then begin
                    "Employee Name" := EmployeeRec.FullName();
                    "Shortcut Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code" := EmployeeRec."Global Dimension 2 Code";
                    "Mobile No" := EmployeeRec."Phone No.";
                    "Responsibility Center" := EmployeeRec."responsibility center";
                end;
            end;

        }
        //Emmployee Name
        field(15; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }
        // "User ID"
        field(16; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(52; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = filter(false));

            trigger OnValidate()
            begin
            end;
        }
        field(53; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = filter(false));

            trigger OnValidate()
            begin

            end;
        }
        // "Mobile No" 
        field(54; "Mobile No"; Code[20])
        {
            Caption = 'Mobile No';
            DataClassification = CustomerContent;
        }
        //  "Responsibility Center"
        field(55; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center';
            DataClassification = CustomerContent;
        }
        // "Email Adress" 
        field(56; "Email Adress"; Text[100])
        {
            Caption = 'Email Adress';
            DataClassification = CustomerContent;
        }


    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        HRSetup: Record "Human Resources Setup";
        LeavePlannerRec: Record "Leave Planner Header";
        NoSeriesMgt: Codeunit "No. Series";
        LeavePeriodExistsErr: Label 'Another Leave Planner Document %1 for %2 Leave Period already exists';
        EmployeeRec: Record Employee;
        UserSertup: Record "User Setup";
        // "Leave Period"."Leave Period Code";
        LeavePeriodRec: Record "Leave Period";

    trigger OnInsert()
    begin
        HRSetup.Get();
        HRSetup.Testfield("Leave Plan Nos");
        if NoSeriesMgt.AreRelated(HRSetup."Leave Plan Nos", xRec."No. Series") then
            "No. Series" := xRec."No. Series"
        else
            "No. Series" := HRSetup."Leave Plan Nos";
        "No." := NoSeriesMgt.GetNextNo("No. Series", WorkDate());


        "User ID" := UserId;

        if GuiAllowed then begin
            UserSertup.Get("User ID");
            UserSertup.TestField("Employee No.");
            EmployeeRec.Get(UserSertup."Employee No.");
            "Employee Code" := EmployeeRec."No.";
            "Employee Name" := EmployeeRec.FullName();
            "Mobile No" := EmployeeRec."Phone No.";
            "Shortcut Dimension 1 Code" := EmployeeRec."Global Dimension 1 Code";
            "Shortcut Dimension 2 Code" := EmployeeRec."Global Dimension 2 Code";
            "Responsibility Center" := EmployeeRec."responsibility center";
            "Email Adress" := EmployeeRec."Company E-Mail";
        end else
            Validate("Employee Code");

        LeavePeriodRec.Get();
        leaveperiodRec.FindLast();
        "Leave Period" := LeavePeriodRec."Leave Period Code";

    end;
}






