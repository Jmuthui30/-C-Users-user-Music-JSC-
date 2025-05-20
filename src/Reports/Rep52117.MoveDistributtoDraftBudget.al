report 52117 "Move Distribut to Draft Budget"
{
    // version BUDGET
    Caption = 'Move Budget Distribution to the Draft Budget';
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Budget Distribution"; "Budget Distribution")
        {
            // DataItemTableView = WHERE(Budget = field(BudgetName))
            trigger OnAfterGetRecord()
            begin
                if "Budget Distribution".Budget = BudgetName then begin
                    Counter:=Counter + 1000;
                    MainBudget.Init;
                    MainBudget."Entry No.":=Counter;
                    MainBudget."Budget Name":=BudgetName;
                    MainBudget."G/L Account No.":="Budget Distribution"."GL Account";
                    MainBudget.Date:="Budget Distribution".Date;
                    MainBudget."Global Dimension 1 Code":="Budget Distribution".Department;
                    MainBudget."Global Dimension 2 Code":="Budget Distribution".Branch;
                    MainBudget.Amount:="Budget Distribution".Amount;
                    MainBudget.Description:="Budget Distribution".Description;
                    MainBudget."User ID":=UserId;
                    MainBudget."Budget Dimension 1 Code":="Budget Distribution"."SI Code";
                    MainBudgetCopy.Reset;
                    MainBudgetCopy.SetRange("Budget Name", BudgetName);
                    MainBudgetCopy.SetRange("G/L Account No.", "Budget Distribution"."GL Account");
                    MainBudgetCopy.SetRange("Global Dimension 1 Code", "Budget Distribution".Department);
                    MainBudgetCopy.SetRange("Global Dimension 2 Code", "Budget Distribution".Branch);
                    MainBudgetCopy.SetRange("Budget Dimension 1 Code", "Budget Distribution"."SI Code");
                    if MainBudgetCopy.FindFirst = false then MainBudget.Insert
                    else
                    begin
                        MainBudgetCopy.Amount:="Budget Distribution".Amount;
                        MainBudgetCopy.Description:="Budget Distribution".Description;
                        MainBudgetCopy.Modify;
                    end;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                field(BudgetName; BudgetName)
                {
                    ApplicationArea = All;
                    TableRelation = "G/L Budget Name" where(Status=const(Open));
                    ShowMandatory = true;
                    Caption = 'Budget Name';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        Counter:=10000;
        if BudgetName = '' then Error('Budget Name must have a value');
    end;
    var MainBudget: Record "Draft Budget Entry";
    Counter: Integer;
    MainBudgetCopy: Record "Draft Budget Entry";
    BudgetName: Code[10];
}
