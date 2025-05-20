table 51825 "Motorpool Cost Header"
{
    fields
    {
        field(1; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(2; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(3; Period; Date)
        {
            TableRelation = "Cost Period";

            trigger OnValidate()
            begin
                if CostPeriod.Get(Period)then "Period Name":=CostPeriod.Name + ' ' + Format(Date2DMY(Period, 3));
            end;
        }
        field(4; "Period Name"; Text[30])
        {
        }
        field(5; "Created By"; Code[50])
        {
        }
        field(6; "Created Date"; Date)
        {
        }
        field(7; Posted; Boolean)
        {
        }
        field(8; "Posted By"; Code[50])
        {
        }
        field(9; "Posted Date"; DateTime)
        {
        }
        field(10; "Total Monthly Expenses"; Decimal)
        {
            CalcFormula = Sum("Cost Apportionment"."Total Amount Spent" WHERE("Global Dimension 1 Code"=FIELD("Global Dimension 1 Code"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Code"), Period=FIELD(Period)));
            FieldClass = FlowField;
        }
        field(11; "Total Amount Distributed"; Decimal)
        {
            CalcFormula = Sum("Motorpool Cost Matrix".Amount WHERE("Global Dimension 2 Code"=FIELD("Global Dimension 2 Code"), Period=FIELD(Period)));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Global Dimension 1 Code", "Global Dimension 2 Code", Period)
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        "Created By":=UserId;
        "Created Date":=Today;
    end;
    var CostPeriod: Record "Cost Period";
}
