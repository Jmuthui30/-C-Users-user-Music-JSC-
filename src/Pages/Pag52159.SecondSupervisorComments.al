page 52159 "Second Supervisor Comments"
{
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Appraisal Comments";
    Caption = 'Second Supervisor Comments';
    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                Editable = CommentsEditable;

                field("Appraisal No."; Rec."Appraisal No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Appraisal No. field';
                }
                field(Person; Rec.Person)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Person field';
                }
                field("Review Period Code"; Rec."Review Period Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the quarterly review period for this comment.';
                }
                field("Comments on Performance"; Rec."Comments on Performance")
                {
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Comments on Performance field';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        ApplyCommentDefaultsFromFilters();
        SetControlAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ApplyCommentDefaultsFromFilters();
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    begin
        ApplyCommentDefaultsFromFilters();
        SetControlAppearance();
    end;

    var
        EmployeeAppraisal: Record "Employee Appraisal";
        CommentsEditable: Boolean;

    local procedure ApplyCommentDefaultsFromFilters()
    begin
        Rec.ApplyDefaultsFromFilters(Rec.GetFilter("Appraisal No."), Rec.GetFilter("Review Period Code"), Rec.GetFilter(Person));
    end;

    local procedure SetControlAppearance()
    begin
        CommentsEditable := false;

        if Rec."Appraisal No." = '' then
            exit;

        if not EmployeeAppraisal.Get(Rec."Appraisal No.") then
            exit;

        CommentsEditable :=
            ((EmployeeAppraisal.Status = EmployeeAppraisal.Status::Open) and
             (EmployeeAppraisal."Appraisal Status" in [EmployeeAppraisal."Appraisal Status"::Setting, EmployeeAppraisal."Appraisal Status"::Set])) or
            ((EmployeeAppraisal.Status = EmployeeAppraisal.Status::Released) and
             (EmployeeAppraisal."Appraisal Status" in [EmployeeAppraisal."Appraisal Status"::Review, EmployeeAppraisal."Appraisal Status"::"Further review"]));
    end;
}





