pageextension 51006 CustomerBankAccountPageExt extends "Customer Bank Account Card"
{
    layout
    {
        moveafter(Name; "Bank Branch No.")
        moveafter("Bank Account No."; Name)

        modify(Code)
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }

        modify("Bank Branch No.")
        {
            trigger OnAfterValidate()
            begin
                CurrPage.Update();
            end;
        }

        addafter(Code)
        {
            field("Bank Name"; Rec.Name)
            {
                ApplicationArea = All;
                Caption = 'Bank Name';
                ToolTip = 'Specifies the value of the Bank Name field.';
            }
        }
        addafter("Bank Branch No.")
        {
            field("Bank Branch Name"; Rec."Bank Branch Name")
            {
                ApplicationArea = All;
                Caption = 'Bank Branch Name';
                ToolTip = 'Specifies the value of the Bank Branch Name field';
            }
        }
    }
}
