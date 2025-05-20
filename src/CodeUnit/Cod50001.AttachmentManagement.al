codeunit 50001 "Attachment Management"
{
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure DocumentAttachmentOnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        Requisition: Record "Requisition Header";
        Establishment: Record "Company Jobs";
        Applicants: Record Applicant;
        // RecruitmentPlan: Record "Recruitment Plan";
        // ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan";
        // JobRequisition: Record "Job Requisition";
        // StaffOrientations: Record "Staff Orientations";
        // LeavePlan: Record "Leave Plan";
        Leave: Record "Employee Leave Application";
        LeaveAdjustment: Record "Leave Adjustment Header";
        // LeaveRecall: Record "Leave Recall";
        // EmployeeExit: Record "Employee Exit";
        // PettyCash: Record "Petty Cash Header";
        // PaymentRequest: Record "Payment Request Header";
        Imprest: Record "Imprest Header";
    begin
        case DocumentAttachment."Table ID" of //**********Finance**********
        DATABASE::"Requisition Header": begin
            RecRef.Open(DATABASE::"Requisition Header");
            if Requisition.Get(DocumentAttachment."No.")then begin
                RecRef.GetTable(Requisition);
            end;
        end;
        DATABASE::"Company Jobs": begin
            RecRef.Open(DATABASE::"Company Jobs");
            if Establishment.Get(DocumentAttachment."No.")then RecRef.GetTable(Establishment);
        end;
        DATABASE::Applicant: begin
            RecRef.Open(DATABASE::Applicant);
            if Applicants.Get(DocumentAttachment."No.")then RecRef.GetTable(Applicants);
        end;
        // DATABASE::"Recruitment Plan":
        //     begin
        //         RecRef.Open(DATABASE::"Recruitment Plan");
        //         if RecruitmentPlan.Get(DocumentAttachment."No.") then
        //             RecRef.GetTable(RecruitmentPlan);
        //     end;
        // DATABASE::"Consolidated Recruitment Plan":
        //     begin
        //         RecRef.Open(DATABASE::"Consolidated Recruitment Plan");
        //         if ConsolidatedRecruitmentPlan.Get(DocumentAttachment."No.") then
        //             RecRef.GetTable(ConsolidatedRecruitmentPlan);
        //     end;
        // DATABASE::"Job Requisition":
        //     begin
        //         RecRef.Open(DATABASE::"Job Requisition");
        //         if JobRequisition.Get(DocumentAttachment."No.") then
        //             RecRef.GetTable(JobRequisition);
        //     end;
        // DATABASE::"Staff Orientations":
        //     begin
        //         RecRef.Open(DATABASE::"Staff Orientations");
        //         if StaffOrientations.Get(DocumentAttachment."No.") then
        //             RecRef.GetTable(StaffOrientations);
        //     end;
        // DATABASE::"Leave Plan":
        //     begin
        //         RecRef.Open(DATABASE::"Leave Plan");
        //         if LeavePlan.Get(DocumentAttachment."No.") then
        //             RecRef.GetTable(LeavePlan);
        //     end;
        DATABASE::"Employee Leave Application": begin
            RecRef.Open(DATABASE::"Employee Leave Application");
            if Leave.Get(DocumentAttachment."No.")then RecRef.GetTable(Leave);
        end;
        DATABASE::"Leave Adjustment Header": begin
            RecRef.Open(DATABASE::"Leave Adjustment Header");
            if Leave.Get(DocumentAttachment."No.")then RecRef.GetTable(Leave);
        end;
        // DATABASE::"Leave Recall":
        //     begin
        //         RecRef.Open(DATABASE::"Leave Recall");
        //         if LeaveRecall.Get(DocumentAttachment."No.") then
        //             RecRef.GetTable(LeaveRecall);
        //     end;
        // DATABASE::"Employee Exit":
        //     begin
        //         RecRef.Open(DATABASE::"Employee Exit");
        //         if EmployeeExit.Get(DocumentAttachment."No.") then
        //             RecRef.GetTable(EmployeeExit);
        //     end;
        // DATABASE::"Petty Cash Header":
        //     begin
        //         RecRef.Open(DATABASE::"Petty Cash Header");
        //         if PettyCash.Get(DocumentAttachment."No.") then
        //             RecRef.GetTable(PettyCash);
        //     end;
        // DATABASE::"Payment Request Header":
        //     begin
        //         RecRef.Open(DATABASE::"Payment Request Header");
        //         if PaymentRequest.Get(DocumentAttachment."No.") then
        //             RecRef.GetTable(PaymentRequest);
        //end;
        DATABASE::"Imprest Header": begin
            RecRef.Open(DATABASE::"Imprest Header");
            if Imprest.Get(DocumentAttachment."No.")then RecRef.GetTable(Imprest);
        end;
        // DATABASE::"Pr Employee Change Header":
        //     begin
        //         RecRef.Open(DATABASE::"Pr Employee Change Header");
        //         if PayChangeHeader.Get(DocumentAttachment."No.") then
        //             RecRef.GetTable(PayChangeHeader);
        //     end;
        end;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure DocumentAtachmentOnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        LineNo: Integer;
    begin
        case RecRef.Number of Database::"Requisition Header", Database::"Company Jobs", Database::Applicant, // Database::"Recruitment Plan",
        // Database::"Consolidated Recruitment Plan",
        // Database::"Job Requisition",
        // Database::"Staff Orientations",
        // Database::"Leave Plan",
        // Database::"Employee Leave Application",
        // Database::"Leave Recall",
        // Database::"Employee Exit",
        // Database::"Petty Cash Header",
        // Database::"Payment Request Header",
        Database::"Imprest Header": begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
            DocumentAttachment.SetRange("No.", RecNo);
        end;
        Database::"Employee Leave Application": begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
            DocumentAttachment.SetRange("No.", RecNo);
        end;
        Database::"Leave Adjustment Header": begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
            DocumentAttachment.SetRange("No.", RecNo);
        end;
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnAfterInitFieldsFromRecRef', '', false, false)]
    local procedure DocAttachmentOnAfterInitFieldsFromRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        DocType: Option Quote, "Order", Invoice, "Credit Memo", "Blanket Order", "Return Order";
        LineNo: Integer;
    begin
        DocumentAttachment.Validate("Table ID", RecRef.Number);
        case RecRef.Number of Database::"Requisition Header", Database::"Company Jobs", Database::Applicant, // Database::"Recruitment Plan",
        // Database::"Consolidated Recruitment Plan",
        // Database::"Job Requisition",
        // Database::"Staff Orientations",
        // Database::"Leave Plan",
        // Database::"Leave Applications",
        // Database::"Leave Recall",
        // Database::"Employee Exit",
        // Database::"Petty Cash Header",
        // Database::"Payment Request Header",
        Database::"Imprest Header": begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;
        Database::"Employee Leave Application": begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;
        Database::"Leave Adjustment Header": begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
            DocumentAttachment.Validate("No.", RecNo);
        end;
        end;
    end;
    procedure UploadPortalFilePath(RecordID: RecordID; FileName: Text[250]; FileExtension: Text[30]; CreatedBy: Code[50]; FilePath: Text[250]): Boolean var
        DocumentAttachment: Record "Document Attachment";
        Users: Record User;
        RecRef: RecordRef;
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        RecRef:=RecordID.GetRecord;
        case RecRef.Number of Database::"Requisition Header", Database::"Company Jobs", Database::Applicant, // Database::"Recruitment Plan",
        // Database::"Consolidated Recruitment Plan",
        // Database::"Job Requisition",
        // Database::"Staff Orientations",
        // Database::"Leave Plan",
        // Database::"Leave Applications",
        // Database::"Leave Recall",
        // Database::"Employee Exit",
        // Database::"Petty Cash Header",
        // Database::"Payment Request Header",
        Database::"Imprest Header": begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
        end;
        Database::"Employee Leave Application": begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
        end;
        Database::"Leave Adjustment Header": begin
            FieldRef:=RecRef.Field(1);
            RecNo:=FieldRef.Value;
        end;
        end;
        Users.Reset();
        Users.SetRange("User Name", CreatedBy);
        if Users.FindFirst then;
        DocumentAttachment.Init();
        DocumentAttachment.ID:=LastDocumentAttachmentNo.ID + 1;
        DocumentAttachment."Line No.":=LastDocumentAttachmentNo."Line No." + 1;
        DocumentAttachment."Table ID":=RecordID.TableNo;
        DocumentAttachment."No.":=RecNo;
        DocumentAttachment."Attached Date":=CurrentDateTime;
        DocumentAttachment."File Name":=FileName;
        DocumentAttachment.Validate("File Extension", FileExtension);
        DocumentAttachment."Portal File Path":=FilePath;
        DocumentAttachment."Attached By":=Users."User Security ID";
        DocumentAttachment.User:=CreatedBy;
        DocumentAttachment."Document Reference ID":=LastDocumentAttachmentNo."Document Reference ID";
        if DocumentAttachment.Insert then exit(true);
    end;
    local procedure LastDocumentAttachmentNo(): Record "Document Attachment" var
        DocumentAttachment: Record "Document Attachment";
    begin
        DocumentAttachment.Reset();
        DocumentAttachment.SetCurrentKey(ID);
        DocumentAttachment.SetAscending(ID, false);
        if DocumentAttachment.FindFirst()then exit(DocumentAttachment);
    end;
}
