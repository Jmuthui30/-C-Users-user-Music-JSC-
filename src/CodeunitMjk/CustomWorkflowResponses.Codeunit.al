Codeunit 50341 "Custom Workflow Responses"
{
    trigger OnRun()
    begin
    end;

    var
        WFEventHandler: Codeunit "Workflow Event Handling";
        WFResponseHandler: Codeunit "Workflow Response Handling";
        MsgToSend: Text[250];
        CompanyInfo: Record "Company Information";
    // AFactory: Codeunit "ALTAIRETRO Factory";

    procedure AddResponsesToLib()
    begin
        AddResponsePredecessors();
    end;

    procedure AddResponsePredecessors()
    begin
        //-----------------------------End AddOn--------------------------------------------------------------------------------------
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', true, true)]
    procedure SetStatusToPendingApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        IsHandled: Boolean;
        MembershipApplication: Record "Employee Change Request";

    begin
        case RecRef.Number of //PettyCash Reimbursement


            //Membership Application
            Database::"Employee Change Request":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate("Approval Status", MembershipApplication."Approval Status"::"Pending Approval");
                    MembershipApplication.Modify(true);
                    Variant := MembershipApplication;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        MembershipApplication: Record "Employee Change Request";
    begin
        case RecRef.Number of

            //Membership Application
            DATABASE::"Employee Change Request":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication."Approval Status" := MembershipApplication."Approval Status"::Open;
                    MembershipApplication.Modify(true);
                    Handled := true;
                end;
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        MembershipApplication: Record "Employee Change Request";
    begin
        RecRef.GetTable(Variant);
        case RecRef.Number of


            //Membership Application
            Database::"Employee Change Request":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate("Approval Status", MembershipApplication."Approval Status"::"Pending Approval");
                    MembershipApplication.Modify(true);
                    IsHandled := true;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnExecuteWorkflowResponse', '', true, true)]
    local procedure SetRecStatusToPendingApproval(var Variant: Variant)
    var
        RecRef: RecordRef;
        IsHandled: Boolean;
        MembershipApplication: Record "Employee Change Request";
    begin
        case RecRef.Number of


            //Membership Application
            Database::"Employee Change Request":
                begin
                    RecRef.SetTable(MembershipApplication);
                    MembershipApplication.Validate("Approval Status", MembershipApplication."Approval Status"::Approved);
                    MembershipApplication.Modify(true);
                    Variant := MembershipApplication;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        MemberShipApp: Record "Employee Change Request";
    begin
        case RecRef.Number of


            //Membership applications
            DATABASE::"Employee Change Request":
                begin
                    RecRef.SetTable(MemberShipApp);
                    MemberShipApp."Approval Status" := MemberShipApp."Approval Status"::Approved;
                    MemberShipApp.Modify(true);
                    Handled := true;
                    Message('Status is %1', MemberShipApp."Approval Status");
                end;


        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        MemberShipApp: Record "Employee Change Request";
    begin
        case RecRef.Number of
        //Travel Requests

        //Leave Application
        // Database::"Employee Change Request":
        //     begin
        //         // RecRef.SetTable(LoansRegister);
        //         ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::LoanApplication;
        //         ApprovalEntryArgument."Document No." := MemberShipApp."Loan  No.";
        //         ApprovalEntryArgument.Description := MemberShipApp."Loan  No." + '_' + LoansRegister."Client Name";
        //         ApprovalEntryArgument.Amount := MemberShipApp."Approved Amount";
        //         ApprovalEntryArgument."Salespers./Purch. Code" := '';
        //     end;
        end;
    end;
}
