table 51839 "Worksheet Requisitions Lines"
{
    // version THL- PRM 1.0
    Caption = 'Worksheet Requisitions Lines';
    DrillDownPageID = "Worksheet Requisition";
    LookupPageID = "Worksheet Requisition";

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            Caption = 'Line No.';
            Editable = false;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            Editable = false;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Resource,Item,G/L Account,Text';
            OptionMembers = Resource, Item, "G/L Account", Text;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = IF(Type=CONST(Resource))Resource WHERE(Blocked=CONST(false))
            ELSE IF(Type=CONST(Item))Item WHERE(Blocked=CONST(false))
            ELSE IF(Type=CONST("G/L Account"))"G/L Account"
            ELSE IF(Type=CONST(Text))"Standard Text";

            trigger OnValidate()
            begin
                if Type = Type::Item then begin
                    if Item.Get("No.")then begin
                        Description:=Item.Description;
                        "Unit Cost":=Item."Unit Cost";
                        "Unit Price":=Item."Unit Price";
                        "Unit of Measure Code":=Item."Base Unit of Measure";
                        "Gen. Prod. Posting Group":=Item."Gen. Prod. Posting Group";
                    end;
                end
                else if Type = Type::Resource then begin
                        if Resource.Get("No.")then begin
                            Description:=Resource.Name;
                            "Unit Cost":=Resource."Unit Cost";
                            "Unit Price":=Resource."Unit Price";
                            "Unit of Measure Code":=Resource."Base Unit of Measure";
                            "Gen. Prod. Posting Group":=Resource."Gen. Prod. Posting Group";
                        end;
                    end
                    else if Type = Type::"G/L Account" then begin
                            GLAccount.Reset;
                            GLAccount.SetRange("No.", Rec."No.");
                            if GLAccount.FindFirst then begin
                                Description:=GLAccount.Name;
                                "Gen. Prod. Posting Group":=GLAccount."Gen. Prod. Posting Group";
                            end;
                        end;
            /*
                  JobTask.RESET;
                  JobTask.SETRANGE("Job No.",Rec."Job No.");
                  JobTask.SETRANGE("Job Task No.", Rec."Job Task No.");
                  JobTask.SETRANGE("Job Task Type", JobTask."Job Task Type"::Posting);
                  IF JobTask.FINDFIRST THEN
                    "Shortcut Dimension 1 Code" := JobTask."Global Dimension 1 Code";
                */
            end;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0: 5;

            trigger OnValidate()
            var
                Delta: Decimal;
            begin
                "Line Amount":=Quantity * "Unit Cost";
                "Quantity Unissued":=Rec.Quantity - Rec."Quantity Issued";
                if "Quantity Unissued" = 0 then Posted:=true;
            end;
        }
        field(7; "Location Code"; Code[20])
        {
            Caption = 'Location Code';
            TableRelation = Location WHERE("Use As In-Transit"=CONST(false));
        }
        field(8; "WorkSheet Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Job,Service';
            OptionMembers = Job, Service;
        }
        field(9; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            NotBlank = true;

            trigger OnValidate()
            begin
                Job.Reset;
                Job.SetRange("No.", "Job No.");
                if Job.FindFirst then "Job Description":=Job.Description;
            end;
        }
        field(10; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            NotBlank = true;

            trigger OnValidate()
            begin
                JobTask.Reset;
                JobTask.SetRange("Job No.", "Job No.");
                JobTask.SetRange("Job Task No.", "Job Task No.");
                if JobTask.FindFirst then "Shortcut Dimension 1 Code":=JobTask."Global Dimension 1 Code";
                "Document No.":="Job No." + '_' + "Job Task No.";
            end;
        }
        field(11; "Service Order No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Service Item No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Quantity Issued"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Quantity Issued" > Quantity then Error('You Cannot Issue more than requested');
                //"Quantity Unissued" := Quantity - "Quantity Issued";
                "Quantity Unissued":=Rec.Quantity - Rec."Quantity Issued";
                if "Quantity Unissued" = 0 then Posted:=true;
            end;
        }
        field(14; "Quantity Unissued"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(16; "Unit of Measure Code"; Code[20])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF(Type=CONST(Item))"Item Unit of Measure".Code WHERE("Item No."=FIELD("No."))
            ELSE IF(Type=CONST(Resource))"Resource Unit of Measure".Code WHERE("Resource No."=FIELD("No."))
            ELSE
            "Unit of Measure";

            trigger OnValidate()
            var
                Resource: Record Resource;
            begin
            end;
        }
        field(17; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Gen. Business Posting Group";
        }
        field(18; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Gen. Product Posting Group";
        }
        field(19; "Unit Cost"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Line Amount":=Quantity * "Unit Cost";
            end;
        }
        field(20; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';

            trigger OnValidate()
            begin
                "Line Amount":=Quantity * "Unit Price";
            end;
        }
        field(21; "Line Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));
        }
        field(24; "Raised by"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=CONST(false));
        }
        field(26; "Working Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Store Req. Status"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Job Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Job No.", "Job Task No.", "Line No.")
        {
        }
        key(Key2; "Document No.", "WorkSheet Type")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        JobUsageLink: Record "Job Usage Link";
    begin
        TestField(Status, Status::Open);
        TestField(Posted, false);
    end;
    trigger OnInsert()
    begin
        "Raised by":=UserId;
        Status:=Status::Open;
    end;
    var Resource: Record Resource;
    Item: Record Item;
    JobTask: Record "Job Task";
    GLAccount: Record "G/L Account";
    Job: Record Job;
}
