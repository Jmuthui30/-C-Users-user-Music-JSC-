table 51824 "Motorpool Cost Centers"
{
    fields
    {
        field(1; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                if "Global Dimension 1 Code" <> '' then begin
                    GenLed.Get;
                    GenLed.TestField("Global Dimension 1 Code");
                    if DimValue.Get(GenLed."Global Dimension 1 Code", "Global Dimension 1 Code")then begin
                        if "Global Dimension 2 Code" <> '' then begin
                            GenLed.TestField("Global Dimension 2 Code");
                            if DimValue2.Get(GenLed."Global Dimension 2 Code", "Global Dimension 2 Code")then Description:=DimValue.Name + ' - ' + DimValue2.Name;
                        end
                        else
                            Description:=DimValue.Name;
                    end;
                end;
            end;
        }
        field(2; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                if "Global Dimension 1 Code" <> '' then begin
                    GenLed.Get;
                    GenLed.TestField("Global Dimension 1 Code");
                    if DimValue.Get(GenLed."Global Dimension 1 Code", "Global Dimension 1 Code")then begin
                        if "Global Dimension 2 Code" <> '' then begin
                            GenLed.TestField("Global Dimension 2 Code");
                            if DimValue2.Get(GenLed."Global Dimension 2 Code", "Global Dimension 2 Code")then Description:=DimValue.Name + ' - ' + DimValue2.Name;
                        end
                        else
                            Description:=DimValue.Name;
                    end;
                end
                else
                begin
                    if "Global Dimension 2 Code" <> '' then begin
                        GenLed.TestField("Global Dimension 2 Code");
                        if DimValue2.Get(GenLed."Global Dimension 2 Code", "Global Dimension 2 Code")then Description:=DimValue2.Name;
                    end;
                end;
            end;
        }
        field(3; Description; Text[100])
        {
        }
        field(4; "Cost Center Mileage"; Decimal)
        {
            CalcFormula = Sum("Work Ticket Lines"."Distance Covered (KM)" WHERE("Global Dimension 1 Code"=FIELD("Global Dimension 1 Code"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Code"), Date=FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(5; "Cost Center No. of Staff"; Decimal)
        {
        }
        field(6; "Cost Center Office Space"; Decimal)
        {
        }
        field(7; "Cost Ctr Electronic Footprint"; Decimal)
        {
            Caption = 'Cost Center Electronic Footprint';
        }
        field(8; "Total Mileage"; Decimal)
        {
            CalcFormula = Sum("Work Ticket Lines"."Distance Covered (KM)" WHERE("Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"), Date=FIELD("Date Filter")));
            FieldClass = FlowField;
        }
        field(9; "Total No. of Staff"; Decimal)
        {
        }
        field(10; "Total Office Space"; Decimal)
        {
        }
        field(11; "Total Electronic Footprint"; Decimal)
        {
        }
        field(12; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(13; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,1,1';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                if "Global Dimension 1 Code" <> '' then begin
                    GenLed.Get;
                    GenLed.TestField("Global Dimension 1 Code");
                    if DimValue.Get(GenLed."Global Dimension 1 Code", "Global Dimension 1 Code")then begin
                        if "Global Dimension 2 Code" <> '' then begin
                            GenLed.TestField("Global Dimension 2 Code");
                            if DimValue2.Get(GenLed."Global Dimension 2 Code", "Global Dimension 2 Code")then Description:=DimValue.Name + ' - ' + DimValue2.Name;
                        end
                        else
                            Description:=DimValue.Name;
                    end;
                end;
            end;
        }
        field(14; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,1,2';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                if "Global Dimension 1 Code" <> '' then begin
                    GenLed.Get;
                    GenLed.TestField("Global Dimension 1 Code");
                    if DimValue.Get(GenLed."Global Dimension 1 Code", "Global Dimension 1 Code")then begin
                        if "Global Dimension 2 Code" <> '' then begin
                            GenLed.TestField("Global Dimension 2 Code");
                            if DimValue2.Get(GenLed."Global Dimension 2 Code", "Global Dimension 2 Code")then Description:=DimValue.Name + ' - ' + DimValue2.Name;
                        end
                        else
                            Description:=DimValue.Name;
                    end;
                end
                else
                begin
                    if "Global Dimension 2 Code" <> '' then begin
                        GenLed.TestField("Global Dimension 2 Code");
                        if DimValue2.Get(GenLed."Global Dimension 2 Code", "Global Dimension 2 Code")then Description:=DimValue2.Name;
                    end;
                end;
            end;
        }
    }
    keys
    {
        key(Key1; "Global Dimension 1 Code", "Global Dimension 2 Code")
        {
        }
    }
    fieldgroups
    {
    }
    var GenLed: Record "General Ledger Setup";
    DimValue: Record "Dimension Value";
    DimValue2: Record "Dimension Value";
}
