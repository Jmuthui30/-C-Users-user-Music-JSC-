table 51801 "Procurement Setup"
{
    // version THL- PRM 1.0
    DrillDownPageID = "Procurement Setup";
    LookupPageID = "Procurement Setup";

    fields
    {
        field(1; "Primary Key"; Integer)
        {
        }
        field(2; "Purchase Req No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Store Requisition Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(4; "Effective Procurement Plan"; Code[20])
        {
        }
        field(5; "Stores Control Email"; Text[80])
        {
        }
        field(6; "Store Issue Template"; Code[20])
        {
            TableRelation = "Item Journal Template";
        }
        field(7; "Store Issue Batch"; Code[20])
        {
        }
        field(8; "Enable Email Notification"; Boolean)
        {
        }
        field(9; "Store Receipt Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(10; "Store Issue Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(11; "Store Transfer Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(12; "Request for Quotation Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13; "Inspection Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(14; "Inspection Reviewer"; Text[50])
        {
        }
        field(15; "NBO PO Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(16; "KSM PO Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(17; "KCO PO Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(18; "International PO Address"; Text[50])
        {
        }
        field(19; "S_Store Requisition Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(20; "J_Store Requisition Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(21; "Tenders Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(22; "Appointment Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(23; "Request for Proposals Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(24; "Vendor Reg Req Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
            Caption = 'Vendor Registration Request Nos.';
        }
        field(25; "Procurement Plan No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(26; "Repair Requisition No."; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(27; "Work Order No."; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(28; "Mail No."; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }
    fieldgroups
    {
    }
}
