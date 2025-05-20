report 50026 "Fix New Expense Codes"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Fix New Expense Codes.rdlc';

    dataset
    {
        dataitem(NewCodes; "New Codes")
        {
            trigger OnAfterGetRecord()
            begin
                RequisitionLines.Reset;
                RequisitionLines.SetRange(No, NewCodes."Expense Code");
                if RequisitionLines.FindSet then begin
                    repeat RequisitionLines.ModifyAll(Type, RequisitionLines.Type::Expense);
                    until RequisitionLines.Next = 0;
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
    var ExpenseCodes: Record "Expense Codes";
    RequisitionLines: Record "Requisition Lines";
}
