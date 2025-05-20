table 51941 "Work Order Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Work Order Type"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Repair Type";
        }
        field(3; Active; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(4; Description; text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Service Level"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Repair Service Level";
        }
        field(6; Status;Enum "Document Status")
        {
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("work No", "No.");
                if Lines.Find('-')then begin
                    repeat Lines.Status:=Status;
                        Lines.Modify;
                    until Lines.Next = 0;
                end;
            end;
        }
        field(7; "Expected Start Date"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Expected End Date"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Scheduled Start Date"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Scheduled End Date"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Actual Start Date"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(12; "Actual End Date"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(13; Responsible; text[100])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(14; "Raised by"; code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "Repair Request Initiator"; text[100])
        {
            DataClassification = CustomerContent;
        }
        field(16; Reason; text[100])
        {
            DataClassification = CustomerContent;
        }
        field(17; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=FILTER(1));

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("Work No", "No.");
                if Lines.Find('-')then Lines.ModifyAll("Global Dimension 1 Code", "Global Dimension 1 Code");
            end;
        }
        field(19; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("Work No", "No.");
                if Lines.Find('-')then Lines.ModifyAll("Global Dimension 2 Code", "Global Dimension 2 Code");
            end;
        }
        field(20; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(21; "Fault Code"; code[20])
        {
            Caption = 'Fault Type';
            TableRelation = "Fault Code".Code where("Fault Area Code"=field("Fault Area"), "Symptom Code"=field("Fault Symptom"));
        }
        field(22; "Fault Symptom"; code[20])
        {
            Caption = 'Fault Symptom';
            TableRelation = "Symptom Code";
        }
        field(23; "No of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51941), "Document No."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(25; "Pending Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51941), "Document No."=FIELD("No."), Status=FILTER(Open|Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
        }
        field(26; "Empty No."; Boolean)
        {
            CalcFormula = Exist("Work Order Lines" WHERE(No=CONST(''), "Work No"=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(27; "SharePoint Link"; Text[250])
        {
        }
        field(28; "Fault Area"; code[20])
        {
            TableRelation = "Fault Area";
        }
        field(29; "Work Notes"; text[250])
        {
        }
        field(30; "Fault Date"; DateTime)
        {
        }
        field(31; "Country/Region Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(32; "Currency Code"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(33; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Quote,Order,Invoice';
            OptionMembers = Quote, Order, Invoice;
        }
        field(34; "Buy-from Vendor No."; code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
            TableRelation = Vendor;

            trigger OnValidate()
            var
                Vend: Record Vendor;
            begin
                if Vend.get("Buy-from Vendor No.")then begin
                    Vend.CheckBlockedVendOnDocs(Vend, FALSE);
                    Vend.TestField("Vendor Posting Group");
                    "Buy-from Vendor Name":=Vend.Name;
                    "Buy-from Address":=Vend.Address;
                    "Buy-from Contact":=Vend.Contact;
                    "Gen. Bus. Posting Group":=Vend."Gen. Bus. Posting Group";
                    "VAT Bus. Posting Group":=Vend."VAT Bus. Posting Group";
                    "Buy-from Country/Region Code":=Vend."Country/Region Code";
                    "Payment Terms Code":=Vend."Payment Method Code";
                    "Buy-from City":=Vend.City;
                    "Buy-from Post Code":=Vend."Post Code";
                end;
            end;
        }
        field(35; "Buy-from Vendor Name"; text[50])
        {
            DataClassification = CustomerContent;
        }
        field(36; "Buy-from Address"; text[50])
        {
            DataClassification = CustomerContent;
        }
        field(37; "Buy-from City"; text[30])
        {
            DataClassification = CustomerContent;
            TableRelation = IF("Buy-from Country/Region Code"=CONST(''))"Post Code".City
            ELSE IF("Buy-from Country/Region Code"=FILTER(<>''))"Post Code".City WHERE("Country/Region Code"=FIELD("Buy-from Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(38; "Buy-from Contact"; text[50])
        {
            DataClassification = CustomerContent;
        }
        field(39; "Work Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(40; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(41; "Vendor Posting Group"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Posting Group";
        }
        field(42; "On Hold"; code[10])
        {
            DataClassification = CustomerContent;
        }
        field(43; Receive; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(44; Invoice; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(45; Amount; Decimal)
        {
            CalcFormula = Sum("Work Order Lines".Amount WHERE("Work No"=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(46; "Vendor Order No."; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(47; "Vendor Invoice No."; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(48; "Buy-from Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = IF("Buy-from Country/Region Code"=CONST(''))"Post Code"
            ELSE IF("Buy-from Country/Region Code"=FILTER(<>''))"Post Code" WHERE("Country/Region Code"=FIELD("Buy-from Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(49; "Pay-to County"; text[30])
        {
            DataClassification = CustomerContent;
        }
        field(50; "Buy-from Country/Region Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(51; "Quote No."; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(52; "Repair Request No."; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(53; Priority; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Low,High,Medium';
            OptionMembers = Low, High, Medium;
        }
        field(54; "Work Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Unscheduled,Scheduled,InProgress,Completed,Closed,Canceled';
            OptionMembers = Unscheduled, Scheduled, InProgress, Completed, Closed, Canceled;
        }
        field(55; "Work Order Lifecycle State"; Option)
        {
            OptionCaption = 'New,Pending Approval,Released,Scheduled,InProgress,Completed,Finished;';
            OptionMembers = New, "Pending Approval", Released, Scheduled, InProgress, Completed, Finished;
        }
        field(56; Approvers; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51941), "Document No."=FIELD("No."), Status=FILTER(Approved)));
            FieldClass = FlowField;
            Caption = 'Approvers';
        }
        field(57; Trade; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Contractor,Electrician,Mechanic,Millwright,Maintenance,Operator';
            OptionMembers = , Contractor, Electrician, Mechanic, Millwright, Maintenance, Operator;
        }
        field(58; "Asset Location"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "FA Location";

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("Work No", "No.");
                if Lines.Find('-')then Lines.ModifyAll("Asset Location", "Asset Location");
            end;
        }
        field(59; "Payment Terms Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Gen. Bus. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "VAT Bus. Posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(62; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Posted Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Posted By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "WO Generated Directly"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    var Lines: Record "Work Order Lines";
    trigger OnInsert()
    begin
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
