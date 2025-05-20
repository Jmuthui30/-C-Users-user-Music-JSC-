codeunit 51428 "Page Management Ext"
{
    trigger OnRun()
    begin
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
    local Procedure OnAfterGetPageID(RecordRef: RecordRef; var PageId: Integer)
    begin
        if PageId = 0 then PageId:=GetConditionalCardPageID(RecordRef);
    end;
    local procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer begin
        case RecordRef.Number of //**********************THL - BASIC FINANCE MODULE CUSTOMIZATIONS***********************
        //1. Payment Voucher
        DATABASE::"PV Header": exit(PAGE::"Payment Voucher");
        //**********************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS***********************
        //1. Petty Cash
        DATABASE::"Expense Claim Header": exit(PAGE::"Petty Cash Header");
        //2. Imprest
        DATABASE::"Imprest Header": exit(GetImprestHeaderPageID(RecordRef));
        //
        //2. Imprest
        DATABASE::"Imprest Memo Header": exit(PAGE::"Imprest Memo Header");
        //
        //2. Imprest Payroll Claims
        DATABASE::"Imprest Payroll Claims Header": exit(PAGE::"Imprest Payroll Claim Header");
        //
        // 4. Request For Payment
        DATABASE::"Request for Payment": exit(PAGE::"Payment Requests");
        //5. Supplementary Budget Request
        DATABASE::"Supplementary Budget Request": exit(PAGE::"Supplementary Budget Request");
        //
        //6. Staff Based Budget
        DATABASE::"Staff Based Budget Header": exit(PAGE::"Staff Based Budget Header");
        //
        //**********************THL - PROCUREMENT MODULE CUSTOMIZATIONS***********************
        //1. Requisition
        DATABASE::"Requisition Header": exit(PAGE::"Requisition Header-Pe");
        // 
        //2. Vendor Registarion Request
        DATABASE::"Vendor Reg. Request": exit(PAGE::"Vendor Reg Request");
        //
        //Ibrahim Wasiu
        //3. Procurement Plan
        Database::"Procurement Plan Header": exit(page::"Procurement Plan Header");
        //
        //4. Repair Requisition
        Database::"Repair Header": exit(page::"Repair Requisition Header");
        //
        //5. Work Ticket
        Database::"Work Ticket Header": exit(page::"Work Ticket Header-Open");
        //
        //6. RFQ
        Database::"RFQ Header": exit(page::"RFQ Header");
        //7. Bal Score Card
        DATABASE::"Bal Score Card Header": exit(GetBalScoreCardHeaderPageID(RecordRef));
        //
        //End: Ibrahim Wasiu
        //**********************THL - HR MODULE CUSTOMIZATIONS***********************
        //1. Leave Application
        DATABASE::"Employee Leave Application": exit(PAGE::"Leave Application-Approval");
        //
        //2. Appraisal
        DATABASE::"Performance Appraisal": exit(PAGE::"Appraisal Card - Approval");
        //
        //3. Orientation
        DATABASE::"Staff Orientation Header": exit(PAGE::"Orientation Header-Approval");
        //
        //4. Medical Claim
        DATABASE::"Medical Claim": exit(PAGE::"Medical Claim - Approval");
        //
        //5. CSR
        DATABASE::"Staff CSR": exit(PAGE::"CSR Card - Approval");
        //
        //6. Training
        DATABASE::"Staff Training Header": exit(PAGE::"Training Card - Approval");
        //
        //7. Training Needs
        DATABASE::"Training Needs Header": exit(PAGE::"Training Needs Header Approval");
        //8. Leave Adjustment
        DATABASE::"Leave Adjustment Header": exit(PAGE::"Leave Adjustment Card");
        //
        //9. Recruitment Plan
        DATABASE::"Recruitment Plan": exit(PAGE::"Recruitment Plan");
        //
        //10. ConsolidatedcRecruitment Plan
        DATABASE::"Consolidated Recruitment Plan": exit(PAGE::"Consolidated Recruitment Plan");
        //
        //10. Company Establishment
        DATABASE::"Company Jobs": exit(PAGE::"Company Jobs");
        //
        //11. Recruitment Need
        DATABASE::"Recruitment Needs": exit(PAGE::"Create New Recruitment Req.");
        //
        //**********************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS***********************
        //
        //1. Job Worksheet
        DATABASE::"Worksheet Requisitions Lines": exit(PAGE::"Worksheet Requisition-Approval");
        //
        //2. Service Worksheet
        DATABASE::"Service Item Line": exit(PAGE::"Service Item Worksheet - App");
        //
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
    local procedure OnAfterGetListPageID(RecordRef: RecordRef; var PageId: Integer)
    begin
        begin
            if PageId = 0 then PageId:=GetConditionalListPageID(RecordRef);
        end;
    end;
    local procedure GetConditionalListPageID(RecRef: RecordRef): Integer begin
        case RecRef.Number of end;
    end;
    local procedure GetImprestHeaderPageID(RecRef: RecordRef): Integer var
        ImprestHeader: Record "Imprest Header";
    begin
        RecRef.SetTable(ImprestHeader);
        case ImprestHeader."Staff Claim" of ImprestHeader."Staff Claim" = false: if ImprestHeader.Type = ImprestHeader.Type::Request then exit(PAGE::"Imprest")
            else if ImprestHeader.Type = ImprestHeader.Type::Surrender then exit(PAGE::"Imprest Surrender");
        ImprestHeader."Staff Claim" = true: exit(PAGE::"Staff Claim");
        end;
    end;
    local procedure GetBalScoreCardHeaderPageID(RecRef: RecordRef): Integer var
        BalScoreCard: Record "Bal Score Card Header";
    begin
        RecRef.SetTable(BalScoreCard);
        case BalScoreCard."Document Type" of BalScoreCard."Document Type"::Planning: exit(PAGE::"Bal Planning Score Card");
        BalScoreCard."Document Type"::Appraisal: exit(PAGE::"Bal Appraisal Score Card");
        end;
    end;
}
