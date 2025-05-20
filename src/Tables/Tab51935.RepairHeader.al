table 51935 "Repair Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Employee Code"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if "RR Created" then begin
                    UsersRec.Reset;
                    UsersRec.SetRange("Employee No.", "Employee Code");
                    if UsersRec.FindFirst then begin
                        "Requested For":=UsersRec."User ID";
                        "Purchaser Code":=UsersRec."User ID";
                    /* if EmpRec.Get(UsersRec."Employee No") then begin
                             "Global Dimension 1 Code" := EmpRec."Global Dimension 1 Code";
                             "Global Dimension 2 Code" := EmpRec."Global Dimension 2 Code";
                         end;*/
                    end;
                end;
                //Ibrahim Wasiu, Date: 4th June 2021
                if EmpRec.Get("Employee Code")then begin
                    "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                end;
                if NAVemp.Get("Employee Code")then "Employee Name":=NAVemp.FullName();
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(5; Reason; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Repair Start Date"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(7; Status;Enum "Document Status")
        {
            Caption = 'Status';
            Editable = false;

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("Repair No", "No.");
                if Lines.Find('-')then begin
                    repeat Lines.Status:=Status;
                        Lines.Modify;
                    until Lines.Next = 0;
                end;
            end;
        }
        field(8; "Raised by"; Code[50])
        {
            Editable = false;
        }
        field(9; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(10; Rejected; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=FILTER(1));

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("Repair No", "No.");
                if Lines.Find('-')then Lines.ModifyAll("Global Dimension 1 Code", "Global Dimension 1 Code");
            end;
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("Repair No", "No.");
                if Lines.Find('-')then Lines.ModifyAll("Global Dimension 2 Code", "Global Dimension 2 Code");
            end;
        }
        field(13; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(14; "Procurement Plan"; Code[20])
        {
            Editable = false;
        }
        field(15; "Fault Type"; code[20])
        {
            TableRelation = "Fault Code".Code where("Fault Area Code"=field("Fault Area"), "Symptom Code"=field("Fault Symptom"));
        }
        field(17; "Fault Symptom"; code[20])
        {
            TableRelation = "Symptom Code";
        }
        field(18; Posted; Boolean)
        {
        }
        field(19; "No of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51935), "Document No."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; Select; Boolean)
        {
        }
        field(21; "Selected By"; Code[50])
        {
        }
        field(22; "Location Code"; Code[20])
        {
            TableRelation = Location;
        }
        field(23; Received; Boolean)
        {
        }
        field(24; "Received From"; Text[80])
        {
        }
        field(25; "Received Date"; Date)
        {
        }
        field(26; Issued; Boolean)
        {
        }
        field(27; "Issued By"; Code[50])
        {
        }
        field(28; "Issued Date"; Date)
        {
        }
        field(29; "RR Closed"; Boolean)
        {
        }
        field(30; "RR Closed By"; Option)
        {
            OptionCaption = ' ,Direct Receipt of Goods/Services,Work Order,Rejection';
            OptionMembers = " ", "Direct Receipt of Goods/Services", "Work Order", Rejection;
        }
        field(31; "Closed Date"; Date)
        {
        }
        field(32; "Closed By"; Code[50])
        {
        }
        field(33; "Quantity Requested"; Decimal)
        {
            CalcFormula = Sum("Repair Lines".Quantity WHERE("Repair No"=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(34; Amount; Decimal)
        {
            CalcFormula = Sum("Repair Lines".Amount WHERE("Repair No"=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(35; "Reason Code"; Code[50])
        {
            TableRelation = "Expense Codes";

            trigger OnValidate()
            begin
                if Expenses.Get("Reason Code")then begin
                    Reason:=Expenses.Description;
                    "Account Type":=Expenses."Account Type";
                    "Account No":=Expenses."Account No";
                end;
            end;
        }
        field(36; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Vendor,Customer,Item,Fixed Asset';
            OptionMembers = "G/L Account", Vendor, Customer, Item, "Fixed Asset";
        }
        field(37; "Account No"; Code[20])
        {
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account" WHERE("Account Type"=CONST(Posting), Blocked=CONST(false))
            ELSE IF("Account Type"=CONST(Vendor))Vendor
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST(Item))Item
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset";
        }
        field(38; "Requested For"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup";

            trigger OnValidate()
            begin
                if UsersRec.Get("Requested For")then begin
                    if EmpRec.Get(UsersRec."Employee No.")then begin
                        "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                        "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                        "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                    end;
                end;
            end;
        }
        field(39; "Purchaser Code"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup";
        }
        field(40; "Needed By Date"; Date)
        {
        }
        field(41; "Expiration Date"; Date)
        {
        }
        field(42; "Supplier No"; Code[20])
        {
            TableRelation = Vendor;
        }
        field(43; "WO Generated Directly"; Boolean)
        {
        }
        field(44; "WO Generated By"; Code[50])
        {
        }
        field(45; "WO Generated Date"; Date)
        {
        }
        field(46; "WO Number"; Code[20])
        {
        }
        field(47; "Pending Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51935), "Document No."=FIELD("No."), Status=FILTER(Open|Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
        }
        field(48; "Empty No."; Boolean)
        {
            CalcFormula = Exist("Repair Lines" WHERE(No=CONST(''), "Repair No"=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(49; "SharePoint Link"; Text[250])
        {
        }
        field(50; "Repair Type"; code[20])
        {
            TableRelation = "Repair Type";
        }
        field(51; "Repair Service Level"; code[20])
        {
            TableRelation = "Repair Service Level";
        }
        field(52; "Job No."; Code[20])
        {
        }
        field(53; "Job Task No."; Code[20])
        {
        }
        field(54; "Job Description"; Text[100])
        {
        }
        field(55; "Service Order No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(56; "Service Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(57; "Service Order Desc."; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(58; "RR Created"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(59; "SSP Created"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60; "Fault Area"; code[20])
        {
            TableRelation = "Fault Area";
        }
        field(61; "Repair Notes"; text[250])
        {
        }
        field(62; "Repair End Date"; DateTime)
        {
        }
        field(63; Responsible; code[20])
        {
            TableRelation = Resource;
        }
        field(64; "Fault Date"; DateTime)
        {
        }
        field(65; "Country/Region Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
        field(66; "Currency Code"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency;
        }
        field(67; "Work Order No."; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(68; Approvers; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51935), "Document No."=FIELD("No."), Status=FILTER(Approved)));
            FieldClass = FlowField;
            Caption = 'Approvers';
        }
        field(69; Trade; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = ' ,Contractor,Electrician,Mechanic,Millwright,Maintenance,Operator';
            OptionMembers = , Contractor, Electrician, Mechanic, Millwright, Maintenance, Operator;
        }
        field(70; "Asset Location"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "FA Location";

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("Repair No", "No.");
                if Lines.Find('-')then Lines.ModifyAll("Asset Location", "Asset Location");
            end;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    trigger OnInsert()
    begin
        PurchSetup.Get;
        if "No." = '' then begin
            PurchSetup.TestField("Repair Requisition No.");
            NoSeriesMgt.InitSeries(PurchSetup."Repair Requisition No.", xRec."No.", 0D, "No.", "No. Series");
        end;
        "Raised by":=UserId;
        "Needed By Date":=Today;
        //"Expiration Date" := WorkDate;
        if(not "RR Created") and (not "SSP Created")then begin
            "Requested For":=UserId;
            "Purchaser Code":=UserId;
            if UsersRec.Get(UserId)then begin
                UsersRec.TestField("Employee No.");
                "Employee Code":=UsersRec."Employee No.";
                Validate("Employee Code");
            end;
        end;
        "Repair Start Date":=CurrentDateTime;
        "Procurement Plan":=PurchSetup."Effective Procurement Plan";
    end;
    var PurchSetup: Record "Procurement Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UsersRec: Record "User Setup";
    NAVemp: Record Employee;
    EmpRec: Record "Employee Master";
    Expenses: Record "Expense Codes";
    Lines: Record "Repair Lines";
    FaultRec: Record "Fault Code";
    procedure AssitEdit(): Boolean begin
        PurchSetup.Get;
        PurchSetup.TestField("Repair Requisition No.");
        if NoSeriesMgt.SelectSeries(PurchSetup."Repair Requisition No.", xRec."No. Series", "No. Series")then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;
}
