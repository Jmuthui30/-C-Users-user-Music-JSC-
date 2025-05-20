page 52400 "Balance Score Card Chart"
{
    PageType = CardPart;
    ApplicationArea = All;
    UsageCategory = Administration;

    //SourceTable = TableName;
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
                    Bal: Record "Bal Score Card Header";
                    i: Integer;
                    lineCount: Integer;
                begin
                    HRSetUp.Get();
                    Buffer.Initialize();
                    Buffer.AddMeasure('Target', 0, Buffer."Data Type"::Decimal, Buffer."Chart Type"::Column);
                    Buffer.AddMeasure('Score', 1, Buffer."Data Type"::Decimal, Buffer."Chart Type"::Column);
                    buffer.SetXAxis('Employee', Buffer."Data Type"::String);
                    if HRSetUp."No Of Chart Entries" <> 0 then lineCount:=HRSetUp."No Of Chart Entries"
                    else
                        lineCount:=5;
                    Bal.Reset();
                    Bal.SetCurrentKey(Score);
                    Bal.SetAscending(Score, false);
                    if Bal.FindSet()then repeat lineCount:=lineCount - 1;
                            Bal.CalcFields(Score);
                            Bal.CalcFields("Expected Score");
                            if Bal.Score <> 0 then begin
                                Buffer.AddColumn(Bal."Employee Name");
                                Buffer.SetValueByIndex(0, i, Bal."Expected Score");
                                Buffer.SetValueByIndex(1, i, Bal."Combined Score");
                                i+=1;
                            end;
                        until((lineCount = 0) OR (Bal.Next() = 0));
                    Buffer.Update(CurrPage.Chart);
                end;
            }
        }
    }
    var HRSetUp: Record "QuantumJumps HR Setup";
}
