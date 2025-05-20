page 52416 "Exit by Location"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = TableName;
    RefreshOnActivate = true;
    Caption = 'Employee Distribution by Location %';

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
                    EmployeeMaster: Record "Employee Master";
                    i: Integer;
                    j: Integer;
                begin
                    Buffer.Initialize();
                    Buffer.AddMeasure('Employees', 0, Buffer."Data Type"::Integer, Buffer."Chart Type"::Pie);
                    buffer.SetXAxis('Location', Buffer."Data Type"::String);
                    Dimensions.Reset();
                    Dimensions.SetRange("Dimension Code", 'BRANCH');
                    if Dimensions.FindSet()then repeat EmployeeMaster.Reset();
                            EmployeeMaster.SetRange("Global Dimension 2 Code", Dimensions.Code);
                            EmployeeMaster.SetRange(Status, EmployeeMaster.Status::Inactive);
                            EmployeeMaster.SetRange(Status, EmployeeMaster.Status::Terminated);
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
