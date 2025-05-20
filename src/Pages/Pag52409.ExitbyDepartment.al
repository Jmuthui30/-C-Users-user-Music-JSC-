page 52409 "Exit by Department"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = TableName;
    RefreshOnActivate = true;
    Caption = 'Employee Exit by Department';

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
                    Employee: Record Employee;
                    i: Integer;
                    a: Integer;
                    b: Integer;
                begin
                    Buffer.Initialize();
                    Buffer.AddMeasure('Employees', 0, Buffer."Data Type"::Integer, Buffer."Chart Type"::Pie);
                    buffer.SetXAxis('Department', Buffer."Data Type"::String);
                    Dimensions.Reset();
                    Dimensions.SetRange("Dimension Code", 'DEPT');
                    if Dimensions.FindSet()then repeat Employee.Reset();
                            Employee.SetRange("Global Dimension 1 Code", Dimensions.Code);
                            Employee.SetRange(Status, Employee.Status::Inactive);
                            a:=Employee.Count;
                            Employee.Reset();
                            Employee.SetRange("Global Dimension 1 Code", Dimensions.Code);
                            Employee.SetRange(Status, Employee.Status::Terminated);
                            b:=Employee.Count;
                            Buffer.AddColumn(Dimensions.Name);
                            if a <> 0 then Buffer.SetValueByIndex(0, i, a);
                            if b <> 0 then Buffer.SetValueByIndex(0, i, b);
                            i+=1;
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
