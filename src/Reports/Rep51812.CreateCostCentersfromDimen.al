report 51812 "Create Cost Centers from Dimen"
{
    Caption = 'Create Cost Centers from Dimensions';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = WHERE("Global Dimension No."=CONST(1));

            trigger OnAfterGetRecord()
            begin
                Dimension.Reset;
                Dimension.SetRange("Global Dimension No.", 2);
                if Dimension.FindSet then begin
                    repeat if not CostCenter.Get("Dimension Value".Code, Dimension.Code)then begin
                            CostCenter.Init;
                            CostCenter.Validate("Global Dimension 1 Code", "Dimension Value".Code);
                            CostCenter.Validate("Global Dimension 2 Code", Dimension.Code);
                            CostCenter.Insert;
                        end;
                    until Dimension.Next = 0;
                end
                else
                begin
                    if not CostCenter.Get("Dimension Value".Code, '')then begin
                        CostCenter.Init;
                        CostCenter.Validate("Global Dimension 1 Code", "Dimension Value".Code);
                        CostCenter.Insert;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    var Dimension: Record "Dimension Value";
    CostCenter: Record "Motorpool Cost Centers";
}
