page 52082 "Vendor Reg Request"
{
    PageType = Card;
    SourceTable = "Vendor Reg. Request";
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(Content)
        {
            group("A: GENERAL INFORMATION")
            {
                //Editable = Rec.Status = Rec.Status::Open;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit then CurrPage.Update;
                    end;
                }
                field("Vendor Reg Type"; Rec."Vendor Reg Type")
                {
                    ApplicationArea = All;
                }
                field(Ownership; Rec.Ownership)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                    //Importance = Additional;
                    ShowMandatory = true;
                }
                field("Registration No."; Rec."Registration No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                // field("Tax Id Number";Rec."Tax Id Number")
                // {
                //     ApplicationArea = All;
                // }
                // field("Cert. Of Incorporation No"; Rec."Cert. Of Incorporation No")
                // {
                //     ApplicationArea = All;
                // }
                // field("VAT Reg No"; Rec."VAT Reg No")
                // {
                //     ApplicationArea = All;
                // }
                // field("Company Date Reg Date"; Rec."Company Date Reg Date")
                // {
                //     ApplicationArea = All;
                // }
                // field(Date; Rec.Date)
                // {
                //     ApplicationArea = All;
                // }
                // field("Created By"; Rec."Created By")
                // {
                //     ApplicationArea = All;
                // }
                // field("Pending Approvals Ext"; Rec."Pending Approvals Ext")
                // {
                //     ApplicationArea = All;
                //     trigger OnAssistEdit()
                //     var
                //         Entries: Record "Approval Entry";
                //     begin
                //         Entries.Reset();
                //         Entries.SetRange("Table ID", 51883);
                //         Entries.SetRange("Document No.", Rec."No.");
                //         Entries.SetFilter(Status, '%1|%2', Entries.Status::Open, Entries.Status::Created);
                //         Page.RunModal(Page::"Custom Approval Entries", Entries);
                //     end;
                // }
                // field(Approvers; Rec.Approvers)
                // {
                //     Editable = false;
                //     ApplicationArea = All;
                //     trigger OnAssistEdit()
                //     var
                //         Entries: Record "Approval Entry";
                //     begin
                //         Entries.Reset();
                //         Entries.SetRange("Table ID", 51883);
                //         Entries.SetRange("Document No.", Rec."No.");
                //         Entries.SetFilter(Status, '=%1', Entries.Status::Approved);
                //         Page.RunModal(Page::"Custom Approval Entries", Entries);
                //     end;
                //}
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Vendor Created"; Rec."Vendor Created")
                {
                    ApplicationArea = All;
                }
            }
            group("B: ADDRESS")
            {
                //Editable = Rec.Status = Rec.Status::Open;
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Country Name"; Rec."Country Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Street; Rec.Street)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Postal Code"; Rec."Postal Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("P.O Box"; Rec."P.O Box")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Telephone; Rec.Telephone)
                {
                    ApplicationArea = All;
                }
                field(Fax; Rec.Fax)
                {
                    ApplicationArea = All;
                }
                field("Company Email"; Rec."Company Email")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Company Phone"; Rec."Company Phone")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Alternative Company Phone"; Rec."Alternative Company Phone")
                {
                    ApplicationArea = All;
                }
            }
            group("C: CONTACT PERSON")
            {
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Firstname; Rec.Firstname)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("National ID No."; Rec."National ID No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Personal KRA PIN"; Rec."Personal KRA PIN")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Primary Phone"; Rec."Primary Phone")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ExtendedDatatype = EMail;
                }
            }
            group("D: PRODUCTS")
            {
                part(Product; "Vendor Products")
                {
                    ApplicationArea = All;
                    SubPageLink = "Vendor No."=field("No.");
                }
            }
            group("E: DIRECTORS")
            {
                part(Directors; "Company Directors")
                {
                    ApplicationArea = All;
                    SubPageLink = "Vendor No."=field("No.");
                }
            }
            group("F: CERTIFICATES")
            {
                part(Certificates; Certificates)
                {
                    ApplicationArea = All;
                    SubPageLink = "Vendor No."=field("No.");
                }
            }
            group("G: OTHER ATTACHMENTS")
            {
                field("Certificate of Incorporation"; Rec."Certificate of Incorporation")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = url;
                    Enabled = false;
                }
                field("KRA PIN Certificate"; Rec."KRA PIN Certificate")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = url;
                    Enabled = false;
                }
                field(CR12; Rec.CR12)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = url;
                    Enabled = false;
                }
                field(AGPO; Rec.AGPO)
                {
                    ApplicationArea = All;
                    ExtendedDatatype = url;
                    Enabled = false;
                }
                field("Other Attachments"; Rec."Other Attachments")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = url;
                    Enabled = false;
                }
            }
            group("H: BANK ACCOUNT")
            {
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Bank Branch Code"; Rec."Bank Branch Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Bank Swift Code"; Rec."Bank Swift Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = false;
                }
            }
            group("I: NOTES")
            {
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "Vendor Reg Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51883);
            }
            systempart(Control13; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                RunObject = Page "Vendor Reg Documents";
                RunPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51883);
            }
            group("Approval Details")
            {
                Visible = NOT OpenApprovalEntriesExistForCurrUser;
                Caption = 'Approvals';

                action(Approvals)
                {
                    //AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category7;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        ApprovalsMgt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgt.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Vendor Reg. Request", 0, Rec."No.");
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Visible = NOT OpenApprovalEntriesExistForCurrUser;

                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        if Rec."Vendor Reg Type" = Rec."Vendor Reg Type"::" " then Error('Vendor registration type can not be emptied, please select among the list.');
                        if Rec."Vendor Reg Type" = Rec."Vendor Reg Type"::"Local Vendor (Limited)" then begin
                            Rec.TestField("Company Name");
                            // Rec.TestField("Tax Id Number");
                            Rec.TestField("Registration No.");
                            // Rec.TestField("Reg. Office Address");
                            // Rec.TestField(State);
                            Rec.TestField(Country);
                            Rec.TestField(Telephone);
                            Rec.TestField("Bank Name");
                            Rec.TestField("Bank Account No.");
                        // Rec.TestField("Bank Sort Code");
                        end
                        else if Rec."Vendor Reg Type" = Rec."Vendor Reg Type"::"Local Vendor (Non-Limited)" then begin
                                Rec.TestField("Company Name");
                                // Rec.TestField("Reg. Office Address");
                                // Rec.TestField(State);
                                Rec.TestField(Country);
                                Rec.TestField(Telephone);
                                Rec.TestField("Bank Name");
                                Rec.TestField("Bank Account No.");
                            // Rec.TestField("Bank Sort Code");
                            end
                            else if Rec."Vendor Reg Type" = Rec."Vendor Reg Type"::"International Vendor" then begin
                                    Rec.TestField("Company Name");
                                    // Rec.TestField("Reg. Office Address");
                                    // Rec.TestField(State);
                                    Rec.TestField(Country);
                                    Rec.TestField(Telephone);
                                    Rec.TestField("Bank Name");
                                    // Rec.TestField("Bank Address");
                                    Rec.TestField("Bank Account No.");
                                end;
                        ApprovalsMgt.OnSendVendorRegForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        ApprovalsMgt.OnCancelVendorRegApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
            group("Manual Approval")
            {
                Caption = 'Release';
                Visible = NOT OpenApprovalEntriesExistForCurrUser;

                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseVendorReg: Codeunit "Release Vendor Reg. Request";
                    begin
                        Rec.TestField("Vendor Created", false);
                        ReleaseVendorReg.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ReleaseVendorReg: Codeunit "Release Vendor Reg. Request";
                    begin
                        Rec.TestField("Vendor Created", false);
                        ReleaseVendorReg.PerformManualReopen(Rec);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';

                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status:=Rec.Status::Open;
    end;
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.UPDATE;
    end;
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord:=ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
    var ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
    vendor: Record Vendor;
}
