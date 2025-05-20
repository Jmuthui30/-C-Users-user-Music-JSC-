table 51800 "Requisition Header"
{
    fields
    {
        field(1; "No."; Code[22])
        {
        }
        field(2; "Employee Code"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if "PR Created" then begin
                    UsersRec.Reset;
                    UsersRec.SetRange("Employee No.", "Employee Code");
                    if UsersRec.FindFirst then begin
                        "Requested For":=UsersRec."User ID";
                        "Purchaser Code":=UsersRec."User ID";
                    //Ibrahim Wasiu: Code comment for not working for Self Service
                    /*if EmpRec.Get(UsersRec."Employee No") then begin
                            "Global Dimension 1 Code" := EmpRec."Global Dimension 1 Code";
                            "Global Dimension 2 Code" := EmpRec."Global Dimension 2 Code";
                        end;*/
                    end;
                end;
                if EmpRec.Get("Employee Code")then begin
                    "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                end;
                if NAVemp.Get("Employee Code")then "Employee Name":=NAVemp.FullName();
            //     end else
            //         Error('QuantJumps User Setup for %1 have not been done', "Employee Name");
            // end else
            //     if "SSP Created" then begin
            //         //Code
            //     end;
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            Editable = false;
        }
        field(5; Reason; Text[100])
        {
        }
        field(6; "Requisition Date"; Date)
        {
        }
        field(7; Status;Enum "Document Status")
        {
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("Requisition No", "No.");
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
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=FILTER(1));

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("Requisition No", "No.");
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
                Lines.SetRange("Requisition No", "No.");
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
        field(15; "Document Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Purchase Requisition,Store Requisition,Imprest,Claim-Accounting,Appointment,Payment Voucher';
            OptionMembers = Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order", "None", "Purchase Requisition", "Store Requisition", Imprest, "Claim-Accounting", Appointment, "Payment Voucher";
        }
        field(16; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(17; "Requisition Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Purchase Requisition,Store Requisition,Imprest,Claim-Accounting,Appointment,Payment Voucher,S_Store Requisition,J_Store Requisition';
            OptionMembers = Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order", "None", "Purchase Requisition", "Store Requisition", Imprest, "Claim-Accounting", Appointment, "Payment Voucher", "S_Store Requisition", "J_Store Requisition";

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("Requisition No", "No.");
                if Lines.Find('-')then Lines.ModifyAll("Requisition Type", "Requisition Type");
            end;
        }
        field(18; Posted; Boolean)
        {
        }
        field(19; "No of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51800), "Document No."=FIELD("No.")));
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

            trigger OnValidate()
            begin
            /*PurchLine.RESET;
                PurchLine.SETRANGE("Requisition No","No.");
                IF PurchLine.FIND('-') THEN BEGIN REPEAT
                  PurchLine.VALIDATE("Location Code","Location Code");
                  PurchLine.MODIFY;
                UNTIL PurchLine.NEXT = 0;
                END;*/
            end;
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
        field(29; "PR Closed"; Boolean)
        {
        }
        field(30; "PR Closed By"; Option)
        {
            OptionCaption = ' ,Direct Receipt of Goods/Services,Purchase Order,Rejection';
            OptionMembers = " ", "Direct Receipt of Goods/Services", "Purchase Order", Rejection;
        }
        field(31; "Closed Date"; Date)
        {
        }
        field(32; "Closed By"; Code[50])
        {
        }
        field(33; "Quantity Requested"; Decimal)
        {
            CalcFormula = Sum("Requisition Lines".Quantity WHERE("Requisition No"=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(34; Amount; Decimal)
        {
            CalcFormula = Sum("Requisition Lines".Amount WHERE("Requisition No"=FIELD("No.")));
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
        field(43; "PO Generated Directly"; Boolean)
        {
        }
        field(44; "PO Generated By"; Code[50])
        {
        }
        field(45; "PO Generated Date"; Date)
        {
        }
        field(46; "PO Number"; Code[20])
        {
        }
        field(47; "Pending Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51800), "Document No."=FIELD("No."), Status=FILTER(Open|Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
        }
        field(48; "Empty No."; Boolean)
        {
            CalcFormula = Exist("Requisition Lines" WHERE(No=CONST(''), "Requisition No"=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(49; "SharePoint Link"; Text[250])
        {
        }
        field(51839; "Store Req. Qty. Requested"; Decimal)
        {
            CalcFormula = Sum("Requisition Lines".Quantity WHERE("Requisition No"=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(51840; "Store Req. Qty. Issued"; Decimal)
        {
            CalcFormula = Sum("Requisition Lines"."Quantity Issued" WHERE("Requisition No"=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(51841; "Job No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51842; "Job Task No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51843; "Job Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51844; "Service Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51845; "Service Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51846; "Service Order Desc."; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51847; "PR Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51848; "SSP Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        //Ibrahim Wasiu
        field(51849; "Amount Limit Code"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Amount Limit Type";
            Editable = false;

            trigger OnValidate()
            var
                AmountLimit: Record "Amount Limit Type";
            begin
                if AmountLimit.get("Amount Limit Code")then "Amount Limit Description":=AmountLimit.Description;
            end;
        }
        field(51850; "Amount Limit Description"; Text[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(51851; Title; text[50])
        {
            DataClassification = CustomerContent;
        }
        field(51852; Description; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(51853; Approvers; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(51800), "Document No."=FIELD("No."), Status=FILTER(Approved)));
            FieldClass = FlowField;
            Caption = 'Approvers';
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        PurchSetup.Get;
        if "No." = '' then begin
            if "Requisition Type" = "Requisition Type"::"Purchase Requisition" then begin
                PurchSetup.TestField("Purchase Req No");
                NoSeriesMgt.InitSeries(PurchSetup."Purchase Req No", xRec."No.", 0D, "No.", "Procurement Plan");
            end;
            if "Requisition Type" = "Requisition Type"::"Store Requisition" then begin
                PurchSetup.TestField(PurchSetup."Store Requisition Nos.");
                NoSeriesMgt.InitSeries(PurchSetup."Store Requisition Nos.", xRec."No.", 0D, "No.", "Procurement Plan");
            end;
            if "Requisition Type" = "Requisition Type"::"S_Store Requisition" then begin
                PurchSetup.TestField(PurchSetup."S_Store Requisition Nos.");
                NoSeriesMgt.InitSeries(PurchSetup."S_Store Requisition Nos.", xRec."No.", 0D, "No.", "Procurement Plan");
            end;
            if "Requisition Type" = "Requisition Type"::"J_Store Requisition" then begin
                PurchSetup.TestField(PurchSetup."J_Store Requisition Nos.");
                NoSeriesMgt.InitSeries(PurchSetup."J_Store Requisition Nos.", xRec."No.", 0D, "No.", "Procurement Plan");
            end;
        end;
        "Raised by":=UserId;
        /*"Requisition Date" := WorkDate;
        "Needed By Date" := WorkDate;
        "Expiration Date" := WorkDate;*/
        if(not "PR Created") and (not "SSP Created")then begin
            "Requested For":=UserId;
            "Purchaser Code":=UserId;
            if UsersRec.Get(UserId)then begin
                UsersRec.TestField("Employee No.");
                "Employee Code":=UsersRec."Employee No.";
                Validate("Employee Code");
            end;
        end;
        "Requisition Date":=Today;
        "Needed By Date":=Today;
        "Expiration Date":=Today;
        "Procurement Plan":=PurchSetup."Effective Procurement Plan";
    end;
    var PurchSetup: Record "Procurement Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UsersRec: Record "User Setup";
    NAVemp: Record Employee;
    EmpRec: Record "Employee Master";
    Expenses: Record "Expense Codes";
    Lines: Record "Requisition Lines";
    procedure AssitEdit(): Boolean begin
        PurchSetup.Get;
        PurchSetup.TestField("Store Requisition Nos.");
        if NoSeriesMgt.SelectSeries(PurchSetup."Store Requisition Nos.", xRec."No. Series", "No. Series")then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;
}
