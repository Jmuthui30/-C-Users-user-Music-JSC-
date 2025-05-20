table 51805 "RFQ Header"
{
    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;
        }
        field(2; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(3; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(4; Remarks; Text[50])
        {
        }
        field(5; "Ship-To-Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code;

            trigger OnValidate()
            begin
                ShipToAddress.Reset;
                ShipToAddress.SetRange(Code, "Ship-To-Code");
                if ShipToAddress.FindFirst then begin
                    "Ship-To-Name":=ShipToAddress.Name;
                    "Ship-To-Address":=ShipToAddress.Address;
                end;
            end;
        }
        field(6; "Ship-To-Name"; Text[30])
        {
        }
        field(7; "Ship-To-Address"; Text[30])
        {
        }
        field(8; "Expected Opening Date"; Date)
        {
        }
        field(9; "Expected Closing Date"; Date)
        {
        }
        field(10; "Location Code"; Code[10])
        {
            TableRelation = Location;
        }
        field(11; Status;Enum "Document Status")
        {
        }
        field(12; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13; "Created By"; Code[50])
        {
        }
        field(14; "Created Date"; Date)
        {
        }
        field(15; "Responsibility Centre"; Code[10])
        {
            TableRelation = "Responsibility Center";
        }
        field(16; "Requisition No."; Code[20])
        {
        }
        field(17; "RFP/RFQ Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'RFP,RFQ';
            OptionMembers = RFP, RFQ;
        }
        field(18; Title; text[50])
        {
            DataClassification = CustomerContent;
        }
        field(19; Description; text[250])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Empty No."; Boolean)
        {
            CalcFormula = Exist("RFQ Lines" WHERE(No=CONST(''), "RFQ No"=FIELD(No)));
            FieldClass = FlowField;
        }
        field(21; "RFQ Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Created, Sent, Accepted, Rejected, Returned';
            OptionMembers = Created, Sent, Accepted, Rejected, Returned;
        }
        field(22; "Pending Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51805), "Document No."=FIELD(No), Status=FILTER(Open|Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
        }
        field(23; Approvers; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51805), "Document No."=FIELD(No), Status=FILTER(Approved)));
            FieldClass = FlowField;
            Caption = 'Approvers';
        }
    }
    keys
    {
        key(Key1; No)
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if(No = '')then begin
            PurchaseSetup.Get;
            PurchaseSetup.TestField("Request for Quotation Nos.");
            NoSeriesMgt.InitSeries(PurchaseSetup."Request for Quotation Nos.", xRec.No, 0D, No, "No. Series");
        end;
        "Created Date":=Today;
        "Created By":=UserId;
    end;
    var ShipToAddress: Record "Ship-to Address";
    PurchaseSetup: Record "Procurement Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
