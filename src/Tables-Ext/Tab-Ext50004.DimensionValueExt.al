tableextension 50004 "Dimension Value Ext" extends "Dimension Value"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "State Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(50001; Region; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Dimension Code"=CONST('REGION'));
        }
        field(50002; "PENCOM State Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "PENCOM Country Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        // field(50004; Balance; Decimal)
        // {
        //     CalcFormula = - Sum("G/L Entry".Amount WHERE(Branch = FIELD(Code)));
        //     Editable = false;
        //     FieldClass = FlowField;
        // }
        field(50005; Address1; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(50006; Address2; Text[50])
        {
            Caption = 'Address';
            DataClassification = ToBeClassified;
        }
        field(50008; "Local Gov. Code"; Code[3])
        {
            DataClassification = ToBeClassified;

            //TableRelation = Table50016;
            trigger OnValidate()
            begin
                if "Local Gov. Code" <> '' then if recLGA.Get("Local Gov. Code")then begin
                        "State Code":=recLGA.Code;
                        Region:=recLGA.Code;
                    end;
            end;
        }
        field(50011; "Telephone 1"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50012; Email; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Mobile 1"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Mobile 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Fax; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Telephone 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(50019; "Fund Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        //TableRelation = Fund;
        }
        field(50021; "Bank Account Number"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        // field(50022; "Bank Branch"; Code[100])
        // {
        //     DataClassification = ToBeClassified;
        //     TableRelation = "HR Employee Bank Accounts";
        // }
        field(50023; "In-Patient Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Out-Patient Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Commissioners Balance"; Decimal)
        {
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No."=CONST('302210'), "Global Dimension 2 Code"=FIELD(Code)));
            FieldClass = FlowField;
        }
        field(50027; "Commissioners Balance Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "G/L Account";
        }
        // field(50028; RSAFUM; Decimal)
        // {
        //     CalcFormula = Sum("Client Ledger Enty".Amount WHERE("State Code" = FIELD(Code), "Fund Code" = FILTER('1' | '71'), "Posting Date" = FIELD("Date Filter")));
        //     FieldClass = FlowField;
        // }
        // field(50029; RETFUM; Decimal)
        // {
        //     CalcFormula = Sum("Client Ledger Enty".Amount WHERE("State Code" = FIELD(Code), "Fund Code" = FILTER('11'), "Posting Date" = FIELD("Date Filter")));
        //     FieldClass = FlowField;
        // }
        // field(50030; TOTALFUM; Decimal)
        // {
        //     CalcFormula = Sum("Client Ledger Enty".Amount WHERE("State Code" = FIELD(Code), "Posting Date" = FIELD("Date Filter")));
        //     FieldClass = FlowField;
        // }
        // field(50031; Contributions; Decimal)
        // {
        //     CalcFormula = Sum("Client Ledger Enty".Amount WHERE("Transaction Type" = CONST(Contribution), "State Code" = FIELD(Code), "Posting Date" = FIELD("Date Filter")));
        //     FieldClass = FlowField;
        // }
        // field(50032; "Admin Fees"; Decimal)
        // {
        //     CalcFormula = Sum("Client Ledger Enty".Amount WHERE("Contribution Type" = FILTER("RSA Fee" | "VC Fee"), "State Code" = FIELD(Code), "Posting Date" = FIELD("Date Filter")));
        //     FieldClass = FlowField;
        // }
        field(50033; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        // field(50034; "Total FUM"; Decimal)
        // {
        //     CalcFormula = Sum("Agent FUM".FUM WHERE("Start Date" = FIELD("Start Date"), "End Date" = FIELD("End Date")));
        //     FieldClass = FlowField;
        // }
        field(50035; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        // field(50036; "Pay Period Filter"; Date)
        // {
        //     FieldClass = FlowFilter;
        //     TableRelation = "Payroll Periods";
        // }
        field(50037; "Company Accounts Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    var recLGA: Record "Dimension Value";
}
