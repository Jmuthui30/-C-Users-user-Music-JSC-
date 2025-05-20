page 51925 "Attendance Lines"
{
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Attendance Worksheet Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Posting Type"; Rec."Posting Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Posting Type" = Rec."Posting Type"::Overtime then editable:=true
                        else
                            editable:=false;
                        if Rec."Posting Type" = Rec."Posting Type"::Absent then h_editable:=false
                        else
                            h_editable:=true;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Normal Overtime"; Rec."Normal Overtime")
                {
                    ApplicationArea = All;
                    Enabled = Seditable;

                    trigger OnValidate()
                    begin
                        if Rec."Special Overtime" = true then Error('You Cant Select two Overtime Types');
                    end;
                }
                field("Special Overtime"; Rec."Special Overtime")
                {
                    ApplicationArea = All;
                    Enabled = Seditable;

                    trigger OnValidate()
                    begin
                        if Rec."Normal Overtime" = true then Error('You Cant Select two Overtime Types');
                    end;
                }
                field(Hours; Rec.Hours)
                {
                    ApplicationArea = All;
                    Enabled = h_editable;

                    trigger OnValidate()
                    begin
                        if Rec."Posting Type" = Rec."Posting Type"::Overtime then begin
                            if(Rec."Normal Overtime" = false) and (Rec."Special Overtime" = false)then Error('Choose Overtime Type');
                        end;
                    end;
                }
                field("Working Date"; Rec."Working Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(Functions)
            {
                action("Post Holiday")
                {
                    ApplicationArea = Suite;
                    Caption = 'Post Holiday';
                    Image = Holiday;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    ToolTip = 'Post Holiday';
                    Visible = true;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                    //ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
            }
        }
    }
    var Seditable: Boolean;
    h_editable: Boolean;
}
