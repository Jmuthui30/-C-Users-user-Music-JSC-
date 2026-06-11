page 52063 "HR Appraisal Dev Actions"
{
    ApplicationArea = All;
    Caption = 'Appraisal Developmental Actions';
    PageType = ListPart;
    SourceTable = "Appraisal Comments";
    PopulateAllFields = true;

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                Caption = 'Control2';
                Editable = CommentsEditable;

                field("Appraisal No."; Rec."Appraisal No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Appraisal No. field';
                    Caption = 'Appraisal No.';
                }
                field(Person; Rec.Person)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Person field';
                    Caption = 'Person';
                }
                field("Review Period Code"; Rec."Review Period Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the quarterly review period for this comment.';
                }
                field("Developmental Action"; Rec."Developmental Action")
                {
                    ToolTip = 'Specifies the value of the Developmental Action field.';
                    Caption = 'Developmental Action';
                }
                field("Comments on Performance"; Rec."Comments on Performance")
                {
                    ShowCaption = false;
                    ToolTip = 'Specifies the value of the Comments on Performance field';
                    Caption = 'Comments on Performance';
                }
            }
        }
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





