page 51658 "SS Orientation Header-Open"
{
    // version THL- HRM 1.0
    Caption = 'New Orientation Checklist';
    PageType = Card;
    SourceTable = "Staff Orientation Header";
    SourceTableView = WHERE(Status=CONST(Open), "Hr Created"=CONST(false));

    layout
    {
        area(content)
        {
            group("Staff Information")
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Lookup = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field(Manager; Rec.Manager)
                {
                    ApplicationArea = All;
                }
                field("Manager's Name"; Rec."Manager's Name")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
            }
            part(Control16; "Orientation Checklist Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No"=FIELD("Employee No");
            }
        }
        area(factboxes)
        {
            systempart(Control15; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Fetch Checklist")
            {
                ApplicationArea = All;
                Image = Suggest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Window.Open(Text00, Names);
                    CheckList.Reset;
                    if CheckList.Find('-')then begin
                        repeat Details.Init;
                            Details."Employee No":=Rec."Employee No";
                            Details.Item:=CheckList.Item;
                            Details.Description:=CheckList.Description;
                            Details.Timeline:=CheckList.Timeline;
                            if not Details2.Get(Rec."Employee No", CheckList.Item)then Details.Insert
                            else
                            begin
                                Details2.Description:=CheckList.Description;
                                Details2.Timeline:=CheckList.Timeline;
                                Details2.Modify;
                            end;
                            Window.Update(1, CheckList.Item);
                        until CheckList.Next = 0;
                        Window.Close;
                    end;
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMgt.OnSendOrientationForApproval(Rec);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec."Hr Created":=false;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Hr Created":=false;
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange(Rec."Created By", UserId);
    end;
    var CheckList: Record "Orientation Checklist Setup";
    Details: Record "Staff Orientation Checklist";
    Details2: Record "Staff Orientation Checklist";
    Window: Dialog;
    Text00: Label 'Fetching Checkist items #####1';
    Names: Text;
    ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    Seditable: Boolean;
}
