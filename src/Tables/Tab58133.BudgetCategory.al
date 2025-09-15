table 58133 "Budget Category"
{
    // version BUDGET
    DrillDownPageID = "Budget Categories";
    LookupPageID = "Budget Categories";

    fields
    {
        field(1; No; Code[10])
        {
        }
        field(2; Description; Text[100])
        {
        }
        field(3; "Budget Line"; Code[20])
        {
            TableRelation = "G/L Account";

            trigger OnValidate()
            begin
                if GLAcc.Get("Budget Line") then "Budget Line Description" := GLAcc.Name;
                if not ExpenseCodes.Get(No) then begin
                    ExpenseCodes.Init;
                    ExpenseCodes.Code := No;
                    ExpenseCodes.Description := Description;
                    if Type = Type::CAPEX then
                        ExpenseCodes."Account Type" := ExpenseCodes."Account Type"::"Fixed Asset"
                    else begin
                        ExpenseCodes."Account Type" := ExpenseCodes."Account Type"::"G/L Account";
                        ExpenseCodes."Account No" := "Budget Line";
                        ExpenseCodes."Account Name" := "Budget Line Description";
                    end;
                    ExpenseCodes.Insert;
                end;
            end;
        }
        field(4; Inactive; Boolean)
        {
        }
        field(5; "Budget Line Description"; Text[50])
        {
        }
        field(6; "Business Unit"; Option)
        {
            OptionCaption = 'IT,ADMIN';
            OptionMembers = IT,ADMIN;
        }
        field(7; Type; Option)
        {
            OptionCaption = 'CAPEX,OPEX';
            OptionMembers = CAPEX,OPEX;
        }
    }
    keys
    {
        key(Key1; No)
        {
        }
        key(Key2; "Budget Line")
        {
        }
    }
    fieldgroups
    {
    }
    var
        GLAcc: Record "G/L Account";
        ExpenseCodes: Record "Expense Codes";
}
