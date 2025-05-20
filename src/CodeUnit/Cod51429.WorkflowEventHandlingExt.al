codeunit 51429 "Workflow Event Handling Ext"
{
    trigger OnRun()
    begin
        //Ibrahim Wasiu: To write into Table, Workflow Event Handling 
        CreateEventsLibrary();
    end;
    var WorkflowEventHandling: Codeunit "Workflow Event Handling";
    WorkflowManagement: Codeunit "Workflow Management";
    ALApprovalMngt: Codeunit "Approvals Mgmt. Ext";
    //"******THL-BASIC FINANCE MODULE CUSTOMIZATIONS***************": ;
    //"*********Payment Voucher**********": ;
    PVSendForApprovalEventDescTxt: Label 'Approval for a Payment Voucher Requested.';
    CancelPVApprovalRequestEventDescTxt: Label 'Approval request for Payment Voucher Cancelled.';
    PVReleasedEventDescTxt: Label 'A Payment Voucher record has been released.';
    //
    //"******THL- ADVANCED FINANCE MODULE CUSTOMIZATIONS***************": ;
    //"*********Petty Cash**********": ;
    PettyCashSendForApprovalEventDescTxt: Label 'Approval for a Petty Cash Requested.';
    CancelPettyCashApprovalRequestEventDescTxt: Label 'Approval request for Petty Cash Cancelled.';
    PettyCashReleasedEventDescTxt: Label 'A Petty Cash record has been released.';
    //
    //"*********Imprest**********": ;
    ImprestSendForApprovalEventDescTxt: Label 'Approval for an Imprest Requested.';
    CancelImprestApprovalRequestEventDescTxt: Label 'Approval request for Imprest Cancelled.';
    ImprestReleasedEventDescTxt: Label 'An Imprest record has been released.';
    //
    //"*********Imprest Memo**********": ;
    ImprestMemoSendForApprovalEventDescTxt: Label 'Approval for an Imprest Memo Requested.';
    CancelImprestMemoApprovalRequestEventDescTxt: Label 'Approval request for Imprest Memo Cancelled.';
    ImprestMemoReleasedEventDescTxt: Label 'An Imprest Memo record has been released.';
    //
    //"*********Imprest Payroll Claims**********": ;
    ImprestPayrollClaimSendForApprovalEventDescTxt: Label 'Approval for an Imprest Payroll Claims Requested.';
    CancelImprestPayrollClaimApprovalRequestEventDescTxt: Label 'Approval request for Imprest Payroll Claims Cancelled.';
    ImprestPayrollClaimReleasedEventDescTxt: Label 'An Imprest Payroll Claims record has been released.';
    //
    //"*********Request For Payment**********": ;
    RequestForPaymentSendForApprovalEventDescTxt: Label 'Approval for Request For Payment Requested.';
    CancelRequestForPaymentApprovalRequestEventDescTxt: Label 'Approval request for Request For Payment Cancelled.';
    RequestForPaymentReleasedEventDescTxt: Label 'A Request For Payment record has been released.';
    //
    //"*********Supplementary Budget Request**********": ;
    SupplementaryBudgetSendForApprovalEventDescTxt: Label 'Approval for Supplementary Budget Requested.';
    CancelSupplementaryBudgetApprovalRequestEventDescTxt: Label 'Approval request for Supplementary Budget Cancelled.';
    SupplementaryBudgetReleasedEventDescTxt: Label 'A Supplementary Budget record has been released.';
    //
    //"*********Staff Based Budget**********": ;
    StaffBasedBudgetSendForApprovalEventDescTxt: Label 'Approval for Staff Based Budget.';
    CancelStaffBasedBudgetApprovalRequestEventDescTxt: Label 'Approval request for Staff Based Budget Cancelled.';
    StaffBasedBudgetReleasedEventDescTxt: Label 'A Staff Based Budget record has been released.';
    //
    //******THL-PROCUREMENT MODULE CUSTOMIZATIONS***************
    // "*********Requisition**********": ;
    RequisitionSendForApprovalEventDescTxt: Label 'Approval for a Requisition Requested.';
    CancelRequisitionApprovalRequestEventDescTxt: Label 'Approval request for Requisition Cancelled.';
    RequisitionReleasedEventDescTxt: Label 'A Requisition record has been released.';
    //
    // "*********Vendor Registration Request**********": ;
    VendorRegSendForApprovalEventDescTxt: Label 'Approval for a Vendor Registration Requested.';
    CancelVendorRegApprovalRequestEventDescTxt: Label 'Approval request for Vendor Registration Cancelled.';
    VendorRegReleasedEventDescTxt: Label 'A Vendor Registration record has been released.';
    //
    //Ibrahim Wasiu
    // "*********Procurement Plan**********": ;
    ProcurePlanSendForApprovalEventDescTxt: Label 'Approval for a Procurement Plan Requested.';
    CancelProcurePlanApprovalRequestEventDescTxt: Label 'Approval request for Procurement Plan Cancelled.';
    ProcurePlanReleasedEventDescTxt: Label 'A Procurement Plan record has been released.';
    //
    // "*********Repair Requisition**********": ;
    RepairRequestSendForApprovalEventDescTxt: Label 'Approval for a Repair Requisition Requested.';
    CancelRepairRequestApprovalRequestEventDescTxt: Label 'Approval request for Repair Requisition Cancelled.';
    RepairRequestReleasedEventDescTxt: Label 'A Repair Requisition record has been released.';
    //
    //"*********Work Ticket**********": ;
    WorkTSendForApprovalEventDescTxt: Label 'Approval for a Work Ticket Requested.';
    CancelWorkTApprovalRequestEventDescTxt: Label 'Approval request for Work Ticket Cancelled.';
    WorkTReleasedEventDescTxt: Label 'A Work Ticket record has been released.';
    //
    //"***********RFQ Header**************": ;
    RFQSendForApprovalEventDescTxt: Label 'Approval for an RFQ/RFP Requested.';
    CancelRFQApprovalRequestEventDescTxt: Label 'Approval request for RFQ/RFP Cancelled.';
    RFQReleasedEventDescTxt: Label 'An RFQ/RFP record has been released.';
    //
    //"***********Balance Score Card Header**************": ;
    BalScoreCardSendForApprovalEventDescTxt: Label 'Approval for an Balance Score Card Requested.';
    CancelBalScoreCardApprovalRequestEventDescTxt: Label 'Approval request for Balance Score Card Cancelled.';
    BalScoreCardReleasedEventDescTxt: Label 'An Balance Score Card record has been released.';
    //End: Ibrahim Wasiu
    //
    //"******THL-HR MODULE CUSTOMIZATIONS***************": ;
    //"*********Leave Application**********": ;
    LeaveSendForApprovalEventDescTxt: Label 'Approval for a Leave Application Requested.';
    CancelLeaveApprovalRequestEventDescTxt: Label 'Approval request for Leave Application Cancelled.';
    LeaveReleasedEventDescTxt: Label 'A Leave Application record has been released.';
    //
    //"*********Appraisal**********": ;
    AppraisalSendForApprovalEventDescTxt: Label 'Approval for Appraisal Requested.';
    CancelAppraisalApprovalRequestEventDescTxt: Label 'Approval request for Appraisal Cancelled.';
    AppraisalReleasedEventDescTxt: Label 'An Appraisal record has been released.';
    //
    // "*********Orientationl**********": ;
    OrientationSendForApprovalEventDescTxt: Label 'Approval for Orientation Checklist Requested.';
    CancelOrientationApprovalRequestEventDescTxt: Label 'Approval request for Orientation Checklist Cancelled.';
    OrientationReleasedEventDescTxt: Label 'An Orientation Checklist record has been released.';
    //
    //"*********Medical Claim**********": ;
    ClaimSendForApprovalEventDescTxt: Label 'Approval for Medical Claim Requested.';
    CancelClaimApprovalRequestEventDescTxt: Label 'Approval request for Medical Claim Cancelled.';
    ClaimReleasedEventDescTxt: Label 'A Medical Claim record has been released.';
    //
    //"*********CSR**********": ;
    CSRSendForApprovalEventDescTxt: Label 'Approval for CSR Requested.';
    CancelCSRApprovalRequestEventDescTxt: Label 'Approval request for CSR Cancelled.';
    CSRReleasedEventDescTxt: Label 'A CSR record has been released.';
    //
    //"*********Training**********": ;
    TrainingSendForApprovalEventDescTxt: Label 'Approval for Traning Requested.';
    CancelTrainingApprovalRequestEventDescTxt: Label 'Approval request for Training Cancelled.';
    TrainingReleasedEventDescTxt: Label 'A Training record has been released.';
    //
    //"*********Training Needs**********": ;
    TrainingNeedsSendForApprovalEventDescTxt: Label 'Approval for Traning Needs Requested.';
    CancelTrainingNeedsApprovalRequestEventDescTxt: Label 'Approval request for Training Needs Cancelled.';
    TrainingNeedsReleasedEventDescTxt: Label 'A Training Needs record has been released.';
    //
    //"*********Recruitment Request**********": ;
    RecruitmentSendForApprovalEventDescTxt: Label 'Approval for Recruitment Requested.';
    CancelRecruitmentApprovalRequestEventDescTxt: Label 'Approval request for Recruitment Cancelled.';
    RecruitmentReleasedEventDescTxt: Label 'A Recruitment record has been released.';
    //
    //"*********Leave Plan Request**********": ;
    LeavePlanSendForApprovalEventDescTxt: Label 'Approval for Leave Plan Requested.';
    CancelLeavePlanApprovalRequestEventDescTxt: Label 'Approval request for Leave Plan Cancelled.';
    LeavePlanReleasedEventDescTxt: Label 'A Leave Plan record has been released.';
    //
    //"*********Govt. Emp Objectives Request**********": ;
    EmpObjectivesSendForApprovalEventDescTxt: Label 'Approval for Employee Appraisal Objectives Requested.';
    CancelEmpObjectivesApprovalRequestEventDescTxt: Label 'Approval request for Employee Appraisal Objectives Cancelled.';
    EmpObjectivesReleasedEventDescTxt: Label 'Employee Appraisal Objectives record has been released.';
    //
    //"*********Govt. EmpAppraisal Request**********": ;
    EmpApraisalSendForApprovalEventDescTxt: Label 'Approval for Employee Appraisal Requested.';
    CancelEmpApraisalApprovalRequestEventDescTxt: Label 'Approval request for Employee Appraisal Cancelled.';
    EmpApraisalReleasedEventDescTxt: Label 'Employee Appraisal record has been released.';
    //
    //"*********Leave Adjsutment**********": ;
    LeaveAdjustSendForApprovalEventDescTxt: Label 'Approval for a Leave Adjustment Requested.';
    CancelLeaveAdjsutApprovalRequestEventDescTxt: Label 'Approval request for Leave Adjustment Cancelled.';
    LeaveAdjsutReleasedEventDescTxt: Label 'A Leave Adjustment record has been released.';
    //"*********Recruitment Plan**********": ;
    RecruitmentPlanSendForApprovalEventDescTxt: Label 'Approval for Recruitment Plan Requested.';
    CancelRecruitmentPlanApprovalRequestEventDescTxt: Label 'Approval request for Recruitment Plan Cancelled.';
    RecruitmentPlanReleasedEventDescTxt: Label 'A Recruitment Plan record has been released.';
    //"*********Consolidated Recruitment Plan**********": ;
    ConsolidatedRecruitmentPlanSendForApprovalEventDescTxt: Label 'Approval for Consolidated Recruitment Plan Requested.';
    CancelConsolidatedRecruitmentPlanApprovalRequestEventDescTxt: Label 'Approval request for Consolidated Recruitment Plan Cancelled.';
    ConsolidatedRecruitmentPlanReleasedEventDescTxt: Label 'A Consolidated Recruitment Plan record has been released.';
    //"*********Company Establishment**********": ;
    CompanyEstablishmentSendForApprovalEventDescTxt: Label 'Approval for Company Establishment Requested.';
    CancelCompanyEstablishmentApprovalRequestEventDescTxt: Label 'Approval request for Company Establishment Cancelled.';
    CompanyEstablishmentReleasedEventDescTxt: Label 'A Company Establishment record has been released.';
    //"*********Recruitment Need**********": ;
    RecruitmentNeedSendForApprovalEventDescTxt: Label 'Approval for Recruitment Request Requested.';
    CancelRecruitmentNeedApprovalRequestEventDescTxt: Label 'Approval request for Recruitment Request Cancelled.';
    RecruitmentNeedReleasedEventDescTxt: Label 'A Recruitment Request record has been released.';
    //
    //"*********THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS**********":;
    //"*********Job Worksheet**********": ;
    JobWorksheetSendForApprovalEventDescTxt: Label 'Approval for Job Worksheet Requested.';
    CancelJobWorksheetApprovalRequestEventDescTxt: Label 'Approval request for Job Worksheet Cancelled.';
    JobWorksheetReleasedEventDescTxt: Label 'A Job Worksheet record has been released.';
    //
    //"*********Service Worksheet**********": ;
    ServiceWorksheetSendForApprovalEventDescTxt: Label 'Approval for Service Worksheet Requested.';
    CancelServiceWorksheetApprovalRequestEventDescTxt: Label 'Approval request for Service Worksheet Cancelled.';
    ServiceWorksheetReleasedEventDescTxt: Label 'A Service Worksheet record has been released.';
    //#region Events
    //"**************************THL - BASIC FINANCE MODULE CUSTOMIZATIONS******************"
    // "******************** Payment Voucher Approval**************************"
    procedure RunWorkflowOnSendPVForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendPVForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendPVForApproval', '', false, false)]
    procedure RunWorkflowOnSendPVForApproval(var PV: Record "PV Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPVForApprovalCode, PV);
    end;
    procedure RunWorkflowOnCancelPVApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelPVApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelPVApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelPVApprovalRequest(PV: Record "PV Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPVApprovalRequestCode, PV);
    end;
    procedure RunWorkflowOnAfterReleasePVCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleasePV'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Payment Voucher", 'OnAfterReleasePV', '', false, false)]
    procedure RunWorkflowOnAfterReleasePV(var PV: Record "PV Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleasePVCode, PV);
    end;
    //"**************************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS******************"
    // "******************** Petty Cash Approval**************************"
    procedure RunWorkflowOnSendPettyCashForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendPettyCashForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendPettyCashForApproval', '', false, false)]
    procedure RunWorkflowOnSendPettyCashForApproval(var PettyCash: Record "Expense Claim Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendPettyCashForApprovalCode, PettyCash);
    end;
    procedure RunWorkflowOnCancelPettyCashApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelPettyCashApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelPettyCashApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelPettyCashApprovalRequest(PettyCash: Record "Expense Claim Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelPettyCashApprovalRequestCode, PettyCash);
    end;
    procedure RunWorkflowOnAfterReleasePettyCashCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleasePettyCash'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Petty Cash", 'OnAfterReleasePettyCash', '', false, false)]
    procedure RunWorkflowOnAfterReleasePettyCash(var PettyCash: Record "Expense Claim Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleasePettyCashCode, PettyCash);
    end;
    //
    //"******************** Imprest Approval**************************"
    procedure RunWorkflowOnSendImprestForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendImprestForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendImprestForApproval', '', false, false)]
    procedure RunWorkflowOnSendImprestForApproval(var Imprest: Record "Imprest Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestForApprovalCode, Imprest);
    end;
    procedure RunWorkflowOnCancelImprestApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelImprestApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelImprestApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelImprestApprovalRequest(var Imprest: Record "Imprest Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestApprovalRequestCode, Imprest);
    end;
    procedure RunWorkflowOnAfterReleaseImprestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseImprest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Imprest", 'OnAfterReleaseImprest', '', false, false)]
    procedure RunWorkflowOnAfterReleaseImprest(var Imprest: Record "Imprest Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseImprestCode, Imprest);
    end;
    //
    //"******************** Imprest Memo Approval**************************"
    procedure RunWorkflowOnSendImprestMemoForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendImprestMemoForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendImprestMemoForApproval', '', false, false)]
    procedure RunWorkflowOnSendImprestMemoForApproval(var ImprestMemo: Record "Imprest Memo Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestMemoForApprovalCode, ImprestMemo);
    end;
    procedure RunWorkflowOnCancelImprestMemoApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelImprestMemoApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelImprestMemoApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelImprestMemoApprovalRequest(var ImprestMemo: Record "Imprest Memo Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestMemoApprovalRequestCode, ImprestMemo);
    end;
    procedure RunWorkflowOnAfterReleaseImprestMemoCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseImprestMemo'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Imprest Memo", 'OnAfterReleaseImprestMemo', '', false, false)]
    procedure RunWorkflowOnAfterReleaseImprestMemo(var ImprestMemo: Record "Imprest Memo Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseImprestMemoCode, ImprestMemo);
    end;
    //
    //"******************** Imprest Payroll Claims Approval**************************"
    procedure RunWorkflowOnSendImprestPayrollClaimForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendImprestPayrollClaimForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendImprestPayrollClaimForApproval', '', false, false)]
    procedure RunWorkflowOnSendImprestPayrollClaimForApproval(var ImprestPayrollClaim: Record "Imprest Payroll Claims Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendImprestPayrollClaimForApprovalCode, ImprestPayrollClaim);
    end;
    procedure RunWorkflowOnCancelImprestPayrollClaimApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelImprestPayrollClaimApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelImprestPayrollClaimApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelImprestPayrollClaimApprovalRequest(var ImprestPayrollClaim: Record "Imprest Payroll Claims Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelImprestPayrollClaimApprovalRequestCode, ImprestPayrollClaim);
    end;
    procedure RunWorkflowOnAfterReleaseImprestPayrollClaimCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseImprestPayrollClaim'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Imprest Payroll Claim", 'OnAfterReleaseImprestPayrollClaim', '', false, false)]
    procedure RunWorkflowOnAfterReleaseImprestPayrollClaim(var ImprestPayrollClaim: Record "Imprest Payroll Claims Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseImprestPayrollClaimCode, ImprestPayrollClaim);
    end;
    //
    // "********************Request For Payment Approval**************************"
    procedure RunWorkflowOnSendRequestForPaymentForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendRequestForPaymentForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendRequestForPaymentForApproval', '', false, false)]
    procedure RunWorkflowOnSendRequestForPaymentForApproval(var RequestForPayment: Record "Request for Payment")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendRequestForPaymentForApprovalCode, RequestForPayment);
    end;
    procedure RunWorkflowOnCancelRequestForPaymentApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelRequestForPaymentApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelRequestForPaymentApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelRequestForPaymentApprovalRequest(var RequestForPayment: Record "Request for Payment")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRequestForPaymentApprovalRequestCode, RequestForPayment);
    end;
    procedure RunWorkflowOnAfterReleaseRequestForPaymentCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseRequestForPayment'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Request for Payment", 'OnAfterReleaseRequestForPayment', '', false, false)]
    procedure RunWorkflowOnAfterReleaseRequestForPayment(var RequestForPayment: Record "Request for Payment")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseRequestForPaymentCode, RequestForPayment);
    end;
    //
    // "********************Supplementary Budget Request Approval**************************"
    procedure RunWorkflowOnSendSupplementaryBudgetForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendSupplementaryBudgetForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendSupplementaryBudgetForApproval', '', false, false)]
    procedure RunWorkflowOnSendSupplementaryBudgetForApproval(var SupplementaryBudget: Record "Supplementary Budget Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendSupplementaryBudgetForApprovalCode, SupplementaryBudget);
    end;
    procedure RunWorkflowOnCancelSupplementaryBudgetApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelSupplementaryBudgetApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelSupplementaryBudgetApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelSupplementaryBudgetApprovalRequest(var SupplementaryBudget: Record "Supplementary Budget Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelSupplementaryBudgetApprovalRequestCode, SupplementaryBudget);
    end;
    procedure RunWorkflowOnAfterReleaseSupplementaryBudgetCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseSupplementaryBudget'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Supplementary Budget", 'OnAfterReleaseSupplementaryBudget', '', false, false)]
    procedure RunWorkflowOnAfterReleaseSupplementaryBudget(var SupplementaryBudget: Record "Supplementary Budget Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseSupplementaryBudgetCode, SupplementaryBudget);
    end;
    //
    // "********************Staff Based Budget Request Approval**************************"
    procedure RunWorkflowOnSendStaffBasedBudgetForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendStaffBasedBudgetForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendStaffBasedBudgetForApproval', '', false, false)]
    procedure RunWorkflowOnSendStaffBasedBudgetForApproval(var StaffBasedBudget: Record "Staff Based Budget Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendStaffBasedBudgetForApprovalCode, StaffBasedBudget);
    end;
    procedure RunWorkflowOnCancelStaffBasedBudgetApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelStaffBasedBudgetApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelStaffBasedBudgetApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelStaffBasedBudgetApprovalRequest(var StaffBasedBudget: Record "Staff Based Budget Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelStaffBasedBudgetApprovalRequestCode, StaffBasedBudget);
    end;
    procedure RunWorkflowOnAfterReleaseStaffBasedBudgetCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseStaffBasedBudget'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Staff Based Budget", 'OnAfterReleaseStaffBasedBudget', '', false, false)]
    procedure RunWorkflowOnAfterReleaseStaffBasedBudget(var StaffBasedBudget: Record "Staff Based Budget Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseStaffBasedBudgetCode, StaffBasedBudget);
    end;
    //
    // "**************************THL - PROCUREMENT MODULE CUSTOMIZATIONS******************"
    //"******************** Requisition Approval**************************"
    procedure RunWorkflowOnSendRequisitionForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendRequisitionForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendRequisitionForApproval', '', false, false)]
    procedure RunWorkflowOnSendRequisitionForApproval(var Requisition: Record "Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendRequisitionForApprovalCode, Requisition);
    end;
    procedure RunWorkflowOnCancelRequisitionApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelRequisitionApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelRequisitionApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelRequisitionApprovalRequest(var Requisition: Record "Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRequisitionApprovalRequestCode, Requisition);
    end;
    procedure RunWorkflowOnAfterReleaseRequisitionCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseRequisition'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Requisition", 'OnAfterReleaseRequisition', '', false, false)]
    procedure RunWorkflowOnAfterReleaseRequisition(var Requisition: Record "Requisition Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseRequisitionCode, Requisition);
    end;
    //"******************** Vendor Registration Request Approval**************************"
    procedure RunWorkflowOnSendVendorRegForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendVendorRegForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendVendorRegForApproval', '', false, false)]
    procedure RunWorkflowOnSendVendorRegForApproval(var VendorReg: Record "Vendor Reg. Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendVendorRegForApprovalCode, VendorReg);
    end;
    procedure RunWorkflowOnCancelVendorRegApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelVendorRegApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelVendorRegApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelVendorRegApprovalRequest(var VendorReg: Record "Vendor Reg. Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelVendorRegApprovalRequestCode, VendorReg);
    end;
    procedure RunWorkflowOnAfterReleaseVendorRegCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseVendorReg'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Vendor Reg. Request", 'OnAfterReleaseVendorReg', '', false, false)]
    procedure RunWorkflowOnAfterReleaseVendorReg(var VendorReg: Record "Vendor Reg. Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseVendorRegCode, VendorReg);
    end;
    //
    //Ibrahim Wasiu
    //"******************** Procurement Plan Approval**************************"
    procedure RunWorkflowOnSendProcurePlanForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendProcurePlanForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendProcurePlanForApproval', '', false, false)]
    procedure RunWorkflowOnSendProcurePlanForApproval(var ProcurePlan: Record "Procurement Plan Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendProcurePlanForApprovalCode, ProcurePlan);
    end;
    procedure RunWorkflowOnCancelProcurePlanApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelProcurePlanApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelProcurePlanApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelProcurePlanApprovalRequest(var ProcurePlan: Record "Procurement Plan Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelProcurePlanApprovalRequestCode, ProcurePlan);
    end;
    procedure RunWorkflowOnAfterReleaseProcurePlanCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseProcurePlan'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Procurement Plan", 'OnAfterReleaseProcurePlan', '', false, false)]
    procedure RunWorkflowOnAfterReleaseProcurePlan(var ProcurePlan: Record "Procurement Plan Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseProcurePlanCode, ProcurePlan);
    end;
    //
    //"******************** Repair Requisition Approval**************************"
    procedure RunWorkflowOnSendRepairRequestForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendRepairRequestForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendRepairRequestForApproval', '', false, false)]
    procedure RunWorkflowOnSendRepairRequestForApproval(var RepairRequest: Record "Repair Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendRepairRequestForApprovalCode, RepairRequest);
    end;
    procedure RunWorkflowOnCancelRepairRequestApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelRepairRequestApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelRepairRequestApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelRepairRequestApprovalRequest(var RepairRequest: Record "Repair Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRepairRequestApprovalRequestCode, RepairRequest);
    end;
    procedure RunWorkflowOnAfterReleaseRepairRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseRepairRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Repair Requisition", 'OnAfterReleaseRepairRequest', '', false, false)]
    procedure RunWorkflowOnAfterReleaseRepairRequest(var RepairRequest: Record "Repair Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseRepairRequestCode, RepairRequest);
    end;
    //
    //"******************Work Ticket Approval**********************"
    procedure RunWorkflowOnSendWorkTForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendWorkTForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendWorkTForApproval', '', false, false)]
    procedure RunWorkflowOnSendWorkTForApproval(var WorkT: Record "Work Ticket Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendWorkTForApprovalCode, WorkT);
    end;
    procedure RunWorkflowOnCancelWorkTApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelWorkTApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelWorkTApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelWorkTApprovalRequest(var WorkT: Record "Work Ticket Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelWorkTApprovalRequestCode, WorkT);
    end;
    procedure RunWorkflowOnAfterReleaseWorkTCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseWorkT'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Work Ticket", 'OnAfterReleaseWorkT', '', false, false)]
    procedure RunWorkflowOnAfterReleaseWorkT(var WorkT: Record "Work Ticket Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseWorkTCode, WorkT);
    end;
    //
    //"******************RFQ Approval*************************************"
    procedure RunWorkflowOnSendRFQForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendRFQForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendRFQForApproval', '', false, false)]
    procedure RunWorkflowOnSendRFQForApproval(var RFQ: Record "RFQ Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendRFQForApprovalCode, RFQ);
    end;
    procedure RunWorkflowOnCancelRFQApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelRFQApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelRFQApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelRFQApprovalRequest(var RFQ: Record "RFQ Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRFQApprovalRequestCode, RFQ);
    end;
    procedure RunWorkflowOnAfterReleaseRFQCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseRFQ'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release RFQ Header", 'OnAfterReleaseRFQ', '', false, false)]
    procedure RunWorkflowOnAfterReleaseRFQ(var RFQ: Record "RFQ Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseRFQCode, RFQ);
    end;
    //
    //"******************Balance Score Card Approval*************************************"
    procedure RunWorkflowOnSendBalScoreCardForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendBalScoreCardForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendBalScoreCardForApproval', '', false, false)]
    procedure RunWorkflowOnSendBalScoreCardForApproval(var BalScoreCard: Record "Bal Score Card Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendRFQForApprovalCode, BalScoreCard);
    end;
    procedure RunWorkflowOnCancelBalScoreCardApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelBalScoreCardApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelBalScoreCardApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelBalScoreCardApprovalRequest(var BalScoreCard: Record "Bal Score Card Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelBalScoreCardApprovalRequestCode, BalScoreCard);
    end;
    procedure RunWorkflowOnAfterReleaseBalScoreCardCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseBalScoreCard'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Bal Score Card", 'OnAfterReleaseBalScoreCard', '', false, false)]
    procedure RunWorkflowOnAfterReleaseBalScoreCard(var BalScoreCard: Record "Bal Score Card Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseRFQCode, BalScoreCard);
    end;
    //End: Ibrahim Wasiu
    //"**************************THL - HR MODULE CUSTOMIZATIONS******************"
    //"******************** Leave Application Approval**************************"
    procedure RunWorkflowOnSendLeaveForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendLeaveForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendLeaveForApproval', '', false, false)]
    procedure RunWorkflowOnSendLeaveForApproval(var Leave: Record "Employee Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveForApprovalCode, Leave);
    end;
    procedure RunWorkflowOnCancelLeaveApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelLeaveApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelLeaveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelLeaveApprovalRequest(var Leave: Record "Employee Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveApprovalRequestCode, Leave);
    end;
    procedure RunWorkflowOnAfterReleaseLeaveCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseLeave'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Leave Application", 'OnAfterReleaseLeave', '', false, false)]
    procedure RunWorkflowOnAfterReleaseLeave(var Leave: Record "Employee Leave Application")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseLeaveCode, Leave);
    end;
    //
    //"******************** Leave Adjustment Approval**************************"
    procedure RunWorkflowOnSendLeaveAdjustForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendLeaveAdjustForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendLeaveAdjustmentForApproval', '', false, false)]
    procedure RunWorkflowOnSendLeaveAdjustForApproval(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLeaveAdjustForApprovalCode, LeaveAdjust);
    end;
    procedure RunWorkflowOnCancelLeaveAdjustApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelLeaveAdjustApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelLeaveAdjustmentApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelLeaveAdjustApprovalRequest(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeaveAdjustApprovalRequestCode, LeaveAdjust);
    end;
    procedure RunWorkflowOnAfterReleaseLeaveAdjustCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseLeaveAdjust'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Leave Application", 'OnAfterReleaseLeaveAdjust', '', false, false)]
    procedure RunWorkflowOnAfterReleaseLeaveAdjust(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseLeaveAdjustCode, LeaveAdjust);
    end;
    //
    // "********************Appraisal Approval**************************"
    procedure RunWorkflowOnSendAppraisalForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendAppraisalForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendAppraisalForApproval', '', false, false)]
    procedure RunWorkflowOnSendAppraisalForApproval(var Appraisal: Record "Performance Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendAppraisalForApprovalCode, Appraisal);
    end;
    procedure RunWorkflowOnCancelAppraisalApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelAppraisalApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelAppraisalApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelAppraisalApprovalRequest(var Appraisal: Record "Performance Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelAppraisalApprovalRequestCode, Appraisal);
    end;
    procedure RunWorkflowOnAfterReleaseAppraisalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseAppraisal'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Appraisal", 'OnAfterReleaseAppraisal', '', false, false)]
    procedure RunWorkflowOnAfterReleaseAppraisal(var Appraisal: Record "Performance Appraisal")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseAppraisalCode, Appraisal);
    end;
    //
    // "********************Orientation Checklist Approval**************************"
    procedure RunWorkflowOnSendOrientationForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendOrientationForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendOrientationForApproval', '', false, false)]
    procedure RunWorkflowOnSendOrientationlForApproval(var Orientation: Record "Staff Orientation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendOrientationForApprovalCode, Orientation);
    end;
    procedure RunWorkflowOnCancelOrientationApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelOrientationApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelOrientationApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelOrientationApprovalRequest(var Orientation: Record "Staff Orientation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelOrientationApprovalRequestCode, Orientation);
    end;
    procedure RunWorkflowOnAfterReleaseOrientationCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseOrientation'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Orientation Checklist", 'OnAfterReleaseOrientation', '', false, false)]
    procedure RunWorkflowOnAfterReleaseOrientation(var Orientation: Record "Staff Orientation Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseOrientationCode, Orientation);
    end;
    //
    //"********************Medical Claim Approval**************************"
    procedure RunWorkflowOnSendClaimForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendClaimForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendClaimForApproval', '', false, false)]
    procedure RunWorkflowOnSendClaimForApproval(var Claim: Record "Medical Claim")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendClaimForApprovalCode, Claim);
    end;
    procedure RunWorkflowOnCancelClaimApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelClaimApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelClaimApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelClaimApprovalRequest(var Claim: Record "Medical Claim")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelClaimApprovalRequestCode, Claim);
    end;
    procedure RunWorkflowOnAfterReleaseClaimCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseClaim'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Medical Claim", 'OnAfterReleaseClaim', '', false, false)]
    procedure RunWorkflowOnAfterReleaseClaim(var Claim: Record "Medical Claim")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseClaimCode, Claim);
    end;
    //
    // "********************CSR Approval**************************"
    procedure RunWorkflowOnSendCSRForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendCSRForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendCSRForApproval', '', false, false)]
    procedure RunWorkflowOnSendCSRForApproval(var CSR: Record "Staff CSR")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendCSRForApprovalCode, CSR);
    end;
    procedure RunWorkflowOnCancelCSRApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelCSRApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendCSRForApproval', '', false, false)]
    procedure RunWorkflowOnCancelCSRApprovalRequest(var CSR: Record "Staff CSR")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelCSRApprovalRequestCode, CSR);
    end;
    procedure RunWorkflowOnAfterReleaseCSRCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseCSR'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release CSR", 'OnAfterReleaseCSR', '', false, false)]
    procedure RunWorkflowOnAfterReleaseCSR(var CSR: Record "Staff CSR")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseCSRCode, CSR);
    end;
    //
    // "********************Training Approval**************************"
    procedure RunWorkflowOnSendTrainingForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendTrainingForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendTrainingForApproval', '', false, false)]
    procedure RunWorkflowOnSendTrainingForApproval(var Training: Record "Staff Training Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTrainingForApprovalCode, Training);
    end;
    procedure RunWorkflowOnCancelTrainingApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelTrainingApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelTraininigApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelTrainingApprovalRequest(var Training: Record "Staff Training Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTrainingApprovalRequestCode, Training);
    end;
    procedure RunWorkflowOnAfterReleaseTrainingCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseTraining'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Training", 'OnAfterReleaseTraining', '', false, false)]
    procedure RunWorkflowOnAfterReleaseTraining(var Training: Record "Staff Training Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseTrainingCode, Training);
    end;
    //
    //"********************Training Needs Approval**************************"
    procedure RunWorkflowOnSendTrainingNeedsForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendTrainingNeedsForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendTrainingNeedsForApproval', '', false, false)]
    procedure RunWorkflowOnSendTrainingNeedsForApproval(var TrainingNeeds: Record "Training Needs Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendTrainingNeedsForApprovalCode, TrainingNeeds);
    end;
    procedure RunWorkflowOnCancelTrainingNeedsApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelTrainingNeedsApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelTraininigNeedsApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelTrainingNeedsApprovalRequest(var TrainingNeeds: Record "Training Needs Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelTrainingNeedsApprovalRequestCode, TrainingNeeds);
    end;
    procedure RunWorkflowOnAfterReleaseTrainingNeedsCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseTrainingNeeds'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Training Needs", 'OnAfterReleaseTrainingNeeds', '', false, false)]
    procedure RunWorkflowOnAfterReleaseTrainingNeeds(var TrainingNeeds: Record "Training Needs Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseTrainingNeedsCode, TrainingNeeds);
    end;
    //
    //procedure "********************Recruitment Approval**************************"
    procedure RunWorkflowOnSendRecruitmentForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendRecruitmentForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendRecruitmentForApproval', '', false, false)]
    procedure RunWorkflowOnSendRecruitmentForApproval(var Recruitment: Record "Recruitment Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendRecruitmentForApprovalCode, Recruitment);
    end;
    procedure RunWorkflowOnCancelRecruitmentApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelRecruitmentApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelRecruitmentApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelRecruitmentApprovalRequest(var Recruitment: Record "Recruitment Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRecruitmentApprovalRequestCode, Recruitment);
    end;
    procedure RunWorkflowOnAfterReleaseRecruitmentCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseRecruitment'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Recruitment", 'OnAfterReleaseRecruitment', '', false, false)]
    procedure RunWorkflowOnAfterReleaseRecruitment(var Recruitment: Record "Recruitment Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseRecruitmentCode, Recruitment);
    end;
    //
    // "********************Leave Plan Approval**************************"
    procedure RunWorkflowOnSendLeavePlanForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendLeavePlanForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendLeavePlanForApproval', '', false, false)]
    procedure RunWorkflowOnSendLeavePlanForApproval(var LeavePlan: Record "Employee Leave Plan Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendLeavePlanForApprovalCode, LeavePlan);
    end;
    procedure RunWorkflowOnCancelLeavePlanApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelLeavePlanApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelLeavePlanApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelLeavePlanApprovalRequest(var LeavePlan: Record "Employee Leave Plan Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelLeavePlanApprovalRequestCode, LeavePlan);
    end;
    procedure RunWorkflowOnAfterReleaseLeavePlanCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseLeavePlan'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Leave Plan", 'OnAfterReleaseLeavePlan', '', false, false)]
    procedure RunWorkflowOnAfterReleaseLeavePlan(var LeavePlan: Record "Employee Leave Plan Header")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseLeavePlanCode, LeavePlan);
    end;
    //
    // "********************Govt. Employee Objectives Approval**************************"
    procedure RunWorkflowOnSendEmpObjectivesForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendEmpObjectivesForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendAppraisalObjectiveForApproval', '', false, false)]
    procedure RunWorkflowOnSendEmpObjectivesForApproval(var EmpObjectives: Record "Employee Appraisal Objectives")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendEmpObjectivesForApprovalCode, EmpObjectives);
    end;
    procedure RunWorkflowOnCancelEmpObjectivesApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelEmpObjectivesApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelAppraisalObjectiveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelEmpObjectivesApprovalRequest(var EmpObjectives: Record "Employee Appraisal Objectives")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelEmpObjectivesApprovalRequestCode, EmpObjectives);
    end;
    procedure RunWorkflowOnAfterReleaseEmpObjectivesCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseEmpObjectives'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Govt. Emp Objectives", 'OnAfterReleaseEmpObjectives', '', false, false)]
    procedure RunWorkflowOnAfterReleaseEmpObjectives(var EmpObjectives: Record "Employee Appraisal Objectives")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseEmpObjectivesCode, EmpObjectives);
    end;
    //
    //"********************Govt. Employee Appraisal Approval**************************"
    procedure RunWorkflowOnSendEmpAppraisalForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendEmpAppraisalForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendEmployeeAppraisalForApproval', '', false, false)]
    procedure RunWorkflowOnSendEmpAppraisalForApproval(var EmpAppraisal: Record "Employee Appraisals")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendEmpAppraisalForApprovalCode, EmpAppraisal);
    end;
    procedure RunWorkflowOnCancelEmpAppraisalApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelEmpAppraisalApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelEmployeeAppraisalApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelEmpAppraisalApprovalRequest(var EmpAppraisal: Record "Employee Appraisals")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelAppraisalApprovalRequestCode, EmpAppraisal);
    end;
    procedure RunWorkflowOnAfterReleaseEmpAppraisalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseEmpAppraisal'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Govt. Emp Appraisal", 'OnAfterReleaseEmpAppraisal', '', false, false)]
    procedure RunWorkflowOnAfterReleaseEmpAppraisal(var EmpAppraisal: Record "Employee Appraisals")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseEmpAppraisalCode, EmpAppraisal);
    end;
    // "******************** Recruitment Plan Approval**************************"
    procedure RunWorkflowOnSendRecruitmentPlanForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendRecruitmentPlanForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendRecruitmentPlanForApproval', '', false, false)]
    procedure RunWorkflowOnSendRecruitmentPlanForApproval(var RecruitmentPlan: Record "Recruitment Plan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendRecruitmentPlanForApprovalCode, RecruitmentPlan);
    end;
    procedure RunWorkflowOnCancelRecruitmentPlanApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelRecruitmentPlanApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelRecruitmentPlanApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelRecruitmentPlanApprovalRequest(RecruitmentPlan: Record "Recruitment Plan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRecruitmentPlanApprovalRequestCode, RecruitmentPlan);
    end;
    procedure RunWorkflowOnAfterReleaseRecruitmentPlanCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseRecruitmentPlan'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Recruitment Plan", 'OnAfterReleaseRecruitmentPlan', '', false, false)]
    procedure RunWorkflowOnAfterReleaseRecruitmentPlan(var RecruitmentPlan: Record "Recruitment Plan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseRecruitmentPlanCode, RecruitmentPlan);
    end;
    //
    // "******************** Consolidated Recruitment Plan Approval**************************"
    procedure RunWorkflowOnSendConsolidatedRecruitmentPlanForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendConsolidatedRecruitmentPlanForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendConsolidatedRecruitmentPlanForApproval', '', false, false)]
    procedure RunWorkflowOnSendConsolidatedRecruitmentPlanForApproval(var ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendConsolidatedRecruitmentPlanForApprovalCode, ConsolidatedRecruitmentPlan);
    end;
    procedure RunWorkflowOnCancelConsolidatedRecruitmentPlanApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelConsolidatedRecruitmentPlanApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelConsolidatedRecruitmentPlanApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelConsolidatedRecruitmentPlanApprovalRequest(ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelConsolidatedRecruitmentPlanApprovalRequestCode, ConsolidatedRecruitmentPlan);
    end;
    procedure RunWorkflowOnAfterReleaseConsolidatedRecruitmentPlanCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseConsolidatedRecruitmentPlan'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Cons. Recruitment Plan", 'OnAfterReleaseConsolidatedRecruitmentPlan', '', false, false)]
    procedure RunWorkflowOnAfterReleaseConsolidatedRecruitmentPlan(var ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseConsolidatedRecruitmentPlanCode, ConsolidatedRecruitmentPlan);
    end;
    // "************************Recruitment Request/Need Approval**************************"
    procedure RunWorkflowOnSendRecruitmentNeedForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendRecruitmentNeedForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendRecruitmentNeedForApproval', '', false, false)]
    procedure RunWorkflowOnSendRecruitmentNeedForApproval(var RecruitmentNeed: Record "Recruitment Needs")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendRecruitmentNeedForApprovalCode, RecruitmentNeed);
    end;
    procedure RunWorkflowOnCancelRecruitmentNeedApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowRecruitmentNeedApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelRecruitmentNeedApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelRecruitmentNeedApprovalRequest(Var RecruitmentNeed: Record "Recruitment Needs")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelRecruitmentNeedApprovalRequestCode, RecruitmentNeed);
    end;
    procedure RunWorkflowOnAfterReleaseRecruitmentNeedCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseRecruitmentNeed'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Recruitment Need", 'OnAfterReleaseRecruitmentNeed', '', false, false)]
    procedure RunWorkflowOnAfterReleaseRecruitmentNeed(var RecruitmentNeed: Record "Recruitment Needs")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseRecruitmentNeedCode, RecruitmentNeed);
    end;
    // "************************Company Establishment Approval**************************"
    procedure RunWorkflowOnSendCompanyEstablishmentForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendCompanyEstablishmentForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendCompanyEstablishmentForApproval', '', false, false)]
    procedure RunWorkflowOnSendCompanyEstablishmentForApproval(var CompanyEstablishment: Record "Company Jobs")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendCompanyEstablishmentForApprovalCode, CompanyEstablishment);
    end;
    procedure RunWorkflowOnCancelCompanyEstablishmentApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowCompanyEstablishmentApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelCompanyEstablishmentApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelCompanyEstablishmentApprovalRequest(Var CompanyEstablishment: Record "Company Jobs")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelCompanyEstablishmentApprovalRequestCode, CompanyEstablishment);
    end;
    procedure RunWorkflowOnAfterReleaseCompanyEstablishmentCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseCompanyEstablishment'));
    end;
    [EventSubscriber(ObjectType::Codeunit, CodeUnit::"Release Company Establishment", 'OnAfterReleaseCompanyEstablishment', '', false, false)]
    procedure RunWorkflowOnAfterReleaseCompanyEstablishment(var CompanyEstablishment: Record "Company Jobs")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseCompanyEstablishmentCode, CompanyEstablishment);
    end;
    // "**************************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS******************"
    // "********************Job Worksheet Approval**************************"
    procedure RunWorkflowOnSendJobWorksheetForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendJobWorksheetForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendJobWorksheetForApproval', '', false, false)]
    procedure RunWorkflowOnSendJobWorksheetForApproval(var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendJobWorksheetForApprovalCode, WorksheetRequisitionsLines);
    end;
    procedure RunWorkflowOnCancelJobWorksheetApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelJobWorksheetApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelJobWorksheetApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelJobWorksheetApprovalRequest(var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelJobWorksheetApprovalRequestCode, WorksheetRequisitionsLines);
    end;
    procedure RunWorkflowOnAfterReleaseJobWorksheetCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseJobWorksheet'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Job Worksheet", 'OnAfterReleaseJobworksheet', '', false, false)]
    procedure RunWorkflowOnAfterReleaseJobWorksheet(var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseJobWorksheetCode, WorksheetRequisitionsLines);
    end;
    //
    // "********************Service Worksheet Approval**************************"
    procedure RunWorkflowOnSendServiceWorksheetForApprovalCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnSendServiceWorksheetForApproval'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnSendServiceWorkSheetForApproval', '', false, false)]
    procedure RunWorkflowOnSendServiceWorksheetForApproval(var ServiceLine: Record "Service Line")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendServiceWorksheetForApprovalCode, ServiceLine);
    end;
    procedure RunWorkflowOnCancelServiceWorksheetApprovalRequestCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnCancelServiceWorksheetApprovalRequest'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. Ext", 'OnCancelServiceWorkSheetApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelServiceWorksheetApprovalRequest(var ServiceLine: Record "Service Line")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelServiceWorksheetApprovalRequestCode, ServiceLine);
    end;
    procedure RunWorkflowOnAfterReleaseServiceWorksheetCode(): Code[128]begin
        exit(UpperCase('RunWorkflowOnAfterReleaseServiceWorksheet'));
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Service Worksheet", 'OnAfterServiceWorksheetTraining', '', false, false)]
    procedure RunWorkflowOnAfterReleaseServiceWorksheet(var ServiceLine: Record "Service Line")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnAfterReleaseServiceWorksheetCode, ServiceLine);
    end;
    //#endregion 
    //#region AddEventToLibrary
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    procedure CreateEventsLibrary()
    begin
        //************************THL - BASIC FINANCE MODULE CUSTOMIZATIONS***************************
        //1. Payment Voucher:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPVForApprovalCode, DATABASE::"PV Header", PVSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPVApprovalRequestCode, DATABASE::"PV Header", CancelPVApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleasePVCode, DATABASE::"PV Header", PVReleasedEventDescTxt, 0, false);
        //
        //************************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS***************************
        //1. Petty Cash:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPettyCashForApprovalCode, DATABASE::"Expense Claim Header", PettyCashSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPettyCashApprovalRequestCode, DATABASE::"Expense Claim Header", CancelPettyCashApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleasePettyCashCode, DATABASE::"Expense Claim Header", PettyCashReleasedEventDescTxt, 0, false);
        //
        //2. Imprest:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendImprestForApprovalCode, DATABASE::"Imprest Header", ImprestSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelImprestApprovalRequestCode, DATABASE::"Imprest Header", CancelImprestApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseImprestCode, DATABASE::"Imprest Header", ImprestReleasedEventDescTxt, 0, false);
        //
        //2. Imprest Memo:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendImprestMemoForApprovalCode, DATABASE::"Imprest Memo Header", ImprestMemoSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelImprestMemoApprovalRequestCode, DATABASE::"Imprest Memo Header", CancelImprestMemoApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseImprestMemoCode, DATABASE::"Imprest Memo Header", ImprestMemoReleasedEventDescTxt, 0, false);
        //
        //2. Imprest Payroll Claims:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendImprestPayrollClaimForApprovalCode, DATABASE::"Imprest Payroll Claims Header", ImprestPayrollClaimSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelImprestPayrollClaimApprovalRequestCode, DATABASE::"Imprest Payroll Claims Header", CancelImprestPayrollClaimApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseImprestPayrollClaimCode, DATABASE::"Imprest Payroll Claims Header", ImprestPayrollClaimReleasedEventDescTxt, 0, false);
        //
        //4. Request For Payment:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRequestForPaymentForApprovalCode, DATABASE::"Request for Payment", RequestForPaymentSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRequestForPaymentApprovalRequestCode, DATABASE::"Request for Payment", CancelRequestForPaymentApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseRequestForPaymentCode, DATABASE::"Request for Payment", RequestForPaymentReleasedEventDescTxt, 0, false);
        //
        //5. Supplementary Budget Request:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendSupplementaryBudgetForApprovalCode, DATABASE::"Supplementary Budget Request", SupplementaryBudgetSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelSupplementaryBudgetApprovalRequestCode, DATABASE::"Supplementary Budget Request", CancelSupplementaryBudgetApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseSupplementaryBudgetCode, DATABASE::"Supplementary Budget Request", SupplementaryBudgetReleasedEventDescTxt, 0, false);
        //
        //6. Staff Based Budget:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendStaffBasedBudgetForApprovalCode, DATABASE::"Staff Based Budget Header", StaffBasedBudgetSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelStaffBasedBudgetApprovalRequestCode, DATABASE::"Staff Based Budget Header", CancelStaffBasedBudgetApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseStaffBasedBudgetCode, DATABASE::"Staff Based Budget Header", StaffBasedBudgetReleasedEventDescTxt, 0, false);
        //
        //************************THL - PROCUREMENT MODULE CUSTOMIZATIONS***************************
        //1. Requisition:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRequisitionForApprovalCode, DATABASE::"Requisition Header", RequisitionSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRequisitionApprovalRequestCode, DATABASE::"Requisition Header", CancelRequisitionApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseRequisitionCode, DATABASE::"Requisition Header", RequisitionReleasedEventDescTxt, 0, false);
        //
        //2. Vendor Reg. Request:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendVendorRegForApprovalCode, DATABASE::"Vendor Reg. Request", VendorRegSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelVendorRegApprovalRequestCode, DATABASE::"Vendor Reg. Request", CancelVendorRegApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseVendorRegCode, DATABASE::"Vendor Reg. Request", VendorRegReleasedEventDescTxt, 0, false);
        //
        //Ibrahim Wasiu
        //3. Procurement Plan
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendProcurePlanForApprovalCode, Database::"Procurement Plan Header", ProcurePlanSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelProcurePlanApprovalRequestCode, Database::"Procurement Plan Header", CancelProcurePlanApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseProcurePlanCode, Database::"Procurement Plan Header", ProcurePlanReleasedEventDescTxt, 0, false);
        //
        //4. Repair Requisition
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRepairRequestForApprovalCode, Database::"Repair Header", RepairRequestSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRepairRequestApprovalRequestCode, Database::"Repair Header", CancelRepairRequestApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseRepairRequestCode, Database::"Repair Header", RepairRequestReleasedEventDescTxt, 0, false);
        //
        //5. Work Ticket
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendWorkTForApprovalCode, Database::"Work Ticket Header", WorkTSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelWorkTApprovalRequestCode, Database::"Work Ticket Header", CancelWorkTApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseWorkTCode, Database::"Work Ticket Header", WorkTReleasedEventDescTxt, 0, false);
        //
        //6. RFQ
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRFQForApprovalCode, Database::"RFQ Header", RFQSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRFQApprovalRequestCode, Database::"RFQ Header", CancelRFQApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseRFQCode, Database::"RFQ Header", RFQReleasedEventDescTxt, 0, false);
        //
        //7. Balance Score Card
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendBalScoreCardForApprovalCode, Database::"Bal Score Card Header", BalScoreCardSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelBalScoreCardApprovalRequestCode, Database::"Bal Score Card Header", CancelBalScoreCardApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseBalScoreCardCode, Database::"Bal Score Card Header", BalScoreCardReleasedEventDescTxt, 0, false);
        //End: Ibrahim Wasiu
        //************************THL - HR MODULE CUSTOMIZATIONS***************************
        //1. Leave Application:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendLeaveForApprovalCode, DATABASE::"Employee Leave Application", LeaveSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelLeaveApprovalRequestCode, DATABASE::"Employee Leave Application", CancelLeaveApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseLeaveCode, DATABASE::"Employee Leave Application", LeaveReleasedEventDescTxt, 0, false);
        //
        //2. Appraisal:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendAppraisalForApprovalCode, DATABASE::"Performance Appraisal", AppraisalSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelAppraisalApprovalRequestCode, DATABASE::"Performance Appraisal", CancelAppraisalApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseAppraisalCode, DATABASE::"Performance Appraisal", AppraisalReleasedEventDescTxt, 0, false);
        //
        //3. Orientation:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendOrientationForApprovalCode, DATABASE::"Staff Orientation Header", OrientationSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelOrientationApprovalRequestCode, DATABASE::"Staff Orientation Header", CancelOrientationApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseOrientationCode, DATABASE::"Staff Orientation Header", OrientationReleasedEventDescTxt, 0, false);
        //
        //4. Medical Claim:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendClaimForApprovalCode, DATABASE::"Medical Claim", ClaimSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelClaimApprovalRequestCode, DATABASE::"Medical Claim", CancelClaimApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseClaimCode, DATABASE::"Medical Claim", ClaimReleasedEventDescTxt, 0, false);
        //
        //5. CSR:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendCSRForApprovalCode, DATABASE::"Staff CSR", CSRSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelCSRApprovalRequestCode, DATABASE::"Staff CSR", CancelCSRApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseCSRCode, DATABASE::"Staff CSR", CSRReleasedEventDescTxt, 0, false);
        //
        //6. Training:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendTrainingForApprovalCode, DATABASE::"Staff Training Header", TrainingSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelTrainingApprovalRequestCode, DATABASE::"Staff Training Header", CancelTrainingApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseTrainingCode, DATABASE::"Staff Training Header", TrainingReleasedEventDescTxt, 0, false);
        //
        //7. Training Needs:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendTrainingNeedsForApprovalCode, DATABASE::"Training Needs Header", TrainingNeedsSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelTrainingNeedsApprovalRequestCode, DATABASE::"Training Needs Header", CancelTrainingNeedsApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseTrainingNeedsCode, DATABASE::"Training Needs Header", TrainingNeedsReleasedEventDescTxt, 0, false);
        //
        //8. Recruitment:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRecruitmentForApprovalCode, DATABASE::"Recruitment Request", RecruitmentSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRecruitmentApprovalRequestCode, DATABASE::"Recruitment Request", CancelRecruitmentApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseRecruitmentCode, DATABASE::"Recruitment Request", RecruitmentReleasedEventDescTxt, 0, false);
        //
        //9. Leave Plan:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendLeavePlanForApprovalCode, DATABASE::"Employee Leave Plan Header", LeavePlanSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelLeavePlanApprovalRequestCode, DATABASE::"Employee Leave Plan Header", CancelLeavePlanApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseLeavePlanCode, DATABASE::"Employee Leave Plan Header", LeavePlanReleasedEventDescTxt, 0, false);
        //
        //10. Govt. Employee Appraisal Objectives:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendEmpObjectivesForApprovalCode, DATABASE::"Employee Appraisal Objectives", EmpObjectivesSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelEmpObjectivesApprovalRequestCode, DATABASE::"Employee Appraisal Objectives", CancelEmpObjectivesApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseEmpObjectivesCode, DATABASE::"Employee Appraisal Objectives", EmpObjectivesReleasedEventDescTxt, 0, false);
        //
        //11. Govt. Employee Appraisal:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendEmpAppraisalForApprovalCode, DATABASE::"Employee Appraisals", EmpApraisalSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelEmpAppraisalApprovalRequestCode, DATABASE::"Employee Appraisals", CancelEmpApraisalApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseEmpAppraisalCode, DATABASE::"Employee Appraisals", EmpApraisalReleasedEventDescTxt, 0, false);
        //
        //12. Leave Adjustment:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendLeaveAdjustForApprovalCode, DATABASE::"Leave Adjustment Header", LeaveAdjustSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelLeaveAdjustApprovalRequestCode, DATABASE::"Leave Adjustment Header", CancelLeaveAdjsutApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseLeaveAdjustCode, DATABASE::"Leave Adjustment Header", LeaveAdjsutReleasedEventDescTxt, 0, false);
        // //13. Recruitment Plan:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRecruitmentPlanForApprovalCode, DATABASE::"Recruitment Plan", RecruitmentPlanSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRecruitmentPlanApprovalRequestCode, DATABASE::"Recruitment Plan", CancelRecruitmentPlanApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseRecruitmentPlanCode, DATABASE::"Recruitment Plan", RecruitmentPlanReleasedEventDescTxt, 0, false);
        //
        // //14. Consolidated Recruitment Plan:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendConsolidatedRecruitmentPlanForApprovalCode, DATABASE::"Consolidated Recruitment Plan", ConsolidatedRecruitmentPlanSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelConsolidatedRecruitmentPlanApprovalRequestCode, DATABASE::"Consolidated Recruitment Plan", CancelConsolidatedRecruitmentPlanApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseConsolidatedRecruitmentPlanCode, DATABASE::"Consolidated Recruitment Plan", ConsolidatedRecruitmentPlanReleasedEventDescTxt, 0, false);
        //
        // //15. Company Establishment:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendCompanyEstablishmentForApprovalCode, DATABASE::"Company Jobs", CompanyEstablishmentSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelCompanyEstablishmentApprovalRequestCode, DATABASE::"Company Jobs", CancelCompanyEstablishmentApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseCompanyEstablishmentCode, DATABASE::"Company Jobs", CompanyEstablishmentReleasedEventDescTxt, 0, false);
        //
        //************************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS***************************
        //
        //1. Job Worksheet:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendJobWorksheetForApprovalCode, DATABASE::"Worksheet Requisitions Lines", JobWorksheetSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelJobWorksheetApprovalRequestCode, DATABASE::"Worksheet Requisitions Lines", CancelJobWorksheetApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseJobWorksheetCode, DATABASE::"Worksheet Requisitions Lines", JobWorksheetReleasedEventDescTxt, 0, false);
        //
        //2. Service Wprksheet:
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendServiceWorksheetForApprovalCode, DATABASE::"Service Line", ServiceWorksheetSendForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelServiceWorksheetApprovalRequestCode, DATABASE::"Service Line", CancelServiceWorksheetApprovalRequestEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnAfterReleaseServiceWorksheetCode, DATABASE::"Service Line", ServiceWorksheetReleasedEventDescTxt, 0, false);
    //
    end;
    //#endregion
    //#region AddEventPredecessor
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure AddEventPredecessors(EventFunctionName: Code[128])
    begin
        case EventFunctionName of //****************THL - BASIC FINANCE MODULE CUSTOMIZATIONS**************************
        //1. Payment Voucher
        RunWorkflowOnCancelPVApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelPVApprovalRequestCode, RunWorkflowOnSendPVForApprovalCode);
        //
        //****************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS**************************
        //1. Petty Cash
        RunWorkflowOnCancelPettyCashApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelPettyCashApprovalRequestCode, RunWorkflowOnSendPettyCashForApprovalCode);
        //2. Imprest
        RunWorkflowOnCancelImprestApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelImprestApprovalRequestCode, RunWorkflowOnSendImprestForApprovalCode);
        //
        //2. Imprest Memo
        RunWorkflowOnCancelImprestMemoApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelImprestMemoApprovalRequestCode, RunWorkflowOnSendImprestMemoForApprovalCode);
        //
        //2. Imprest Payroll Claims
        RunWorkflowOnCancelImprestPayrollClaimApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelImprestPayrollClaimApprovalRequestCode, RunWorkflowOnSendImprestPayrollClaimForApprovalCode);
        //
        //4. Request For Payment
        RunWorkflowOnCancelRequestForPaymentApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelRequestForPaymentApprovalRequestCode, RunWorkflowOnSendRequestForPaymentForApprovalCode);
        //
        //5.Supplementary Budget Request
        RunWorkflowOnCancelSupplementaryBudgetApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelSupplementaryBudgetApprovalRequestCode, RunWorkflowOnSendSupplementaryBudgetForApprovalCode);
        //
        //5.Supplementary Budget Request
        RunWorkflowOnCancelStaffBasedBudgetApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelStaffBasedBudgetApprovalRequestCode, RunWorkflowOnSendStaffBasedBudgetForApprovalCode);
        //
        //****************THL - PROCUREMENT MODULE CUSTOMIZATIONS**************************
        //1. Requisition
        RunWorkflowOnCancelRequisitionApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelRequisitionApprovalRequestCode, RunWorkflowOnSendRequisitionForApprovalCode);
        //
        //2. Vendor Registration
        RunWorkflowOnCancelVendorRegApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelVendorRegApprovalRequestCode, RunWorkflowOnSendVendorRegForApprovalCode);
        //
        //Ibrahim Wasiu
        //3. Procurement Plan
        RunWorkflowOnCancelProcurePlanApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelProcurePlanApprovalRequestCode, RunWorkflowOnSendProcurePlanForApprovalCode);
        //
        //4. Repair Requisition
        RunWorkflowOnCancelRepairRequestApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelRepairRequestApprovalRequestCode, RunWorkflowOnSendRepairRequestForApprovalCode);
        //
        //5. Work Ticket
        RunWorkflowOnCancelWorkTApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelWorkTApprovalRequestCode, RunWorkflowOnSendWorkTForApprovalCode);
        //
        //6. RFQ
        RunWorkflowOnCancelRFQApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelRFQApprovalRequestCode, RunWorkflowOnSendRFQForApprovalCode);
        //
        //7. Balance Score Card
        RunWorkflowOnCancelBalScoreCardApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelBalScoreCardApprovalRequestCode, RunWorkflowOnSendBalScoreCardForApprovalCode);
        //End: Ibrahim Wasiu
        //****************THL - HR MODULE CUSTOMIZATIONS**************************
        //1. Leave Application
        RunWorkflowOnCancelLeaveApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelLeaveApprovalRequestCode, RunWorkflowOnSendLeaveForApprovalCode);
        //
        //2. Appraisal
        RunWorkflowOnCancelAppraisalApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelAppraisalApprovalRequestCode, RunWorkflowOnSendAppraisalForApprovalCode);
        //
        //3. Orientation
        RunWorkflowOnCancelOrientationApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelOrientationApprovalRequestCode, RunWorkflowOnSendOrientationForApprovalCode);
        //
        //4. Medical Claim
        RunWorkflowOnCancelClaimApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelClaimApprovalRequestCode, RunWorkflowOnSendClaimForApprovalCode);
        //
        //5. CSR
        RunWorkflowOnCancelCSRApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelCSRApprovalRequestCode, RunWorkflowOnSendCSRForApprovalCode);
        //
        //6. Training
        RunWorkflowOnCancelTrainingApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelTrainingApprovalRequestCode, RunWorkflowOnSendTrainingForApprovalCode);
        //
        //7. Training Needs
        RunWorkflowOnCancelTrainingNeedsApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelTrainingNeedsApprovalRequestCode, RunWorkflowOnSendTrainingNeedsForApprovalCode);
        //
        //8. Recruitment
        RunWorkflowOnCancelRecruitmentApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelRecruitmentApprovalRequestCode, RunWorkflowOnSendRecruitmentForApprovalCode);
        //
        //9. Leave Plan
        RunWorkflowOnCancelLeavePlanApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelLeavePlanApprovalRequestCode, RunWorkflowOnSendLeavePlanForApprovalCode);
        //
        //10. Govt. Employee Appraisal Objectives
        RunWorkflowOnCancelEmpObjectivesApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelEmpObjectivesApprovalRequestCode, RunWorkflowOnSendEmpObjectivesForApprovalCode);
        //
        //11. Govt. Employee Appraisal
        RunWorkflowOnCancelEmpAppraisalApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelEmpAppraisalApprovalRequestCode, RunWorkflowOnSendEmpAppraisalForApprovalCode);
        //
        //12. Leave Adjustment
        RunWorkflowOnCancelLeaveAdjustApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelLeaveAdjustApprovalRequestCode, RunWorkflowOnSendLeaveAdjustForApprovalCode);
        //13. Recruitment Plan
        RunWorkflowOnCancelRecruitmentPlanApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelRecruitmentPlanApprovalRequestCode, RunWorkflowOnSendRecruitmentPlanForApprovalCode);
        //
        //14. Consolidated Recruitment Plan
        RunWorkflowOnCancelConsolidatedRecruitmentPlanApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelConsolidatedRecruitmentPlanApprovalRequestCode, RunWorkflowOnSendConsolidatedRecruitmentPlanForApprovalCode);
        //
        //15. Company Establishment
        RunWorkflowOnCancelCompanyEstablishmentApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelCompanyEstablishmentApprovalRequestCode, RunWorkflowOnSendCompanyEstablishmentForApprovalCode);
        //
        //************************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS***************************
        //
        //1. Job Worksheet
        RunWorkflowOnCancelJobWorksheetApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelJobWorksheetApprovalRequestCode, RunWorkflowOnSendJobWorksheetForApprovalCode);
        //
        //2. Service Worksheet
        RunWorkflowOnCancelServiceWorksheetApprovalRequestCode: WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelServiceWorksheetApprovalRequestCode, RunWorkflowOnSendServiceWorksheetForApprovalCode);
        //
        //
        WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode: begin
            //*****************THL - BASIC FINANCE MODULE CUSTOMIZATIONS********************
            //1. Payment Voucher
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPVForApprovalCode);
            //
            //*****************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS********************
            //1. Petty Cash
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPettyCashForApprovalCode);
            //
            //2. Imprest
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendImprestForApprovalCode);
            //
            //2. Imprest Memo
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendImprestMemoForApprovalCode);
            //
            //2. Imprest Payroll Claims
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendImprestPayrollClaimForApprovalCode);
            //
            //
            //4. Request For Payment
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendRequestForPaymentForApprovalCode);
            //
            //5. Supplementary Budget Request
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSupplementaryBudgetForApprovalCode);
            //
            //6. Staff Based Budget
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendStaffBasedBudgetForApprovalCode);
            //
            //*****************THL - PROCUREMENT MODULE CUSTOMIZATIONS********************
            //1. Requisition
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendRequisitionForApprovalCode);
            //
            //2. Vendor Registration Request
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendVendorRegForApprovalCode);
            //
            //Ibrahim Wasiu
            //3. Procurement Plan
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendProcurePlanForApprovalCode);
            //
            //4. Repair Requisition
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendRepairRequestForApprovalCode);
            //
            //5. Work Ticket
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendWorkTForApprovalCode);
            //
            //6. RFQ
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendRFQForApprovalCode);
            //
            //7. Balance Score Card
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendBalScoreCardForApprovalCode);
            //End: Ibrahim Wasiu
            //*****************THL - HR MODULE CUSTOMIZATIONS********************
            //1. Leave Application
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLeaveForApprovalCode);
            //
            //2. Appraisal
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendAppraisalForApprovalCode);
            //
            //3. Orientation
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendOrientationForApprovalCode);
            //
            //4. Medical Claim
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendClaimForApprovalCode);
            //
            //5. CSR
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendCSRForApprovalCode);
            //
            //6. Training
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendTrainingForApprovalCode);
            //
            //7. Training Needs
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendTrainingNeedsForApprovalCode);
            //
            //8. Recruitment
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendRecruitmentForApprovalCode);
            //
            //9. Leave Plan
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLeavePlanForApprovalCode);
            //
            //10. Govt. Employee Appraisal Objectives
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendEmpObjectivesForApprovalCode);
            //
            //11. Govt. Employee Appraisal
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendEmpAppraisalForApprovalCode);
            //
            //12. Leave Adjustment
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLeaveAdjustForApprovalCode);
            //13. Recruitment Plan
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendRecruitmentPlanForApprovalCode);
            //14. Consolidated Recruitment Plan
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendConsolidatedRecruitmentPlanForApprovalCode);
            //15. Company Establishment
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendCompanyEstablishmentForApprovalCode);
            //*****************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS********************
            //
            //1. Job Worksheet
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendJobWorksheetForApprovalCode);
            //
            //2. Service Worsheet
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendServiceWorksheetForApprovalCode);
        //
        end;
        WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode: begin
            //******************THL - BASIC FINANCE MODULE CUSTOMIZATIONS*********************
            //1. Payment Voucher
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPVForApprovalCode);
            //
            //******************THL - ADVANCED FINANCE MODULE CUSTOMIZATIONS*********************
            //1. Petty Cash
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPettyCashForApprovalCode);
            //
            //2. Imprest
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendImprestForApprovalCode);
            //
            //2. Imprest Memo
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendImprestMemoForApprovalCode);
            //
            //2. Imprest Payroll Claims
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendImprestPayrollClaimForApprovalCode);
            //
            //
            //4. Request For Payment
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendRequestForPaymentForApprovalCode);
            // 
            //5. Supplementary Budget Request
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSupplementaryBudgetForApprovalCode);
            // 
            //6. Staff Based Budget
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendStaffBasedBudgetForApprovalCode);
            //
            //******************THL - PROCUREMENT MODULE CUSTOMIZATIONS*********************
            //1. Requisition
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendRequisitionForApprovalCode);
            //
            //1. Vendor Registration Request
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendVendorRegForApprovalCode);
            //
            //Ibrahim Wasiu
            //3. Procurement Plan
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendProcurePlanForApprovalCode);
            //
            //4. Repair Requisition
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendRepairRequestForApprovalCode);
            //
            //5. Work Ticket
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendWorkTForApprovalCode);
            //
            //6. RFQ-RFP
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendRFQForApprovalCode);
            //
            //7. Balance Score Card
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendBalScoreCardForApprovalCode);
            //End: Ibrahim Wasiu
            //******************THL - HR MODULE CUSTOMIZATIONS*********************
            //1. Leave Application
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLeaveForApprovalCode);
            //
            //2. Appraisal
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendAppraisalForApprovalCode);
            //
            //3. Orientation
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendOrientationForApprovalCode);
            //
            //4. Medical Claim
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendClaimForApprovalCode);
            //
            //5. CSR
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendCSRForApprovalCode);
            //
            //6. Training
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendTrainingForApprovalCode);
            //
            //7. Training Needs
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendTrainingNeedsForApprovalCode);
            //
            //8. Recruitment
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendRecruitmentForApprovalCode);
            //
            //9. Leave Plan
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLeavePlanForApprovalCode);
            //
            //10. Govt. Employee Appraisal Objectives
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendEmpObjectivesForApprovalCode);
            //
            //11. Govt. Employee Appraisal
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendEmpAppraisalForApprovalCode);
            //
            //12. Leave Adjustment
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLeaveAdjustForApprovalCode);
            //13. Recruitment Plan
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendRecruitmentPlanForApprovalCode);
            //14. Consolidated RecruitmentPlan
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendConsolidatedRecruitmentPlanForApprovalCode);
            //15. Company Establishment
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendCompanyEstablishmentForApprovalCode);
            //
            //*****************THL - SERVICE MANAGEMENT MODULE CUSTOMIZATIONS********************
            //
            //1. Job Worksheet
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendJobWorksheetForApprovalCode);
            //
            //2. Service Worksheet
            WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendServiceWorksheetForApprovalCode);
        //
        end;
        end;
    end;
//#endregion
}
