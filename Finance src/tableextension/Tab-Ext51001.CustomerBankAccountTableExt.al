tableextension 51001 CustomerBankAccountTableExt extends "Customer Bank Account"
{
    fields
    {

        modify("Bank Branch No.")
        {
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field(Code));
        }
        modify(Name)
        {
            Caption = 'Account Name';
        }
        field(51001; "Bank Branch Name"; Text[250])
        {
            CalcFormula = lookup("Bank Branches"."Branch Name" where("Bank Code" = field(Code)));
            Caption = 'Bank Branch Name';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
