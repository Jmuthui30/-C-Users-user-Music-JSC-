tableextension 51434 "ExtVendor" extends Vendor
{
    fields
    {
        // Add changes to table fields here
        field(51423; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4), Blocked=CONST(false));
        }
        field(51424; "SharePoint Link"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(51425; Competency; Decimal)
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Rating".factor;

            trigger OnValidate()
            begin
                CreateVendorEvaluation();
            end;
        }
        field(51426; Capacity; Decimal)
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Rating".factor;

            trigger OnValidate()
            begin
                CreateVendorEvaluation();
            end;
        }
        field(51427; Commitment; Decimal)
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Rating".factor;

            trigger OnValidate()
            begin
                CreateVendorEvaluation();
            end;
        }
        field(51428; Control; Decimal)
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Rating".factor;

            trigger OnValidate()
            begin
                CreateVendorEvaluation();
            end;
        }
        field(51429; "Cash Resources"; Decimal)
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Rating".factor;

            trigger OnValidate()
            begin
                CreateVendorEvaluation();
            end;
        }
        field(51430; Cost; Decimal)
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Rating".factor;

            trigger OnValidate()
            begin
                CreateVendorEvaluation();
            end;
        }
        field(51431; Consistency; Decimal)
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Rating".factor;

            trigger OnValidate()
            begin
                CreateVendorEvaluation();
            end;
        }
        field(51432; "Blocked Reason"; text[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Blocked Reason";
        }
        field(51433; "Vendor DateFormat"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51434; "Vendor NameValue"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51435; "Vendor Application No."; Code[20])
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
            //Validate("Vendor Application No.", "No.");
            end;
        }
    }
    local procedure CreateVendorEvaluation()
    var
        LineNo: Integer;
    begin
        If VendEvaluate.Get("No.")Then begin
            if VendEvaluate."Vendor Name" = '' then VendEvaluate."Vendor Name":=Name;
            VendEvaluate.Date:=Today;
            VendEvaluate.Competency:=Competency;
            VendEvaluate."Cash Resources":="Cash Resources";
            VendEvaluate.Commitment:=Commitment;
            VendEvaluate.Capacity:=Capacity;
            VendEvaluate.Consistency:=Consistency;
            VendEvaluate.Control:=Control;
            VendEvaluate.Cost:=Cost;
            VendEvaluate.Modify(true);
        end;
    end;
    local procedure GenerateVendorNo()
    var
        Counter: Integer;
        TagInt: Code[10];
    begin
        Counter:=0;
        TagInt:='';
        CreatedDate:=Today;
        "Vendor DateFormat":=Format(CreatedDate, 0, '<Year,2>');
        "Vendor NameValue":=CopyStr(Name, 1, 1);
        VendRec.Reset();
        VendRec.SetFilter("Vendor NameValue", "Vendor NameValue");
        VendRec.SetFilter("Vendor DateFormat", "Vendor DateFormat");
        if VendRec.FindSet()then begin
            Counter:=VendRec.Count;
            Counter:=Counter + 1;
            if Counter < 10 then TagInt:='00' + Format(Counter)
            else if((Counter > 10) And (Counter < 100))then TagInt:='0' + Format(Counter)
                else
                    TagInt:=Format(Counter);
            "No.":="Vendor DateFormat" + "Vendor NameValue" + TagInt;
        end
        else
        begin
            "No.":="Vendor DateFormat" + "Vendor NameValue" + '001';
        end;
    end;
    var DimensionValue: Record "Dimension Value";
    VendEvaluate: Record "Vendor Evaluation";
    VendRec: Record Vendor;
    CreatedDate: Date;
    PurchSetup: Record "Purchases & Payables Setup";
    VendMgt: Codeunit "Vendor Onboarding Mgnt";
}
