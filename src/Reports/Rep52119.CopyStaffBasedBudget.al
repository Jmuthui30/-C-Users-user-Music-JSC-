report 52119 "Copy Staff Based Budget"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(From_BudgetName; From_BudgetName)
                {
                    ApplicationArea = All;
                    TableRelation = "G/L Budget Name" where(Status=const(Released));
                    ShowMandatory = true;
                    Caption = 'From Budget Name';
                }
                field(To_BudgetName; To_BudgetName)
                {
                    ApplicationArea = All;
                    TableRelation = "G/L Budget Name" where(Status=const(Open));
                    ShowMandatory = true;
                    Caption = 'To Budget Name';
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        if From_BudgetName = '' then Error('From Budget Name must have a value');
        if To_BudgetName = '' then Error(' To Budget Name must have a value');
        CopyStaffBasedBudget;
    end;
    local procedure CopyStaffBasedBudget()
    begin
        StaffBasedBudget.Reset();
        StaffBasedBudget.SetRange(Budget, From_BudgetName);
        if StaffBasedBudget.FindSet()then begin
            repeat Copy_StaffBasedBudget.Init();
                Copy_StaffBasedBudget.Budget:=To_BudgetName;
                Copy_StaffBasedBudget.Validate("Staff No.", StaffBasedBudget."Staff No.");
                Copy_StaffBasedBudget.Validate(Department, StaffBasedBudget.Department);
                Copy_StaffBasedBudget.Validate(Branch, StaffBasedBudget.Branch);
                Copy_StaffBasedBudget.Validate("SI Code", StaffBasedBudget."SI Code");
                Copy_StaffBasedBudget.Validate("Budget Line Account", StaffBasedBudget."Budget Line Account");
                Copy_StaffBasedBudget.Amount:=StaffBasedBudget.Amount;
                if not StaffBasedBudgetCheck.Get(To_BudgetName, StaffBasedBudget."Staff No.", StaffBasedBudget."SI Code", StaffBasedBudget."Budget Line Account")then Copy_StaffBasedBudget.Insert(true);
            until StaffBasedBudget.Next() = 0;
            Message('Copying Complete');
        end;
    end;
    var From_BudgetName: Code[10];
    To_BudgetName: Code[10];
    StaffBasedBudget: Record "Staff Based Budget";
    Copy_StaffBasedBudget: Record "Staff Based Budget";
    StaffBasedBudgetCheck: Record "Staff Based Budget";
}
