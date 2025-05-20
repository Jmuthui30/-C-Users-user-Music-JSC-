page 51520 "Bal Admin App Score Card Lines"
{
    PageType = ListPart;
    SourceTable = "Bal Score Card Lines";
    SourceTableView = where("Document Type"=const(Appraisal));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Percepective; Rec.Percepective)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Progress Review Period"; Rec."Progress Review Period")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Achievements ToDate"; Rec."Achievements ToDate")
                {
                    ApplicationArea = All;
                    Caption = 'Achievements / Progress To-Date';
                    Visible = QTRVisibility;
                }
                // field(Emphasis;  Rec.Emphasis)
                // {
                //     ApplicationArea = All;
                //     Visible = QTRVisibility;
                // }
                // field("Performance Results";  Rec."Achievements ToDate")
                // {
                //     ApplicationArea = All;
                //     Visible = FullAppraisalVisibility;
                // }
                field("Self Rating"; Rec."Self Rating")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Joint Rating"; Rec."Joint Rating")
                {
                    ApplicationArea = All;
                    Visible = FullAppraisalVisibility;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                    Visible = FullAppraisalVisibility;
                }
                field("Expected Max Score"; Rec."Expected Max Score")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    var FullAppraisalVisibility: Boolean;
    QTRVisibility: Boolean;
    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;
    trigger OnInit()
    begin
        SetControlAppearance;
    end;
    trigger OnOpenPage();
    begin
        SetControlAppearance;
    end;
    local procedure SetControlAppearance()
    begin
        // if "Full Period Appraisal" = true then begin
        //     FullAppraisalVisibility := true;
        //     QTRVisibility := false;
        // end else begin
        //     FullAppraisalVisibility := false;
        //     QTRVisibility := true;
        // end;
        FullAppraisalVisibility:=true;
        QTRVisibility:=true;
    end;
}
