page 52403 "Distribution by cadre"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = TableName;
    RefreshOnActivate = true;
    Caption = 'Employee Distribution by Management Cadre';

    layout
    {
        area(Content)
        {
            usercontrol(Chart; "Microsoft.Dynamics.Nav.Client.BusinessChart")
            {
                ApplicationArea = All;

                trigger AddInReady()
                var
                    Buffer: Record "Business Chart Buffer";
                    Dimensions: Record "Dimension Value";
                    EmployeeMaster: Record "Employee";
                    i: Integer;
                    j: Integer;
                begin
                    Buffer.Initialize();
                    Buffer.AddMeasure('Employees', 0, Buffer."Data Type"::Integer, Buffer."Chart Type"::Column);
                    buffer.SetXAxis('Department', Buffer."Data Type"::String);
                    Dimensions.Reset();
                    Dimensions.SetRange("Dimension Code", 'DEPARTMENT');
                    if Dimensions.FindSet()then repeat EmployeeMaster.Reset();
                            EmployeeMaster.SetRange("Global Dimension 1 Code", Dimensions.Code);
                            EmployeeMaster.SetRange(Status, EmployeeMaster.Status::Active);
                            j:=EmployeeMaster.Count;
                            if j <> 0 then begin
                                Buffer.AddColumn(Dimensions.Name);
                                Buffer.SetValueByIndex(0, i, j);
                                i+=1;
                            end;
                        until Dimensions.Next() = 0;
                    Buffer.Update(CurrPage.Chart);
                end;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                end;
            }
        }
    }
    var myInt: Integer;
}
