table 51826 "Cost Apportionment"
{
    fields
    {
        field(1; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
        }
        field(2; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
        }
        field(3; Period; Date)
        {
        }
        field(4; Cost; Code[20])
        {
            TableRelation = "Motorpool Cost";

            trigger OnValidate()
            begin
                if Costs.Get(Cost)then Description:=Costs.Description;
            end;
        }
        field(5; Description; Text[50])
        {
        }
        field(6; "Total Amount Spent"; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; "Global Dimension 1 Code", "Global Dimension 2 Code", Period, Cost)
        {
        }
    }
    fieldgroups
    {
    }
    var Costs: Record "Motorpool Cost";
}
