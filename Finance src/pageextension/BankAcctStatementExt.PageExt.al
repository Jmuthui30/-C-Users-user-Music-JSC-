pageextension 51031 "Bank Acct Statement Ext" extends "Bank Account Statement"
{
     layout
    {

    }
    actions
    {
        addafter(Print)
        {
            action("Bank ReconReport")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reconciliation Report';
                Image = Report;
                ToolTip = 'Executes the Journal Report action.';
                Promoted= true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    BankRec.Reset();
                    BankRec.SetRange("Bank Account No.",Rec."Bank Account No.");
                    BankRec.SetRange("Statement No.",Rec."Statement No.");
                    if BankRec.FindFirst() then
                   Report.Run(Report::"Bank Reconciliation",true,true,BankRec);
                end;
            }
        }
    }
    var
    BankRec: Record "Bank Account Statement";
}
