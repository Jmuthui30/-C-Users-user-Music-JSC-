report 51500 "Close Bal Appraisal Period"
{
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(AppraisalNo; AppraisalNo)
                    {
                        ApplicationArea = All;
                        Caption = 'Appraisal No';
                        Editable = false;
                    }
                    field(CurrentReveiwPeriod; CurrentReveiwPeriod)
                    {
                        ApplicationArea = All;
                        Caption = 'Progress Reveiw Period';
                        Editable = false;
                    }
                    field(NextReviewPeriod; NextReviewPeriod)
                    {
                        ApplicationArea = All;
                        Caption = 'Next Progress Reveiw Period';
                        ShowMandatory = true;
                        TableRelation = "Bal Score Preview Periods";
                    }
                }
            }
        }
    }
    trigger OnPreReport()
    begin
        BalScoreCardMngt.ChangeProgressReviewPeriod(AppraisalNo, CurrentReveiwPeriod, NextReviewPeriod);
    end;
    var AppraisalNo: Code[20];
    CurrentReveiwPeriod: Code[20];
    NextReviewPeriod: Code[20];
    BalScoreCardMngt: Codeunit "Bal Score Card Mngt.";
    /// <summary>
    /// GetAppraisalNo.
    /// </summary>
    /// <param name="Var Appraisal ">Record "Bal Score Card Header".</param>
    procedure GetAppraisalNo(Var Appraisal: Record "Bal Score Card Header")
    begin
        AppraisalNo:=Appraisal."No.";
        CurrentReveiwPeriod:=Appraisal."Progress Review Period";
        NextReviewPeriod:='';
    end;
}
