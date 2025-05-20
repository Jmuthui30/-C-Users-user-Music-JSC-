report 51813 "Update Cost Center Numbers"
{
    ProcessingOnly = true;

    dataset
    {
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(DimOne; DimOne)
                {
                    ApplicationArea = All;
                    CaptionClass = '1,1,1';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
                }
                field(DimTwo; DimTwo)
                {
                    ApplicationArea = All;
                    CaptionClass = '1,1,2';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
                }
                field(ValueToUpdate; ValueToUpdate)
                {
                    ApplicationArea = All;
                    Caption = 'What do you want to update?';
                }
                field(CostCenterValue; CostCenterValue)
                {
                    ApplicationArea = All;
                    Caption = 'Value for Cost Center';
                }
                field(TotalValue; TotalValue)
                {
                    ApplicationArea = All;
                    Caption = 'Total Value';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        if ValueToUpdate = ValueToUpdate::" " then Error('You must select what you want to update!');
        if(DimOne = '') and (DimTwo = '')then Error('You must select at least one dimension!');
        if Confirm(StrSubstNo('You are about to update %1 for %2. Do you wish to continue?', Format(ValueToUpdate), Format(DimOne) + ' ' + Format(DimTwo)), false) = true then begin
            CostCenter.Reset;
            if DimOne <> '' then CostCenter.SetRange("Global Dimension 1 Code", DimOne);
            if DimTwo <> '' then CostCenter.SetRange("Global Dimension 2 Code", DimTwo);
            if CostCenter.FindSet then begin
                if ValueToUpdate = ValueToUpdate::"Electronic Footprint" then begin
                    //Cost Center Value
                    if CostCenterValue = 0 then begin
                        if Confirm('The Cost Center Value is zero, do you wish to change the Cost Center Electronic Foortprint to zero?', false) = true then begin
                            UpdateCostCenterValue(DimOne, DimTwo, ValueToUpdate, CostCenterValue);
                        end;
                    end
                    else
                        UpdateCostCenterValue(DimOne, DimTwo, ValueToUpdate, CostCenterValue);
                    //Total Value
                    if TotalValue = 0 then begin
                        if Confirm('The Total Value is zero, do you wish to change the Total Electronic Foortprint to zero?', false) = true then begin
                            UpdateTotalValue(DimOne, DimTwo, ValueToUpdate, TotalValue);
                        end;
                    end
                    else
                        UpdateTotalValue(DimOne, DimTwo, ValueToUpdate, TotalValue);
                //
                end
                else if ValueToUpdate = ValueToUpdate::"No. of Staff" then begin
                        //Cost Center Value
                        if CostCenterValue = 0 then begin
                            if Confirm('The Cost Center Value is zero, do you wish to change the Cost Center No. of Staff to zero?', false) = true then begin
                                UpdateCostCenterValue(DimOne, DimTwo, ValueToUpdate, CostCenterValue);
                            end;
                        end
                        else
                            UpdateCostCenterValue(DimOne, DimTwo, ValueToUpdate, CostCenterValue);
                        //Total Value
                        if TotalValue = 0 then begin
                            if Confirm('The Total Value is zero, do you wish to change the Total No. of Staff to zero?', false) = true then begin
                                UpdateTotalValue(DimOne, DimTwo, ValueToUpdate, TotalValue);
                            end;
                        end
                        else
                            UpdateTotalValue(DimOne, DimTwo, ValueToUpdate, TotalValue);
                    //
                    end
                    else if ValueToUpdate = ValueToUpdate::"Office Space" then begin
                            //Cost Center Value
                            if CostCenterValue = 0 then begin
                                if Confirm('The Cost Center Value is zero, do you wish to change the Cost Center office space to zero?', false) = true then begin
                                    UpdateCostCenterValue(DimOne, DimTwo, ValueToUpdate, CostCenterValue);
                                end;
                            end
                            else
                                UpdateCostCenterValue(DimOne, DimTwo, ValueToUpdate, CostCenterValue);
                            //Total Value
                            if TotalValue = 0 then begin
                                if Confirm('The Total Value is zero, do you wish to change the Total office space to zero?', false) = true then begin
                                    UpdateTotalValue(DimOne, DimTwo, ValueToUpdate, TotalValue);
                                end;
                            end
                            else
                                UpdateTotalValue(DimOne, DimTwo, ValueToUpdate, TotalValue);
                        //
                        end;
            end;
        end;
    end;
    var DimOne: Code[20];
    DimTwo: Code[20];
    ValueToUpdate: Option " ", "No. of Staff", "Office Space", "Electronic Footprint";
    CostCenterValue: Decimal;
    TotalValue: Decimal;
    CostCenter: Record "Motorpool Cost Centers";
    procedure UpdateCostCenterValue(var DimOne: Code[20]; var DimTwo: Code[20]; var ValueToUpdate: Option " ", "No. of Staff", "Office Space", "Electronic Footprint"; var Amount: Decimal)
    begin
        CostCenter.Reset;
        if DimOne <> '' then CostCenter.SetRange("Global Dimension 1 Code", DimOne);
        if DimTwo <> '' then CostCenter.SetRange("Global Dimension 2 Code", DimTwo);
        if CostCenter.FindSet then begin
            if ValueToUpdate = ValueToUpdate::"Electronic Footprint" then CostCenter.ModifyAll("Cost Ctr Electronic Footprint", CostCenterValue)
            else if ValueToUpdate = ValueToUpdate::"No. of Staff" then CostCenter.ModifyAll("Cost Center No. of Staff", CostCenterValue)
                else if ValueToUpdate = ValueToUpdate::"Office Space" then CostCenter.ModifyAll("Cost Center Office Space", CostCenterValue);
        end;
    end;
    procedure UpdateTotalValue(var DimOne: Code[20]; var DimTwo: Code[20]; var ValueToUpdate: Option " ", "No. of Staff", "Office Space", "Electronic Footprint"; var Amount: Decimal)
    begin
        CostCenter.Reset;
        if DimOne <> '' then CostCenter.SetRange("Global Dimension 1 Code", DimOne);
        if DimTwo <> '' then CostCenter.SetRange("Global Dimension 2 Code", DimTwo);
        if CostCenter.FindSet then begin
            if ValueToUpdate = ValueToUpdate::"Electronic Footprint" then CostCenter.ModifyAll("Total Electronic Footprint", TotalValue)
            else if ValueToUpdate = ValueToUpdate::"No. of Staff" then CostCenter.ModifyAll("Total No. of Staff", TotalValue)
                else if ValueToUpdate = ValueToUpdate::"Office Space" then CostCenter.ModifyAll("Total Office Space", TotalValue);
        end;
    end;
}
