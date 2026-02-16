pageextension 51013 "Chart of Accounts Ext" extends "Chart of Accounts"
{
    Editable = false;
    layout
    {

        addlast(Control1)
        {

            field("Budgeted Amount"; Rec."Budgeted Amount")
            {
                ApplicationArea = All;
                Caption = 'Budgeted Amount';
                ToolTip = 'Specifies either the G/L account''s total budget or, if you have specified a name in the Budget Name field, a specific budget.';
            }

        }
    }
}
