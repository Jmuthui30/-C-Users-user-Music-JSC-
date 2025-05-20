page 52407 "Distribution by Age"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    //SourceTable = TableName;
    RefreshOnActivate = true;
    Caption = 'Employee Distribution by Age';

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
                    Employee2: Record Employee;
                    i: Integer;
                    a: Integer;
                    b: Integer;
                    c: Integer;
                    d: Integer;
                    y1: Integer;
                    y2: Integer;
                    AgeDistribution: Label 'Distribution by Age';
                    Age: Text[100];
                    Dates: Codeunit "HR Dates";
                begin
                    Buffer.Initialize();
                    Buffer.AddMeasure('20..29', 0, Buffer."Data Type"::Integer, Buffer."Chart Type"::Column);
                    Buffer.AddMeasure('30..39', 1, Buffer."Data Type"::Integer, Buffer."Chart Type"::Column);
                    Buffer.AddMeasure('40..49', 2, Buffer."Data Type"::Integer, Buffer."Chart Type"::Column);
                    Buffer.AddMeasure('>50', 3, Buffer."Data Type"::Integer, Buffer."Chart Type"::Column);
                    buffer.SetXAxis('Age', Buffer."Data Type"::String);
                    Employee.Reset();
                    Employee.SetRange(Status, Employee.Status::Active);
                    IF Employee.FindSet()then repeat if Employee."Birth Date" <> 0D then begin
                                y1:=Date2DMY(Today, 3);
                                y2:=Date2DMY(Employee."Birth Date", 3);
                                //Employee."Employee Age" := y1 - y2;
                                Employee.Modify(true);
                            end;
                        until Employee.Next() = 0;
                    Employee2.Reset();
                    Employee2.SetFilter("Employee Age", '%1..%2', '20', '29');
                    if Employee2.FindSet()then a:=Employee2.Count;
                    Employee2.Reset();
                    Employee2.SetFilter("Employee Age", '%1..%2', '30', '39');
                    if Employee2.FindSet()then b:=Employee2.Count;
                    Employee2.Reset();
                    Employee2.SetFilter("Employee Age", '%1..%2', '40', '49');
                    if Employee2.FindSet()then c:=Employee2.Count;
                    Employee2.Reset();
                    Employee2.SetFilter("Employee Age", '>%1', '50');
                    if Employee2.FindSet()then d:=Employee2.Count;
                    Buffer.AddColumn(AgeDistribution);
                    Buffer.SetValueByIndex(0, i, a);
                    Buffer.SetValueByIndex(1, i, b);
                    Buffer.SetValueByIndex(2, i, c);
                    Buffer.SetValueByIndex(3, i, d);
                    i+=1;
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
