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
            Caption = 'Shortcut Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));

            trigger OnValidate()
            begin
                //  ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(50008; "Global Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));

            trigger OnValidate()
            begin
                //  ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
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


        field(50090; "Delegated From"; Code[50])
        {
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
            Caption = 'Delegated From';
        }

        field(50012; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(50013; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(50094; "Imprest Account"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Customer;
            Caption = 'Imprest Account';
        }
        field(50095; "Post Journals"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'View Journals';
        }
        field(50096; "Post Bank Reconcilliation"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Post Bank Reconcilliation';
        }
        field(50097; "Allow Posting From [Time]"; Time)
        {
            Caption = 'Allow Posting From [Time]';
            DataClassification = CustomerContent;
        }
        field(50098; "Allow Posting To [Time]"; Time)
        {
            Caption = 'Allow Posting To [Time]';
            DataClassification = CustomerContent;
        }
        field(50099; "Show Hidden"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Show Hidden';
        }
        field(50080; "Reverse Register"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Reverse Register';
        }
        field(50081; "Multiple Login"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Multiple Login';
        }
        field(50082; "Post Reversals"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Post Reversals';
        }
        field(50083; "Allow Login After Hours"; Boolean)
        {
            Caption = 'Allow Login After Hours';
            DataClassification = SystemMetadata;
        }
        field(50084; "Request Admin"; Boolean)
        {
            Caption = 'Request Admin';
            DataClassification = SystemMetadata;
        }
        field(50085; "Approval Status"; Enum ApprovalStatus)
        {
            Caption = 'Approval Status';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(50086; "User Type"; Option)
        {
            Caption = 'User Type';
            DataClassification = SystemMetadata;
            OptionMembers = "Limited to User","View All","Approval Limits";
        }
        field(50087; "Last Password Change"; Date)
        {
            Caption = 'Last Password Change';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(50088; "Password Does Not Expire"; Boolean)
        {
            Caption = 'Password Does Not Expire';
            DataClassification = SystemMetadata;
        }
        field(50089; "Allow Multiple Login"; Boolean)
        {
            Caption = 'Allow Multiple Login';
            DataClassification = SystemMetadata;
        }
        field(50031; "View HR Information"; Boolean)
        {
            Caption = 'View HR Information';
            DataClassification = SystemMetadata;
        }
        field(50032; "Edit HR Information"; Boolean)
        {
            Caption = 'Edit HR Information';
            DataClassification = SystemMetadata;
        }
    }
    var
        userrec: Record User;
        QJUser: Record "User Setup";
}
