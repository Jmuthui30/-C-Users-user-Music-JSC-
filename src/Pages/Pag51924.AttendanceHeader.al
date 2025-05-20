page 51924 "Attendance Header"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Attendance Worksheet Header";
    SourceTableView = WHERE(Posted=CONST(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Working Date"; Rec."Working Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. Lines"; Rec."No. Lines")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Lines; "Attendance Lines")
            {
                ApplicationArea = All;
                Caption = 'Lines';
                SubPageLink = "Document No."=FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control11; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control12; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Control13; Links)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = Suite;
                Caption = 'Post';
                Image = PostedTimeSheet;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                ToolTip = 'Post Attendance Sheet';
                Visible = true;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    Rec.TestField(Posted, false);
                    AttendanceWorksheetLines.Reset;
                    AttendanceWorksheetLines.SetRange("Document No.", Rec."No.");
                    if AttendanceWorksheetLines.FindSet then repeat begin
                            AttendanceWorksheetLines.TestField("No.");
                            if AttendanceWorksheetLines."Posting Type" = AttendanceWorksheetLines."Posting Type"::Overtime then AttendanceWorksheetLines.TestField(Hours);
                        end;
                        until AttendanceWorksheetLines.Next = 0;
                    AttendanceManagement."Post Internal Employee Routines"(Rec);
                end;
            }
            separator(Separator19)
            {
            }
            group(Holidays)
            {
                action(Holiday)
                {
                    ApplicationArea = Suite;
                    Caption = 'Holiday';
                    Image = Holiday;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    ToolTip = 'Holiday';
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        PostExEmployeesHoliday.RunModal;
                        Clear(PostExEmployeesHoliday);
                    end;
                }
            }
            separator(Separator20)
            {
            }
            group("External Employees Leave")
            {
                action(Leave)
                {
                    ApplicationArea = Suite;
                    Caption = 'Leave';
                    Image = Post;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    ToolTip = 'Holiday';
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        PostExternalEmployeesLeaves.RunModal;
                        Clear(PostExternalEmployeesLeaves);
                    end;
                }
            }
            separator(Separator22)
            {
            }
            group("Special Days")
            {
                action("Post Special Days")
                {
                    ApplicationArea = Suite;
                    Caption = 'Relief & Sundays';
                    Image = DateRange;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    ToolTip = 'Special Days Relief & Sundays';
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        PostingSpecialDays.RunModal;
                        Clear(PostingSpecialDays);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Rec."Posting Date" <> Today then Rec.Posted:=true;
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange("Raised By", UserId);
    end;
    var Admins: Record Admins;
    AttendanceManagement: Codeunit "Attendance - Management";
    AttendanceWorksheetLines: Record "Attendance Worksheet Lines";
    PostExEmployeesHoliday: Report "Post Ex Employees Holiday";
    PostExternalEmployeesLeaves: Report "Post External Employees Leaves";
    PostingSpecialDays: Report "Posting Special Days";
}
