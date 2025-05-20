page 52401 "Distribution by Location"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = TableName;
    RefreshOnActivate = true;
    Caption = 'Employee Distribution by Location';

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
                    EmployeeMaster2: Record "Employee";
                    i: Integer;
                    j: Decimal;
                begin
                    Buffer.Initialize();
                    Buffer.AddMeasure('Employees', 0, Buffer."Data Type"::Integer, Buffer."Chart Type"::Pie);
                    buffer.SetXAxis('Location', Buffer."Data Type"::String);
                    EmployeeMaster2.Reset();
                    EmployeeMaster2.SetRange(Status, EmployeeMaster2.Status::Active);
                    Dimensions.Reset();
                    Dimensions.SetRange("Dimension Code", 'DEPARTMENT');
                    if Dimensions.FindSet()then repeat EmployeeMaster.Reset();
                            EmployeeMaster.SetRange("Global Dimension 1 Code", Dimensions.Code);
                            EmployeeMaster.SetRange(Status, EmployeeMaster.Status::Active);
                            j:=Round(((EmployeeMaster.Count / EmployeeMaster2.Count) * 100), 0.05);
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
}
