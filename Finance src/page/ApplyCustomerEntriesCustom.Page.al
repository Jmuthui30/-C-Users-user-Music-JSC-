page 51056 "Apply Customer Entries Custom"
{
    ApplicationArea = All;
    Caption = 'Apply Customer Entries';
    DataCaptionFields = "Customer No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = Worksheet;
    SourceTable = "Cust. Ledger Entry";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("ApplyingCustLedgEntry.""Posting Date"""; ApplyingCustLedgEntry."Posting Date")
                {
                    Caption = 'Posting Date';
                    Editable = false;
                    ToolTip = 'Specifies the posting date of the entry to be applied.';
                }
                field("ApplyingCustLedgEntry.""Document Type"""; ApplyingCustLedgEntry."Document Type")
                {
                    Caption = 'Document Type';
                    Editable = false;
                    ToolTip = 'Specifies the document type of the entry to be applied.';
                }
                field("ApplyingCustLedgEntry.""Document No."""; ApplyingCustLedgEntry."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                    ToolTip = 'Specifies the document number of the entry to be applied.';
                }
                field(ApplyingCustomerNo; ApplyingCustLedgEntry."Customer No.")
                {
                    Caption = 'Customer No.';
                    Editable = false;
                    ToolTip = 'Specifies the customer number of the entry to be applied.';
                    Visible = false;
                }
                field(ApplyingCustomerName; ApplyingCustLedgEntry."Customer Name")
                {
                    Caption = 'Customer Name';
                    ToolTip = 'Specifies the customer name of the entry to be applied.';
                    Visible = CustNameVisible;
                }
                field(ApplyingDescription; ApplyingCustLedgEntry.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                    ToolTip = 'Specifies the description of the entry to be applied.';
                    Visible = false;
                }
                field("ApplyingCustLedgEntry.""Currency Code"""; ApplyingCustLedgEntry."Currency Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Currency Code';
                    Editable = false;
                    ToolTip = 'Specifies the code for the currency that amounts are shown in.';
                }
                field("ApplyingCustLedgEntry.Amount"; ApplyingCustLedgEntry.Amount)
                {
                    Caption = 'Amount';
                    Editable = false;
                    ToolTip = 'Specifies the amount on the entry to be applied.';
                }
                field("ApplyingCustLedgEntry.""Remaining Amount"""; ApplyingCustLedgEntry."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                    Editable = false;
                    ToolTip = 'Specifies the amount on the entry to be applied.';
                }
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field(AppliesToID; Rec."Applies-to ID")
                {
                    Caption = 'Applies-to ID';
                    ToolTip = 'Specifies the ID of entries that will be applied to when you choose the Apply Entries action.';
                    Visible = AppliesToIDVisible;
                    trigger OnValidate()
                    begin
                        if (CalcType = CalcType::GenJnlLine) and (ApplnType = ApplnType::"Applies-to Doc. No.") then
                            Error(CannotSetAppliesToIDErr);

                        SetCustApplId(true);

                        CurrPage.Update(false);
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    Editable = false;
                    ToolTip = 'Specifies the customer entry''s posting date.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    Caption = 'Document Type';
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the document type that the customer entry belongs to.';
                }
                field("Document No."; Rec."Document No.")
                {
                    Caption = 'Document No.';
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the entry''s document number.';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    Editable = false;
                    ToolTip = 'Specifies the customer account number that the entry is linked to.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                    Editable = false;
                    ToolTip = 'Specifies the customer name that the entry is linked to.';
                    Visible = CustNameVisible;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Description';
                    Editable = false;
                    ToolTip = 'Specifies a description of the customer entry.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Caption = 'Currency Code';
                    ToolTip = 'Specifies the currency code for the amount on the line.';
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    Caption = 'Original Amount';
                    Editable = false;
                    ToolTip = 'Specifies the amount of the original entry.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry.';
                    Visible = false;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    Caption = 'Debit Amount';
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                    Visible = false;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    Caption = 'Credit Amount';
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                    Visible = false;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    Caption = 'Remaining Amount';
                    Editable = false;
                    ToolTip = 'Specifies the amount that remains to be applied to before the entry has been completely applied.';
                }
                field("CalcApplnRemainingAmount(""Remaining Amount"")"; CalcApplnRemainingAmount(Rec."Remaining Amount"))
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Remaining Amount';
                    ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
                }
                field("Amount to Apply"; Rec."Amount to Apply")
                {
                    Caption = 'Amount to Apply';
                    ToolTip = 'Specifies the amount to apply.';
                    trigger OnValidate()
                    begin
                        Codeunit.Run(Codeunit::"Cust. Entry-Edit", Rec);

                        if (xRec."Amount to Apply" = 0) or (Rec."Amount to Apply" = 0) and
                           ((ApplnType = ApplnType::"Applies-to ID") or (CalcType = CalcType::Direct))
                        then
                            SetCustApplId(false);
                        Rec.Get(Rec."Entry No.");
                        AmountToApplyOnAfterValidate();
                    end;
                }
                field(ApplnAmountToApply; CalcApplnAmountToApply(Rec."Amount to Apply"))
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Amount to Apply';
                    ToolTip = 'Specifies the amount to apply.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    Caption = 'Due Date';
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the due date on the entry.';
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    Caption = 'Pmt. Discount Date';
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                    trigger OnValidate()
                    begin
                        RecalcApplnAmount();
                    end;
                }
                field("Pmt. Disc. Tolerance Date"; Rec."Pmt. Disc. Tolerance Date")
                {
                    Caption = 'Pmt. Disc. Tolerance Date';
                    ToolTip = 'Specifies the last date the amount in the entry must be paid in order for a payment discount tolerance to be granted.';
                }
                field("Original Pmt. Disc. Possible"; Rec."Original Pmt. Disc. Possible")
                {
                    Caption = 'Original Pmt. Disc. Possible';
                    ToolTip = 'Specifies the discount that the customer can obtain if the entry is applied to before the payment discount date.';
                    Visible = false;
                }
                field("Remaining Pmt. Disc. Possible"; Rec."Remaining Pmt. Disc. Possible")
                {
                    Caption = 'Remaining Pmt. Disc. Possible';
                    ToolTip = 'Specifies the remaining payment discount which can be received if the payment is made before the payment discount date.';
                    trigger OnValidate()
                    begin
                        RecalcApplnAmount();
                    end;
                }
                field("CalcApplnRemainingAmount(""Remaining Pmt. Disc. Possible"")"; CalcApplnRemainingAmount(Rec."Remaining Pmt. Disc. Possible"))
                {
                    AutoFormatExpression = ApplnCurrencyCode;
                    AutoFormatType = 1;
                    Caption = 'Appln. Pmt. Disc. Possible';
                    ToolTip = 'Specifies the discount that the customer can obtain if the entry is applied to before the payment discount date.';
                }
                field("Max. Payment Tolerance"; Rec."Max. Payment Tolerance")
                {
                    Caption = 'Max. Payment Tolerance';
                    ToolTip = 'Specifies the maximum tolerated amount the entry can differ from the amount on the invoice or credit memo.';
                }
                field(Open; Rec.Open)
                {
                    Caption = 'Open';
                    Editable = false;
                    ToolTip = 'Specifies whether the amount on the entry has been fully paid or there is still a remaining amount that must be applied to.';
                }
                field(Positive; Rec.Positive)
                {
                    Caption = 'Positive';
                    Editable = false;
                    ToolTip = 'Specifies if the entry to be applied is positive.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Global Dimension 1 Code';
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Global Dimension 2 Code';
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                }
            }
            group(Control41)
            {
                ShowCaption = false;
                fixed(Control1903222401)
                {
                    ShowCaption = false;
                    group("Appln. Currency")
                    {
                        Caption = 'Appln. Currency';
                        field(ApplnCurrencyCode; ApplnCurrencyCode)
                        {
                            ApplicationArea = Suite;
                            Editable = false;
                            ShowCaption = false;
                            TableRelation = Currency;
                            ToolTip = 'Specifies the currency code that the amount will be applied in, in case of different currencies.';
                        }
                    }
                    group(Control1903098801)
                    {
                        Caption = 'Amount to Apply';
                        field(AmountToApply; AppliedAmount)
                        {
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Amount to Apply';
                            Editable = false;
                            ToolTip = 'Specifies the sum of the amounts on all the selected customer ledger entries that will be applied by the entry shown in the Available Amount field. The amount is in the currency represented by the code in the Currency Code field.';
                        }
                    }
                    group("Pmt. Disc. Amount")
                    {
                        Caption = 'Pmt. Disc. Amount';
                        field(PmtDiscountAmount; -PmtDiscAmount)
                        {
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Pmt. Disc. Amount';
                            Editable = false;
                            ToolTip = 'Specifies the sum of the payment discount amounts granted on all the selected customer ledger entries that will be applied by the entry shown in the Available Amount field. The amount is in the currency represented by the code in the Currency Code field.';
                        }
                    }
                    group(Rounding)
                    {
                        Caption = 'Rounding';
                        field(ApplnRounding; ApplnRounding)
                        {
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Rounding';
                            Editable = false;
                            ToolTip = 'Specifies the rounding difference when you apply entries in different currencies to one another. The amount is in the currency represented by the code in the Currency Code field.';
                        }
                    }
                    group("Applied Amount")
                    {
                        Caption = 'Applied Amount';
                        field(AppliedAmount; AppliedAmount + (-PmtDiscAmount) + ApplnRounding)
                        {
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Applied Amount';
                            Editable = false;
                            ToolTip = 'Specifies the sum of the amounts in the Amount to Apply field, Pmt. Disc. Amount field, and the Rounding. The amount is in the currency represented by the code in the Currency Code field.';
                        }
                    }
                    group("Available Amount")
                    {
                        Caption = 'Available Amount';
                        field(ApplyingAmount; ApplyingAmount)
                        {
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Available Amount';
                            Editable = false;
                            ToolTip = 'Specifies the amount of the journal entry, sales credit memo, or current customer ledger entry that you have selected as the applying entry.';
                        }
                    }
                    group(Balance)
                    {
                        Caption = 'Balance';
                        field(ControlBalance; AppliedAmount + (-PmtDiscAmount) + ApplyingAmount + ApplnRounding)
                        {
                            AutoFormatExpression = ApplnCurrencyCode;
                            AutoFormatType = 1;
                            Caption = 'Balance';
                            Editable = false;
                            ToolTip = 'Specifies any extra amount that will remain after the application.';
                        }
                    }
                }
            }
        }
        area(FactBoxes)
        {
            part(Control1903096107; "Customer Ledger Entry FactBox")
            {
                Caption = 'Customer Ledger Entry FactBox';
                SubPageLink = "Entry No." = field("Entry No.");
                Visible = true;
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                Image = Entry;
                action("Reminder/Fin. Charge Entries")
                {
                    ApplicationArea = Suite;
                    Caption = 'Reminder/Fin. Charge Entries';
                    Image = Reminder;
                    RunObject = page "Reminder/Fin. Charge Entries";
                    RunPageLink = "Customer Entry No." = field("Entry No.");
                    RunPageView = sorting("Customer Entry No.");
                    ToolTip = 'View the reminders and finance charge entries that you have entered for the customer.';
                }
                action("Applied E&ntries")
                {
                    Caption = 'Applied E&ntries';
                    Image = Approve;
                    RunObject = page "Applied Customer Entries";
                    RunPageOnRec = true;
                    ToolTip = 'View the ledger entries that have been applied to this record.';
                }
                action(Dimensions)
                {
                    AccessByPermission = tabledata Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortcutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action("Detailed &Ledger Entries")
                {
                    Caption = 'Detailed &Ledger Entries';
                    Image = View;
                    RunObject = page "Detailed Cust. Ledg. Entries";
                    RunPageLink = "Cust. Ledger Entry No." = field("Entry No.");
                    RunPageView = sorting("Cust. Ledger Entry No.", "Posting Date");
                    ShortcutKey = 'Ctrl+F7';
                    ToolTip = 'View a summary of the all posted entries and adjustments related to a specific customer ledger entry.';
                }
                action("&Navigate")
                {
                    Caption = 'Find entries...';
                    Image = Navigate;
                    ShortcutKey = 'Shift+Ctrl+I';
                    ToolTip = 'Find entries and documents that exist for the document number and posting date on the selected document. (Formerly this action was named Navigate.)';

                    trigger OnAction()
                    begin
                        Navigate.SetDoc(Rec."Posting Date", Rec."Document No.");
                        Navigate.Run();
                    end;
                }
            }
        }
        area(Processing)
        {
            group("&Application")
            {
                Caption = '&Application';
                Image = Apply;
                action("Set Applies-to ID")
                {
                    Caption = 'Set Applies-to ID';
                    Image = SelectLineToApply;
                    ShortcutKey = 'Shift+F11';
                    ToolTip = 'Set the Applies-to ID field on the posted entry to automatically be filled in with the document number of the entry in the journal.';

                    trigger OnAction()
                    begin
                        if (CalcType = CalcType::GenJnlLine) and (ApplnType = ApplnType::"Applies-to Doc. No.") then
                            Error(CannotSetAppliesToIDErr);

                        SetCustApplId(false);
                    end;
                }
                action("Post Application")
                {
                    Caption = 'Post Application';
                    Ellipsis = true;
                    Image = PostApplication;
                    ShortcutKey = 'F9';
                    ToolTip = 'Define the document number of the ledger entry to use to perform the application. In addition, you specify the Posting Date for the application.';

                    trigger OnAction()
                    begin
                        PostDirectApplication(false);
                    end;
                }
                action(Preview)
                {
                    Caption = 'Preview Posting';
                    Image = ViewPostedOrder;
                    ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                    trigger OnAction()
                    begin
                        PostDirectApplication(true);
                    end;
                }
                separator("-")
                {
                    Caption = '-';
                }
                action("Show Only Selected Entries to Be Applied")
                {
                    Caption = 'Show Only Selected Entries to Be Applied';
                    Image = ShowSelected;
                    ToolTip = 'View the selected ledger entries that will be applied to the specified record.';

                    trigger OnAction()
                    begin
                        ShowAppliedEntries := not ShowAppliedEntries;
                        if ShowAppliedEntries then
                            if CalcType = CalcType::GenJnlLine then
                                Rec.SetRange("Applies-to ID", GenJnlLine."Applies-to ID")
                            else begin
                                CustEntryApplID := UserId;
                                if CustEntryApplID = '' then
                                    CustEntryApplID := '***';
                                Rec.SetRange("Applies-to ID", CustEntryApplID);
                            end
                        else
                            Rec.SetRange("Applies-to ID");
                    end;
                }
            }
            action(ShowPostedDocument)
            {
                Caption = 'Show Posted Document';
                Image = Document;
                ToolTip = 'Show details for the posted payment, invoice, or credit memo.';

                trigger OnAction()
                begin
                    Rec.ShowDoc()
                end;
            }
            action(ShowDocumentAttachment)
            {
                Caption = 'Show Document Attachment';
                Enabled = HasDocumentAttachment;
                Image = Attach;
                ToolTip = 'View documents or images that are attached to the posted invoice or credit memo.';

                trigger OnAction()
                begin
                    Rec.ShowPostedDocAttachment();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process', Comment = 'Generated from the PromotedActionCategories property index 1.';

                actionref("Set Applies-to ID_Promoted"; "Set Applies-to ID")
                {
                }
                actionref("Post Application_Promoted"; "Post Application")
                {
                }
                actionref(Preview_Promoted; Preview)
                {
                }
                actionref("Show Only Selected Entries to Be Applied_Promoted"; "Show Only Selected Entries to Be Applied")
                {
                }
            }

            group(Category_Category4)
            {
                Caption = 'Line', Comment = 'Generated from the PromotedActionCategories property index 3.';

                actionref(ShowPostedDocument_Promoted; ShowPostedDocument)
                {
                }
                actionref(ShowDocumentAttachment_Promoted; ShowDocumentAttachment)
                {
                }
            }
            group(Category_Category5)
            {
                Caption = 'Entry', Comment = 'Generated from the PromotedActionCategories property index 4.';

                actionref("Reminder/Fin. Charge Entries_Promoted"; "Reminder/Fin. Charge Entries")
                {
                }
                actionref("Applied E&ntries_Promoted"; "Applied E&ntries")
                {
                }
                actionref(Dimensions_Promoted; Dimensions)
                {
                }
                actionref("Detailed &Ledger Entries_Promoted"; "Detailed &Ledger Entries")
                {
                }
                actionref("&Navigate_Promoted"; "&Navigate")
                {
                }
            }
        }
    }

    var
        Currency: Record Currency;
        CurrExchRate: Record "Currency Exchange Rate";
        ApplyingCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        Cust: Record Customer;
        GenJnlLine: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";
        PaymentLine, PaymentLine2 : Record "Payment Lines";
        PaymentRec: Record Payments;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        TotalSalesLine: Record "Sales Line";
        TotalSalesLineLCY: Record "Sales Line";
        ServHeader: Record "Service Header";
        TotalServLine: Record "Service Line";
        TotalServLineLCY: Record "Service Line";
        CustEntrySetApplID: Codeunit "Cust. Entry-SetAppl.ID";
        GenJnlApply: Codeunit "Gen. Jnl.-Apply";
        PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
        SalesPost: Codeunit "Sales-Post";
        Navigate: Page Navigate;
        AppliesToIDVisible: Boolean;
        CustNameVisible: Boolean;
        HasDocumentAttachment: Boolean;
        OK: Boolean;
        PaymentLineApply: Boolean;
        PostingDone: Boolean;
        ShowAppliedEntries: Boolean;
        ValidExchRate: Boolean;
        CustEntryApplID: Code[50];
        ApplnDate: Date;
        AmountRoundingPrecision: Decimal;
        ApplnRounding: Decimal;
        ApplnRoundingPrecision: Decimal;
        ProfitLCY: Decimal;
        ProfitPct: Decimal;
        VATAmount: Decimal;
        CannotSetAppliesToIDErr: Label 'You cannot set Applies-to ID while selecting Applies-to Doc. No.';
        EarlierPostingDateErr: Label 'You cannot apply and post an entry to an entry with an earlier posting date.\\Instead, post the document of type %1 with the number %2 and then apply it to the document of type %3 with the number %4.';
        Text002: Label 'You must select an applying entry before you can post the application.';
        Text003: Label 'You must post the application from the window where you entered the applying entry.';
        Text012: Label 'The application was successfully posted.';
        ApplnType: Option " ","Applies-to Doc. No.","Applies-to ID";
        CalcType: Option Direct,GenJnlLine,SalesHeader,ServHeader,Payments;
        StyleTxt: Text;
        VATAmountText: Text[30];

    protected var
        AppliedCustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry: Record "Cust. Ledger Entry";
        GenJnlLine2: Record "Gen. Journal Line";
        DifferentCurrenciesInAppln: Boolean;
        ApplnCurrencyCode: Code[10];
        AppliedAmount: Decimal;
        ApplyingAmount: Decimal;
        PmtDiscAmount: Decimal;

    trigger OnInit()
    begin
        AppliesToIDVisible := true;
    end;

    trigger OnOpenPage()
    begin
        if CalcType = CalcType::Direct then begin
            Cust.Get(Rec."Customer No.");
            ApplnCurrencyCode := Cust."Currency Code";
            FindApplyingEntry();
        end;

        SalesSetup.Get();
        CustNameVisible := SalesSetup."Copy Customer Name to Entries";

        AppliesToIDVisible := ApplnType <> ApplnType::"Applies-to Doc. No.";

        GLSetup.Get();

        /* if ApplnType = ApplnType::"Applies-to Doc. No." then
            CalcApplnAmount; */

        if CalcType = CalcType::GenJnlLine then
            CalcApplnAmount();

        //Modified
        if CalcType = CalcType::Payments then
            CalcApplnAmount();
        PostingDone := false;
    end;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := Rec.SetStyle();
    end;

    trigger OnModifyRecord(): Boolean
    begin
        Codeunit.Run(Codeunit::"Cust. Entry-Edit", Rec);
        if Rec."Applies-to ID" <> xRec."Applies-to ID" then
            CalcApplnAmount();
        exit(false);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        RaiseError: Boolean;
    begin
        if CloseAction = Action::LookupOK then
            LookupOKOnPush();
        if ApplnType = ApplnType::"Applies-to Doc. No." then begin
            if OK then begin
                RaiseError := ApplyingCustLedgEntry."Posting Date" < Rec."Posting Date";
                OnBeforeEarlierPostingDateError(ApplyingCustLedgEntry, Rec, RaiseError, CalcType);
                if RaiseError then begin
                    OK := false;
                    Error(
                      EarlierPostingDateErr, ApplyingCustLedgEntry."Document Type", ApplyingCustLedgEntry."Document No.",
                      Rec."Document Type", Rec."Document No.");
                end;
            end;
            if OK then begin
                if Rec."Amount to Apply" = 0 then
                    Rec."Amount to Apply" := Rec."Remaining Amount";
                Codeunit.Run(Codeunit::"Cust. Entry-Edit", Rec);
            end;
        end;
        if (CalcType = CalcType::Direct) and not OK and not PostingDone then begin
            Rec := ApplyingCustLedgEntry;
            Rec."Applying Entry" := false;
            Rec."Applies-to ID" := '';
            Rec."Amount to Apply" := 0;
            Codeunit.Run(Codeunit::"Cust. Entry-Edit", Rec);
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if ApplnType = ApplnType::"Applies-to Doc. No." then
            CalcApplnAmount();
        HasDocumentAttachment := Rec.HasPostedDocAttachment();
    end;

    procedure CalcApplnAmount()
    begin
        OnBeforeCalcApplnAmount(Rec, GenJnlLine, SalesHeader, AppliedCustLedgEntry, CalcType, ApplnType);

        AppliedAmount := 0;
        PmtDiscAmount := 0;
        DifferentCurrenciesInAppln := false;

        case CalcType of
            CalcType::Direct:
                begin
                    FindAmountRounding();
                    CustEntryApplID := UserId;
                    if CustEntryApplID = '' then
                        CustEntryApplID := '***';

                    CustLedgEntry := ApplyingCustLedgEntry;

                    AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                    AppliedCustLedgEntry.SetRange("Customer No.", Rec."Customer No.");
                    AppliedCustLedgEntry.SetRange(Open, true);
                    AppliedCustLedgEntry.SetRange("Applies-to ID", CustEntryApplID);

                    if ApplyingCustLedgEntry."Entry No." <> 0 then begin
                        CustLedgEntry.CalcFields("Remaining Amount");
                        AppliedCustLedgEntry.SetFilter("Entry No.", '<>%1', ApplyingCustLedgEntry."Entry No.");
                    end;

                    HandleChosenEntries(0, CustLedgEntry."Remaining Amount", CustLedgEntry."Currency Code", CustLedgEntry."Posting Date");
                end;
            CalcType::GenJnlLine:
                begin
                    FindAmountRounding();
                    if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer then
                        Codeunit.Run(Codeunit::"Exchange Acc. G/L Journal Line", GenJnlLine);

                    case ApplnType of
                        ApplnType::"Applies-to Doc. No.":
                            begin
                                AppliedCustLedgEntry := Rec;
                                AppliedCustLedgEntry.CalcFields("Remaining Amount");
                                if AppliedCustLedgEntry."Currency Code" <> ApplnCurrencyCode then begin
                                    AppliedCustLedgEntry."Remaining Amount" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedCustLedgEntry."Currency Code", ApplnCurrencyCode, AppliedCustLedgEntry."Remaining Amount");
                                    AppliedCustLedgEntry."Remaining Pmt. Disc. Possible" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedCustLedgEntry."Currency Code", ApplnCurrencyCode, AppliedCustLedgEntry."Remaining Pmt. Disc. Possible");
                                    AppliedCustLedgEntry."Amount to Apply" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedCustLedgEntry."Currency Code", ApplnCurrencyCode, AppliedCustLedgEntry."Amount to Apply");
                                end;

                                if AppliedCustLedgEntry."Amount to Apply" <> 0 then
                                    AppliedAmount := Round(AppliedCustLedgEntry."Amount to Apply", AmountRoundingPrecision)
                                else
                                    AppliedAmount := Round(AppliedCustLedgEntry."Remaining Amount", AmountRoundingPrecision);

                                if PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(
                                     GenJnlLine, AppliedCustLedgEntry, 0, false) and
                                   ((Abs(GenJnlLine.Amount) + ApplnRoundingPrecision >=
                                     Abs(AppliedAmount - AppliedCustLedgEntry."Remaining Pmt. Disc. Possible")) or
                                    (GenJnlLine.Amount = 0))
                                then
                                    PmtDiscAmount := AppliedCustLedgEntry."Remaining Pmt. Disc. Possible";

                                if not DifferentCurrenciesInAppln then
                                    DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedCustLedgEntry."Currency Code";
                                CheckRounding();
                            end;
                        ApplnType::"Applies-to ID":
                            begin
                                GenJnlLine2 := GenJnlLine;
                                AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                                AppliedCustLedgEntry.SetRange("Customer No.", GenJnlLine."Account No.");
                                AppliedCustLedgEntry.SetRange(Open, true);
                                AppliedCustLedgEntry.SetRange("Applies-to ID", GenJnlLine."Applies-to ID");

                                HandleChosenEntries(1, GenJnlLine2.Amount, GenJnlLine2."Currency Code", GenJnlLine2."Posting Date");
                            end;
                    end;
                end;
            CalcType::SalesHeader, CalcType::ServHeader:
                begin
                    FindAmountRounding();

                    case ApplnType of
                        ApplnType::"Applies-to Doc. No.":
                            begin
                                AppliedCustLedgEntry := Rec;
                                AppliedCustLedgEntry.CalcFields("Remaining Amount");

                                if AppliedCustLedgEntry."Currency Code" <> ApplnCurrencyCode then
                                    AppliedCustLedgEntry."Remaining Amount" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedCustLedgEntry."Currency Code", ApplnCurrencyCode, AppliedCustLedgEntry."Remaining Amount");

                                AppliedAmount := Round(AppliedCustLedgEntry."Remaining Amount", AmountRoundingPrecision);

                                if not DifferentCurrenciesInAppln then
                                    DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedCustLedgEntry."Currency Code";
                                CheckRounding();
                            end;
                        ApplnType::"Applies-to ID":
                            begin
                                AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                                if CalcType = CalcType::SalesHeader then
                                    AppliedCustLedgEntry.SetRange("Customer No.", SalesHeader."Bill-to Customer No.")
                                else
                                    AppliedCustLedgEntry.SetRange("Customer No.", ServHeader."Bill-to Customer No.");
                                AppliedCustLedgEntry.SetRange(Open, true);
                                AppliedCustLedgEntry.SetRange("Applies-to ID", GetAppliesToID());

                                HandleChosenEntries(2, ApplyingAmount, ApplnCurrencyCode, ApplnDate);
                            end;
                    end;
                end;
            CalcType::Payments:
                begin
                    FindAmountRounding();
                    case ApplnType of
                        ApplnType::"Applies-to Doc. No.":
                            begin
                                AppliedCustLedgEntry := Rec;
                                AppliedCustLedgEntry.CalcFields("Remaining Amount");
                                if AppliedCustLedgEntry."Currency Code" <> ApplnCurrencyCode then begin
                                    AppliedCustLedgEntry."Remaining Amount" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedCustLedgEntry."Currency Code", ApplnCurrencyCode, AppliedCustLedgEntry."Remaining Amount");
                                    AppliedCustLedgEntry."Remaining Pmt. Disc. Possible" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedCustLedgEntry."Currency Code", ApplnCurrencyCode, AppliedCustLedgEntry."Remaining Pmt. Disc. Possible");
                                    AppliedCustLedgEntry."Amount to Apply" :=
                                      CurrExchRate.ExchangeAmtFCYToFCY(
                                        ApplnDate, AppliedCustLedgEntry."Currency Code", ApplnCurrencyCode, AppliedCustLedgEntry."Amount to Apply");
                                end;
                                if AppliedCustLedgEntry."Amount to Apply" <> 0 then
                                    AppliedAmount := Round(AppliedCustLedgEntry."Amount to Apply", AmountRoundingPrecision)
                                else
                                    AppliedAmount := Round(AppliedCustLedgEntry."Remaining Amount", AmountRoundingPrecision);
                                if PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(
                                     GenJnlLine, AppliedCustLedgEntry, 0, false) and
                                   ((Abs(PaymentLine.Amount) + ApplnRoundingPrecision >=
                                     Abs(AppliedAmount - AppliedCustLedgEntry."Remaining Pmt. Disc. Possible")) or
                                    (GenJnlLine.Amount = 0))
                                then
                                    PmtDiscAmount := AppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                                if not DifferentCurrenciesInAppln then
                                    DifferentCurrenciesInAppln := ApplnCurrencyCode <> AppliedCustLedgEntry."Currency Code";
                                CheckRounding();
                            end;
                        ApplnType::"Applies-to ID":
                            begin
                                PaymentLine2 := PaymentLine;
                                PaymentRec.Get(PaymentLine.No);
                                AppliedCustLedgEntry.SetCurrentKey("Customer No.", Open, Positive);
                                AppliedCustLedgEntry.SetRange("Customer No.", PaymentLine."Account No");
                                AppliedCustLedgEntry.SetRange(Open, true);
                                AppliedCustLedgEntry.SetRange("Applies-to ID", PaymentLine."Applies-to ID");
                                HandleChosenEntries(3,
                                  PaymentLine2.Amount,
                                  PaymentRec.Currency,
                                  PaymentRec.Date);
                            end;
                    end;
                end;
        end;

        OnAfterCalcApplnAmount(Rec, AppliedAmount, ApplyingAmount);
    end;

    procedure CalcOppositeEntriesAmount(var TempAppliedCustLedgerEntry: Record "Cust. Ledger Entry" temporary) Result: Decimal
    var
        SavedAppliedCustLedgerEntry: Record "Cust. Ledger Entry";
        CurrPosFilter: Text;
    begin
        CurrPosFilter := TempAppliedCustLedgerEntry.GetFilter(Positive);
        if CurrPosFilter <> '' then begin
            SavedAppliedCustLedgerEntry := TempAppliedCustLedgerEntry;
            TempAppliedCustLedgerEntry.SetRange(Positive, not TempAppliedCustLedgerEntry.Positive);
            if TempAppliedCustLedgerEntry.FindSet() then
                repeat
                    TempAppliedCustLedgerEntry.CalcFields("Remaining Amount");
                    Result += TempAppliedCustLedgerEntry."Remaining Amount";
                until TempAppliedCustLedgerEntry.Next() = 0;
            TempAppliedCustLedgerEntry.SetFilter(Positive, CurrPosFilter);
            TempAppliedCustLedgerEntry := SavedAppliedCustLedgerEntry;
        end;
    end;

    procedure CheckRounding()
    begin
        ApplnRounding := 0;

        case CalcType of
            CalcType::SalesHeader, CalcType::ServHeader:
                exit;
            CalcType::GenJnlLine:
                if (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Payment) and
                   (GenJnlLine."Document Type" <> GenJnlLine."Document Type"::Refund)
                then
                    exit;
        end;

        if ApplnCurrencyCode = '' then
            ApplnRoundingPrecision := GLSetup."Appln. Rounding Precision"
        else begin
            if ApplnCurrencyCode <> Rec."Currency Code" then
                Currency.Get(ApplnCurrencyCode);
            ApplnRoundingPrecision := Currency."Appln. Rounding Precision";
        end;

        if (Abs((AppliedAmount - PmtDiscAmount) + ApplyingAmount) <= ApplnRoundingPrecision) and DifferentCurrenciesInAppln then
            ApplnRounding := -((AppliedAmount - PmtDiscAmount) + ApplyingAmount);
    end;

    procedure ExchangeAmountsOnLedgerEntry(Type: Option Direct,GenJnlLine,SalesHeader; CurrencyCode: Code[10]; var CalcCustLedgEntry: Record "Cust. Ledger Entry"; PostingDate: Date)
    var
        CalculateCurrency: Boolean;
    begin
        CalcCustLedgEntry.CalcFields("Remaining Amount");

        if Type = Type::Direct then
            CalculateCurrency := ApplyingCustLedgEntry."Entry No." <> 0
        else
            CalculateCurrency := true;

        if (CurrencyCode <> CalcCustLedgEntry."Currency Code") and CalculateCurrency then begin
            CalcCustLedgEntry."Remaining Amount" :=
              CurrExchRate.ExchangeAmount(
                CalcCustLedgEntry."Remaining Amount", CalcCustLedgEntry."Currency Code", CurrencyCode, PostingDate);
            CalcCustLedgEntry."Remaining Pmt. Disc. Possible" :=
              CurrExchRate.ExchangeAmount(
                CalcCustLedgEntry."Remaining Pmt. Disc. Possible", CalcCustLedgEntry."Currency Code", CurrencyCode, PostingDate);
            CalcCustLedgEntry."Amount to Apply" :=
              CurrExchRate.ExchangeAmount(
                CalcCustLedgEntry."Amount to Apply", CalcCustLedgEntry."Currency Code", CurrencyCode, PostingDate);
        end;

        OnAfterExchangeAmountsOnLedgerEntry(CalcCustLedgEntry, CustLedgEntry, CurrencyCode);
    end;

    procedure GetApplnCurrencyCode(): Code[10]
    begin
        exit(ApplnCurrencyCode);
    end;

    procedure GetCalcType(): Integer
    begin
        exit(CalcType);
    end;

    procedure GetCustLedgEntry(var CustLedgEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgEntry := Rec;
    end;

    procedure SetApplyingCustLedgEntry()
    var
        Customer: Record Customer;
    begin
        OnBeforeSetApplyingCustLedgEntry(AppliedCustLedgEntry, GenJnlLine, SalesHeader);

        case CalcType of
            CalcType::SalesHeader:
                begin
                    ApplyingCustLedgEntry."Entry No." := 1;
                    ApplyingCustLedgEntry."Posting Date" := SalesHeader."Posting Date";
                    if SalesHeader."Document Type" = SalesHeader."Document Type"::"Return Order" then
                        ApplyingCustLedgEntry."Document Type" := ApplyingCustLedgEntry."Document Type"::"Credit Memo"
                    else
                        ApplyingCustLedgEntry."Document Type" := ApplyingCustLedgEntry."Document Type"::Invoice;
                    ApplyingCustLedgEntry."Document No." := SalesHeader."No.";
                    ApplyingCustLedgEntry."Customer No." := SalesHeader."Bill-to Customer No.";
                    ApplyingCustLedgEntry.Description := SalesHeader."Posting Description";
                    ApplyingCustLedgEntry."Currency Code" := SalesHeader."Currency Code";
                    if ApplyingCustLedgEntry."Document Type" = ApplyingCustLedgEntry."Document Type"::"Credit Memo" then begin
                        ApplyingCustLedgEntry.Amount := -TotalSalesLine."Amount Including VAT";
                        ApplyingCustLedgEntry."Remaining Amount" := -TotalSalesLine."Amount Including VAT";
                    end else begin
                        ApplyingCustLedgEntry.Amount := TotalSalesLine."Amount Including VAT";
                        ApplyingCustLedgEntry."Remaining Amount" := TotalSalesLine."Amount Including VAT";
                    end;
                    CalcApplnAmount();
                end;
            CalcType::ServHeader:
                begin
                    ApplyingCustLedgEntry."Entry No." := 1;
                    ApplyingCustLedgEntry."Posting Date" := ServHeader."Posting Date";
                    if ServHeader."Document Type" = ServHeader."Document Type"::"Credit Memo" then
                        ApplyingCustLedgEntry."Document Type" := ApplyingCustLedgEntry."Document Type"::"Credit Memo"
                    else
                        ApplyingCustLedgEntry."Document Type" := ApplyingCustLedgEntry."Document Type"::Invoice;
                    ApplyingCustLedgEntry."Document No." := ServHeader."No.";
                    ApplyingCustLedgEntry."Customer No." := ServHeader."Bill-to Customer No.";
                    ApplyingCustLedgEntry.Description := ServHeader."Posting Description";
                    ApplyingCustLedgEntry."Currency Code" := ServHeader."Currency Code";
                    if ApplyingCustLedgEntry."Document Type" = ApplyingCustLedgEntry."Document Type"::"Credit Memo" then begin
                        ApplyingCustLedgEntry.Amount := -TotalServLine."Amount Including VAT";
                        ApplyingCustLedgEntry."Remaining Amount" := -TotalServLine."Amount Including VAT";
                    end else begin
                        ApplyingCustLedgEntry.Amount := TotalServLine."Amount Including VAT";
                        ApplyingCustLedgEntry."Remaining Amount" := TotalServLine."Amount Including VAT";
                    end;
                    CalcApplnAmount();
                end;
            CalcType::Direct:
                begin
                    if Rec."Applying Entry" then begin
                        if ApplyingCustLedgEntry."Entry No." <> 0 then
                            CustLedgEntry := ApplyingCustLedgEntry;
                        Codeunit.Run(Codeunit::"Cust. Entry-Edit", Rec);
                        if Rec."Applies-to ID" = '' then
                            SetCustApplId(false);
                        Rec.CalcFields(Amount);
                        ApplyingCustLedgEntry := Rec;
                        if CustLedgEntry."Entry No." <> 0 then begin
                            Rec := CustLedgEntry;
                            Rec."Applying Entry" := false;
                            SetCustApplId(false);
                        end;
                        Rec.SetFilter("Entry No.", '<> %1', ApplyingCustLedgEntry."Entry No.");
                        ApplyingAmount := ApplyingCustLedgEntry."Remaining Amount";
                        ApplnDate := ApplyingCustLedgEntry."Posting Date";
                        ApplnCurrencyCode := ApplyingCustLedgEntry."Currency Code";
                    end;
                    CalcApplnAmount();
                end;
            CalcType::GenJnlLine:
                begin
                    ApplyingCustLedgEntry."Entry No." := 1;
                    ApplyingCustLedgEntry."Posting Date" := GenJnlLine."Posting Date";
                    ApplyingCustLedgEntry."Document Type" := GenJnlLine."Document Type";
                    ApplyingCustLedgEntry."Document No." := GenJnlLine."Document No.";
                    if GenJnlLine."Bal. Account Type" = GenJnlLine."Account Type"::Customer then begin
                        ApplyingCustLedgEntry."Customer No." := GenJnlLine."Bal. Account No.";
                        Customer.Get(ApplyingCustLedgEntry."Customer No.");
                        ApplyingCustLedgEntry.Description := Customer.Name;
                    end else begin
                        ApplyingCustLedgEntry."Customer No." := GenJnlLine."Account No.";
                        ApplyingCustLedgEntry.Description := GenJnlLine.Description;
                    end;
                    ApplyingCustLedgEntry."Currency Code" := GenJnlLine."Currency Code";
                    ApplyingCustLedgEntry.Amount := GenJnlLine.Amount;
                    ApplyingCustLedgEntry."Remaining Amount" := GenJnlLine.Amount;
                    CalcApplnAmount();
                end;
            CalcType::Payments:
                begin
                    PaymentRec.Get(PaymentLine.No);
                    ApplyingCustLedgEntry."Entry No." := 1;
                    ApplyingCustLedgEntry."Posting Date" := PaymentRec.Date;
                    ApplyingCustLedgEntry."Document Type" := PaymentLine."Applies-to Doc Type";
                    ApplyingCustLedgEntry."Document No." := PaymentLine.No;
                    ApplyingCustLedgEntry."Customer No." := PaymentLine."Account No";
                    ApplyingCustLedgEntry.Description := PaymentLine.Description;
                    ApplyingCustLedgEntry."Currency Code" := PaymentRec.Currency;
                    ApplyingCustLedgEntry.Amount := PaymentLine.Amount;
                    ApplyingCustLedgEntry."Remaining Amount" := PaymentLine.Amount;
                    CalcApplnAmount();
                end;
        end;
    end;

    procedure SetCustApplId(CurrentRec: Boolean)
    var
        RaiseError: Boolean;
    begin
        if CalcType = CalcType::GenJnlLine then begin
            RaiseError := ApplyingCustLedgEntry."Posting Date" < Rec."Posting Date";
            OnBeforeEarlierPostingDateError(ApplyingCustLedgEntry, Rec, RaiseError, CalcType);
            if RaiseError then
                Error(
                  EarlierPostingDateErr, ApplyingCustLedgEntry."Document Type", ApplyingCustLedgEntry."Document No.",
                  Rec."Document Type", Rec."Document No.");
        end;

        //Modified
        if CalcType = CalcType::Payments then
            PaymentRec.Get(PaymentLine.No);
        if (CalcType = CalcType::Payments) and (ApplyingCustLedgEntry."Posting Date" < PaymentRec.Date) then
            Error(
              EarlierPostingDateErr, ApplyingCustLedgEntry."Document Type", ApplyingCustLedgEntry."Document No.",
              PaymentLine."Applies-to Doc Type", PaymentLine.No);

        if ApplyingCustLedgEntry."Entry No." <> 0 then
            GenJnlApply.CheckAgainstApplnCurrency(
              ApplnCurrencyCode, Rec."Currency Code", GenJnlLine."Account Type"::Customer, true);

        OnSetCustApplIdAfterCheckAgainstApplnCurrency(Rec, CalcType, GenJnlLine);
        CustLedgEntry.Copy(Rec);
        if CurrentRec then begin
            CustLedgEntry.SetRecFilter();
            CustEntrySetApplID.SetApplId(CustLedgEntry, ApplyingCustLedgEntry, Rec."Applies-to ID")
        end else begin
            CurrPage.SetSelectionFilter(CustLedgEntry);
            CustEntrySetApplID.SetApplId(CustLedgEntry, ApplyingCustLedgEntry, GetAppliesToID())
        end;

        CalcApplnAmount();
    end;

    procedure SetCustLedgEntry(NewCustLedgEntry: Record "Cust. Ledger Entry")
    begin
        Rec := NewCustLedgEntry;
    end;

    procedure SetGenJnlLine(NewGenJnlLine: Record "Gen. Journal Line"; ApplnTypeSelect: Integer)
    begin
        GenJnlLine := NewGenJnlLine;

        if GenJnlLine."Account Type" = GenJnlLine."Account Type"::Customer then
            ApplyingAmount := GenJnlLine.Amount;
        if GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::Customer then
            ApplyingAmount := -GenJnlLine.Amount;
        ApplnDate := GenJnlLine."Posting Date";
        ApplnCurrencyCode := GenJnlLine."Currency Code";
        CalcType := CalcType::GenJnlLine;

        case ApplnTypeSelect of
            GenJnlLine.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            GenJnlLine.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;

        SetApplyingCustLedgEntry();
    end;

    procedure SetPaymentLine(NewPaymentLine: Record "Payment Lines"; ApplnTypeSelect: Integer)
    var
        PaymentRec: Record Payments;
    begin
        PaymentLine := NewPaymentLine;
        PaymentLineApply := true;
        PaymentRec.Get(PaymentLine.No);
        if PaymentLine."Account Type" = PaymentLine."Account Type"::Customer then
            ApplyingAmount := PaymentLine.Amount;
        ApplnDate := PaymentRec.Date;
        ApplnCurrencyCode := PaymentRec.Currency;
        CalcType := CalcType::Payments;
        case ApplnTypeSelect of
            PaymentLine.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            PaymentLine.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;
        SetApplyingCustLedgEntry();
    end;

    procedure SetSales(NewSalesHeader: Record "Sales Header"; var NewCustLedgEntry: Record "Cust. Ledger Entry"; ApplnTypeSelect: Integer)
    var
        TotalAdjCostLCY: Decimal;
    begin
        SalesHeader := NewSalesHeader;
        Rec.CopyFilters(NewCustLedgEntry);

        SalesPost.SumSalesLines(
          SalesHeader, 0, TotalSalesLine, TotalSalesLineLCY,
          VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY);

        case SalesHeader."Document Type" of
            SalesHeader."Document Type"::"Return Order",
          SalesHeader."Document Type"::"Credit Memo":
                ApplyingAmount := -TotalSalesLine."Amount Including VAT"
            else
                ApplyingAmount := TotalSalesLine."Amount Including VAT";
        end;

        ApplnDate := SalesHeader."Posting Date";
        ApplnCurrencyCode := SalesHeader."Currency Code";
        CalcType := CalcType::SalesHeader;

        case ApplnTypeSelect of
            SalesHeader.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            SalesHeader.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;

        SetApplyingCustLedgEntry();
    end;

    procedure SetService(NewServHeader: Record "Service Header"; var NewCustLedgEntry: Record "Cust. Ledger Entry"; ApplnTypeSelect: Integer)
    var
        ServAmountsMgt: Codeunit "Serv-Amounts Mgt.";
        TotalAdjCostLCY: Decimal;
    begin
        ServHeader := NewServHeader;
        Rec.CopyFilters(NewCustLedgEntry);

        ServAmountsMgt.SumServiceLines(
          ServHeader, 0, TotalServLine, TotalServLineLCY,
          VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY);

        case ServHeader."Document Type" of
            ServHeader."Document Type"::"Credit Memo":
                ApplyingAmount := -TotalServLine."Amount Including VAT"
            else
                ApplyingAmount := TotalServLine."Amount Including VAT";
        end;

        ApplnDate := ServHeader."Posting Date";
        ApplnCurrencyCode := ServHeader."Currency Code";
        CalcType := CalcType::ServHeader;

        case ApplnTypeSelect of
            ServHeader.FieldNo("Applies-to Doc. No."):
                ApplnType := ApplnType::"Applies-to Doc. No.";
            ServHeader.FieldNo("Applies-to ID"):
                ApplnType := ApplnType::"Applies-to ID";
        end;

        SetApplyingCustLedgEntry();
    end;

    local procedure AmountToApplyOnAfterValidate()
    begin
        if ApplnType <> ApplnType::"Applies-to Doc. No." then begin
            CalcApplnAmount();
            CurrPage.Update(false);
        end;
    end;

    local procedure CalcApplnAmountToApply(AmountToApply: Decimal): Decimal
    var
        ApplnAmountToApply: Decimal;
    begin
        ValidExchRate := true;

        if ApplnCurrencyCode = Rec."Currency Code" then
            exit(AmountToApply);

        if ApplnDate = 0D then
            ApplnDate := Rec."Posting Date";
        ApplnAmountToApply :=
          CurrExchRate.ApplnExchangeAmtFCYToFCY(
            ApplnDate, Rec."Currency Code", ApplnCurrencyCode, AmountToApply, ValidExchRate);

        OnAfterCalcApplnAmountToApply(Rec, ApplnAmountToApply);
        exit(ApplnAmountToApply);
    end;

    local procedure CalcApplnRemainingAmount(Amount: Decimal): Decimal
    var
        ApplnRemainingAmount: Decimal;
    begin
        ValidExchRate := true;
        if ApplnCurrencyCode = Rec."Currency Code" then
            exit(Amount);

        if ApplnDate = 0D then
            ApplnDate := Rec."Posting Date";
        ApplnRemainingAmount :=
          CurrExchRate.ApplnExchangeAmtFCYToFCY(
            ApplnDate, Rec."Currency Code", ApplnCurrencyCode, Amount, ValidExchRate);

        OnAfterCalcApplnRemainingAmount(Rec, ApplnRemainingAmount);
        exit(ApplnRemainingAmount);
    end;

    local procedure FindAmountRounding()
    begin
        if ApplnCurrencyCode = '' then begin
            Currency.Init();
            Currency.Code := '';
            Currency.InitRoundingPrecision();
        end else
            if ApplnCurrencyCode <> Currency.Code then
                Currency.Get(ApplnCurrencyCode);

        AmountRoundingPrecision := Currency."Amount Rounding Precision";
    end;

    local procedure FindApplyingEntry()
    begin
        if CalcType = CalcType::Direct then begin
            CustEntryApplID := UserId;
            if CustEntryApplID = '' then
                CustEntryApplID := '***';

            CustLedgEntry.SetCurrentKey("Customer No.", "Applies-to ID", Open);
            CustLedgEntry.SetRange("Customer No.", Rec."Customer No.");
            CustLedgEntry.SetRange("Applies-to ID", CustEntryApplID);
            CustLedgEntry.SetRange(Open, true);
            CustLedgEntry.SetRange("Applying Entry", true);
            OnFindFindApplyingEntryOnAfterCustLedgEntrySetFilters(Rec, CustLedgEntry);
            if CustLedgEntry.FindFirst() then begin
                CustLedgEntry.CalcFields(Amount, "Remaining Amount");
                ApplyingCustLedgEntry := CustLedgEntry;
                Rec.SetFilter("Entry No.", '<>%1', CustLedgEntry."Entry No.");
                ApplyingAmount := CustLedgEntry."Remaining Amount";
                ApplnDate := CustLedgEntry."Posting Date";
                ApplnCurrencyCode := CustLedgEntry."Currency Code";
            end;
            CalcApplnAmount();
        end;
    end;

    local procedure GetAppliesToID() AppliesToID: Code[50]
    begin
        case CalcType of
            CalcType::GenJnlLine:
                AppliesToID := GenJnlLine."Applies-to ID";
            CalcType::SalesHeader:
                AppliesToID := SalesHeader."Applies-to ID";
            CalcType::ServHeader:
                AppliesToID := ServHeader."Applies-to ID";
            //Modified
            CalcType::Payments:
                AppliesToID := PaymentLine."Applies-to ID";
        end;
    end;

    local procedure HandleChosenEntries(Type: Option Direct,GenJnlLine,SalesHeader; CurrentAmount: Decimal; CurrencyCode: Code[10]; PostingDate: Date)
    var
        TempAppliedCustLedgEntry: Record "Cust. Ledger Entry" temporary;
        CanUseDisc: Boolean;
        FromZeroGenJnl: Boolean;
        IsHandled: Boolean;
        CorrectionAmount: Decimal;
        OldPmtDisc: Decimal;
        PossiblePmtDisc: Decimal;
        RemainingAmountExclDiscounts: Decimal;
    begin
        IsHandled := false;
        OnBeforeHandledChosenEntries(Type, CurrentAmount, CurrencyCode, PostingDate, AppliedCustLedgEntry, IsHandled);
        if IsHandled then
            exit;

        if not AppliedCustLedgEntry.FindSet() then
            exit;

        repeat
            TempAppliedCustLedgEntry := AppliedCustLedgEntry;
            TempAppliedCustLedgEntry.Insert();
        until AppliedCustLedgEntry.Next() = 0;

        FromZeroGenJnl := (CurrentAmount = 0) and (Type = Type::GenJnlLine);

        repeat
            if not FromZeroGenJnl then
                TempAppliedCustLedgEntry.SetRange(Positive, CurrentAmount < 0);
            if TempAppliedCustLedgEntry.FindFirst() then begin
                ExchangeAmountsOnLedgerEntry(Type, CurrencyCode, TempAppliedCustLedgEntry, PostingDate);

                case Type of
                    Type::Direct:
                        CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscCust(CustLedgEntry, TempAppliedCustLedgEntry, 0, false, false);
                    Type::GenJnlLine:
                        CanUseDisc := PaymentToleranceMgt.CheckCalcPmtDiscGenJnlCust(GenJnlLine2, TempAppliedCustLedgEntry, 0, false)
                    else
                        CanUseDisc := false;
                end;

                if CanUseDisc and
                   (Abs(TempAppliedCustLedgEntry."Amount to Apply") >=
                    Abs(TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible"))
                then
                    if (Abs(CurrentAmount) >
                        Abs(TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible"))
                    then begin
                        PmtDiscAmount += TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                        CurrentAmount += TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                    end else
                        if (Abs(CurrentAmount) =
                            Abs(TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible"))
                        then begin
                            PmtDiscAmount += TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                            CurrentAmount +=
                              TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                            AppliedAmount += CorrectionAmount;
                        end else
                            if FromZeroGenJnl then begin
                                PmtDiscAmount += TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                                CurrentAmount +=
                                  TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                            end else begin
                                PossiblePmtDisc := TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                                RemainingAmountExclDiscounts :=
                                  TempAppliedCustLedgEntry."Remaining Amount" - PossiblePmtDisc - TempAppliedCustLedgEntry."Max. Payment Tolerance";
                                if Abs(CurrentAmount) + Abs(CalcOppositeEntriesAmount(TempAppliedCustLedgEntry)) >=
                                   Abs(RemainingAmountExclDiscounts)
                                then begin
                                    PmtDiscAmount += PossiblePmtDisc;
                                    AppliedAmount += CorrectionAmount;
                                end;
                                CurrentAmount +=
                                  TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Remaining Pmt. Disc. Possible";
                            end
                else begin
                    if ((CurrentAmount + TempAppliedCustLedgEntry."Amount to Apply") * CurrentAmount) <= 0 then
                        AppliedAmount += CorrectionAmount;
                    CurrentAmount += TempAppliedCustLedgEntry."Amount to Apply";
                end
            end else begin
                TempAppliedCustLedgEntry.SetRange(Positive);
                TempAppliedCustLedgEntry.FindFirst();
                ExchangeAmountsOnLedgerEntry(Type, CurrencyCode, TempAppliedCustLedgEntry, PostingDate);
            end;

            if OldPmtDisc <> PmtDiscAmount then
                AppliedAmount += TempAppliedCustLedgEntry."Remaining Amount"
            else
                AppliedAmount += TempAppliedCustLedgEntry."Amount to Apply";
            OldPmtDisc := PmtDiscAmount;

            if PossiblePmtDisc <> 0 then
                CorrectionAmount := TempAppliedCustLedgEntry."Remaining Amount" - TempAppliedCustLedgEntry."Amount to Apply"
            else
                CorrectionAmount := 0;

            if not DifferentCurrenciesInAppln then
                DifferentCurrenciesInAppln := ApplnCurrencyCode <> TempAppliedCustLedgEntry."Currency Code";

            TempAppliedCustLedgEntry.Delete();
            TempAppliedCustLedgEntry.SetRange(Positive);
        until not TempAppliedCustLedgEntry.FindFirst();
        CheckRounding();
    end;

    local procedure LookupOKOnPush()
    begin
        OK := true;
    end;

    local procedure PostDirectApplication(PreviewMode: Boolean)
    var
        CustEntryApplyPostedEntries: Codeunit "CustEntry-Apply Posted Entries";
        Applied: Boolean;
        IsHandled: Boolean;
        ApplicationDate: Date;
    begin
        IsHandled := false;
        OnBeforePostDirectApplication(Rec, PreviewMode, IsHandled);
        if IsHandled then
            exit;

        if CalcType = CalcType::Direct then begin
            if ApplyingCustLedgEntry."Entry No." <> 0 then begin
                Rec := ApplyingCustLedgEntry;
                ApplicationDate := CustEntryApplyPostedEntries.GetApplicationDate(Rec);

                OnPostDirectApplicationBeforeSetValues(ApplicationDate);
                /* PostApplication.SetValues(Rec."Document No.", ApplicationDate);
                if ACTION::OK = PostApplication.RunModal() then begin
                    PostApplication.GetValues(NewDocumentNo, NewApplicationDate);
                    if NewApplicationDate < ApplicationDate then
                        Error(Text013, Rec.FieldCaption("Posting Date"), Rec.TableCaption);
                end else
                    Error(Text019); */

                /* OnPostDirectApplicationBeforeApply();
                if PreviewMode then
                    CustEntryApplyPostedEntries.PreviewApply(Rec, NewDocumentNo, NewApplicationDate)
                else
                    Applied := CustEntryApplyPostedEntries.Apply(Rec, NewDocumentNo, NewApplicationDate); */

                if (not PreviewMode) and Applied then begin
                    Message(Text012);
                    PostingDone := true;
                    CurrPage.Close();
                end;
            end else
                Error(Text002);
        end else
            Error(Text003);
    end;

    local procedure RecalcApplnAmount()
    begin
        CurrPage.Update(true);
        CalcApplnAmount();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcApplnAmount(CustLedgerEntry: Record "Cust. Ledger Entry"; var AppliedAmount: Decimal; var ApplyingAmount: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcApplnAmountToApply(CustLedgerEntry: Record "Cust. Ledger Entry"; var ApplnAmountToApply: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterCalcApplnRemainingAmount(CustLedgerEntry: Record "Cust. Ledger Entry"; var ApplnRemainingAmount: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterExchangeAmountsOnLedgerEntry(var CalcCustLedgEntry: Record "Cust. Ledger Entry"; CustLedgerEntry: Record "Cust. Ledger Entry"; CurrencyCode: Code[10])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeCalcApplnAmount(var CustLedgerEntry: Record "Cust. Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header"; var AppliedCustLedgerEntry: Record "Cust. Ledger Entry"; CalculationType: Option; ApplicationType: Option)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeEarlierPostingDateError(ApplyingCustLedgerEntry: Record "Cust. Ledger Entry"; CustLedgerEntry: Record "Cust. Ledger Entry"; var RaiseError: Boolean; CalcType: Option)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeHandledChosenEntries(Type: Option Direct,GenJnlLine,SalesHeader; CurrentAmount: Decimal; CurrencyCode: Code[10]; PostingDate: Date; var AppliedCustLedgerEntry: Record "Cust. Ledger Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforePostDirectApplication(var CustLedgerEntry: Record "Cust. Ledger Entry"; PreviewMode: Boolean; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeSetApplyingCustLedgEntry(var ApplyingCustLedgEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line"; SalesHeader: Record "Sales Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnFindFindApplyingEntryOnAfterCustLedgEntrySetFilters(ApplyingCustLedgerEntry: Record "Cust. Ledger Entry"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostDirectApplicationBeforeApply()
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostDirectApplicationBeforeSetValues(var ApplicationDate: Date)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnSetCustApplIdAfterCheckAgainstApplnCurrency(var CustLedgerEntry: Record "Cust. Ledger Entry"; CalcType: Option; GenJnlLine: Record "Gen. Journal Line")
    begin
    end;
}
