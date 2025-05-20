table 51885 "Procurement Plan"
{
    DrillDownPageID = "Procurement Plan list";
    LookupPageID = "Procurement Plan list";

    fields
    {
        field(1; "Plan Year"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Plan Item No"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Procurement Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Service, Goods, Works;

            trigger OnValidate()
            begin
                if "Procurement Type" = "Procurement Type"::Service then Type:=Type::"G/L Account";
                if "Procurement Type" = "Procurement Type"::Goods then Type:=Type::Item;
                if "Procurement Type" = "Procurement Type"::Works then Type:=Type::"G/L Account";
            end;
        }
        field(4; "Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(5; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Estimated Cost":=Quantity * "Unit Price";
            end;
        }
        field(6; "Procurement Method"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Method";
        }
        field(7; "Source of Funds"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(8; "Estimated Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Advertisement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Bid/Quotation Opening Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Proposal Evaluation date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Financial Opening date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Negotiation date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Notification of award date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Contract Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Contract End Date (Planned)"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Department Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(18; "TOR/Technical specs due Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Item Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Validate("Unit Price");
            end;
        }
        field(21; Category; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";
        }
        field(22; "Process Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Direct, RFQ, RFP, Tender;
        }
        field(23; "Approved Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Plan Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Open, Approved, Rejected;
        }
        field(25; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "G/L Account", Item, , "Fixed Asset", "Charge (Item)";
        }
        field(26; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=CONST(" "))"Standard Text"
            ELSE IF(Type=CONST("G/L Account"))"G/L Account"
            ELSE IF(Type=CONST(Item))Item
            ELSE IF(Type=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF(Type=CONST("Charge (Item)"))"Item Charge";

            trigger OnValidate()
            begin
                if GLAcc.Get("No.")then begin
                end;
                if ItemRec.Get("No.")then begin
                    "Item Description":=ItemRec.Description;
                    "Unit of Measure":=ItemRec."Base Unit of Measure";
                    "Unit Price":=ItemRec."Last Direct Cost";
                end;
            end;
        }
        field(27; Actual; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No."=FIELD("Source of Funds")));
            FieldClass = FlowField;
        }
        field(28; Commitment; Decimal)
        {
            CalcFormula = Sum("Commitment Register".Amount WHERE("Budget Line"=FIELD("Source of Funds")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Plan Year", "Department Code", "Plan Item No")
        {
            SumIndexFields = "Estimated Cost";
        }
        key(Key2; "Source of Funds")
        {
            SumIndexFields = "Estimated Cost";
        }
        key(Key3; "Plan Item No")
        {
        }
    }
    fieldgroups
    {
    }
    var GLAcc: Record "G/L Account";
    ItemRec: Record Item;
    procedure CheckAttachment(var ProcurementPlan: Record "Procurement Plan")LinkExists: Boolean var
        RecLink: Record "Record Link";
        SearchString: Text[50];
        ProcPlanRef: RecordRef;
        RecLinkRef: RecordRef;
    begin
        ProcPlanRef.GetTable(ProcurementPlan);
        SearchString:=Format(ProcPlanRef.RecordId);
        RecLink.SetFilter(RecLink."Record ID", SearchString);
        if RecLink.Find('-')then begin
            LinkExists:=true;
            repeat //MESSAGE('%1 %2',RecLink."Link ID",RecLink.Description);
            until RecLink.Next = 0;
        end
        else
            LinkExists:=false;
    end;
    procedure FindManagersEmail(var ProcurePlan: Record "Procurement Plan")Memailaddress: Text[50]var
        Jobs: Record "Company Jobs";
        Emp: Record "Employee Master";
        Employee: Record Employee;
    begin
        Jobs.Reset;
        Jobs.SetRange(Jobs.Management, true);
        Jobs.SetRange(Jobs."Dimension 1", ProcurePlan."Department Code");
        if Jobs.Find('-')then begin
            //MESSAGE('%1',Jobs."Job ID");
            Emp.Reset;
            Emp.SetRange(Emp.Position, Jobs."Job ID");
            if Emp.Find('-')then begin
                if Employee.Get(Emp."No.")then Memailaddress:=Employee."Company E-Mail";
            end;
            if Memailaddress = '' then Error('set company address for employee %1', Emp."No.");
        end
        else
            Error('Manager for Department %1 has not been defined in the system', ProcurePlan."Department Code");
    end;
}
