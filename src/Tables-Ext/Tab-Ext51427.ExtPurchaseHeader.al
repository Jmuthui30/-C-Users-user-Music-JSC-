tableextension 51427 "ExtPurchase Header" extends "Purchase Header"
{
    fields
    {
        field(50000; "Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Last Printed by"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Last Print Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Last Print Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Last Print No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; Printed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "International LPO"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50009; Committed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; Uncommitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51423; "Order Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Local Purchase Order, Local Service Order';
            OptionMembers = "Local Purchase Order", "Local Service Order";
        }
        field(51424; "RFQ Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Created, Sent, Accepted, Rejected, Returned';
            OptionMembers = Created, Sent, Accepted, Rejected, Returned;
        }
        field(51425; "Reply Progress"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Purchase is updating, Vendor is updating, Submitted by purchaser, Submitted by vendor';
            OptionMembers = "Purchase is updating", "Vendor is updating", "Submitted by purchaser", "Submitted by vendor";
        }
        field(51426; "Purchase Order Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Open order, Received, Canceled, Invoiced';
            OptionMembers = "Open order", Received, Canceled, Invoiced;
        }
        field(51427; "Portal Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Unread, Read;
        }
        field(51428; Description; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(51429; RFQRemarks; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(51430; RFQTitle; Text[200])
        {
            DataClassification = CustomerContent;
        }
        field(51431; RFQNo; code[200])
        {
            DataClassification = CustomerContent;
        }
        field(51432; "Vendor Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Reg. Request"."No.";

            trigger OnValidate()
            var
                Vend: Record "Vendor Reg. Request";
            begin
                Vend.SetRange("No.", vend."No.");
                if Vend.FindFirst then begin
                    Rec."No.":=Vend."No.";
                    Rec.Modify;
                end;
            end;
        }
        field(51433; "Department"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(51434; "Invoice Attachment"; Text[500])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = url;
        }
    }
}
