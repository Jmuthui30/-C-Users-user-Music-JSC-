xmlport 52111 "Staff Based Budget"
{
    Direction = Import;
    Format = VariableText;
    UseRequestPage = false;

    schema
    {
    textelement(Root)
    {
    tableelement("Staff Based Budget";
    "Staff Based Budget")
    {
    XmlName = 'StaffBasedBudget';

    fieldattribute(Budget;
    "Staff Based Budget".Budget)
    {
    }
    fieldattribute(StaffNo;
    "Staff Based Budget"."Staff No.")
    {
    }
    fieldattribute(BudgetLineAccount;
    "Staff Based Budget"."Budget Line Account")
    {
    }
    fieldattribute(Amount;
    "Staff Based Budget".Amount)
    {
    }
    }
    }
    }
    trigger OnPostXmlPort()
    begin
        Message('Import Completed.');
    end;
    trigger OnPreXmlPort()
    begin
        StaffBudget.Reset;
        StaffBudget.DeleteAll;
    end;
    var StaffBudget: Record "Staff Based Budget";
}
