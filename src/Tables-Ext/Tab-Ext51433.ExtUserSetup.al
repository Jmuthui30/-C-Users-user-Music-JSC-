tableextension 51433 "ExtUser Setup" extends "User Setup"
{
    fields
    {
        // Add changes to table fields here
        Modify("User ID")
        {
            trigger OnAfterValidate()
            begin
                userrec.setrange("User Name", "User ID");
                if userrec.FindFirst() then begin
                    "User Security ID" := userrec."User Security ID";
                    State := userrec.State;
                    "Full Name" := userrec."Full Name";
                end;
            end;
        }
        field(50000; Signature; Blob)
        {
            Compressed = false;
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50001; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(50002; HOD; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(50003; "Immediate Supervisor"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(50004; "Not Available"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Not Available" = true then begin
                    "Marked By" := UserId;
                    "Date Not Available" := Today;
                    Modify;
                end;
            end;
        }
        field(50005; "Date Not Available"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Marked By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'State';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('STATES'));
        }
        field(50009; "Global Dimension 3 Code"; Code[20])
        {
            Caption = 'Region';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('REGION'));
        }
        field(50010; "Global Dimension 4 Code"; Code[20])
        {
            Caption = 'Branch';
            DataClassification = ToBeClassified;
            // TableRelation = "Dimension Value".Code WHERE("Dimension Code" = CONST('BRANCH'),
            //                                               "State Code" = FIELD("Global Dimension 2 Code"));
        }
        field(50011; "Signature Url"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Full Name"; Text[80])
        {
            Caption = 'Full Name';
        }
        field(50015; "User Security ID"; Guid)
        {
            Caption = 'User Security ID';
            Editable = false;
        }
        field(50016; State; Option)
        {
            Caption = 'State';
            OptionCaption = 'Enabled,Disabled';
            OptionMembers = Enabled,Disabled;
        }
        field(50017; "Employee ID"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Agent Code"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; CX; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50020; CP; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Budget Holder"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "CP Available"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; Payroll; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "HR Admin"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Password"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Password';
        }
        field(50026; "In Management"; Boolean)
        {
        }
        field(60003; "Customer No."; Code[20])
        {
            TableRelation = Customer;
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
        }
        field(60011; "Responsibility Centre"; Code[10])
        {
            AccessByPermission = tabledata "Responsibility Center" = RIMD;
            DataClassification = CustomerContent;
            TableRelation = "Responsibility Center";
            Caption = 'Responsibility Center';
        }
        field(60007; "Show All"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Show All';
        }
        field(60005; "HOD User"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'HOD User';
        }
        field(60006; "HOD Imprest Approver"; Code[60])
        {
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
            Caption = 'HOD Imprest Approver';
        }
    }
    var
        userrec: Record User;
        QJUser: Record "User Setup";
}
