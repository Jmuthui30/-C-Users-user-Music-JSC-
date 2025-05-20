report 52116 "Distribute Staff Based Budget"
{
    // version BUDGET
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Staff Based Budget"; "Staff Based Budget")
        {
            DataItemTableView = WHERE("Budget Line Account"=filter(<>''), Department=FILTER(<>''), Amount=filter(<>0));
            RequestFilterFields = "Staff No.", Department, Branch;

            trigger OnAfterGetRecord()
            begin
                if "Staff Based Budget"."Staff No." <> '' then DistributeStaffBasedBudget("Staff Based Budget");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field(RefDate; RefDate)
                {
                    ApplicationArea = All;
                    Caption = 'Referance Date';
                    ShowMandatory = true;
                }
            }
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        DraftBudget.Reset;
        DraftBudget.DeleteAll;
        if RefDate = 0D then Error(Text000);
    end;
    var DraftBudget: Record "Budget Distribution";
    Counter: Integer;
    DraftBudgetCopy: Record "Budget Distribution";
    StaffBudget: Record "Staff Based Budget";
    RefDate: Date;
    Text000: Label 'Reference Date must have a value';
    local procedure DistributeStaffBasedBudget(var StaffBasedBudget: Record "Staff Based Budget")
    begin
        DraftBudget.Init;
        DraftBudget.Validate("GL Account", StaffBasedBudget."Budget Line Account");
        DraftBudget.Validate(Department, StaffBasedBudget.Department);
        DraftBudget.Validate(Branch, StaffBasedBudget.Branch);
        DraftBudget.Validate("SI Code", StaffBasedBudget."SI Code");
        DraftBudget.Budget:=StaffBasedBudget.Budget;
        DraftBudget.Date:=RefDate;
        DraftBudget.Amount:=Round(StaffBasedBudget.Amount, 0.01);
        if not DraftBudgetCopy.Get(StaffBasedBudget."Budget Line Account", StaffBasedBudget.Department, StaffBasedBudget.Branch, StaffBasedBudget."SI Code", StaffBasedBudget.Budget, RefDate)then DraftBudget.Insert
        else
        begin
            DraftBudgetCopy.Amount:=DraftBudgetCopy.Amount + DraftBudget.Amount;
            DraftBudgetCopy.Modify;
        end;
    end;
}
