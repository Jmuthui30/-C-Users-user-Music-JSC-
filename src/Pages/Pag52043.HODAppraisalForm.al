page 58043 "HOD Appraisal Form"
{
    SourceTable = "Employee Appraisals";
    PageType = Card;
    SourceTableView = WHERE(Status = CONST(Open));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Category"; Rec."Appraisal Category")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee''s No.';
                }
                field("Employee.""First Name"" + ' ' + Employee.""Middle Name"" + ' ' + Employee.""Last Name"""; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee''s Names';
                    Editable = false;
                }
                field("EmpNav.Position"; EmpNav.Position)
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee''s Designation';
                    Editable = false;
                }
                field("Job Group"; Rec."Job Group")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee''s Job Group';
                    Editable = false;
                }
                field("Employee.""Job Title"""; Employee."Job Title")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee''s Job Title';
                    Editable = false;
                }
                field("Appraiser No"; Rec."Appraiser No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Appraisers Name"; Rec."Appraisers Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            field(Control4; '')
            {
                ApplicationArea = All;
                CaptionClass = Text19018837;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(Control3; "Objective Lines-Appraisal")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No" = FIELD("Employee No"), "Appraisal Period" = FIELD("Appraisal Period");
            }
            field(Control2; '')
            {
                ApplicationArea = All;
                CaptionClass = Text19036363;
                ShowCaption = false;
            }
            part(Control1; "Appraiser and Appraisee Comm")
            {
                ApplicationArea = All;
                SubPageLink = "Appraisal No" = FIELD("Appraisal No");
                Visible = false;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Next Page   >>")
            {
                ApplicationArea = All;
                Caption = 'Next Page   >>';
                Image = NextRecord;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if EmployeeApp.Get(Rec."Appraisal No") then PAGE.RunModal(52039, EmployeeApp); //
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Employee.Get(Rec."Employee No") then //IF Employee.Position<>'' THEN
            if EmpNav.Get(Rec."Employee No") then if Jobs.Get(EmpNav.Position) then;
    end;

    trigger OnInit()
    begin
        Rec."HOD Created" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."HOD Created" := true;
    end;

    trigger OnOpenPage()
    begin
        //SETRANGE("Appraisee ID",USERID);
    end;

    var
        Text19018837: Label 'Performance Plan';
        Text19036363: Label 'NB: Set five objectives maximum';
        Employee: Record Employee;
        EmpNav: Record "Employee Master";
        Jobs: Record "Company Jobs";
        EmployeeApp: Record "Employee Appraisals";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
}
