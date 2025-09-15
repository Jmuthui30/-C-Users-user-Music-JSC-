page 51034 "Payment Voucher card"
{
    ApplicationArea = All;
    Caption = 'Payment Voucher';
    DeleteAllowed = false;
    Editable = true;
    PageType = Card;
    SourceTable = Payments;
    SourceTableView = where("Payment Type" = const("Payment Voucher"));
    UsageCategory = None;
    layout
    {
        area(Content)
        {
            group("Payment Voucher")
            {
                Caption = 'Payment Voucher';
                field("No."; Rec."No.")
                {
                    Caption = 'No.';
                    ToolTip = 'Specifies the value of the No. field';
                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field(Date; Rec.Date)
                {
                    Caption = 'Date';
                    ToolTip = 'Specifies the value of the Date field';
                }
                field("Time Inserted"; Rec."Time Inserted")
                {
                    Caption = 'Time';
                    ToolTip = 'Specifies the value of the Time field';
                }
                group(Control54)
                {
                    Caption = 'Dimensions';
                    Editable = not OpenApprovalEntriesExist;

                    field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                    {
                        Caption = 'Shortcut Dimension 1 Code';
                        Editable = true;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                    }
                    field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                    {
                        Caption = 'Shortcut Dimension 2 Code';
                        Editable = true;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                    }
                    field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                    {
                        Caption = 'Shortcut Dimension 3 Code';
                        ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field';
                        Visible = false;
                    }
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    Caption = 'Pay Mode';
                    Editable = not DocPosted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Pay Mode field';
                    trigger OnValidate()
                    begin
                        SetControlAppearance();
                    end;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    Caption = 'Paying Bank Account';
                    Editable = not OpenApprovalEntriesExist;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Paying Bank Account field';
                }
                field("Payment Release Date"; Rec."Payment Release Date")
                {
                    Caption = 'Posting Date';
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    Caption = 'Responsibility Center';
                    ToolTip = 'Specifies the value of the Responsibility Center field';
                    Visible = false;
                }
                group(Control66)
                {
                    ShowCaption = false;
                    Visible = ChequePayment;

                    field("Cheque Type"; Rec."Cheque Type")
                    {
                        Caption = 'Cheque Type';
                        Editable = ChequePayment and not DocPosted and not OpenApprovalEntriesExist;
                        ToolTip = 'Specifies the value of the Cheque Type field';
                    }
                    field("Cheque No"; Rec."Cheque No")
                    {
                        Caption = 'Cheque No';
                        Editable = ChequePayment and not DocPosted;
                        ToolTip = 'Specifies the value of the Cheque No field';
                    }
                    field("Cheque Date"; Rec."Cheque Date")
                    {
                        Caption = 'Cheque Date';
                        Editable = ChequePayment and not DocPosted;
                        ToolTip = 'Specifies the value of the Cheque Date field';
                    }
                }
                field(Payee; Rec.Payee)
                {
                    Caption = 'Payee';
                    Editable = not OpenApprovalEntriesExist;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Payee field';
                }
                group(Control64)
                {
                    ShowCaption = false;
                    Visible = ChequePayment;

                    field("Check Printed"; Rec."Check Printed")
                    {
                        Caption = 'Check Printed';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Check Printed field';
                        Visible = ChequePayment;
                    }
                }
                field("On behalf of"; Rec."On behalf of")
                {
                    Caption = 'On behalf of';
                    Editable = not OpenApprovalEntriesExist;
                    ToolTip = 'Specifies the value of the On behalf of field';
                }
                field("Payment Narration"; Rec."Payment Narration")
                {
                    Caption = 'Payment Narration';
                    Editable = not OpenApprovalEntriesExist;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the value of the Payment Narration field';
                }
                field("Payee PIN"; Rec."Payee PIN")
                {
                    Caption = 'Payee PIN';
                    ToolTip = 'Specifies the value of the Payee PIN field';
                    Visible = false;
                }
                field(Currency; Rec.Currency)
                {
                    Caption = 'Currency';
                    ToolTip = 'Specifies the value of the Currency field';
                }
                field("Created By"; Rec."Created By")
                {
                    Caption = 'Created By';
                    ToolTip = 'Specifies the value of the Created By field';
                }
                field(Status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Fixed Asset"; Rec."Fixed Asset Payment Voucher")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Status field';
                    Visible = false;
                }
                field("Fixed Asset No"; Rec."Fixed Asset No")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Status field';
                    Visible = false;

                }
                group(PostedDetails)
                {
                    Visible = Rec.Posted;
                    field(Posted; Rec.Posted)
                    {
                        Caption = 'Posted';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Posted field';
                    }
                    field("Posted By"; Rec."Posted By")
                    {
                        Caption = 'Posted By';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Posted By field';
                    }
                    field("Posted Date"; Rec."Posted Date")
                    {
                        Caption = 'Posted Date';
                        Editable = false;
                        ToolTip = 'Specifies the value of the Posted Date field';
                    }
                }
                group("RTGS Details")
                {
                    Caption = 'RTGS Details';
                    Editable = not DocPosted;
                    Visible = RTGSPayment;

                    field("RTGS Date"; Rec."RTGS Date")
                    {
                        Caption = 'RTGS Date';
                        ToolTip = 'Specifies the value of the RTGS Date field';
                    }
                }
                group("EFT Details")
                {
                    Caption = 'EFT Details';
                    Editable = not DocPosted;
                    Visible = EFTPayment;

                    field("EFT Reference"; Rec."EFT Reference")
                    {
                        Caption = 'EFT Reference';
                        ToolTip = 'Specifies the value of the EFT Reference field';
                    }
                    field("EFT File Generated"; Rec."EFT File Generated")
                    {
                        Caption = 'EFT File Generated';
                        Editable = false;
                        ToolTip = 'Specifies the value of the EFT File Generated field';
                    }
                    field("EFT Date"; Rec."EFT Date")
                    {
                        Caption = 'EFT Date';
                        ToolTip = 'Specifies the value of the EFT Date field';
                    }
                }
                group("Apportion?")
                {
                    Caption = 'Apportion?';
                    Visible = false;

                    field("No Apportion"; Rec."No Apportion")
                    {
                        Caption = 'No';
                        ToolTip = 'Specifies the value of the No field';
                    }
                    field(Apportion; Rec.Apportion)
                    {
                        Caption = 'Yes';
                        ToolTip = 'Specifies the value of the Yes field';
                    }
                }
                group(Summary)
                {
                    Caption = 'Summary';
                    field("Total Amount"; Rec."Total Amount")
                    {
                        Caption = 'Total Amount';
                        ToolTip = 'Specifies the value of the Total Amount field';
                    }
                    field("Total Amount (LCY)"; Rec."Total Amount (LCY)")
                    {
                        Caption = 'Total Amount (LCY)';
                        ToolTip = 'Specifies the value of the Total Amount (LCY) field.';
                    }
                    field("Total VAT Amount"; Rec."Total VAT Amount")
                    {
                        Caption = 'Total VAT Amount';
                        ToolTip = 'Specifies the value of the Total VAT Amount field';
                    }
                    field("Total Witholding Tax Amount"; Rec."Total Witholding Tax Amount")
                    {
                        Caption = 'Total Witholding Tax Amount';
                        ToolTip = 'Specifies the value of the Total Witholding Tax Amount field';
                    }
                    field("Total Witholding VAT Tax"; Rec."Total Witholding VAT Tax")
                    {
                        Caption = 'Total Witholding VAT Tax';
                        ToolTip = 'Specifies the value of the Total Witholding VAT Tax field';
                    }
                    field("Total Retention Amount"; Rec."Total Retention Amount")
                    {
                        Caption = 'Total Retention Amount';
                        ToolTip = 'Specifies the value of the Total Retention Amount field';
                    }
                    field("Total Net Amount"; Rec."Total Net Amount")
                    {
                        Caption = 'Total Net Amount';
                        ToolTip = 'Specifies the value of the Total Net Amount field';
                    }
                    field("Total Payment Amount LCY"; Rec."Total Payment Amount LCY")
                    {
                        Caption = 'Total Net Amount (LCY)';
                        ToolTip = 'Specifies the value of the Total Payment Amount LCY field';
                    }
                }
            }
            part(Control26; "PV Subform")
            {
                Caption = 'PV Subform';
                SubPageLink = No = field("No.");
                UpdatePropagation = Both;
            }
            part(Control78; "Apportionment Allocation Lines")
            {
                Caption = 'Apportionment Allocation Lines';
                SubPageLink = "Document No." = field("No.");
                Visible = Rec.Apportion;
            }
        }
        area(FactBoxes)
        {
            part("Payment Amounts"; "Payment Amounts Factbox")
            {
                Caption = 'Payment Amounts';
                SubPageLink = "No." = field("No.");
            }
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::Payments),
                              "No." = field("No.");
            }
            part(CommentsFactBox; "Approval Comments FactBox")
            {
                ApplicationArea = Suite;
                Caption = 'Approval Comments FactBox';
                SubPageLink = "Document No." = field("No.");
                Visible = ShowCommentFactbox;
            }
            systempart(Control21; Notes)
            {
            }
            systempart(Control20; MyNotes)
            {
            }
            systempart(Attachments; Links)
            {
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group(Action38)
            {
                Caption = 'Payment Voucher';
                Image = "Order";

                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = page "Comment Sheet";
                    ToolTip = 'Executes the Co&mments action';
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortcutKey = 'Shift+Ctrl+D';
                    ToolTip = 'Executes the Dimensions action';

                    trigger OnAction()
                    begin
                        Rec.ShowDocDim();
                        CurrPage.SaveRecord();
                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approval;
                    ToolTip = 'Executes the Approvals action';

                    trigger OnAction()
                    var
                        ApprovalEntry: Record "Approval Entry";
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        ApprovalEntry.Reset();
                        ApprovalEntry.SetCurrentKey("Document No.");
                        ApprovalEntry.SetRange("Table ID", Database::Payments);
                        ApprovalEntry.SetRange("Document No.", Rec."No.");
                        ApprovalEntries.SetTableView(ApprovalEntry);
                        ApprovalEntries.LookupMode(true);
                        ApprovalEntries.RunModal();
                    end;
                }
                action(Navigate)
                {
                    Caption = '&Navigate';
                    Image = Navigate;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the posted purchase document.';
                    Visible = DocPosted;

                    trigger OnAction()
                    begin
                        Rec.Navigate();
                    end;
                }
            }
        }
        area(Processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = not OpenApprovalEntriesExist;
                    Image = SendApprovalRequest;
                    ToolTip = 'Executes the Send A&pproval Request action';

                    trigger OnAction()
                    begin
                        Rec.TestField("Paying Bank Account");
                        /* Rec.TestField("Shortcut Dimension 1 Code");
                        Rec.TestField("Shortcut Dimension 2 Code"); */
                        Rec.TestField(Payee);
                        Rec.TestField("Payment Narration");

                        if PayMethod.Get(Rec."Pay Mode") then
                            case PayMethod."Bal. Account Type" of
                                PayMethod."Bal. Account Type"::Cheque:
                                    begin
                                        Rec.TestField("Cheque No");
                                        Rec.TestField("Cheque Date");
                                    end;
                                PayMethod."Bal. Account Type"::EFT:
                                    begin
                                        Rec.TestField("EFT Date");
                                        Rec.TestField("EFT Reference");
                                    end;
                                PayMethod."Bal. Account Type"::RTGS:

                                    Rec.TestField("RTGS Date");
                            end;

                        /*if "Direct Expense"=true then
                          begin
                            if Confirm('You have indicated that %1 is a direct expense hence will be committed. Continue?',false,"No.")=true then
                              begin
                                Committment.CheckPVCommittment(Rec);
                                Committment.PVCommittment(Rec,ErrorMsg);
                                if ErrorMsg<>'' then
                                  Error(ErrorMsg);
                              end else
                                exit;
                          end;*/

                        PLines.Reset();
                        PLines.SetRange(No, Rec."No.");
                        if PLines.FindSet() then
                            repeat
                                if PLines."Account No" = '' then
                                    Error('Account No. Field is Blank. Please Fill the Line No. %1 with amount %2.', PLines."Line No", PLines.Amount);

                                PLines.TestField(Description);
                                if StrLen(PLines.Description + '-' + Rec.Payee) > 100 then
                                    Error('The Posting Description: \%1 for Line %2 is %3 characters long. \Please shorten it to 100 characters to prevent posting errors', (PLines.Description + '-' + Rec.Payee), PLines."Line No", StrLen(PLines.Description + '-' + Rec.Payee));
                            until PLines.Next() = 0;

                        /*  if Rec.Apportion then
                             Apportionment.CheckApportionment(Rec."No.");

                         Committment.CheckPVCommittment(Rec);
                         Committment.PVCommittment(Rec, ErrorMsg);
                         if ErrorMsg <> '' then
                             Error(ErrorMsg); */

                        if ApprovalsMgmt.CheckPaymentsApprovalsWorkflowEnabled(Rec) then
                            ApprovalsMgmt.OnSendPaymentsForApproval(Rec);

                        //Check HOD approver
                        // IF UserSetup.GET(USERID) THEN
                        //  BEGIN
                        //    IF UserSetup."HOD User" THEN
                        //      BEGIN
                        //        ApprovalEntry.RESET;
                        //        ApprovalEntry.SETRANGE("Table ID",Database::"Payments");
                        //        ApprovalEntry.SETRANGE("Document No.","No.");
                        //        ModifyHODApprovals.SETTABLEVIEW(ApprovalEntry);
                        //        ModifyHODApprovals.RUNMODAL;
                        //      END;
                        //  END;

                        CurrPage.Close();
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForPayment and not DocPosted;
                    Image = Cancel;
                    ToolTip = 'Executes the Cancel Approval Re&quest action';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to cancel the approval request? Please note this will uncommit previous committments regarding %1', false, Rec."No.") = true then begin
                            //Committment.ReversePVCommittment(Rec);
                            ApprovalsMgmt.OnCancelPaymentsApprovalRequest(Rec);
                            Committment.CancelPaymentsCommitments(Rec);
                        end;

                        CurrPage.Close();
                    end;
                }
                separator(Action30)
                {
                }
            }
            group(Print)
            {
                Caption = 'Print';
                Image = Print;

                action("&Print")
                {
                    Caption = '&Print';
                    Ellipsis = true;
                    Image = Print;
                    ToolTip = 'Executes the &Print action';

                    trigger OnAction()
                    begin
                        PaymentRec.Reset();
                        PaymentRec.SetRange(PaymentRec."No.", Rec."No.");
                        if PaymentRec.FindFirst() then begin
                            PLines.Reset();
                            PLines.SetRange(No, PaymentRec."No.");
                            if PLines.FindFirst() then
                                if PLines."Account Type" <> PLines."Account Type"::Vendor then
                                    Report.Run(Report::"Payment Voucher", true, false, PaymentRec)
                                else
                                    Report.Run(Report::"Payment Voucher-Vendor", true, false, PaymentRec);
                        end;
                    end;
                }
                action(PaymentAdvice)
                {
                    Caption = 'Payment Advice';
                    Image = PrintAcknowledgement;
                    ToolTip = 'Executes the Payment Advice report';

                    trigger OnAction()
                    begin
                        PaymentRec.Reset();
                        PaymentRec.SetRange(PaymentRec."No.", Rec."No.");
                        if PaymentRec.FindFirst() then
                            Report.Run(Report::"Payment Advice", true, false, PaymentRec);
                    end;
                }
            }
            group("P&osting")
            {
                Caption = 'P&osting';
                Image = Post;

                action(Post)
                {
                    Caption = 'P&ost';
                    Image = PostOrder;
                    ShortcutKey = 'F9';
                    ToolTip = 'Executes the P&ost action';
                    Visible = DocReleased and not DocPosted;

                    trigger OnAction()
                    var
                        GenJnlLine: Record "Gen. Journal Line";
                        LineNo: Integer;
                        JTemplate: Code[20];
                        JBatch: Code[20];
                        strFilter: Text[250];
                        IntC: Integer;
                        IntCount: Integer;
                    // Payments: Record Payments;
                    begin
                        //Post PV Entries
                        CurrPage.SAVERECORD;
                        CheckPVRequiredItems;
                        //post pv
                        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                        GenJnlLine.RESET;
                        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
                        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
                        IF GenJnlLine.FIND('+') THEN BEGIN
                            LineNo := GenJnlLine."Line No." + 1000;
                        END
                        ELSE BEGIN
                            LineNo := 1000;
                        END;
                        GenJnlLine.DELETEALL;
                        GenJnlLine.RESET;

                        Payments.RESET;
                        Payments.SETRANGE(Payments."No.", Rec."No.");
                        IF Payments.FIND('-') THEN BEGIN
                            PayLine.RESET;
                            PayLine.SETRANGE(PayLine.No, Payments."No.");
                            IF PayLine.FIND('-') THEN BEGIN
                                REPEAT
                                    PostHeader(Payments);

                                UNTIL PayLine.NEXT = 0;
                            END;

                            post := FALSE;
                            // Post := JournlPosted.PostedSuccessfully();
                            //IF Post THEN  BEGIN

                            Rec.Posted := TRUE;
                            Rec.Status := Payments.Status::Archived;
                            Rec."Posted By" := USERID;
                            // Rec."Date Posted" := TODAY;
                            Rec."Time Posted" := TIME;
                            Rec.Modify()

                            //Post Reversal Entries for Commitments
                            // Doc_Type:=Doc_Type::"Payment Voucher";
                            //CheckBudgetAvail.ReverseEntries(Doc_Type,"No.");
                            // END;
                        END;

                        COMMIT;

                        CurrPage.CLOSE;

                        // //Uncommented the code
                        // PaymentsPost."Post Payment Voucher"(Rec, false);
                        // CurrPage.Close();
                    end;
                }
                action(PreviewPosting)
                {
                    Caption = 'Preview Posting';
                    Image = PreviewChecks;
                    ToolTip = 'Executes the Preview Posting action';
                    Visible = not DocPosted;

                    trigger OnAction()
                    begin
                        PaymentsPost."Post Payment Voucher"(Rec, true);
                    end;
                }
                action(GenerateEFT)
                {
                    Caption = 'Generate EFT File';
                    //Enabled = EFTpayment;
                    Enabled = true;
                    Image = ExportToExcel;
                    ToolTip = 'Executes the Generate EFT File action';
                    //Visible = not DocPosted;
                    Visible = true;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to generate an EFT file for PV %1', false, Rec."No.") = true then begin
                            if PayMethod.Get(Rec."Pay Mode") then begin
                                if PayMethod."Bal. Account Type" <> PayMethod."Bal. Account Type"::EFT then
                                    Error('Payment mode must be EFT');
                            end else
                                Error('Pay mode %1 has not been set up', Rec."Pay Mode");
                            PaymentsPost.GenerateEFT(Rec);
                        end;
                    end;
                }
                action(PrintCheck)
                {
                    Caption = 'Print Cheque';
                    Image = PrintCheck;
                    ToolTip = 'Executes the Print Cheque action';
                    //Visible = not DocPosted;
                    Visible = true;

                    trigger OnAction()
                    begin
                        if PayMethod.Get(Rec."Pay Mode") then
                            if PayMethod."Bal. Account Type" <> PayMethod."Bal. Account Type"::Cheque then
                                Error('Payment mode must be Cheque');

                        Rec.TestField("Check Printed", false);
                        Rec.TestField("Cheque No");
                        Rec.TestField("Cheque Date");

                        PaymentRec.Reset();
                        PaymentRec.SetRange("No.", Rec."No.");
                        if PaymentRec.FindFirst() then
                            Report.Run(Report::"PV Check", true, false, PaymentRec);
                    end;
                }
                action(ImportPayments)
                {
                    Caption = 'Import Bulk Payments';
                    Image = Import;
                    ToolTip = 'Executes the Import Bulk Payments action';
                    Visible = not DocPosted;

                    trigger OnAction()
                    begin
                        Clear(ImportPVLines);
                        ImportPVLines.GetHeaderNo(Rec);
                        ImportPVLines.Run();
                    end;
                }
                action(Archive)
                {
                    Caption = 'Archive';
                    Image = Archive;
                    ToolTip = 'Executes the Archive action';
                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to archive this document?', false) = true then begin
                            Committment.UncommitPV(Rec);
                            Rec.Status := Rec.Status::Archived;
                            Rec.Modify();
                        end;
                    end;
                }
                action(SendPaymentAdviceViaMail)
                {
                    Caption = 'Send Payment Advice via Mail';
                    Enabled = not Rec."Payment Advice Sent";
                    Image = SendMail;
                    ToolTip = 'Executes the Send Payment Advice via Mail action';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to send the payment advice via mail?', false) then
                            PaymentsPost.SendPaymentAdviceViaMail(Rec);
                    end;
                }
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref(Post_Promoted; Post)
                {
                }
                actionref(PreviewPosting_Promoted; PreviewPosting)
                {
                }
                actionref(Archive_Promoted; Archive)
                {
                }
                actionref(SendPaymentAdviceViaMail_Promoted; SendPaymentAdviceViaMail)
                {
                }
            }
            group(Category_Report)
            {
                Caption = 'Report', Comment = 'Generated from the PromotedActionCategories property index 2.';
                actionref("&Print_Promoted"; "&Print")
                {
                }
                actionref(PaymentAdvice_Promoted; PaymentAdvice)
                {
                }
            }
            group(Category_Category4)
            {
                Caption = 'Documents', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(GenerateEFT_Promoted; GenerateEFT)
                {
                }
                actionref(PrintCheck_Promoted; PrintCheck)
                {
                }
                actionref(ImportPayments_Promoted; ImportPayments)
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Navigate';
                actionref(Navigate_Promoted; Navigate)
                {
                }
            }
            group(Category_Category6)
            {
                Caption = 'Approvals';
                actionref(SendApprovalRequest_Promoted; SendApprovalRequest)
                {
                }
                actionref(CancelApprovalRequest_Promoted; CancelApprovalRequest)
                {
                }
                actionref(Approvals_Promoted; Approvals)
                {
                }
            }
        }
    }

    var
        ApprovalEntry: Record "Approval Entry";
        PLines: Record "Payment Lines";
        PayMethod: Record "Payment Method";
        PaymentRec: Record Payments;
        ApprovalsMgmt: Codeunit "Approval Mgt Finance Ext";
        Committment: Codeunit "Commitments Mgt Finance";
        PaymentsPost: Codeunit "Payments Management";
        ImportPVLines: XmlPort "Import PV Lines";
        CanCancelApprovalForPayment: Boolean;
        ChequePayment: Boolean;
        DocPosted: Boolean;
        DocReleased: Boolean;
        EFTPayment: Boolean;
        OpenApprovalEntriesExist: Boolean;
        RTGSPayment: Boolean;
        ShowCommentFactbox: Boolean;
        PayLine: Record "Payment Lines";

        strFilter: Text[250];
        IntC: Integer;
        IntCount: Integer;
        Payments: Record Payments;
        TarriffCodes: Record "VAT Product Posting Group";
        GenJnlLine: Record "Gen. Journal Line";
        //CashierLinks: Record "Cashier Link";
        LineNo: Integer;
        Temp: Record "Cash Office User Template";
        JTemplate: Code[10];
        JBatch: Code[10];
        // PCheck: Codeunit " Posting Check FP";
        Post: Boolean;
        strText: Text[100];
        PVHead: Record Payments;
        BankAcc: Record "Bank Account";
        CheckBudgetAvail: Codeunit "Budget Depreciation";
        Commitments: Record "Comment Line";



        DocPrint: Codeunit "Document-Print";
        CheckLedger: Record "Check Ledger Entry";
        CheckManagement: Codeunit CheckManagement;
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        AdjustGenJnl: Codeunit "Adjust Gen. Journal Balance";
        OnBehalfEditable: Boolean;

        GlobalDimension1CodeEditable: Boolean;

        NarrationEditable: Boolean;
        PayeeEditable: Boolean;
        DateEditable: Boolean;
        PVLinesEditable: Boolean;
        ShortcutDimension2CodeEditable: Boolean;
        ShortcutDimension3CodeEditable: Boolean;
        ShortcutDimension4CodeEditable: Boolean;
        PaymentModeEditable: Boolean;
        BCSetup: Record "Budgetary Control Setup";
        //GeneralSet:	Record	"Sacco General Set-Up"	;
        PHeader2: Record Payments;
        Table_id: Integer;

        isfixedassetpv: Boolean;
        Text001: label 'This Document no %1 has printed Cheque No %2 which will have to be voided first before reposting.';
        Text000: Label 'Do you want to Void Check No %1';
        Text002: Label 'You have selected post and generate a computer cheque ensure that your cheque printer is ready do you want to continue?';

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Payment Voucher";
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Payment Type" := Rec."Payment Type"::"Payment Voucher";
    end;

    trigger OnAfterGetCurrRecord()
    begin
        ApprovalEntry.Reset();
        ApprovalEntry.SetRange("Document No.", Rec."No.");
        if ApprovalEntry.Find('-') then
            ShowCommentFactbox := CurrPage.CommentsFactBox.Page.SetFilterFromApprovalEntry(ApprovalEntry);
    end;

    local procedure SetControlAppearance()
    var
        PaymentMethod: Record "Payment Method";
        ApprovalsMgmts: Codeunit "Approvals Mgmt.";
    begin
        if (Rec.Status = Rec.Status::Released) or (Rec.Status = Rec.Status::Rejected) then
            OpenApprovalEntriesExist := ApprovalsMgmts.HasApprovalEntries(Rec.RecordId)
        else
            OpenApprovalEntriesExist := ApprovalsMgmts.HasOpenApprovalEntries(Rec.RecordId);
        DocPosted := Rec.Posted;
        CanCancelApprovalForPayment := ApprovalsMgmts.CanCancelApprovalForRecord(Rec.RecordId);

        if PaymentMethod.Get(Rec."Pay Mode") then;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
            ChequePayment := true
        else
            ChequePayment := false;
        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::EFT then
            EFTPayment := true
        else
            EFTPayment := false;
        if (Rec.Status = Rec.Status::Released) then
            DocReleased := true
        else
            DocReleased := false;
        // MESSAGE('%1,%2',DocPosted,OpenApprovalEntriesExist);

        if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::RTGS then
            RTGSPayment := true
        else
            RTGSPayment := false;
    end;

    procedure PostHeader(VAR Payment: Record Payments)
    var

    begin
        IF (Payments."Pay Mode" = 'CHEQUE') THEN
            ERROR('Cheque type has to be specified');

        IF Payments."Pay Mode" = 'CHEQUE' THEN BEGIN
            IF (Payments."Cheque No" = '') THEN BEGIN
                ERROR('Please ensure that the cheque number is inserted');
            END;
        END;

        IF Payments."Pay Mode" = 'BANK EFT' THEN BEGIN
            IF Payments."Cheque No" = '' THEN BEGIN
                ERROR('Please ensure that the EFT number is inserted');
            END;
        END;


        GenJnlLine.RESET;
        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);

        IF GenJnlLine.FIND('+') THEN BEGIN
            LineNo := GenJnlLine."Line No." + 1000;
        END
        ELSE BEGIN
            LineNo := 1000;
        END;


        LineNo := LineNo + 1000;
        GenJnlLine.INIT;
        GenJnlLine."Journal Template Name" := JTemplate;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
        GenJnlLine."Journal Batch Name" := JBatch;
        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
        GenJnlLine."Line No." := LineNo;
        GenJnlLine."Source Code" := 'PAYMENTJNL';
        GenJnlLine."Posting Date" := Payment."Payment Release Date";
        IF CustomerPayLinesExist THEN
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
        ELSE
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
        GenJnlLine."Document No." := Payments."No.";
        GenJnlLine."External Document No." := Payments."Cheque No";

        IF Payments."Paying Type" = Payments."Paying Type"::Bank THEN BEGIN
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
            GenJnlLine."Account No." := Payments."Paying Bank Account";
        END ELSE IF Payments."Paying Type" = Payments."Paying Type"::Vendor THEN BEGIN
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
            GenJnlLine."Account No." := Payments."Paying Vendor Account";
        END;
        GenJnlLine.VALIDATE(GenJnlLine."Account No.");

        GenJnlLine."Currency Code" := Payments.Currency;
        GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
        //CurrFactor
        //  GenJnlLine."Currency Factor" := Payments.cu;
        GenJnlLine.VALIDATE("Currency Factor");

        Payments.CALCFIELDS(Payments."Total Net Amount", Payments."Total VAT Amount");
        GenJnlLine.Amount := -(Payments."Total Net Amount" + Payments."Total VAT Amount");
        GenJnlLine.VALIDATE(GenJnlLine.Amount);
        GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
        GenJnlLine."Bal. Account No." := '';

        GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
        // GenJnlLine."Shortcut Dimension 1 Code" := PayLine.;
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
        GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
        //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
        //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");

        GenJnlLine.Description := COPYSTR('Pay To:' + Payments.Payee, 1, 50);
        GenJnlLine.VALIDATE(GenJnlLine.Description);

        IF Payments."Pay Mode" <> 'CHEQUE' THEN BEGIN
            GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" "
        END ELSE BEGIN
            IF Payments."Cheque Type" = Payments."Cheque Type"::"Computer Check" THEN
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::"Computer Check"
            ELSE
                GenJnlLine."Bank Payment Type" := GenJnlLine."Bank Payment Type"::" "

        END;
        IF GenJnlLine.Amount <> 0 THEN
            GenJnlLine.INSERT;


        //ivan
        //KMET NGO capitalize fixed asset
        IF (Payments."Fixed Asset Payment Voucher" = TRUE) THEN BEGIN

            LineNo := LineNo + 1000;
            GenJnlLine.INIT;
            GenJnlLine."Journal Template Name" := JTemplate;
            GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
            GenJnlLine."Journal Batch Name" := JBatch;
            GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Source Code" := 'PAYMENTJNL';
            GenJnlLine."Posting Date" := Payment."Payment Release Date";
            GenJnlLine."Document No." := Payments."No.";
            GenJnlLine."External Document No." := Payments."Cheque No";
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Fixed Asset";
            GenJnlLine."Account No." := Payments."Fixed Asset No";
            GenJnlLine.VALIDATE(GenJnlLine."Account No.");
            Payments.CALCFIELDS(Payments."Total Net Amount", Payments."Total Payment Amount", Payments."Total VAT Amount", "Asset Amount");
            GenJnlLine.Amount := (Payments."Asset Amount");
            GenJnlLine.VALIDATE(GenJnlLine.Amount);
            GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
            GenJnlLine."Bal. Account No." := '4810';
            GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
            //GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
            GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
            GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
            GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
            //GenJnlLine.ValidateShortcutDimCode(3,"Shortcut Dimension 3 Code");
            //GenJnlLine.ValidateShortcutDimCode(4,"Shortcut Dimension 4 Code");
            GenJnlLine.Description := COPYSTR('Pay To:' + Payments.Payee, 1, 50);
            GenJnlLine.VALIDATE(GenJnlLine.Description);
            IF GenJnlLine.Amount <> 0 THEN
                GenJnlLine.INSERT;
        END;

        //*********************************************************

        PostPV(Payments);
    end;

    procedure PostPV(VAR Payment: Record Payments)
    begin

        PayLine.RESET;
        PayLine.SETRANGE(PayLine.No, Payments."No.");
        IF PayLine.FIND('-') THEN BEGIN

            REPEAT
                // strText := GetAppliedEntries(PayLine."Line No.");
                // Payment.TESTFIELD(Payment.Payee);
                // PayLine.TESTFIELD(PayLine.Amount);
                // PayLine.TESTFIELD(PayLine."Global Dimension 1 Code");


                //BANK
                // IF PayLine."Pay Mode" = PayLine."Pay Mode"::Cash THEN BEGIN
                //     CashierLinks.RESET;
                //     CashierLinks.SETRANGE(CashierLinks.UserID, USERID);
                // END;

                //CHEQUE
                LineNo := LineNo + 1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document No." := PayLine.No;

                //Bett
                IF PayLine."Account Type" = PayLine."Account Type"::Customer THEN BEGIN
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                    // GenJnlLine."Transaction Type" := PayLine."Transaction Type";
                    // GenJnlLine."Loan No" := PayLine."Loan No.";
                END ELSE
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;

                IF PayLine."Account Type" = PayLine."Account Type"::Customer THEN
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" "
                ELSE
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."External Document No." := Payments."Cheque No";
                GenJnlLine.Description := COPYSTR(':' + Payment.Payee, 1, 50);
                GenJnlLine."Currency Code" := Payments.Currency;
                GenJnlLine.VALIDATE("Currency Code");
                // GenJnlLine."Currency Factor" := Payments."Currency Factor";
                // GenJnlLine.VALIDATE("Currency Factor");
                IF PayLine."VAT Code" = '' THEN BEGIN
                    GenJnlLine.Amount := PayLine."Net Amount" + PayLine."VAT Amount";
                END
                ELSE BEGIN
                    GenJnlLine.Amount := PayLine."Net Amount" + PayLine."VAT Amount";
                END;
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                // GenJnlLine."VAT Prod. Posting Group" := PayLine."VAT Prod. Posting Group";
                /// GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                // GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                GenJnlLine."Applies-to Doc. No." := PayLine."Applies-to Doc. No.";
                GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                GenJnlLine."Applies-to ID" := PayLine."Applies-to ID";

                IF GenJnlLine.Amount <> 0 THEN GenJnlLine.INSERT;








                //POST W/TAX to Respective W/TAX GL Account
                TarriffCodes.RESET;
                TarriffCodes.SETRANGE(TarriffCodes.Code, PayLine."W/Tax Code");
                IF TarriffCodes.FIND('-') THEN BEGIN
                    TarriffCodes.TESTFIELD(TarriffCodes.Code);
                    LineNo := LineNo + 1000;
                    GenJnlLine.INIT;
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No";
                    //GenJnlLine."Account Type" := TarriffCodes.a;
                    // GenJnlLine."Account No." := TarriffCodes."Account No.";
                    GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                    // GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                    GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                    GenJnlLine."Gen. Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                    GenJnlLine."VAT Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                    GenJnlLine."VAT Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                    GenJnlLine.Amount := -PayLine."W/Tax Amount";
                    GenJnlLine.VALIDATE(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := COPYSTR('W/Tax:' + FORMAT(PayLine."Account Name") + '::' + strText, 1, 50);
                    //GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                    // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                    //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                    //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                    IF GenJnlLine.Amount <> 0 THEN
                        GenJnlLine.INSERT;
                END;

                //POST retention to Respective retention GL Account
                TarriffCodes.RESET;
                TarriffCodes.SETRANGE(TarriffCodes.Code, PayLine."Retention Code");
                IF TarriffCodes.FIND('-') THEN BEGIN
                    //TarriffCodes.TESTFIELD(TarriffCodes."Account No.");
                    LineNo := LineNo + 1000;
                    GenJnlLine.INIT;
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                    GenJnlLine."Document No." := PayLine.No;
                    // GenJnlLine."External Document No." := Payments."Cheque No.";
                    // GenJnlLine."Account Type" := TarriffCodes."Account Type";
                    // GenJnlLine."Account No." := TarriffCodes."Account No.";
                    GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments.Currency;
                    GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                    GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                    GenJnlLine."Gen. Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                    GenJnlLine."VAT Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                    GenJnlLine."VAT Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                    GenJnlLine.Amount := -PayLine."Retention  Amount";
                    GenJnlLine.VALIDATE(GenJnlLine.Amount);
                    //GenJnlLine."Bal. Account Type":=PayLine."Account Type";
                    //GenJnlLine."Bal. Account No.":=PayLine."Account No.";
                    //GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := COPYSTR('Retention:' + FORMAT(PayLine."Account Name") + '::' + strText, 1, 50);
                    // GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                    //GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                    //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                    //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                    IF GenJnlLine.Amount <> 0 THEN
                        GenJnlLine.INSERT;
                END;

                //Retention balancing account
                LineNo := LineNo + 1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                GenJnlLine."Currency Code" := Payments.Currency;
                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine.Amount := PayLine."Retention  Amount";
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                //GenJnlLine."Bal. Account Type":=PayLine."Account Type";
                // GenJnlLine."Bal. Account No.":=PayLine."Account No.";
                // GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                GenJnlLine.Description := COPYSTR('Retention:' + FORMAT(PayLine."Account Name") + '::' + strText, 1, 50);
                // GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                // GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT;
                //END POSTING RETENTION

                //Post W/TAX Balancing Entry Goes to Vendor
                LineNo := LineNo + 1000;
                GenJnlLine.INIT;
                GenJnlLine."Journal Template Name" := JTemplate;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                GenJnlLine."Journal Batch Name" := JBatch;
                GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                GenJnlLine."Source Code" := 'PAYMENTJNL';
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Posting Date" := Payment."Payment Release Date";
                GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                GenJnlLine."Document No." := PayLine.No;
                GenJnlLine."External Document No." := Payments."Cheque No";
                GenJnlLine."Account Type" := PayLine."Account Type";
                GenJnlLine."Account No." := PayLine."Account No";
                GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                //GenJnlLine."Currency Code" := Payments."Currency Code";
                GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                GenJnlLine."Gen. Bus. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                GenJnlLine."Gen. Prod. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                GenJnlLine."VAT Bus. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                GenJnlLine."VAT Prod. Posting Group" := '';
                GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                GenJnlLine.Amount := PayLine."W/Tax Amount";
                GenJnlLine.VALIDATE(GenJnlLine.Amount);
                GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                GenJnlLine."Bal. Account No." := '';
                GenJnlLine.Description := COPYSTR('W/Tax:' + strText, 1, 50);
                GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                //GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                //  GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;
                // GenJnlLine."Applies-to Doc. No." := PayLine."Apply to";
                GenJnlLine.VALIDATE(GenJnlLine."Applies-to Doc. No.");
                // GenJnlLine."Applies-to ID" := PayLine."Apply to ID";
                IF GenJnlLine.Amount <> 0 THEN
                    GenJnlLine.INSERT;



                IF (Payments."Expense Type" = Payments."Expense Type"::Member) THEN BEGIN
                    LineNo := LineNo + 1000;
                    GenJnlLine.INIT;
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                    GenJnlLine."Document No." := PayLine.No;
                    GenJnlLine."External Document No." := Payments."Cheque No";
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                    GenJnlLine."Account No." := PayLine."Account No";
                    GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                    GenJnlLine."Currency Code" := Payments.Currency;
                    GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                    GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                    GenJnlLine."Gen. Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                    GenJnlLine."VAT Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                    GenJnlLine."VAT Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                    GenJnlLine.Amount := 200;
                    GenJnlLine.VALIDATE(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '301700';
                    GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := COPYSTR('W/Tax:' + FORMAT(PayLine."Account Name") + '::' + strText, 1, 50);
                    //GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                    //  GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                    //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                    //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                    IF GenJnlLine.Amount <> 0 THEN
                        GenJnlLine.INSERT;
                END;

                IF (Payments."Expense Type" = Payments."Expense Type"::RTGS) THEN BEGIN
                    LineNo := LineNo + 1000;
                    GenJnlLine.INIT;
                    GenJnlLine."Journal Template Name" := JTemplate;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                    GenJnlLine."Journal Batch Name" := JBatch;
                    GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                    GenJnlLine."Source Code" := 'PAYMENTJNL';
                    GenJnlLine."Line No." := LineNo;
                    GenJnlLine."Posting Date" := Payment."Payment Release Date";
                    GenJnlLine."Document Type" := GenJnlLine."Document Type"::" ";
                    GenJnlLine."Document No." := PayLine.No;
                    //GenJnlLine."External Document No." := Payments."Cheque No.";
                    GenJnlLine."Account Type" := GenJnlLine."Account Type"::Vendor;
                    // GenJnlLine."Account No." := PayLine."Account No.";
                    GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                    // GenJnlLine."Currency Code" := Payments."Currency Code";
                    GenJnlLine.VALIDATE(GenJnlLine."Currency Code");
                    GenJnlLine."Gen. Posting Type" := GenJnlLine."Gen. Posting Type"::" ";
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Posting Type");
                    GenJnlLine."Gen. Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Bus. Posting Group");
                    GenJnlLine."Gen. Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."Gen. Prod. Posting Group");
                    GenJnlLine."VAT Bus. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Bus. Posting Group");
                    GenJnlLine."VAT Prod. Posting Group" := '';
                    GenJnlLine.VALIDATE(GenJnlLine."VAT Prod. Posting Group");
                    GenJnlLine.Amount := 800;
                    GenJnlLine.VALIDATE(GenJnlLine.Amount);
                    GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"G/L Account";
                    GenJnlLine."Bal. Account No." := '301690';
                    GenJnlLine.VALIDATE(GenJnlLine."Bal. Account No.");
                    GenJnlLine.Description := COPYSTR('W/Tax:' + FORMAT(PayLine."Account Name") + '::' + strText, 1, 50);
                    //GenJnlLine."Shortcut Dimension 1 Code" := PayLine."Global Dimension 1 Code";
                    GenJnlLine."Shortcut Dimension 2 Code" := PayLine."Shortcut Dimension 2 Code";
                    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                    GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                    //GenJnlLine.ValidateShortcutDimCode(3,PayLine."Shortcut Dimension 3 Code");
                    //GenJnlLine.ValidateShortcutDimCode(4,PayLine."Shortcut Dimension 4 Code");
                    IF GenJnlLine.Amount <> 0 THEN
                        GenJnlLine.INSERT;
                END;

            UNTIL PayLine.NEXT = 0;

            COMMIT;
            //Post the Journal Lines
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
            //Adjust Gen Jnl Exchange Rate Rounding Balances
            AdjustGenJnl.RUN(GenJnlLine);
            //End Adjust Gen Jnl Exchange Rate Rounding Balances

            //Before posting if paymode is cheque print the cheque
            IF (Payments."Pay Mode" = 'Cheque') AND (Payments."Cheque Type" = Payments."Cheque Type"::"Computer Check") THEN BEGIN
                DocPrint.PrintCheck(GenJnlLine);
                CODEUNIT.RUN(CODEUNIT::"Adjust Gen. Journal Balance", GenJnlLine);
                //Confirm Cheque printed //Not necessary.
            END;
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
            //CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Sacco", GenJnlLine);
            Post := FALSE;
            // Post := JournlPosted.PostedSuccessfully();
            IF Post THEN BEGIN
                IF PayLine.FINDFIRST THEN BEGIN
                    REPEAT
                        PayLine."Date Posted" := TODAY;
                        PayLine."Time Posted" := TIME;
                        PayLine."Posted By" := USERID;
                        //PayLine. := PayLine.Status::Posted;
                        PayLine.MODIFY;
                    UNTIL PayLine.NEXT = 0;
                END;
            END;

        END;
    end;

    procedure CheckPVRequiredItems()
    var

    begin
        IF Payments.Posted THEN BEGIN
            ERROR('The Document has already been posted');
        END;

        //TESTFIELD(Status,Status::Approved);
        IF Payments."Paying Type" = Payments."Paying Type"::Bank THEN
            Payments.TESTFIELD(Payments."Paying Bank Account")
        ELSE IF Payments."Paying Type" = Payments."Paying Type"::Vendor THEN
            Payments.TESTFIELD(Payments."Paying Vendor Account");

        Payments.TESTFIELD(Payments."Pay Mode");
        Payments.TESTFIELD(Payments."Payment Release Date");
        //Confirm whether Bank Has the Cash
        //IF Payments."Pay Mode" = 'Payments."Pay Mode"::Cash' THEN
        // CheckBudgetAvail.CheckFundsAvailability(Rec);

        //Confirm Payment Release Date is today);
        //  IF Payments."Pay Mode" = Payments."Pay Mode"::Cash THEN
        //    Payments.TESTFIELD(Payments."Payment Release Date", WORKDATE);
        Temp.GET(USERID);

        JTemplate := Temp."Payment Journal Template";
        JBatch := Temp."Payment Journal Batch";

        IF JTemplate = '' THEN BEGIN
            ERROR('Ensure the PV Template is set up in Cash Office Setup');
        END;
        IF JBatch = '' THEN BEGIN
            ERROR('Ensure the PV Batch is set up in the Cash Office Setup')
        END;

        IF (Payments."Pay Mode" = 'Cheque') AND (Payments."Cheque Type" = Payments."Cheque Type"::"Computer Check") THEN BEGIN
            IF NOT CONFIRM(Text002, FALSE) THEN
                ERROR('You have selected to Abort PV Posting');
        END;


        IF Payments."Fixed Asset Payment Voucher" = TRUE THEN
            Payments.TESTFIELD(Payments."Fixed Asset No");

        //Check whether there is any printed cheques and lines not posted
        CheckLedger.RESET;
        CheckLedger.SETRANGE(CheckLedger."Document No.", Payments."No.");
        CheckLedger.SETRANGE(CheckLedger."Entry Status", CheckLedger."Entry Status"::Printed);
        IF CheckLedger.FIND('-') THEN BEGIN
            //Ask whether to void the printed cheque
            GenJnlLine.RESET;
            GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name", JTemplate);
            GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name", JBatch);
            GenJnlLine.FINDFIRST;
            IF CONFIRM(Text000, FALSE, CheckLedger."Check No.") THEN
                CheckManagement.VoidCheck(GenJnlLine)
            ELSE
                ERROR(Text001, Payments."No.", CheckLedger."Check No.");
        END;
    end;

    procedure CustomerPayLinesExist(): Boolean
    begin
        PayLine.RESET;
        PayLine.SETRANGE(PayLine.No, Rec."No.");
        PayLine.SETRANGE(PayLine."Account Type", PayLine."Account Type"::Customer);
        EXIT(PayLine.FINDFIRST);
    end;

    procedure GetAppliedEntries(VAR LineNo: Integer) InvText: Text[100]
    var
    //Appl : Reco
    begin

        // InvText := '';
        // Appl.RESET;
        // Appl.SETRANGE(Appl."Document Type", Appl."Document Type"::PV);
        // Appl.SETRANGE(Appl."Document No.", "No.");
        // Appl.SETRANGE(Appl."Line No.", LineNo);
        // IF Appl.FINDFIRST THEN BEGIN
        //     REPEAT
        //         InvText := COPYSTR(InvText + ',' + Appl."Appl. Doc. No", 1, 50);
        //     UNTIL Appl.NEXT = 0;
        // END;
    end;
}
