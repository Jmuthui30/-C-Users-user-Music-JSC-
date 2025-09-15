report 52252 "Earnings Mass Update"
{
    ApplicationArea = All;
    Caption = 'Earnings Mass Update';
    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = sorting("No.") where(Status = const(Inactive));
            RequestFilterFields = "No.", "Global Dimension 1 Code";

            trigger OnAfterGetRecord()
            begin
                Payroll.DefaultEarningsDeductionsAssignment(Employee);
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

    var
        EarningRec: Record Earning;
        PayPeriod: Record "Payroll Period";
        Payroll: Codeunit Payroll;
        BeginDate: Date;

    procedure GetEarnings(var EarnRec: Record Earning)
    begin
        EarningRec:=EarnRec;
    end;

    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then
            //PayPeriodtext:=PayPeriod.Name;
            BeginDate := PayPeriod."Starting Date";
    end;
}





