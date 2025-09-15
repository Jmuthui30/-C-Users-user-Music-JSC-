tableextension 51000 VendorBankAccountTableExt extends "Vendor Bank Account"
{
    fields
    {

        modify("Bank Branch No.")
        {
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code" = field(Code));
            trigger OnAfterValidate()
            begin
                if BankBranches.Get(Code, "Bank Branch No.") then
                    "Bank Branch Name" := BankBranches."Branch Name";
            end;
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

    var
        BankBranches: Record "Bank Branches";
        Banks: Record "Bank Account";
}
