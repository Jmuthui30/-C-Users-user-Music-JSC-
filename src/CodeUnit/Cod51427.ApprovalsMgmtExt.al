codeunit 51427 "Approvals Mgmt. Ext"
{
    trigger OnRun()
    begin
    end;
    var ApprovalMgnt: Codeunit "Approvals Mgmt.";
    //#region Approval Methods
    local procedure "*****************THL - BASIC FINANCE MODULE CUSTOMIZATIONS*********************"()
    begin
    end;
    local procedure "***********************Payment Voucher******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendPVForApproval(var PV: Record "PV Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelPVApprovalRequest(var PV: Record "PV Header")
    begin
    end;
    local procedure "*****************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS*********************"()
    begin
    end;
    local procedure "***********************Petty Cash******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendPettyCashForApproval(var PettyCash: Record "Expense Claim Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelPettyCashApprovalRequest(var PettyCash: Record "Expense Claim Header")
    begin
    end;
    local procedure "***********************Imprest******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendImprestForApproval(var Imprest: Record "Imprest Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelImprestApprovalRequest(var Imprest: Record "Imprest Header")
    begin
    end;
    local procedure "***********************Imprest Memo******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendImprestMemoForApproval(var ImprestMemo: Record "Imprest Memo Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelImprestMemoApprovalRequest(var ImprestMemo: Record "Imprest Memo Header")
    begin
    end;
    local procedure "***********************Imprest Payroll Claim******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendImprestPayrollClaimForApproval(var ImprestPayrollClaim: Record "Imprest Payroll Claims Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelImprestPayrollClaimApprovalRequest(var ImprestPayrollClaim: Record "Imprest Payroll Claims Header")
    begin
    end;
    local procedure "***********************Request For Payement Request******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendRequestForPaymentForApproval(var RequestForPayment: Record "Request for Payment")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelRequestForPaymentApprovalRequest(var RequestForPayment: Record "Request for Payment")
    begin
    end;
    local procedure "***********************Supplementary Budget Request******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendSupplementaryBudgetForApproval(var SupplementaryBudget: Record "Supplementary Budget Request")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelSupplementaryBudgetApprovalRequest(var SupplementaryBudget: Record "Supplementary Budget Request")
    begin
    end;
    local procedure "***********************Staff Based Budget******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendStaffBasedBudgetForApproval(var StaffBasedBudget: Record "Staff Based Budget Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelStaffBasedBudgetApprovalRequest(var StaffBasedBudget: Record "Staff Based Budget Header")
    begin
    end;
    local procedure "*****************THL - PROCUREMENT MODULE CUSTOMIZATIONS*********************"()
    begin
    end;
    local procedure "***********************Requisitions******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendRequisitionForApproval(var Requisition: Record "Requisition Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelRequisitionApprovalRequest(var Requisition: Record "Requisition Header")
    begin
    end;
    local procedure "***********************Vendor Reg Request******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendVendorRegForApproval(var VendorReg: Record "Vendor Reg. Request")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelVendorRegApprovalRequest(var VendorReg: Record "Vendor Reg. Request")
    begin
    end;
    //Ibrahim Wasiu
    local procedure "***********************Procurement Plans******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendProcurePlanForApproval(var ProcurePlan: Record "Procurement Plan Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelProcurePlanApprovalRequest(var ProcurePlan: Record "Procurement Plan Header")
    begin
    end;
    //
    local procedure "***********************Repair Requisitions******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendRepairRequestForApproval(var RepairRequest: Record "Repair Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelRepairRequestApprovalRequest(var RepairRequest: Record "Repair Header")
    begin
    end;
    local procedure "***********************Work Ticket******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendWorkTForApproval(var WorkT: Record "Work Ticket Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelWorkTApprovalRequest(var WorkT: Record "Work Ticket Header")
    begin
    end;
    //
    local procedure "***********************RFQ Header******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendRFQForApproval(var RFQ: Record "RFQ Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelRFQApprovalRequest(var RFQ: Record "RFQ Header")
    begin
    end;
    //End: Ibrahim Wasiu
    //
    local procedure "*********************** Bal Score Card Request******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendBalScoreCardForApproval(var BalScoreCard: Record "Bal Score Card Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelBalScoreCardApprovalRequest(var BalScoreCard: Record "Bal Score Card Header")
    begin
    end;
    //
    local procedure "*****************THL - HR MODULE CUSTOMIZATIONS*********************"()
    begin
    end;
    local procedure "***********************Leave Application******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendLeaveForApproval(var Leave: Record "Employee Leave Application")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveApprovalRequest(var Leave: Record "Employee Leave Application")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnsendLeaveAdjustmentForApproval(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveAdjustmentApprovalRequest(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
    end;
    local procedure "***********************Appraisal******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendAppraisalForApproval(var Appraisal: Record "Performance Appraisal")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelAppraisalApprovalRequest(var Appraisal: Record "Performance Appraisal")
    begin
    end;
    // Addition
    [IntegrationEvent(false, false)]
    local procedure "***********************Orientation Checklist******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendOrientationForApproval(var Orientation: Record "Staff Orientation Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelOrientationApprovalRequest(var Orientation: Record "Staff Orientation Header")
    begin
    end;
    local procedure "***********************Medical Claim******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendClaimForApproval(var Claim: Record "Medical Claim")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelClaimApprovalRequest(var Claim: Record "Medical Claim")
    begin
    end;
    local procedure "***********************CSR******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendCSRForApproval(var CSR: Record "Staff CSR")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelCSRApprovalRequest(var CSR: Record "Staff CSR")
    begin
    end;
    local procedure "***********************Training******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendTrainingForApproval(var Training: Record "Staff Training Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelTraininigApprovalRequest(var Training: Record "Staff Training Header")
    begin
    end;
    local procedure "***********************Training Needs******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendTrainingNeedsForApproval(var TrainingNeeds: Record "Training Needs Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelTraininigNeedsApprovalRequest(var TrainingNeeds: Record "Training Needs Header")
    begin
    end;
    local procedure "***********************Recruitment Request******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendRecruitmentForApproval(var Recruitment: Record "Recruitment Request")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelRecruitmentApprovalRequest(var Recruitment: Record "Recruitment Request")
    begin
    end;
    local procedure "***********************Employee Leave Plan Request******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendLeavePlanForApproval(var LeavePlan: Record "Employee Leave Plan Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelLeavePlanApprovalRequest(var LeavePlan: Record "Employee Leave Plan Header")
    begin
    end;
    local procedure "***********************Employee Appraisal Objectives Request******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendAppraisalObjectiveForApproval(var EmpObjectives: Record "Employee Appraisal Objectives")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelAppraisalObjectiveApprovalRequest(var EmpObjectives: Record "Employee Appraisal Objectives")
    begin
    end;
    local procedure "*********************** Govt. Employee Appraisal Request******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendEmployeeAppraisalForApproval(var EmpAppraisal: Record "Employee Appraisals")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelEmployeeAppraisalApprovalRequest(var EmpAppraisal: Record "Employee Appraisals")
    begin
    end;
    local procedure "***********************Recruitment Plan******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendRecruitmentPlanForApproval(var RecruitmentPlan: Record "Recruitment Plan")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelRecruitmentPlanApprovalRequest(var RecruitmentPlan: Record "Recruitment Plan")
    begin
    end;
    //endofPlan
    //ConsolidatedRecruitmentplan
    local procedure "*****************************Consolidated Recruitment Plan*******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendConsolidatedRecruitmentPlanForApproval(var ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelConsolidatedRecruitmentPlanApprovalRequest(var ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan")
    begin
    end;
    local procedure "***************************Company Establishment*************************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendCompanyEstablishmentForApproval(var CompanyEstablishment: Record "Company Jobs")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelCompanyEstablishmentApprovalRequest(var CompanyEstablishment: Record "Company Jobs")
    begin
    end;
    local procedure "***********************Recruitment Need******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendRecruitmentNeedForApproval(var RecruitmentNeed: Record "Recruitment Needs")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelRecruitmentNeedApprovalRequest(var RecruitmentNeed: Record "Recruitment Needs")
    begin
    end;
    local procedure "*****************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS*********************"()
    begin
    end;
    local procedure "***********************Job Worksheet Request******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendJobWorksheetForApproval(var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelJobWorksheetApprovalRequest(var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    begin
    end;
    local procedure "***********************Service Worksheet Request******************************************"()
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnSendServiceWorkSheetForApproval(var ServiceLine: Record "Service Line")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnCancelServiceWorkSheetApprovalRequest(var ServiceLine: Record "Service Line")
    begin
    end;
    //#endregion
    //#region SetStatusToPending
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure SetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
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
        WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines";
        ServiceLine: Record "Service Line";
        LeavePlan: Record "Employee Leave Plan Header";
        EmpObjectives: Record "Employee Appraisal Objectives";
        EmpAppraisal: Record "Employee Appraisals";
        RecruitmentPlan: Record "Recruitment Plan";
        ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan";
        CompanyEstablishment: Record "Company Jobs";
        RecruitmentNeed: Record "Recruitment Needs";
        ImprestMemo: Record "Imprest Memo Header";
        ImprestPayrollClaim: Record "Imprest Payroll Claims Header";
    begin
        case RecRef.Number of //***********************THL - BASIC FINANCE MODULE CUSTOMIZATIONS***************************
        //1. Payment Voucher
        DATABASE::"PV Header": begin
            RecRef.SetTable(PV);
            PV.Validate(Status, PV.Status::"Pending Approval");
            PV.Modify(true);
            IsHandled:=true;
        end;
        //
        //***********************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS***************************
        //2. Petty Cash
        DATABASE::"Expense Claim Header": begin
            RecRef.SetTable(PettyCash);
            PettyCash.Validate(Status, PettyCash.Status::"Pending Approval");
            PettyCash.Modify(true);
            IsHandled:=true;
        end;
        //3. Imprest
        DATABASE::"Imprest Header": begin
            RecRef.SetTable(Imprest);
            Imprest.Validate(Status, Imprest.Status::"Pending Approval");
            Imprest.Modify(true);
            IsHandled:=true;
        end;
        //
        //3. Imprest Memo
        DATABASE::"Imprest Memo Header": begin
            RecRef.SetTable(ImprestMemo);
            ImprestMemo.Validate(Status, Imprest.Status::"Pending Approval");
            ImprestMemo.Modify(true);
            IsHandled:=true;
        end;
        //
        //3. Imprest Payroll Claims
        DATABASE::"Imprest Payroll Claims Header": begin
            RecRef.SetTable(ImprestPayrollClaim);
            ImprestPayrollClaim.Validate(Status, Imprest.Status::"Pending Approval");
            ImprestPayrollClaim.Modify(true);
            IsHandled:=true;
        end;
        //
        //4. Request For Payment
        DATABASE::"Request for Payment": begin
            RecRef.SetTable(RequestForPayment);
            RequestForPayment.Validate(Status, RequestForPayment.Status::"Pending Approval");
            RequestForPayment.Modify(true);
            IsHandled:=true;
        end;
        // 
        //5. Supplementary Budget Request
        DATABASE::"Supplementary Budget Request": begin
            RecRef.SetTable(SupplementaryBudget);
            SupplementaryBudget.Validate(Status, SupplementaryBudget.Status::"Pending Approval");
            SupplementaryBudget.Modify(true);
            IsHandled:=true;
        end;
        // 
        //6. Staff Based Budget
        DATABASE::"Staff Based Budget Header": begin
            RecRef.SetTable(StaffBasedBudget);
            StaffBasedBudget.Validate(Status, StaffBasedBudget.Status::"Pending Approval");
            StaffBasedBudget.Modify(true);
            IsHandled:=true;
        end;
        //
        //***********************THL - REQUISITION MODULE CUSTOMIZATIONS***************************
        //1. Requisition
        DATABASE::"Requisition Header": begin
            RecRef.SetTable(Requisition);
            Requisition.Validate(Status, Requisition.Status::"Pending Approval");
            Requisition.Modify(true);
            IsHandled:=true;
        end;
        // 
        //2. Vendor Reg. Request
        DATABASE::"Vendor Reg. Request": begin
            RecRef.SetTable(VendorReg);
            VendorReg.Validate(Status, VendorReg.Status::"Pending Approval");
            VendorReg.Modify(true);
            IsHandled:=true;
        end;
        //
        //Ibrahim Wasiu
        //3. Procurement Plan
        Database::"Procurement Plan Header": begin
            RecRef.SetTable(ProcurePlan);
            ProcurePlan.Validate(Status, ProcurePlan.Status::"Pending Approval");
            ProcurePlan.Modify(true);
            IsHandled:=true;
        end;
        //
        //4. Repair Requisition
        Database::"Repair Header": begin
            RecRef.SetTable(RepairRequest);
            RepairRequest.Validate(Status, RepairRequest.Status::"Pending Approval");
            RepairRequest.Modify(true);
            IsHandled:=true;
        end;
        //
        //5. Work Ticket
        Database::"Work Ticket Header": begin
            RecRef.SetTable(WorkT);
            WorkT.Validate(Status, WorkT.Status::"Pending Approval");
            WorkT.Modify(true);
            IsHandled:=true;
        end;
        //
        //6. RFQ 
        Database::"RFQ Header": begin
            RecRef.SetTable(RFQ);
            RFQ.Validate(Status, RFQ.Status::"Pending Approval");
            RFQ.Modify(true);
            IsHandled:=true;
        end;
        //
        //7. Balance Score Card
        Database::"Bal Score Card Header": begin
            RecRef.SetTable(BalScoreCard);
            BalScoreCard.Validate(Status, BalScoreCard.Status::"Pending Approval");
            BalScoreCard.Modify(true);
            IsHandled:=true;
        end;
        //End: Ibrahim Wasiu
        //***********************THL - HR MODULE CUSTOMIZATIONS***************************
        //1. Leave
        DATABASE::"Employee Leave Application": begin
            RecRef.SetTable(Leave);
            Leave.Validate(Status, Leave.Status::"Pending Approval");
            Leave.Modify(true);
            IsHandled:=true;
        end;
        //
        //2. Appraisal
        DATABASE::"Performance Appraisal": begin
            RecRef.SetTable(Appraisal);
            Appraisal.Validate(Status, Appraisal.Status::"Pending Approval");
            Appraisal.Modify(true);
            IsHandled:=true;
        end;
        //
        //3. Orientation
        DATABASE::"Staff Orientation Header": begin
            RecRef.SetTable(Orientation);
            Orientation.Validate(Status, Orientation.Status::"Pending Approval");
            Orientation.Modify(true);
            IsHandled:=true;
        end;
        //
        //4. Medical Claim
        DATABASE::"Medical Claim": begin
            RecRef.SetTable(Claim);
            Claim.Validate(Status, Claim.Status::"Pending Approval");
            Claim.Modify(true);
            IsHandled:=true;
        end;
        //
        //5. Employee CSR
        DATABASE::"Staff CSR": begin
            RecRef.SetTable(CSR);
            CSR.Validate(Status, CSR.Status::"Pending Approval");
            CSR.Modify(true);
            IsHandled:=true;
        end;
        //
        //6. Training
        DATABASE::"Staff Training Header": begin
            RecRef.SetTable(Training);
            Training.Validate(Status, Training.Status::"Pending Approval");
            Training.Modify(true);
            IsHandled:=true;
        end;
        //
        //7. Training Needs
        DATABASE::"Training Needs Header": begin
            RecRef.SetTable(TrainingNeeds);
            TrainingNeeds.Validate(Status, TrainingNeeds.Status::"Pending Approval");
            TrainingNeeds.Modify(true);
            IsHandled:=true;
        end;
        //
        //8. Recruitment
        DATABASE::"Recruitment Request": begin
            RecRef.SetTable(Recruitment);
            Recruitment.Validate(Status, Recruitment.Status::"Pending Approval");
            Recruitment.Modify(true);
            IsHandled:=true;
        end;
        //
        //9. Employee Leave Plan
        DATABASE::"Employee Leave Plan Header": begin
            RecRef.SetTable(LeavePlan);
            LeavePlan.Validate(Status, LeavePlan.Status::"Pending Approval");
            LeavePlan.Modify(true);
            IsHandled:=true;
        end;
        //
        //10. Govt. Employee Appraisal Objectives
        DATABASE::"Employee Appraisal Objectives": begin
            RecRef.SetTable(EmpObjectives);
            EmpObjectives.Validate(Status, EmpObjectives.Status::"Pending Approval");
            EmpObjectives.Modify(true);
            IsHandled:=true;
        end;
        //
        //11. Govt. Employee Appraisal
        DATABASE::"Employee Appraisals": begin
            RecRef.SetTable(EmpAppraisal);
            EmpAppraisal.Validate(Status, EmpAppraisal.Status::"Pending Approval");
            EmpAppraisal.Modify(true);
            IsHandled:=true;
        end;
        //12. Leave Adjustment
        DATABASE::"Leave Adjustment Header": begin
            RecRef.SetTable(LeaveAdjust);
            LeaveAdjust.Validate(Status, LeaveAdjust.Status::"Pending Approval");
            LeaveAdjust.Modify(true);
            IsHandled:=true;
        end;
        //13. Recruitment Plan
        DATABASE::"Recruitment Plan": begin
            RecRef.SetTable(RecruitmentPlan);
            RecruitmentPlan.Validate(Status, RecruitmentPlan.Status::"Pending Approval");
            RecruitmentPlan.Modify(true);
            IsHandled:=true;
        end;
        //14. Consolidated Recruitment Plan
        DATABASE::"Consolidated Recruitment Plan": begin
            RecRef.SetTable(ConsolidatedRecruitmentPlan);
            ConsolidatedRecruitmentPlan.Validate(Status, ConsolidatedRecruitmentPlan.Status::"Pending Approval");
            ConsolidatedRecruitmentPlan.Modify(true);
            IsHandled:=true;
        end;
        //15. Company Establishments
        DATABASE::"Company Jobs": begin
            RecRef.SetTable(CompanyEstablishment);
            CompanyEstablishment.Validate(Status, CompanyEstablishment.Status::"Pending Approval");
            CompanyEstablishment.Modify(true);
            IsHandled:=true;
        end;
        //16. Recruitment Need
        DATABASE::"Recruitment Needs": begin
            RecRef.SetTable(RecruitmentNeed);
            RecruitmentNeed.Validate(Status, RecruitmentNeed.Status::"Pending Approval");
            RecruitmentNeed.Modify(true);
            IsHandled:=true;
        end;
        //
        //***********************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS***************************
        //1. Job Worksheet
        DATABASE::"Worksheet Requisitions Lines": begin
            RecRef.SetTable(WorksheetRequisitionsLines);
            WorksheetRequisitionsLines.Validate(Status, WorksheetRequisitionsLines.Status::"Pending Approval");
            WorksheetRequisitionsLines.Modify(true);
            IsHandled:=true;
        end;
        //2. Service Worksheet
        DATABASE::"Service Line": begin
            RecRef.SetTable(ServiceLine);
            ServiceLine.VALIDATE(Status, ServiceLine.Status::"Pending Approval");
            ServiceLine.Modify(true);
            IsHandled:=true;
        end;
        //
        end;
    end;
    //#endregion
    //#region PopulateApprovalEntryArgument
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    /// <summary> 
    /// Description for PopulateApprovalEntryArgument.
    /// </summary>
    /// <param name="RecRef">Parameter of type RecordRef.</param>
    /// <param name="ApprovalEntryArgument">Parameter of type Record "Approval Entry".</param>
    local procedure PopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry")
    var
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
        RecruitmentPlan: Record "Recruitment Plan";
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
        LeavePlan: Record "Employee Leave Plan Header";
        EmpObjectives: Record "Employee Appraisal Objectives";
        EmpAppraisal: Record "Employee Appraisals";
        WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines";
        ServiceLine: Record "Service Line";
        ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan";
        CompanyEstablishment: Record "Company Jobs";
        RecruitmentNeed: Record "Recruitment Needs";
        ImprestMemo: Record "Imprest Memo Header";
        ImprestPayrollClaim: Record "Imprest Payroll Claims Header";
    begin
        case RecRef.Number of //**********************THL - BASIC FINANCE MODULE CUSTOMIZATIONS**************************
        //1. Payment Voucher
        DATABASE::"PV Header": BEGIN
            PV.CALCFIELDS("Total Amount");
            RecRef.SETTABLE(PV);
            ApprovalEntryArgument."Document No.":=PV."No.";
            ApprovalEntryArgument.Amount:=PV."Total Amount";
            ApprovalEntryArgument."Amount (LCY)":=PV."Total Amount";
            ApprovalEntryArgument."Currency Code":=PV.Currency;
        END;
        //
        //**********************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS**************************
        //1. Petty Cash
        DATABASE::"Expense Claim Header": BEGIN
            PettyCash.CALCFIELDS("Total Amount");
            RecRef.SETTABLE(PettyCash);
            ApprovalEntryArgument."Document No.":=PettyCash."No.";
            ApprovalEntryArgument.Amount:=PettyCash."Total Amount";
            ApprovalEntryArgument."Amount (LCY)":=PettyCash."Total Amount";
        END;
        //
        //2. Imprest
        DATABASE::"Imprest Header": BEGIN
            Imprest.CALCFIELDS("Total Request Amount");
            Imprest.CALCFIELDS("Total Surrender Amount");
            RecRef.SETTABLE(Imprest);
            ApprovalEntryArgument."Document No.":=Imprest."No.";
            if Imprest.Type = Imprest.Type::Request then begin
                ApprovalEntryArgument.Amount:=Imprest."Total Request Amount";
                ApprovalEntryArgument."Amount (LCY)":=Imprest."Total Request Amount";
            end
            else if Imprest.Type = Imprest.Type::Surrender then begin
                    ApprovalEntryArgument.Amount:=Imprest."Total Surrender Amount";
                    ApprovalEntryArgument."Amount (LCY)":=Imprest."Total Surrender Amount";
                end;
        END;
        //
        //2. Imprest Memo
        DATABASE::"Imprest Memo Header": BEGIN
            ImprestMemo.CALCFIELDS("Total Amount");
            RecRef.SETTABLE(ImprestMemo);
            ApprovalEntryArgument."Document No.":=ImprestMemo."No.";
            ApprovalEntryArgument.Amount:=ImprestMemo."Total Amount";
            ApprovalEntryArgument."Amount (LCY)":=ImprestMemo."Total Amount";
        END;
        //
        //2. Imprest Payroll Claims
        DATABASE::"Imprest Payroll Claims Header": BEGIN
            RecRef.SETTABLE(ImprestPayrollClaim);
            ApprovalEntryArgument."Document No.":=ImprestPayrollClaim."No.";
        // ApprovalEntryArgument.Amount := ImprestPayrollClaim."Total Amount";
        // ApprovalEntryArgument."Amount (LCY)" := ImprestPayrollClaim."Total Amount";
        END;
        //
        //4. Request For Payment
        DATABASE::"Request for Payment": BEGIN
            RequestForPayment.CalcFields(Amount);
            RecRef.SETTABLE(RequestForPayment);
            ApprovalEntryArgument."Document No.":=RequestForPayment."No.";
            ApprovalEntryArgument.Amount:=RequestForPayment.Amount;
            ApprovalEntryArgument."Amount (LCY)":=RequestForPayment.Amount;
        END;
        //
        //5. Supplementary Budget Request
        DATABASE::"Supplementary Budget Request": BEGIN
            SupplementaryBudget.CalcFields(Amount);
            RecRef.SETTABLE(SupplementaryBudget);
            ApprovalEntryArgument."Document No.":=SupplementaryBudget."No.";
            ApprovalEntryArgument.Amount:=SupplementaryBudget.Amount;
            ApprovalEntryArgument."Amount (LCY)":=SupplementaryBudget.Amount;
        END;
        //
        //6. Staff Based Budget
        DATABASE::"Staff Based Budget Header": BEGIN
            StaffBasedBudget.CalcFields(Amount);
            RecRef.SETTABLE(StaffBasedBudget);
            ApprovalEntryArgument."Document No.":=StaffBasedBudget."No.";
            ApprovalEntryArgument.Amount:=StaffBasedBudget.Amount;
            ApprovalEntryArgument."Amount (LCY)":=StaffBasedBudget.Amount;
        END;
        //
        //**********************THL - PROCUREMENT MODULE CUSTOMIZATIONS**************************
        //1. Requisition
        DATABASE::"Requisition Header": BEGIN
            RecRef.SETTABLE(Requisition);
            ApprovalEntryArgument."Document No.":=Requisition."No.";
        END;
        //
        //2. Vendor Reg. Request 
        DATABASE::"Vendor Reg. Request": BEGIN
            RecRef.SETTABLE(VendorReg);
            ApprovalEntryArgument."Document No.":=VendorReg."No.";
        END;
        //
        //Ibrahim Wasiu
        //3. Procurement Plan
        DATABASE::"Procurement Plan Header": BEGIN
            RecRef.SETTABLE(ProcurePlan);
            ApprovalEntryArgument."Document No.":=ProcurePlan."No.";
        END;
        //
        //4. Repair Requisition
        DATABASE::"Repair Header": BEGIN
            RecRef.SETTABLE(RepairRequest);
            ApprovalEntryArgument."Document No.":=RepairRequest."No.";
        END;
        //
        //5. Work Ticket
        DATABASE::"Work Ticket Header": BEGIN
            RecRef.SETTABLE(WorkT);
            ApprovalEntryArgument."Document No.":=WorkT."No.";
        END;
        //
        //6. RFQ
        DATABASE::"RFQ Header": BEGIN
            RecRef.SETTABLE(RFQ);
            ApprovalEntryArgument."Document No.":=RFQ.No;
        END;
        //
        //6. Balance Score Card
        DATABASE::"Bal Score Card Header": BEGIN
            RecRef.SETTABLE(BalScoreCard);
            ApprovalEntryArgument."Document No.":=BalScoreCard."No.";
        END;
        //End: Ibrahim Wasiu
        //***********************THL - HR MODULE CUSTOMIZATIONS***************************
        //1. Leave
        DATABASE::"Employee Leave Application": begin
            RecRef.SETTABLE(Leave);
            ApprovalEntryArgument."Document No.":=Leave."Application No";
        end;
        //
        //2. Appraisal
        DATABASE::"Performance Appraisal": begin
            RecRef.SETTABLE(Appraisal);
            ApprovalEntryArgument."Document No.":=Appraisal."No.";
        end;
        //
        //3. Medical Claim
        DATABASE::"Medical Claim": begin
            Claim.CALCFIELDS("Claim Amount");
            RecRef.SETTABLE(Claim);
            ApprovalEntryArgument."Document No.":=Claim."No.";
            ApprovalEntryArgument.Amount:=Claim."Claim Amount";
            ApprovalEntryArgument."Amount (LCY)":=Claim."Claim Amount";
        end;
        //
        //4. Employee CSR
        DATABASE::"Staff CSR": begin
            RecRef.SETTABLE(CSR);
            ApprovalEntryArgument."Document No.":=CSR."No.";
        end;
        //
        //5. Training
        DATABASE::"Staff Training Header": begin
            RecRef.SetTable(Training);
            ApprovalEntryArgument."Document No.":=Training."No.";
        end;
        //
        //6. Training Needs
        DATABASE::"Training Needs Header": begin
            RecRef.SetTable(TrainingNeeds);
            ApprovalEntryArgument."Document No.":=TrainingNeeds."No.";
        end;
        //
        //7. Recruitment
        DATABASE::"Recruitment Request": begin
            RecRef.SetTable(Recruitment);
            ApprovalEntryArgument."Document No.":=Recruitment."No.";
        end;
        //
        //8. Employee Leave Plan
        DATABASE::"Employee Leave Plan Header": begin
            RecRef.SetTable(LeavePlan);
            ApprovalEntryArgument."Document No.":=LeavePlan."Application No";
        end;
        //9. Leave Adjustment
        DATABASE::"Leave Adjustment Header": begin
            RecRef.SETTABLE(LeaveAdjust);
            ApprovalEntryArgument."Document No.":=LeaveAdjust."Leave Adjustments No.";
        end;
        //13. Recruitment Plan
        DATABASE::"Recruitment Plan": begin
            RecRef.SETTABLE(RecruitmentPlan);
            ApprovalEntryArgument."Document No.":=RecruitmentPlan."No.";
        end;
        //14. Consolidated Recruitment Plan
        DATABASE::"Consolidated Recruitment Plan": begin
            RecRef.SETTABLE(ConsolidatedRecruitmentPlan);
            ApprovalEntryArgument."Document No.":=ConsolidatedRecruitmentPlan."No.";
        end;
        //15. Company Establishments
        DATABASE::"Company Jobs": begin
            RecRef.SETTABLE(CompanyEstablishment);
            ApprovalEntryArgument."Document No.":=CompanyEstablishment."Job ID";
        end;
        //
        //16. Recruitment Need
        DATABASE::"Recruitment Needs": begin
            RecRef.SETTABLE(RecruitmentNeed);
            ApprovalEntryArgument."Document No.":=RecruitmentNeed."No.";
        end;
        //
        //**********************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS**************************
        //1. Job Worksheet
        DATABASE::"Worksheet Requisitions Lines": BEGIN
            RecRef.SETTABLE(WorksheetRequisitionsLines);
            ApprovalEntryArgument."Document No.":=WorksheetRequisitionsLines."Job No.";
            ApprovalEntryArgument.Amount:=WorksheetRequisitionsLines."Line Amount";
            ApprovalEntryArgument."Amount (LCY)":=WorksheetRequisitionsLines."Line Amount";
        END;
        //
        //2. Service Worksheet
        DATABASE::"Service Line": BEGIN
            RecRef.SETTABLE(ServiceLine);
            ApprovalEntryArgument."Document No.":=ServiceLine."Document No.";
            ApprovalEntryArgument.Amount:=ServiceLine.Amount;
            ApprovalEntryArgument."Amount (LCY)":=ServiceLine.Amount;
        END;
        // 
        //
        end;
    end;
    //#endregion
    //#region ShowApprovalComments
    //[EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'GetApprovalComment', '', true, true)]
    local procedure ShowApprovalComments(Variant: Variant; WorkflowStepInstanceID: Guid)
    var
        ApprovalCommentLine: Record "Approval Comment Line";
        ApprovalEntry: Record "Approval Entry";
        ApprovalComments: Page "Approval Comments";
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of DATABASE::"Approval Entry": begin
            ApprovalEntry:=Variant;
            RecRef.Get(ApprovalEntry."Record ID to Approve");
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", ApprovalEntry."Record ID to Approve");
        end;
        //****************THL - BASIC FINANCE MODULE CUSTOMIZATIONS**************************
        //1. Payment Voucher
        DATABASE::"PV Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //****************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS**************************
        //1. Petty Cash
        DATABASE::"Expense Claim Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //2. Imprest
        DATABASE::"Imprest Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //2. Imprest Memo
        DATABASE::"Imprest Memo Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //2. Imprest Payroll Claims
        DATABASE::"Imprest Payroll Claims Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //4. Request For Payment
        DATABASE::"Request for Payment": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //5. Supplementary Budget Request
        DATABASE::"Supplementary Budget Request": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        // 
        //5. Staff Based Budget
        DATABASE::"Staff Based Budget Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //****************THL - PROCUREMENT MODULE CUSTOMIZATIONS**************************
        //1. Requisition
        DATABASE::"Requisition Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        // 
        //2. Vendor Reg. Request
        DATABASE::"Vendor Reg. Request": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //Ibrahim Wasiu
        //3. Procurement Plan
        DATABASE::"Procurement Plan Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //4. Repair Requisition
        DATABASE::"Repair Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //5. Work Ticket
        Database::"Work Ticket Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //6. RFQ
        Database::"RFQ Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //6. Balance Score Card
        Database::"Bal Score Card Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //End: Ibrahim Wasiu
        //****************THL - HR MODULE CUSTOMIZATIONS**************************
        //1. Leave Application
        DATABASE::"Employee Leave Application": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //2. Appraisal
        DATABASE::"Performance Appraisal": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //3. Orientation
        DATABASE::"Staff Orientation Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //4. Medical Claim
        DATABASE::"Medical Claim": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //5. Employee CSR
        DATABASE::"Staff CSR": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //6. Training
        DATABASE::"Staff Training Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //7. Training Needs
        DATABASE::"Training Needs Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //8. Recruitment
        DATABASE::"Recruitment Request": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //9. Employee Leave Plan
        DATABASE::"Employee Leave Plan Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //10. Govt. Appraisal Objectives
        DATABASE::"Employee Appraisal Objectives": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //11. Govt. Appraisal
        DATABASE::"Employee Appraisals": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //12. Leave Adjust
        DATABASE::"Leave Adjustment Header": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //13.RecruitmentPlan
        DATABASE::"Recruitment Plan": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //14.Consolidated RecruitmentPlan
        DATABASE::"Consolidated Recruitment Plan": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //15.Company Establishments
        DATABASE::"Company Jobs": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //16.Recruitment Need
        DATABASE::"Recruitment Needs": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //HREND
        //****************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS**************************
        //1. Job Worksheet
        DATABASE::"Worksheet Requisitions Lines": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //2. Service Worksheet
        DATABASE::"Service Line": begin
            ApprovalCommentLine.SetRange("Table ID", RecRef.Number);
            ApprovalCommentLine.SetRange("Record ID to Approve", RecRef.RecordId);
            ApprovalMgnt.FindApprovalEntryForCurrUser(ApprovalEntry, RecRef.RecordId);
        end;
        //
        //
        end;
        if IsNullGuid(WorkflowStepInstanceID) and (not IsNullGuid(ApprovalEntry."Workflow Step Instance ID"))then WorkflowStepInstanceID:=ApprovalEntry."Workflow Step Instance ID";
        ApprovalComments.SetTableView(ApprovalCommentLine);
        ApprovalComments.SetWorkflowStepInstanceID(WorkflowStepInstanceID);
        ApprovalComments.Run;
    end;
//#endregion
}
