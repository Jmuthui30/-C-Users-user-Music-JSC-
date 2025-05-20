table 58134 "Budget Category Dist. Header"
{
    fields
    {
        field(1; Budget; Code[20])
        {
            TableRelation = "G/L Budget Name";
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Business Unit"; Option)
        {
            OptionCaption = 'IT,ADMIN';
            OptionMembers = IT,ADMIN;
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Draft,Approved';
            OptionMembers = Draft,Approved;
        }
        field(5; "Internal Audit"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00011')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Internal Control"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00012')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Fund Accounts"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00021')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Financial Control"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00022')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "IT Governance"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00031')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; BPT; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00032')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(11; ITOPS; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00033')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "APP DEV"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00034')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Data Management"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00041')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(14; "Investment Admin"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00042')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; Reconciliation; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00043')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(16; "Benefit Administration"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00051')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(17; "Operational Risk"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00061')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Financial Risk"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00062')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(19; "Information Security"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00063')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; Admin; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00071')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Human Resources"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00072')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; Legal; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00081')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; Compliance; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00082')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(24; "Company Secretary"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00091')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(25; "Customer Experience"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00091')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(26; EMT; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00102')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(27; HVC; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00103')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(28; Sales; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00104')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; MCC; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00105')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(30; "Business Support"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00106')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(31; "Business Analytics"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00107')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Corporate Strategy"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00111')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Investment Management"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00121')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "Executive Management"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Global Dimension 1 Code" = CONST('00131')));
            Editable = false;
            FieldClass = FlowField;
        }
        field(35; "Grand Total"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(36; "Total CAPEX"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), Type = CONST(CAPEX)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Total OPEX"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), Type = CONST(OPEX)));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; Budget)
        {
        }
    }
    fieldgroups
    {
    }
}
