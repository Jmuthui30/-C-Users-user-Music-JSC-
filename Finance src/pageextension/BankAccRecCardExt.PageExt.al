pageextension 51050 "Bank Acc. Rec. Card Ext" extends "Bank Acc. Reconciliation"
{
    layout
    {
        // Add changes to page layout here

    }


    actions
    {
        // Add changes to page actions here
        addlast(processing)
        {
            action("Test Report")
            {
                ApplicationArea = All;
                Caption = 'Test Report New';
                Image = Report;
                ToolTip = 'Test Report New';
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    BankRec: Record "Bank Acc. Reconciliation";
                    begin
                      BankRec.Reset();
                    BankRec.SetRange("Bank Account No.",Rec."Bank Account No.");
                    BankRec.SetRange("Statement No.",Rec."Statement No.");
                    if BankRec.FindFirst() then
                   Report.Run(Report::"Bank Reconciliation Test Rep", true, false, BankRec);
                    end;
            }
        }

        // modify("&Test Report_Promoted")
        // {
        //     Visible = false;
        // }
    }

var
        myInt: Integer;
}


    
