page 52404 "Head Count Distribution"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = TableName;
    RefreshOnActivate = true;
    Caption = 'Employee Head Count Distribution';

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
                    AccountingPeriods: Record "Accounting Period";
                    Month: Date;
                    Employee: Record Employee;
                    i: Integer;
                    j: Integer;
                begin
                    Buffer.Initialize();
                    Buffer.AddMeasure('Employees', 0, Buffer."Data Type"::Integer, Buffer."Chart Type"::Point);
                    buffer.SetXAxis('Month', Buffer."Data Type"::String);
                    AccountingPeriods.Reset();
                    AccountingPeriods.SetRange(Closed, false);
                    if AccountingPeriods.FindSet()then repeat Employee.Reset();
                            Employee.SetRange(Status, Employee.Status::Active);
                            j:=Employee.Count;
                            if j <> 0 then begin
                                Buffer.AddColumn(AccountingPeriods.Name);
                                Buffer.SetValueByIndex(0, i, j);
                                i+=1;
                            end;
                        until AccountingPeriods.Next() = 0;
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
