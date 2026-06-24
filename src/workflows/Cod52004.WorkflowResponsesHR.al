codeunit 52004 "Workflow Responses HR"
{
    trigger OnRun()
    begin
    end;

    var
        Committment: Codeunit "Commitments Mgt HR";
        HRMgnt: Codeunit "HR Management";

    procedure ReleaseLeaveRecallRequest(var LeaveRecall: Record "Employee Off/Holiday")
    var
        LeaveRec: Record "Employee Off/Holiday";
    begin
        LeaveRec.Reset();
        LeaveRec.SetRange("No.", LeaveRecall."No.");
        if LeaveRec.FindFirst() then begin
            LeaveRec.Status := LeaveRec.Status::Released;
            LeaveRec.Modify(true);
            //Recall
            HRMgnt.LeaveRecall(LeaveRec."No.");
        end;
    end;

    procedure ReopenLeaveRecallRequest(var LeaveRecall: Record "Employee Off/Holiday")
    var
        LeaveRec: Record "Employee Off/Holiday";
    begin
        LeaveRec.Reset();
        LeaveRec.SetRange("No.", LeaveRecall."No.");
        if LeaveRec.FindFirst() then begin
            LeaveRec.Status := LeaveRecall.Status::Open;
            LeaveRec.Modify(true)
        end;
    end;

    procedure ReleaseLeave(var LeaveReq: Record "Leave Application")
    var
        Leave: Record "Leave Application";
    begin
        Leave.Reset();
        Leave.SetRange("Application No", LeaveReq."Application No");
        if Leave.FindFirst() then begin
            Leave.Validate(Status, Leave.Status::Released);
            Leave.Modify(true);
            Commit();
            HRMgnt.NotifyLeaveReliever(Leave."Application No");
            if Leave.FindFirst() then
                HRMgnt.LeaveApplication(Leave."Application No");

        end;
    end;

    procedure ReopenLeave(var LeaveReq: Record "Leave Application")
    var
        Leave: Record "Leave Application";
    begin

        if leave.Get(LeaveReq."Application No") then begin
            Leave."Status" := Leave."Status"::Open;

            Leave.Modify(true);
        end;
    end;



    procedure ReleaseLeaveEntitlementRequest(var LeaveEntitle: Record Employee)
    begin
    end;

    procedure ReopenLeaveEntitlementRequest(var LeaveEntitle: Record Employee)
    begin
    end;





    procedure ReleaseRecruitment(var RecruitmentReq: Record "Recruitment Needs")
    var
        Recruitment: Record "Recruitment Needs";
    begin
        Recruitment.Reset();
        Recruitment.SetRange("No.", RecruitmentReq."No.");
        if Recruitment.FindFirst() then begin
            RecruitmentReq.Status := RecruitmentReq.Status::Released;
            RecruitmentReq.Modify(true);
        end;


    end;

    procedure ReopenRecruitment(var RecruitmentReq: Record "Recruitment Needs")
    var
        Recruitment: Record "Recruitment Needs";
    begin
        RecruitmentReq.Reset();
        RecruitmentReq.SetRange("No.", Recruitment."No.");
        if RecruitmentReq.FindFirst() then begin
            RecruitmentReq.Status := RecruitmentReq.Status::Open;
            RecruitmentReq.Modify(true)
        end;
    end;






    procedure ReleaseLeaveAdj(LeaveAdj: Record "Leave Bal Adjustment Header")
    var
        LeaveAdjRec: Record "Leave Bal Adjustment Header";
    begin
        if LeaveAdjRec.Get(LeaveAdj.Code) then begin
            LeaveAdjRec.Status := LeaveAdjRec.Status::Released;
            LeaveAdjRec.Modify();
        end;
    end;

    procedure ReopenLeaveAdj(LeaveAdj: Record "Leave Bal Adjustment Header")
    var
        LeaveAdjRec: Record "Leave Bal Adjustment Header";
    begin
        if LeaveAdjRec.Get(LeaveAdj.Code) then begin
            LeaveAdjRec.Status := LeaveAdjRec.Status::Open;
            LeaveAdjRec.Modify();
        end;
    end;


    // New Employee Application
    procedure ReleaseNewEmployeeApplication(var Emp: Record Employee)
    var
        Employee: Record Employee;
    begin
        Employee.Reset();
        Employee.SetRange("No.", Emp."No.");
        if Employee.FindFirst() then begin
            Employee."Approval Status" := Employee."Approval Status"::Approved;
            Employee.Modify(true);
        end;
    end;

    procedure ReopenNewEmployeeApplication(var Emp: Record Employee)
    var
        Employee: Record Employee;
    begin
        Employee.Reset();
        Employee.SetRange("No.", Emp."No.");
        if Employee.FindFirst() then begin
            Employee."Approval Status" := Employee."Approval Status"::Open;
            Employee.Modify(true);
        end;
    end;

    procedure ReleaseEmployeeAppraisalRequest(var Appraisal: Record "Employee Appraisal")
    var
        EmployeeApp: Record "Employee Appraisal";
    begin
        EmployeeApp.Reset();
        EmployeeApp.SetRange("Appraisal No", Appraisal."Appraisal No");
        if EmployeeApp.FindFirst() then begin


            EmployeeApp.Status := EmployeeApp.Status::Released;
            EmployeeApp."Appraisal Status" := EmployeeApp."Appraisal Status"::Review;
            EmployeeApp.Modify(true);
        end;
    end;

    procedure ReopenEmployeeAppraisalRequest(var Appraisal: Record "Employee Appraisal")
    var
        EmployeeApp: Record "Employee Appraisal";
    begin
        EmployeeApp.Reset();
        EmployeeApp.SetRange("Appraisal No", Appraisal."Appraisal No");
        if EmployeeApp.FindFirst() then begin
            EmployeeApp.Status := EmployeeApp.Status::Open;
            EmployeeApp."Appraisal Status" := EmployeeApp."Appraisal Status"::Setting;
            EmployeeApp.Modify(true);
        end;
    end;

    procedure ReopenTrainingRequest(var TrainingReq: Record "Training Request")
    var
        TrainingRequest: Record "Training Request";
    begin
        TrainingRequest.Reset();
        TrainingRequest.SetRange("Request No.", TrainingReq."Request No.");
        if TrainingRequest.FindFirst() then begin
            TrainingRequest.Status := TrainingRequest.Status::Open;
            TrainingRequest.Modify(true)
        end;
    end;

    procedure ReleaseTrainingRequest(var TrainingReq: Record "Training Request")
    var
        TrainingRequest: Record "Training Request";
    begin
        TrainingRequest.Reset();
        TrainingRequest.SetRange("Request No.", TrainingReq."Request No.");
        if TrainingRequest.FindFirst() then begin
            TrainingRequest.Status := TrainingRequest.Status::Released;
            TrainingRequest.Modify(true);
        end;
        HRMgnt.NotifyTrainingRequest(TrainingRequest."Request No.");
    end;
    // EmployeeChangeRequest 
    procedure ReopenEmployeeChangeRequest(var EmployeeChangeReq: Record "Employee Change Request")
    var
        EmployeeChangeRequest: Record "Employee Change Request";
    begin
        EmployeeChangeRequest.Reset();
        EmployeeChangeRequest.SetRange(Number, EmployeeChangeReq.Number);
        if EmployeeChangeRequest.FindFirst() then begin
            EmployeeChangeRequest."Approval Status" := EmployeeChangeRequest."Approval Status"::"Pending Approval";
            EmployeeChangeRequest.Modify(true)
        end;
    end;

    procedure ReleaseEmployeeChangeRequest(var EmployeeChangeReq: Record "Employee Change Request")
    var
        EmployeeChangeRequest: Record "Employee Change Request";
    begin
        EmployeeChangeRequest.Reset();
        EmployeeChangeRequest.SetRange(Number, EmployeeChangeReq.Number);
        if EmployeeChangeRequest.FindFirst() then begin
            EmployeeChangeRequest."Approval Status" := EmployeeChangeRequest."Approval Status"::Approved;
            EmployeeChangeRequest.Modify(true);
        end;
    end;

}
