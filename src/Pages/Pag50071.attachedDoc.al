page 52971 "Attached Document"
{
    // version BUDGET
    Caption = 'Attached Document';
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "SharePoint Intergration";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Uploaded On"; Rec.LocalUrl)
                {
                    ApplicationArea = All;
                }
                field("Uploaded By"; Rec.SP_URL_Returned)
                {
                    ApplicationArea = All;
                }



            }
        }
    }

    actions
    {
        area(processing)
        {



            action(Preview)
            {
                ApplicationArea = All;
                Caption = 'Download';
                Image = Download;
                Enabled = DownloadEnabled;
                Scope = Repeater;
                ToolTip = 'Download the file to your device. Depending on the file, you will need an app to view or edit the file.';

                trigger OnAction()
                begin
                    // if Rec."File Name" <> '' then
                    //     Rec.Export(true);
                end;
            }
            action(AttachFromEmail)
            {
                ApplicationArea = All;
                Caption = 'Attach from email';
                Image = Email;
                Enabled = EmailHasAttachments;
                Scope = Page;
                ToolTip = 'Attach files directly from email.';
                Visible = IsOfficeAddin;

                trigger OnAction()
                begin
                    InitiateAttachFromEmail();
                end;
            }
            fileuploadaction(AttachmentsUpload)
            {
                ApplicationArea = All;
                Caption = 'Attach files';
                Image = Document;
                Enabled = true;
                Scope = Page;
                ToolTip = 'Upload one or more files';
                Visible = true;
                AllowMultipleFiles = true;

                trigger OnAction(files: List of [FileUpload])
                var
                    DocumentAttachment: Record "Document Attachment";
                begin
                    DocumentAttachment.SaveAttachment(files, FromRecRef);
                end;
            }
            action(UploadFile)
            {
                ApplicationArea = All;
                Caption = 'Attach a file';
                Image = Document;
                Enabled = true;
                Scope = Page;
                ToolTip = 'Upload one file';
                Visible = IsOfficeAddin;

                trigger OnAction()
                begin
                    InitiateUploadFile();
                end;
            }
        }
        area(Promoted)
        {
            actionref(Preview_Promoted; Preview)
            {
            }

            actionref(AttachFromEmail_Promoted; AttachFromEmail)
            {
            }
            actionref(UploadFile_Promoted; UploadFile)
            {
            }
            actionref(AttachMultipleFiles_Promoted; AttachmentsUpload)
            {
            }
        }



    }


    trigger OnInit()
    begin
        FlowFieldsEditable := true;
        IsOfficeAddin := OfficeMgmt.IsAvailable();

        if IsOfficeAddin then
            // EmailHasAttachments := OfficeHostMgmt.EmailHasAttachments()
            //else
            EmailHasAttachments := false;
    end;

    trigger OnAfterGetCurrRecord()
    var
        SelectedDocumentAttachment: Record "Document Attachment";
        DocumentSharing: Codeunit "Document Sharing";
    begin
        CurrPage.SetSelectionFilter(SelectedDocumentAttachment);
        IsMultiSelect := SelectedDocumentAttachment.Count() > 1;
        if OfficeMgmt.IsAvailable() or OfficeMgmt.IsPopOut() then begin
            ShareOptionsVisible := false;
            ShareEditOptionVisible := false;
            // end else begin
            //     ShareOptionsVisible := (Rec.HasContent()) and (DocumentSharing.ShareEnabled());
            //     ShareEditOptionVisible := DocumentSharing.EditEnabledForFile('.' + Rec."File Extension");
        end;
        // DownloadEnabled := Rec.HasContent() and (not IsMultiSelect);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // Rec."File Name" := SelectFileTxt;
    end;

    var
        OfficeMgmt: Codeunit "Office Management";
        OfficeHostMgmt: Codeunit "Office Host Management";
        SalesDocumentFlow, ServiceDocumentFlow : Boolean;
        FileDialogTxt: Label 'Attachments (%1)|%1', Comment = '%1=file types, such as *.txt or *.docx';
        FilterTxt: Label '*.jpg;*.jpeg;*.bmp;*.png;*.gif;*.tiff;*.tif;*.pdf;*.docx;*.doc;*.xlsx;*.xls;*.pptx;*.ppt;*.msg;*.xml;*.*', Locked = true;
        ImportTxt: Label 'Attach a document.';
        SelectFileTxt: Label 'Attach a file';
        PurchaseDocumentFlow: Boolean;
        ShareOptionsVisible: Boolean;
        ShareEditOptionVisible: Boolean;
        DownloadEnabled: Boolean;
        FlowFieldsEditable: Boolean;
        EmailHasAttachments: Boolean;
        IsOfficeAddin: Boolean;
        IsMultiSelect: Boolean;
        FlowToPurchTxt: Label 'Flow to Purch. Trx';
        FlowToSalesTxt: Label 'Flow to Sales Trx';
        FlowToServiceTxt: Label 'Flow to Service Trx';
        MenuOptionsTxt: Label 'Attach from email,Upload file', Comment = 'Comma seperated phrases must be translated seperately.';
        SelectInstructionTxt: Label 'Choose the files to attach.';

    protected var
        FromRecRef: RecordRef;

    local procedure InitiateAttachFromEmail()
    begin
        OfficeMgmt.InitiateSendToAttachments(FromRecRef);
        CurrPage.Update(true);
    end;

    local procedure InitiateUploadFile()
    var
        DocumentAttachment: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
    begin
        ImportWithFilter(TempBlob, FileName);
        if FileName <> '' then
            DocumentAttachment.SaveAttachment(FromRecRef, FileName, TempBlob);
        CurrPage.Update(true);
    end;

    local procedure GetCaptionClass(FieldNo: Integer): Text
    begin
        if SalesDocumentFlow and PurchaseDocumentFlow and ServiceDocumentFlow then
            case FieldNo of
                9:
                    exit(FlowToPurchTxt);
                11:
                    exit(FlowToSalesTxt);
                13:
                    exit(FlowToServiceTxt);
            end;
    end;

    procedure OpenForRecRef(RecRef: RecordRef)
    var
        DocumentAttachmentMgmt: Codeunit "Document Attachment Mgmt";
    begin
        Rec.Reset();

        FromRecRef := RecRef;

        // SalesDocumentFlow := DocumentAttachmentMgmt.IsSalesDocumentFlow(RecRef.Number);
        // PurchaseDocumentFlow := DocumentAttachmentMgmt.IsPurchaseDocumentFlow(RecRef.Number);
        // ServiceDocumentFlow := DocumentAttachmentMgmt.IsServiceDocumentFlow(RecRef.Number);
        // FlowFieldsEditable := DocumentAttachmentMgmt.IsFlowFieldsEditable(RecRef.Number);

        // DocumentAttachmentMgmt.SetDocumentAttachmentFiltersForRecRefInternal(Rec, RecRef, false);

        // OnAfterOpenForRecRef(Rec, RecRef, FlowFieldsEditable);
    end;

    local procedure ImportWithFilter(var TempBlob: Codeunit "Temp Blob"; var FileName: Text)
    var
        FileManagement: Codeunit "File Management";
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeImportWithFilter(TempBlob, FileName, IsHandled, FromRecRef);
        if IsHandled then
            exit;

        FileName := FileManagement.BLOBImportWithFilter(
            TempBlob, ImportTxt, FileName, StrSubstNo(FileDialogTxt, FilterTxt), FilterTxt);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeImportWithFilter(var TempBlob: Codeunit "Temp Blob"; var FileName: Text; var IsHandled: Boolean; RecRef: RecordRef)
    begin
    end;


}