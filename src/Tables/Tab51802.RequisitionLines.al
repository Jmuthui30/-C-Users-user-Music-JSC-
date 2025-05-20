table 51802 "Requisition Lines"
{
    fields
    {
        field(1; "Requisition No"; Code[22])
        {
            trigger OnValidate()
            begin
                /*
                IF ReqHeader.GET("Requisition No") THEN
                BEGIN
                 "Procurement Plan":=ReqHeader."Procurement Plan";
                 "Location Code" := ReqHeader."Location Code";
                END;*/
                if ReqHeader.Get("Requisition No")then begin
                    "Global Dimension 1 Code":=ReqHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=ReqHeader."Global Dimension 2 Code";
                    "Location Code":=ReqHeader."Location Code";
                    "Global Dimension 3 Code":=ReqHeader."Global Dimension 3 Code";
                    if ReqHeader.Status = ReqHeader.Status::Open then Status:=Status::Open;
                end;
            end;
        }
        field(2; "Line No"; Integer)
        {
            trigger OnValidate()
            begin
                if ReqHeader.Get("Requisition No")then begin
                    "Procurement Plan":=ReqHeader."Procurement Plan";
                    "Location Code":=ReqHeader."Location Code";
                    "Global Dimension 2 Code":=ReqHeader."Global Dimension 2 Code";
                end;
            end;
        }
        field(3; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Item,Fixed Asset,Expense';
            OptionMembers = Item, "Fixed Asset", Expense;
        }
        field(4; No; Code[50])
        {
            TableRelation = IF(Type=CONST(Item))Item
            ELSE IF(Type=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF(Type=CONST(Expense))"Expense Codes";

            trigger OnValidate()
            begin
                //TestField(Status, Status::Open);
                if ReqHeader.Get("Requisition No")then begin
                    "Global Dimension 1 Code":=ReqHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=ReqHeader."Global Dimension 2 Code";
                    "Location Code":=ReqHeader."Location Code";
                    "Global Dimension 3 Code":=ReqHeader."Global Dimension 3 Code";
                end;
                if Type = Type::Expense then begin
                    if ExpenseCodes.Get(No)then begin
                        if Description = '' then Description:=ExpenseCodes.Description;
                        "GL Account":=ExpenseCodes."Account No";
                    end end;
                if Type = Type::Item then begin
                    if ItemRec.Get(No)then begin
                        if ItemRec."Item Status" = ItemRec."Item Status"::Active then begin
                            if Description = '' then Description:=ItemRec.Description;
                            "Unit of Measure":=ItemRec."Base Unit of Measure";
                            if "Location Code" <> '' then ItemRec.SetFilter("Location Filter", '%1', "Location Code");
                            ItemRec.CalcFields(ItemRec.Inventory);
                            ItemRec.CalcFields(Inventory);
                            "Quantity in Store":=ItemRec.Inventory;
                            "Unit Price":=ItemRec."Unit Cost";
                        /*if ((ItemRec."Gen. Prod. Posting Group" = 'FUEL') and (ReqHeader."Global Dimension 2 Code" = '')) then
                                Error('FA Code Must have a Value');*/
                        end
                        else if ItemRec."Item Status" = ItemRec."Item Status"::Inactive then begin
                                Error('An item is not active.');
                            end;
                    end;
                end;
                if Type = Type::"Fixed Asset" then begin
                    if FA.Get(No)then begin
                        Description:=FA.Description;
                        "Location Code":=FA."FA Location Code";
                    end;
                end;
            end;
        }
        field(5; Description; Text[250])
        {
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity Requested';

            trigger OnValidate()
            begin
                if ReqHeader.Get("Requisition No")then begin
                    if ReqHeader."Requisition Type" = ReqHeader."Requisition Type"::"Store Requisition" then begin
                        if Type = Type::Expense then begin
                            if ItemRec.Get(No)then begin
                                Description:=ItemRec.Description;
                                if "Location Code" <> '' then ItemRec.SetFilter("Location Filter", '%1', "Location Code");
                                ItemRec.CalcFields(ItemRec.Inventory);
                                "Quantity in Store":=ItemRec.Inventory;
                            end;
                        end;
                        //END;
                        //END;
                        "Quantity Approved":=Quantity;
                        "Quantity To Issue":=Quantity - "Quantity Issued";
                        Validate("Unit Price");
                        Validate(Amount);
                        if "Quantity in Store" < Quantity then begin
                            //Message('Procurement Notified ! The stock item: %1 is out of stock, The quantity in store is %2 ,' , Description, "Quantity in Store");
                            //Commented error that quantity more than quantity in store to go for approval out of store field; Ibrahim Wasiu, Date: 6th July 2021
                            Error('Your Request for Item %1 cannot proceed because of low stock quantity. Kindly reduce the Quantity', Description);
                            "Quantity To Issue":="Quantity in Store" - "Quantity Issued";
                            "Out of Store Bal.":=Quantity - "Quantity in Store";
                        end;
                        /*Mail.NewIncidentMail('navadmin@erc.go.ke', RequsitionLines.Description +' is Out of stock  ',"Employee Name"
                        +  'Has Requested'  +  FORMAT(RequsitionLines.Quantity)   + RequsitionLines.Description + ' but it is out of stock');*/
                        exit;
                    end;
                //UNTIL RequsitionLines.NEXT=0;
                end;
            end;
        }
        field(7; "Unit of Measure"; Code[10])
        {
            TableRelation = "Unit of Measure";
        }
        field(8; "Unit Price"; Decimal)
        {
            trigger OnValidate()
            begin
                Amount:=Quantity * "Unit Price";
                Validate(Amount);
            end;
        }
        field(9; Amount; Decimal)
        {
        }
        field(10; "Procurement Plan"; Code[10])
        {
            TableRelation = "Procurement Plan Header";
        }
        field(11; "Procurement Plan Item"; Code[10])
        {
        }
        field(12; "Budget Line"; Code[10])
        {
        }
        field(13; "Quantity Approved"; Decimal)
        {
            Editable = true;
        }
        field(14; "Quantity in Store"; Decimal)
        {
            Editable = false;
        }
        field(15; "Location Code"; Code[10])
        {
            TableRelation = Location WHERE("Use As In-Transit"=CONST(false));

            trigger OnValidate()
            begin
                Validate(No);
            end;
        }
        field(16; "GL Account"; Code[10])
        {
        }
        field(17; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
        }
        field(18; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
        }
        field(19; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(20; "Global Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Global Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4));
        }
        field(21; "Global Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Global Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(5));
        }
        field(22; MFR; Text[30])
        {
        }
        field(23; "Catalog No."; Code[20])
        {
        }
        field(24; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(25; Decision; Option)
        {
            OptionCaption = ' ,RFQ,Order,Append to Order,Blanket Order,Append to Blanket Order,Inventory';
            OptionMembers = " ", RFQ, "Order", "Append to Order", "Blanket Order", "Append to Blanket Order", Inventory;

            trigger OnValidate()
            begin
                "Decision By":=UserId;
            end;
        }
        field(26; "Target No."; Code[20])
        {
            Caption = 'Target No.';
            Editable = true;
            TableRelation = IF(Decision=FILTER(RFQ|Order|"Blanket Order"))Vendor
            ELSE IF(Decision=FILTER("Append to Order"))"Purchase Header"."No." WHERE("Document Type"=CONST(Order), Status=CONST(Open))
            ELSE IF(Decision=FILTER("Append to Blanket Order"))"Purchase Header"."No." WHERE("Document Type"=CONST("Blanket Order"))
            ELSE IF(Decision=FILTER(Inventory))Location;
        //This property is currently not supported
        //TestTableRelation = false;
        }
        field(27; Processed; Boolean)
        {
        }
        field(28; Status;Enum "Document Status")
        {
            //Editable = false;
            DataClassification = CustomerContent;
        }
        field(29; "Order No"; Code[20])
        {
        }
        field(30; "RFQ No"; Code[20])
        {
        }
        field(31; "Decision By"; Code[50])
        {
        }
        field(51423; "Service Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51424; "Job No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51425; "Job Task No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51426; "Service Item Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(51427; "Job Worksheet LineNo"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(51428; "Quantity To Issue"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if("Quantity To Issue") > (Quantity - "Quantity Issued")then Error('You Cant Issue More than Requested');
            end;
        }
        field(51429; "Quantity Issued"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51430; "Issued Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51431; "Issued By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51432; "Out of Store Bal."; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51433; "Requisition Type"; Option)
        {
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order,None,Purchase Requisition,Store Requisition,Imprest,Claim-Accounting,Appointment,Payment Voucher,S_Store Requisition,J_Store Requisition';
            OptionMembers = Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order", "None", "Purchase Requisition", "Store Requisition", Imprest, "Claim-Accounting", Appointment, "Payment Voucher", "S_Store Requisition", "J_Store Requisition";
        }
    }
    keys
    {
        key(Key1; "Requisition No", "Line No")
        {
        }
    }
    trigger OnInsert()
    begin
        Status:=Status::Open;
    end;
    var ReqHeader: Record "Requisition Header";
    ItemRec: Record Item;
    ExpenseCodes: Record "Expense Codes";
    FA: Record "Fixed Asset";
}
