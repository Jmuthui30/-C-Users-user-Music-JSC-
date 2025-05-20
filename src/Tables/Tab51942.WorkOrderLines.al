table 51942 "Work Order Lines"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Work No"; Code[20])
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if WorkOrder.Get("Work No")then begin
                    "Global Dimension 1 Code":=WorkOrder."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=WorkOrder."Global Dimension 2 Code";
                    "Location Code":=WorkOrder."Location Code";
                    "Asset Location":=WorkOrder."Asset Location";
                    "Global Dimension 3 Code":=WorkOrder."Global Dimension 3 Code";
                    if WorkOrder.Status = WorkOrder.Status::Open then Status:=Status::Open;
                end;
            end;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if WorkOrder.Get("Work No")then begin
                    "Location Code":=WorkOrder."Location Code";
                    "Global Dimension 2 Code":=WorkOrder."Global Dimension 2 Code";
                end;
            end;
        }
        field(3; Type; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Item,Fixed Asset';
            OptionMembers = Item, "Fixed Asset";
        }
        field(4; No; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = IF(Type=CONST(Item))Item
            ELSE IF(Type=CONST("Fixed Asset"))"Fixed Asset";

            trigger OnValidate()
            begin
                //TestField(Status, Status::Open);
                if WorkOrder.Get("Work No")then begin
                    "Global Dimension 1 Code":=WorkOrder."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=WorkOrder."Global Dimension 2 Code";
                    "Location Code":=WorkOrder."Location Code";
                    "Global Dimension 3 Code":=WorkOrder."Global Dimension 3 Code";
                end;
                /*if Type = Type::Expense then begin
                    if ExpenseCodes.Get(No) then begin
                        if Description = '' then
                            Description := ExpenseCodes.Description;
                        "GL Account" := ExpenseCodes."Account No";
                    end
                end;*/
                if Type = Type::Item then begin
                    if ItemRec.Get(No)then begin
                        if Description = '' then Description:=ItemRec.Description;
                        "Unit of Measure":=ItemRec."Base Unit of Measure";
                        if "Location Code" <> '' then ItemRec.SetFilter("Location Filter", '%1', "Location Code");
                        ItemRec.CalcFields(ItemRec.Inventory);
                        ItemRec.CalcFields(Inventory);
                        //"Quantity in Store" := ItemRec.Inventory;
                        "Unit Price":=ItemRec."Unit Cost";
                    end;
                end;
                if Type = Type::"Fixed Asset" then begin
                    if FA.Get(No)then begin
                        Description:=FA.Description;
                        "Serial No.":=FA."Serial No.";
                        "Location Code":=FA."FA Location Code";
                        "FA Posting Type":="FA Posting Type"::Maintenance;
                        FA_Sub.Reset();
                        FA_Sub.SetRange(Code, FA."FA Subclass Code");
                        if FA_Sub.FindFirst()then begin
                            FA_Post.Reset();
                            FA_Post.SetRange(Code, FA_Sub."Default FA Posting Group");
                            if FA_Post.FindFirst()then "Maintenance Acc Code":=FA_Post."Maintenance Expense Account";
                        end;
                    end;
                end;
            end;
        }
        field(5; Description; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Unit of Measure";
        }
        field(8; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = Location WHERE("Use As In-Transit"=CONST(false));

            trigger OnValidate()
            begin
                Validate(No);
            end;
        }
        field(10; "GL Account"; Code[10])
        {
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
        }
        field(12; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
        }
        field(13; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(14; "Global Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Global Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4));
        }
        field(15; "Global Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Global Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(5));
        }
        field(16; MFR; Text[30])
        {
        }
        field(17; "Catalog No."; Code[20])
        {
        }
        field(18; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(19; Priority; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Low,High,Medium';
            OptionMembers = Low, High, Medium;
        }
        field(20; "Response Time (Hours)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(21; "Response Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Response Time"; time)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Fault Area Code"; Code[20])
        {
            Caption = 'Fault Area';
            DataClassification = CustomerContent;
            TableRelation = "Fault Area";
        }
        field(24; "Symptom Code"; code[20])
        {
            Caption = 'Fault Symptom';
            DataClassification = CustomerContent;
            TableRelation = "Symptom Code";
        }
        field(25; "Fault Code"; code[20])
        {
            Caption = 'Fault Type';
            DataClassification = CustomerContent;
            TableRelation = "Fault Code".Code where("Fault Area Code"=field("Fault Area Code"), "Symptom Code"=field("Symptom Code"));
        }
        field(26; "Item No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Replacement Asset';
            TableRelation = item;
        }
        field(27; "Serial No."; Code[10])
        {
        }
        field(28; "Asset Location"; Code[10])
        {
            TableRelation = "FA Location";
        }
        field(29; "Scheduled Start Date"; Date)
        {
        }
        field(30; "Scheduled End Date"; Date)
        {
        }
        field(31; Status;Enum "Document Status")
        {
        }
        field(32; "Job No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(33; "Job Task No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(34; "Job Worksheet LineNo"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(35; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Quote,Order,Invoice';
            OptionMembers = Quote, Order, Invoice;
        }
        field(37; "FA Posting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Acquisition Cost,Maintenance';
            OptionMembers = , "Acquisition Cost", Maintenance;
        }
        field(38; "Maintenance Acc Code"; code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Work No", "Line No")
        {
        }
    }
    var WorkOrder: Record "Work Order Header";
    ItemRec: Record Item;
    FA: Record "Fixed Asset";
    FA_Sub: Record "FA Subclass";
    FA_Post: Record "FA Posting Group";
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
