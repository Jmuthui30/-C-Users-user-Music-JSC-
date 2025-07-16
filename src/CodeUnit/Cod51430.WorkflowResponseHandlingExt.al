codeunit 51430 "Workflow Response Handling Ext"
{
    trigger OnRun()
    begin
    end;
    //#region AddResponsePredecessor
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure AddResponsePredecessors(ResponseFunctionName: Code[128])
    var
        WorkflowEventHandling: Codeunit "Workflow Event Handling Ext";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    //**********************THL - BASIC FINANCE MODULE CUSTOMIZATIONS****************************
                    //1. Payment Voucher
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendPVForApprovalCode);
                    //
                    //**********************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS****************************
                    //1. Petty Cash
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendPettyCashForApprovalCode);
                    //2. Imprest
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendImprestForApprovalCode);
                    //
                    //2. Imprest Memo
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendImprestMemoForApprovalCode);
                    //
                    //2. Imprest Payroll Claims
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendImprestPayrollClaimForApprovalCode);
                    //
                    //4. Request For Payment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRequestForPaymentForApprovalCode);
                    //
                    //5. Supplementary Budget Request
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendSupplementaryBudgetForApprovalCode);
                    //
                    //6. Staff Based Budget
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendStaffBasedBudgetForApprovalCode);
                    //
                    //**********************THL - PROCUREMENT MODULE CUSTOMIZATIONS****************************
                    //1. Requisition
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRequisitionForApprovalCode);
                    //
                    //2. Vendor Registration Request
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendVendorRegForApprovalCode);
                    //
                    //Ibrahim Wasiu
                    //3. Procurement Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendProcurePlanForApprovalCode);
                    //
                    //4. Repair Requisition
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRepairRequestForApprovalCode);
                    //
                    //5. Work Ticket
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendWorkTForApprovalCode);
                    //
                    //6. RFQ
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRFQForApprovalCode);
                    //
                    //7. Balance Score Card
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendBalScoreCardForApprovalCode);
                    //End: Ibrahim Wasiu
                    //**********************THL - HR MODULE CUSTOMIZATIONS****************************
                    //1. Leave Application
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendLeaveForApprovalCode);
                    //
                    //2. Appraisal
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendAppraisalForApprovalCode);
                    //
                    //3. Orientation
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendOrientationForApprovalCode);
                    //
                    //4. Medical Claim
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendClaimForApprovalCode);
                    //
                    //5. CSR
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendCSRForApprovalCode);
                    //
                    //6. Training
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendTrainingForApprovalCode);
                    //
                    //7. Training Needs
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendTrainingNeedsForApprovalCode);
                    //
                    //8. Recruitment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRecruitmentForApprovalCode);
                    //
                    //9. Leave Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendLeavePlanForApprovalCode);
                    //
                    //10. Govt. Employee Appraisal Objectives
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendEmpObjectivesForApprovalCode);
                    //
                    //11. Govt. Employee Appraisal
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendEmpAppraisalForApprovalCode);
                    //
                    //12. Leave Adjustment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendLeaveAdjustForApprovalCode);
                    //13. Recruitment Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRecruitmentPlanForApprovalCode);
                    //14. Consolidated Recruitment Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendConsolidatedRecruitmentPlanForApprovalCode);
                    //15. Company Establishment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendCompanyEstablishmentForApprovalCode);
                    //16. Recruitment Need
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRecruitmentNeedForApprovalCode);
                    //
                    //**********************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS****************************
                    //
                    //1. Job Worksheet
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendJobWorksheetForApprovalCode);
                    //
                    //2. Service Worksheet
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendServiceWorksheetForApprovalCode);
                    //
                end;
            WorkflowResponseHandling.CreateApprovalRequestsCode:
                begin
                    //**********************THL - BASIC FINANCE MODULE CUSTOMIZATIONS****************************
                    //1. Payment Voucher
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendPVForApprovalCode);
                    //
                    //**********************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS****************************
                    //1. Petty Cash
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendPettyCashForApprovalCode);
                    //2. Imprest
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendImprestForApprovalCode);
                    //
                    //2. Imprest Memo
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendImprestMemoForApprovalCode);
                    //
                    //2. Imprest Payroll Claims
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendImprestPayrollClaimForApprovalCode);
                    //
                    //4. Request For Payment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendRequestForPaymentForApprovalCode);
                    //
                    //5. Supplementary Budget Request
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendSupplementaryBudgetForApprovalCode);
                    // 
                    //6. Staff Based Budget
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendStaffBasedBudgetForApprovalCode);
                    //
                    //**********************THL - PROCUREMENT MODULE CUSTOMIZATIONS****************************
                    //1. Requisition
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendRequisitionForApprovalCode);
                    //  
                    //2. Vendor Registration Request
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendVendorRegForApprovalCode);
                    //
                    //Ibrahim Wasiu
                    //3. Procurement Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendProcurePlanForApprovalCode);
                    //
                    //4. Repair Requisition
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendRepairRequestForApprovalCode);
                    //
                    //5. Work Ticket
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendRFQForApprovalCode);
                    //
                    //6. RFQ
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendRFQForApprovalCode);
                    //
                    //7. Balance Score Card
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendBalScoreCardForApprovalCode);
                    //End: Ibrahim Wasiu
                    //**********************THL - HR MODULE CUSTOMIZATIONS****************************
                    //1. Leave Application
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendLeaveForApprovalCode);
                    //
                    //2. Appraisal
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendAppraisalForApprovalCode);
                    //
                    //3. Orientation
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendOrientationForApprovalCode);
                    //
                    //4. Medical Claim
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendClaimForApprovalCode);
                    //
                    //5. CSR
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendCSRForApprovalCode);
                    //
                    //6. Training
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendTrainingForApprovalCode);
                    //
                    //7. Training Needs
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendTrainingNeedsForApprovalCode);
                    //
                    //8. Recruitment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendRecruitmentForApprovalCode);
                    //
                    //9. Leave Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendLeavePlanForApprovalCode);
                    //
                    //10. Govt. Emp Appraisal Objectives
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendEmpObjectivesForApprovalCode);
                    //
                    //11. Govt. Emp Appraisal
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendEmpAppraisalForApprovalCode);
                    //
                    //12. Leave Adjustment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendLeaveAdjustForApprovalCode);
                    //13. Recruitment Pan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendRecruitmentPlanForApprovalCode);
                    //14. Consolidated Recruitment Pan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendConsolidatedRecruitmentPlanForApprovalCode);
                    //15. Company Establishment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendCompanyEstablishmentForApprovalCode);
                    //16. Recruitment Need
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRecruitmentNeedForApprovalCode);
                    //**********************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS****************************
                    //
                    //1. Job Worksheet
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendJobWorksheetForApprovalCode);
                    //
                    //2. Service Worksheet
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CreateApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnSendServiceWorksheetForApprovalCode);
                end;
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    //*****************************THL - BASIC FINANCE MODULE CUSTOMIZATIONS*************************
                    //1. Payment Voucher
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendPVForApprovalCode);
                    //
                    //*****************************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS*************************
                    //1. Petty Cash
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendPettyCashForApprovalCode);
                    //2. Imprest
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendImprestForApprovalCode);
                    //
                    //2. Imprest Memo
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendImprestMemoForApprovalCode);
                    //
                    //2. Imprest Payroll Claims
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendImprestPayrollClaimForApprovalCode);
                    //
                    //4. Request For Payment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRequestForPaymentForApprovalCode);
                    // 
                    //5. Supplementary Budget Request
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendSupplementaryBudgetForApprovalCode);
                    // 
                    //6. Staff Based Budget
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendStaffBasedBudgetForApprovalCode);
                    //
                    //*****************************THL - PROCUREMENT MODULE CUSTOMIZATIONS*************************
                    //1. Requisition
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRequisitionForApprovalCode);
                    // 
                    //2. Vendor Regiatration Request
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendVendorRegForApprovalCode);
                    //
                    //Ibrahim Wasiu
                    //3. Procurement Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendProcurePlanForApprovalCode);
                    //
                    //4. Repair Requisition
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRepairRequestForApprovalCode);
                    //
                    //5. Work Ticket
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendWorkTForApprovalCode);
                    //
                    //6. RFQ
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRFQForApprovalCode);
                    //
                    //7. Balance ScoreCard
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendBalScoreCardForApprovalCode);
                    //End: Ibrahim Wasiu
                    //*****************************THL - HR MODULE CUSTOMIZATIONS*************************
                    //1. Leave Application
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendLeaveForApprovalCode);
                    //
                    //2. Appraisal
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendAppraisalForApprovalCode);
                    //
                    //3. Orientation
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendOrientationForApprovalCode);
                    //
                    //4. Medical Claim
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendClaimForApprovalCode);
                    //
                    //5. CSR
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendCSRForApprovalCode);
                    //
                    //6. Training
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendTrainingForApprovalCode);
                    //
                    //7. Training Needs
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendTrainingNeedsForApprovalCode);
                    //
                    //8. Recruitment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRecruitmentForApprovalCode);
                    //
                    //9. Leave Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendLeavePlanForApprovalCode);
                    //
                    //10. Govt. Emp Appraisal Objectives
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendEmpObjectivesForApprovalCode);
                    //
                    //11. Govt. Emp Appraisal
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendEmpAppraisalForApprovalCode);
                    //12. Leave Adjustment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendLeaveAdjustForApprovalCode);
                    //13. Recruitment Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRecruitmentPlanForApprovalCode);
                    //14. Consolidated Recruitment Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendConsolidatedRecruitmentPlanForApprovalCode);
                    //15. Company Establishment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendCompanyEstablishmentForApprovalCode);
                    //16. Recruitment Need
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRecruitmentNeedForApprovalCode);
                    //**********************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS****************************
                    //
                    //1. Job Worksheet
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendJobWorksheetForApprovalCode);
                    //
                    //2. Service Worksheet
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendServiceWorksheetForApprovalCode);
                    //
                end;
            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    //*********************************THL - BASIC FINANCE MODULE CUSTOMIZATIONS*************************
                    //1. Payment Voucher
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelPVApprovalRequestCode);
                    //
                    //*********************************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS*************************
                    //1. Petty Cash
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelPettyCashApprovalRequestCode);
                    //2. Imprest
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelImprestApprovalRequestCode);
                    //
                    //2. Imprest Memo
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelImprestMemoApprovalRequestCode);
                    //
                    //2. Imprest Payroll Claims
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelImprestPayrollClaimApprovalRequestCode);
                    //
                    //4. Request For Payment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelRequestForPaymentApprovalRequestCode);
                    //
                    //5. Supplementary Budget Request
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelSupplementaryBudgetApprovalRequestCode);
                    //
                    //6. Staff Based Budget
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelStaffBasedBudgetApprovalRequestCode);
                    //
                    //*********************************THL - PROCUREMENT MODULE CUSTOMIZATIONS*************************
                    //1. Requisition
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelRequisitionApprovalRequestCode);
                    //
                    //2. Vendor Registration Request
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelVendorRegApprovalRequestCode);
                    //
                    //Ibrahim Wasiu
                    //3. Procurement Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelProcurePlanApprovalRequestCode);
                    //
                    //4. Repair Requisition
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelRepairRequestApprovalRequestCode);
                    //
                    //5. Work Ticket
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelWorkTApprovalRequestCode);
                    //
                    //6. RFQ
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelRFQApprovalRequestCode);
                    //
                    //7. Balance Score Card
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelBalScoreCardApprovalRequestCode);
                    //End: Ibrahim Wasiu
                    //*********************************THL - HR MODULE CUSTOMIZATIONS*************************
                    //1. Leave Application
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelLeaveApprovalRequestCode);
                    //
                    //2. Appraisal
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelAppraisalApprovalRequestCode);
                    //
                    //3. Orientation
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelOrientationApprovalRequestCode);
                    //
                    //4. Medical Claim
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelClaimApprovalRequestCode);
                    //
                    //5. CSR
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelCSRApprovalRequestCode);
                    //
                    //6. Training
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelTrainingApprovalRequestCode);
                    //
                    //7. Training Needs
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelTrainingNeedsApprovalRequestCode);
                    //
                    //8. Recruitment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelRecruitmentApprovalRequestCode);
                    //
                    //9. Leave Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelLeavePlanApprovalRequestCode);
                    //
                    //10. Govt. Emp Appraisal Objectives
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelEmpObjectivesApprovalRequestCode);
                    //
                    //11. Govt. Emp Appraisal
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelEmpAppraisalApprovalRequestCode);
                    //
                    //12. Leave Adjustment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelLeaveAdjustApprovalRequestCode);
                    //13. Recruitment Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelRecruitmentPlanApprovalRequestCode);
                    //14. Consolidated Recruitment Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelConsolidatedRecruitmentPlanApprovalRequestCode);
                    //15. Company Establishment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendCompanyEstablishmentForApprovalCode);
                    //16. Recruitment Need
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEventHandling.RunWorkflowOnSendRecruitmentNeedForApprovalCode);
                    //**********************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS****************************
                    //
                    //1. Job Worksheet
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelJobWorksheetApprovalRequestCode);
                    //
                    //2. Service Worksheet
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEventHandling.RunWorkflowOnCancelServiceWorksheetApprovalRequestCode);
                    //
                end;
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    //***************************THL - BASIC FINANCE MODULE CUSTOMIZATIONS******************************
                    //1. Payment Voucher
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelPVApprovalRequestCode);
                    //
                    //***************************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS******************************
                    //1. Petty Cash
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelPettyCashApprovalRequestCode);
                    //2. Imprest
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelImprestApprovalRequestCode);
                    //
                    //2. Imprest Memo
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelImprestMemoApprovalRequestCode);
                    //
                    //2. Imprest Payroll Claims
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelImprestPayrollClaimApprovalRequestCode);
                    //
                    //4. Request For Payment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelRequestForPaymentApprovalRequestCode);
                    //
                    //5. Supplementary Budget Request
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelSupplementaryBudgetApprovalRequestCode);
                    //
                    //6. Staff Based Budget
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelStaffBasedBudgetApprovalRequestCode);
                    //
                    //***************************THL - PROCUREMENT MODULE CUSTOMIZATIONS******************************
                    //1. Requisition
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelRequisitionApprovalRequestCode);
                    // 
                    //2. Vendor Registration Request
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelVendorRegApprovalRequestCode);
                    //                    
                    //3. Procurement Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelProcurePlanApprovalRequestCode);
                    //
                    //4. Repair Requisition
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelRepairRequestApprovalRequestCode);
                    //
                    //5. Work Ticket
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelWorkTApprovalRequestCode);
                    //
                    //6. RFQ
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelRFQApprovalRequestCode);
                    // 
                    //7. Balance Score Card
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelBalScoreCardApprovalRequestCode);
                    //End: Ibrahim Wasiu
                    //***************************THL - HR MODULE CUSTOMIZATIONS******************************
                    //1. Leave Application
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelLeaveApprovalRequestCode);
                    //
                    //2. Appraisal
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelAppraisalApprovalRequestCode);
                    //
                    //3. Orientation
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelOrientationApprovalRequestCode);
                    //
                    //4. Medical Claim
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelClaimApprovalRequestCode);
                    //
                    //5. CSR
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelCSRApprovalRequestCode);
                    //
                    //6. Training
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelTrainingApprovalRequestCode);
                    //
                    //7. Training Needs
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelTrainingNeedsApprovalRequestCode);
                    //
                    //8. Recruitment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelRecruitmentApprovalRequestCode);
                    //
                    //9. Leave Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelLeavePlanApprovalRequestCode);
                    //
                    //10. Govt. Emp Aprraisal Objectives
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelEmpObjectivesApprovalRequestCode);
                    //
                    //11. Govt. Emp Appraisal
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelEmpAppraisalApprovalRequestCode);
                    //
                    //12. Leave Adjustment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelLeaveAdjustApprovalRequestCode);
                    //13. Recruitment Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelRecruitmentPlanApprovalRequestCode);
                    //14. Consolidated Recruitment Plan
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelConsolidatedRecruitmentPlanApprovalRequestCode);
                    //15. Company Establishment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelCompanyEstablishmentApprovalRequestCode);
                    //16. Recruitment Need
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelRecruitmentNeedApprovalRequestCode);
                    //**********************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS****************************
                    //
                    //1. Job Worksheet
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelJobWorksheetApprovalRequestCode);
                    //
                    //2. Service Worksheet
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEventHandling.RunWorkflowOnCancelServiceWorksheetApprovalRequestCode);
                    //
                end;
        end;
    end;
    //#endregion
    //#region OnReleaseDocument
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure ReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
        WorkflowWebhookEntry: Record "Workflow Webhook Entry";
        TargetRecRef: RecordRef;
        PV: Record "PV Header";
        PettyCash: Record "Expense Claim Header";
        Imprest: Record "Imprest Header";
        RequestForPayment: Record "Request for Payment";
        SupplementaryBudget: Record "Supplementary Budget Request";
        StaffBasedBudget: Record "Staff Based Budget Header";
        Requisition: Record "Requisition Header";
        VendorReg: Record "Vendor Reg. Request";
        ProcurePlan: Record "Procurement Plan Header";
        RepairRequest: Record "Repair Header";
        RFQ: Record "RFQ Header";
        WorkT: Record "Work Ticket Header";
        BalScoreCard: Record "Bal Score Card Header";
        Leave: Record "Employee Leave Application";
        LeaveAdjust: Record "Leave Adjustment Header";
        Appraisal: Record "Performance Appraisal";
        Orientation: Record "Staff Orientation Header";
        Claim: Record "Medical Claim";
        CSR: Record "Staff CSR";
        Training: Record "Staff Training Header";
        TrainingNeeds: Record "Training Needs Header";
        Recruitment: Record "Recruitment Request";
        RecruitmentPlan: Record "Recruitment Plan";
        JobWorksheet: Record "Worksheet Requisitions Lines";
        ServiceWorksheet: Record "Service Line";
        LeavePlan: Record "Employee Leave Plan Header";
        GovtEmpObjectives: Record "Employee Appraisal Objectives";
        GovtEmpAppraisal: Record "Employee Appraisals";
        ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan";
        CompanyEstablishment: Record "Company Jobs";
        RecruitmentNeed: Record "Recruitment Needs";
        ImprestMemo: Record "Imprest Memo Header";
        ImprestPayrollClaim: Record "Imprest Payroll Claims Header";
    begin
        case RecRef.Number of //*******************THL - BASIC FINANCE MODULE CUSTOMIZATIONS**********************
                              //1. Payment Voucher
            DATABASE::"PV Header":
                begin
                    RecRef.SetTable(PV);
                    PV.Validate(Status, PV.Status::Released);
                    PV.Modify;
                    Handled := true;
                end;
            //
            //*******************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS**********************
            //1. Petty Cash
            DATABASE::"Expense Claim Header":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Validate(Status, PettyCash.Status::Released);
                    PettyCash.Modify;
                    Handled := true;
                end;
            //2. Imprest
            DATABASE::"Imprest Header":
                begin
                    RecRef.SetTable(Imprest);
                    Imprest.Validate(Status, Imprest.Status::Released);
                    Imprest.Modify;
                    Handled := true;
                end;
            //
            //2. Imprest Memo
            DATABASE::"Imprest Memo Header":
                begin
                    RecRef.SetTable(ImprestMemo);
                    ImprestMemo.Validate(Status, Imprest.Status::Released);
                    ImprestMemo.Modify;
                    Handled := true;
                end;
            //
            //2. Imprest Payroll Claims
            DATABASE::"Imprest Payroll Claims Header":
                begin
                    RecRef.SetTable(ImprestPayrollClaim);
                    ImprestPayrollClaim.Validate(Status, Imprest.Status::Released);
                    ImprestPayrollClaim.Modify;
                    Handled := true;
                end;
            //
            //4. Request For Payment
            DATABASE::"Request for Payment":
                begin
                    RecRef.SetTable(RequestForPayment);
                    RequestForPayment.Validate(Status, RequestForPayment.Status::Released);
                    RequestForPayment.Modify;
                    Handled := true;
                end;
            //
            //5. Supplementary Budget Request
            DATABASE::"Supplementary Budget Request":
                begin
                    RecRef.SetTable(SupplementaryBudget);
                    SupplementaryBudget.Validate(Status, SupplementaryBudget.Status::Released);
                    SupplementaryBudget.Modify;
                    Handled := true;
                end;
            // 
            //6. Staff Based Budget
            DATABASE::"Staff Based Budget Header":
                begin
                    RecRef.SetTable(StaffBasedBudget);
                    StaffBasedBudget.Validate(Status, StaffBasedBudget.Status::Released);
                    StaffBasedBudget.Modify;
                    Handled := true;
                end;
            //
            //*******************THL - PROCUREMENT MODULE CUSTOMIZATIONS**********************
            //1. Requisition
            DATABASE::"Requisition Header":
                begin
                    RecRef.SetTable(Requisition);
                    Requisition.Validate(Status, Requisition.Status::Released);
                    Requisition.Modify;
                    Handled := true;
                end;
            // 
            //2. Vendor Registration Request
            DATABASE::"Vendor Reg. Request":
                begin
                    RecRef.SetTable(VendorReg);
                    VendorReg.Validate(Status, VendorReg.Status::Released);
                    VendorReg.Modify;
                    Handled := true;
                end;
            //
            //Ibrahim Wasiu
            //3. Procurement Plan
            DATABASE::"Procurement Plan Header":
                begin
                    RecRef.SetTable(ProcurePlan);
                    ProcurePlan.Validate(Status, ProcurePlan.Status::Released);
                    ProcurePlan.Modify;
                    Handled := true;
                end;
            //
            //4. Repair Requisition
            DATABASE::"Repair Header":
                begin
                    RecRef.SetTable(RepairRequest);
                    RepairRequest.Validate(Status, RepairRequest.Status::Released);
                    RepairRequest.Modify;
                    Handled := true;
                end;
            //
            //5. Work Ticket
            DATABASE::"Work Ticket Header":
                begin
                    RecRef.SetTable(WorkT);
                    WorkT.Validate(Status, WorkT.Status::Released);
                    WorkT.Modify;
                    Handled := true;
                end;
            //
            //6. RFQ
            DATABASE::"RFQ Header":
                begin
                    RecRef.SetTable(RFQ);
                    RFQ.Validate(Status, RFQ.Status::Released);
                    RFQ.Modify;
                    Handled := true;
                end;
            // 
            //7. Balance Score Card
            DATABASE::"Bal Score Card Header":
                begin
                    RecRef.SetTable(BalScoreCard);
                    BalScoreCard.Validate(Status, BalScoreCard.Status::Released);
                    BalScoreCard.Modify;
                    Handled := true;
                end;
            //End: Ibrahim Wasiu
            //*******************THL - HR MODULE CUSTOMIZATIONS**********************
            //1. Leave Application
            DATABASE::"Employee Leave Application":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::Released);
                    Leave.Modify;
                    Handled := true;
                end;
            //
            //2. Appraisal
            DATABASE::"Performance Appraisal":
                begin
                    RecRef.SetTable(Appraisal);
                    Appraisal.Validate(Status, Appraisal.Status::Released);
                    Appraisal.Modify;
                    Handled := true;
                end;
            //
            //3. Orientation
            DATABASE::"Staff Orientation Header":
                begin
                    RecRef.SetTable(Orientation);
                    Orientation.Validate(Status, Orientation.Status::Released);
                    Orientation.Modify;
                    Handled := true;
                end;
            //
            //4. Medical Claim
            DATABASE::"Medical Claim":
                begin
                    RecRef.SetTable(Claim);
                    Claim.Validate(Status, Claim.Status::Released);
                    Claim.Modify;
                    Handled := true;
                end;
            //
            //5. CSR
            DATABASE::"Staff CSR":
                begin
                    RecRef.SetTable(CSR);
                    CSR.Validate(Status, CSR.Status::Released);
                    CSR.Modify;
                    Handled := true;
                end;
            //
            //6. Training
            DATABASE::"Staff Training Header":
                begin
                    RecRef.SetTable(Training);
                    Training.Validate(Status, Training.Status::Released);
                    Training.Modify;
                    Handled := true;
                end;
            //
            //7. Training Needs
            DATABASE::"Training Needs Header":
                begin
                    RecRef.SetTable(TrainingNeeds);
                    TrainingNeeds.Validate(Status, TrainingNeeds.Status::Released);
                    TrainingNeeds.Modify;
                    Handled := true;
                end;
            //
            //8. Recruitment
            DATABASE::"Recruitment Request":
                begin
                    RecRef.SetTable(Recruitment);
                    Recruitment.Validate(Status, Recruitment.Status::Released);
                    Recruitment.Modify;
                    Handled := true;
                end;
            //
            //9. Leave Plan
            DATABASE::"Employee Leave Plan Header":
                begin
                    RecRef.SetTable(LeavePlan);
                    LeavePlan.Validate(Status, LeavePlan.Status::Released);
                    LeavePlan.Modify;
                    Handled := true;
                end;
            //
            //10. Govt. Emp Appraisal Objectives
            DATABASE::"Employee Appraisal Objectives":
                begin
                    RecRef.SetTable(GovtEmpObjectives);
                    GovtEmpObjectives.Validate(Status, GovtEmpObjectives.Status::Released);
                    GovtEmpObjectives.Modify;
                    Handled := true;
                end;
            //
            //11. Govt. Emp Appraisals
            DATABASE::"Employee Appraisals":
                begin
                    RecRef.SetTable(GovtEmpAppraisal);
                    GovtEmpAppraisal.Validate(Status, GovtEmpAppraisal.Status::Released);
                    GovtEmpAppraisal.Modify;
                    Handled := true;
                end;
            //
            //12. Leave Adjustment
            DATABASE::"Leave Adjustment Header":
                begin
                    RecRef.SetTable(LeaveAdjust);
                    LeaveAdjust.Validate(Status, LeaveAdjust.Status::Approved);
                    LeaveAdjust.Modify;
                    Handled := true;
                end;
            //
            //13. Recruitment Plan
            DATABASE::"Recruitment Plan":
                begin
                    RecRef.SetTable(RecruitmentPlan);
                    RecruitmentPlan.Validate(Status, RecruitmentPlan.Status::Released);
                    RecruitmentPlan.Modify;
                    Handled := true;
                end;
            //14. Consolidated Recruitment Plan
            DATABASE::"Consolidated Recruitment Plan":
                begin
                    RecRef.SetTable(ConsolidatedRecruitmentPlan);
                    ConsolidatedRecruitmentPlan.Validate(Status, ConsolidatedRecruitmentPlan.Status::Released);
                    ConsolidatedRecruitmentPlan.Modify;
                    Handled := true;
                end;
            //15. Company Establishment
            DATABASE::"Company Jobs":
                begin
                    RecRef.SetTable(CompanyEstablishment);
                    CompanyEstablishment.Validate(Status, CompanyEstablishment.Status::Released);
                    CompanyEstablishment.Modify;
                    Handled := true;
                end;
            //16. Recruitment Need
            DATABASE::"Recruitment Needs":
                begin
                    RecRef.SetTable(RecruitmentNeed);
                    RecruitmentNeed.Validate(Status, RecruitmentNeed.Status::Released);
                    RecruitmentNeed.Modify;
                    Handled := true;
                end;
            //
            //**********************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS****************************
            //
            //1. Job Worksheets
            DATABASE::"Worksheet Requisitions Lines":
                begin
                    RecRef.SetTable(JobWorksheet);
                    JobWorksheet.Validate(Status, JobWorksheet.Status::Released);
                    JobWorksheet.Modify;
                    Handled := true;
                end;
            //
            //2. Service Worksheet
            DATABASE::"Service Line":
                begin
                    RecRef.SetTable(ServiceWorksheet);
                    ServiceWorksheet.Validate(Status, ServiceWorksheet.Status::Released);
                    ServiceWorksheet.Modify;
                    Handled := true;
                end;
        //
        end;
    end;
    //#endregion
    //#region OnOpenDocument
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ApprovalEntry: Record "Approval Entry";
        WorkflowWebhookEntry: Record "Workflow Webhook Entry";
        TargetRecRef: RecordRef;
        PV: Record "PV Header";
        PettyCash: Record "Expense Claim Header";
        Imprest: Record "Imprest Header";
        RequestForPayment: Record "Request for Payment";
        SupplementaryBudget: Record "Supplementary Budget Request";
        StaffBasedBudget: Record "Staff Based Budget Header";
        Requisition: Record "Requisition Header";
        VendorReg: Record "Vendor Reg. Request";
        ProcurePlan: Record "Procurement Plan Header";
        RepairRequest: Record "Repair Header";
        RFQ: Record "RFQ Header";
        WorkT: Record "Work Ticket Header";
        BalScoreCard: Record "Bal Score Card Header";
        Leave: Record "Employee Leave Application";
        LeaveAdjust: Record "Leave Adjustment Header";
        Appraisal: Record "Performance Appraisal";
        Orientation: Record "Staff Orientation Header";
        Claim: Record "Medical Claim";
        CSR: Record "Staff CSR";
        Training: Record "Staff Training Header";
        TrainingNeeds: Record "Training Needs Header";
        Recruitment: Record "Recruitment Request";
        JobWorksheet: Record "Worksheet Requisitions Lines";
        ServiceWorksheet: Record "Service Line";
        LeavePlan: Record "Employee Leave Plan Header";
        GovtEmpObjectives: Record "Employee Appraisal Objectives";
        GovtEmpAppraisal: Record "Employee Appraisals";
        RecruitmentPlan: Record "Recruitment Plan";
        ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan";
        CompanyEstablishment: Record "Company Jobs";
        RecruitmentNeed: Record "Recruitment Needs";
        ImprestMemo: Record "Imprest Memo Header";
        ImprestPayrollClaim: Record "Imprest Payroll Claims Header";
    begin
        case RecRef.Number of //***********THL - BASIC FINANCE MODULE CUSTOMIZATIONS*************
                              //1. Payment Voucher
            DATABASE::"PV Header":
                begin
                    RecRef.SetTable(PV);
                    PV.Validate(Status, PV.Status::Open);
                    PV.Modify;
                    Handled := true;
                end;
            //
            //***********THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS*************
            //1. Petty Cash
            DATABASE::"Expense Claim Header":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Validate(Status, PettyCash.Status::Open);
                    PettyCash.Modify;
                    Handled := true;
                end;
            //2. Imprest
            DATABASE::"Imprest Header":
                begin
                    RecRef.SetTable(Imprest);
                    Imprest.Validate(Status, Imprest.Status::Open);
                    Imprest.Modify;
                    Handled := true;
                end;
            //2. Imprest Memo
            DATABASE::"Imprest Memo Header":
                begin
                    RecRef.SetTable(ImprestMemo);
                    ImprestMemo.Validate(Status, Imprest.Status::Open);
                    ImprestMemo.Modify;
                    Handled := true;
                end;
            //2. Imprest Payroll Claims
            DATABASE::"Imprest Payroll Claims Header":
                begin
                    RecRef.SetTable(ImprestPayrollClaim);
                    ImprestPayrollClaim.Validate(Status, Imprest.Status::Open);
                    ImprestPayrollClaim.Modify;
                    Handled := true;
                end;
            //4. Request For Payment
            DATABASE::"Request for Payment":
                begin
                    RecRef.SetTable(RequestForPayment);
                    RequestForPayment.Validate(Status, RequestForPayment.Status::Open);
                    RequestForPayment.Modify;
                    Handled := true;
                end;
            //
            //5. Supplementary Budget Request 
            DATABASE::"Supplementary Budget Request":
                begin
                    RecRef.SetTable(SupplementaryBudget);
                    SupplementaryBudget.Validate(Status, SupplementaryBudget.Status::Open);
                    SupplementaryBudget.Modify;
                    Handled := true;
                end;
            // 
            //6. Staff Based Budget 
            DATABASE::"Staff Based Budget Header":
                begin
                    RecRef.SetTable(StaffBasedBudget);
                    StaffBasedBudget.Validate(Status, StaffBasedBudget.Status::Open);
                    StaffBasedBudget.Modify;
                    Handled := true;
                end;
            //
            //***********THL - PROCUREMENT MODULE CUSTOMIZATIONS*************
            //1. Requisition
            DATABASE::"Requisition Header":
                begin
                    RecRef.SetTable(Requisition);
                    Requisition.Validate(Status, Requisition.Status::Open);
                    Requisition.Modify;
                    Handled := true;
                end;
            // 
            //2. Vendor Registration Request
            DATABASE::"Vendor Reg. Request":
                begin
                    RecRef.SetTable(VendorReg);
                    VendorReg.Validate(Status, VendorReg.Status::Open);
                    VendorReg.Modify;
                    Handled := true;
                end;
            //
            //Ibrahim Wasiu
            //3. Procurement Plan
            DATABASE::"Procurement Plan Header":
                begin
                    RecRef.SetTable(ProcurePlan);
                    ProcurePlan.Validate(Status, ProcurePlan.Status::Open);
                    ProcurePlan.Modify;
                    Handled := true;
                end;
            //
            //4. Repair Requisition
            DATABASE::"Repair Header":
                begin
                    RecRef.SetTable(RepairRequest);
                    RepairRequest.Validate(Status, RepairRequest.Status::Open);
                    RepairRequest.Modify;
                    Handled := true;
                end;
            //
            //5. Work Ticket
            DATABASE::"Work Ticket Header":
                begin
                    RecRef.SetTable(WorkT);
                    WorkT.Validate(Status, WorkT.Status::Open);
                    WorkT.Modify;
                    Handled := true;
                end;
            //
            //6. RFQ
            DATABASE::"RFQ Header":
                begin
                    RecRef.SetTable(RFQ);
                    RFQ.Validate(Status, RFQ.Status::Open);
                    RFQ.Modify;
                    Handled := true;
                end;
            // 
            //7. Bal Score Card
            DATABASE::"Bal Score Card Header":
                begin
                    RecRef.SetTable(BalScoreCard);
                    BalScoreCard.Validate(Status, BalScoreCard.Status::Open);
                    BalScoreCard.Modify;
                    Handled := true;
                end;
            //End: Ibrahim Wasiu
            //***********THL - HR MODULE CUSTOMIZATIONS*************
            //1. Leave Application
            DATABASE::"Employee Leave Application":
                begin
                    RecRef.SetTable(Leave);
                    Leave.Validate(Status, Leave.Status::Open);
                    Leave.Modify;
                    Handled := true;
                end;
            //
            //2. Appraisal
            DATABASE::"Performance Appraisal":
                begin
                    RecRef.SetTable(Appraisal);
                    Appraisal.Validate(Status, Appraisal.Status::Open);
                    Appraisal.Modify;
                    Handled := true;
                end;
            //
            //3. Orientation
            DATABASE::"Staff Orientation Header":
                begin
                    RecRef.SetTable(Orientation);
                    Orientation.Validate(Status, Orientation.Status::Open);
                    Orientation.Modify;
                    Handled := true;
                end;
            //
            //4. Medical Claim
            DATABASE::"Medical Claim":
                begin
                    RecRef.SetTable(Claim);
                    Claim.Validate(Status, Claim.Status::Open);
                    Claim.Modify;
                    Handled := true;
                end;
            //
            //5. CSR
            DATABASE::"Staff CSR":
                begin
                    RecRef.SetTable(CSR);
                    CSR.Validate(Status, CSR.Status::Open);
                    CSR.Modify;
                    Handled := true;
                end;
            //
            //6. Training
            DATABASE::"Staff Training Header":
                begin
                    RecRef.SetTable(Training);
                    Training.Validate(Status, Training.Status::Open);
                    Training.Modify;
                    Handled := true;
                end;
            //
            //7. Training Needs
            DATABASE::"Training Needs Header":
                begin
                    RecRef.SetTable(TrainingNeeds);
                    TrainingNeeds.Validate(Status, TrainingNeeds.Status::Open);
                    TrainingNeeds.Modify;
                    Handled := true;
                end;
            //
            //8. Recruitment
            DATABASE::"Recruitment Request":
                begin
                    RecRef.SetTable(Recruitment);
                    Recruitment.Validate(Status, Recruitment.Status::Open);
                    Recruitment.Modify;
                    Handled := true;
                end;
            //
            //9. Leave Plan
            DATABASE::"Employee Leave Plan Header":
                begin
                    RecRef.SetTable(LeavePlan);
                    LeavePlan.Validate(Status, LeavePlan.Status::Open);
                    LeavePlan.Modify;
                    Handled := true;
                end;
            //
            //10. Govt.Emp Appraisal Objectives
            DATABASE::"Employee Appraisal Objectives":
                begin
                    RecRef.SetTable(GovtEmpObjectives);
                    GovtEmpObjectives.Validate(Status, GovtEmpObjectives.Status::Open);
                    GovtEmpObjectives.Modify;
                    Handled := true;
                end;
            //
            //11. Govt. Emp Appraisals
            DATABASE::"Employee Appraisals":
                begin
                    RecRef.SetTable(GovtEmpAppraisal);
                    GovtEmpAppraisal.Validate(Status, GovtEmpAppraisal.Status::Open);
                    GovtEmpAppraisal.Modify;
                    Handled := true;
                end;
            //12. Leave Adjust
            DATABASE::"Leave Adjustment Header":
                begin
                    RecRef.SetTable(LeaveAdjust);
                    LeaveAdjust.Validate(Status, LeaveAdjust.Status::New);
                    LeaveAdjust.Modify;
                    Handled := true;
                end;
            ////13. RecruitmentPlan
            DATABASE::"Recruitment Plan":
                begin
                    RecRef.SetTable(RecruitmentPlan);
                    RecruitmentPlan.Validate(Status, RecruitmentPlan.Status::Open);
                    RecruitmentPlan.Modify(true);
                    Handled := true;
                end;
            //
            //14. Consolidated RecruitmentPlan
            DATABASE::"Consolidated Recruitment Plan":
                begin
                    RecRef.SetTable(ConsolidatedRecruitmentPlan);
                    ConsolidatedRecruitmentPlan.Validate(Status, ConsolidatedRecruitmentPlan.Status::Open);
                    ConsolidatedRecruitmentPlan.Modify(true);
                    Handled := true;
                end;
            //15. Company Establishment
            DATABASE::"Company Jobs":
                begin
                    RecRef.SetTable(CompanyEstablishment);
                    CompanyEstablishment.Validate(Status, CompanyEstablishment.Status::Open);
                    CompanyEstablishment.Modify(true);
                    Handled := true;
                end;
            //16. Recruitment Need
            DATABASE::"Recruitment Needs":
                begin
                    RecRef.SetTable(RecruitmentNeed);
                    RecruitmentNeed.Validate(Status, RecruitmentNeed.Status::Open);
                    RecruitmentNeed.Modify(true);
                    Handled := true;
                end;
            //
            //**********************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS****************************
            //
            //1. Job Worksheet
            DATABASE::"Worksheet Requisitions Lines":
                begin
                    RecRef.SetTable(JobWorksheet);
                    JobWorksheet.Validate(Status, JobWorksheet.Status::Open);
                    JobWorksheet.Modify;
                    Handled := true;
                end;
            //
            //2. Service Worksheet
            DATABASE::"Service Line":
                begin
                    RecRef.SetTable(ServiceWorksheet);
                    ServiceWorksheet.Validate(Status, ServiceWorksheet.Status::Open);
                    ServiceWorksheet.Modify;
                    Handled := true;
                end;
        //
        end;
    end;
    //#endregion
}
