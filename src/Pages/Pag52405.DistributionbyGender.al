page 52405 "Distribution by Gender"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = TableName;
    RefreshOnActivate = true;
    Caption = 'Employee Distribution by Gender';

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
                    Employee: Record Employee;
                    i: Integer;
                    m: Integer;
                    f: Integer;
                begin
                    Buffer.Initialize();
                    Buffer.AddMeasure('Male', 0, Buffer."Data Type"::Integer, Buffer."Chart Type"::Column);
                    Buffer.AddMeasure('Female', 0, Buffer."Data Type"::Integer, Buffer."Chart Type"::Column);
                    buffer.SetXAxis('Gender', Buffer."Data Type"::String);
                    Employee.Reset();
                    Employee.SetRange(Gender, Employee.Gender::Male);
                    m:=Employee.Count;
                    Employee.Reset();
                    Employee.SetRange(Gender, Employee.Gender::Female);
                    f:=Employee.Count;
                    IF((m <> 0) or (f <> 0))then begin
                        Buffer.AddColumn(Employee.Gender);
                        Buffer.SetValueByIndex(0, i, m);
                        Buffer.SetValueByIndex(1, i, f);
                        i+=1;
                    end;
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
