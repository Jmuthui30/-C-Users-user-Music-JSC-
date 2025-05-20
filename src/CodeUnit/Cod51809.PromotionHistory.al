codeunit 51809 "Promotion History"
{
    trigger OnRun()
    begin
    end;
    var Emp: Record "Employee Master";
    PromotionRec: Record "Promotion History";
    Employee: Record Employee;
    CompanyJobs: Record "Company Jobs";
    procedure ProcessPromotion_First(EmployeeNo: Code[20]; StartDate: Date; HrRemarks: Text; JobPosition: Code[20])
    begin
        PromotionRec.Init;
        PromotionRec."Employee No":=EmployeeNo;
        PromotionRec.Position:=JobPosition;
        PromotionRec.Validate(Position);
        PromotionRec."Start Date":=StartDate;
        PromotionRec."HR Remarks":=HrRemarks;
        PromotionRec."Last Modified":=Today;
        PromotionRec.Insert(true);
        if Emp.Get(EmployeeNo)then begin
            Emp.Position:=JobPosition;
            Emp."Job ID":=JobPosition;
            if Employee.Get(EmployeeNo)then begin
                CompanyJobs.Reset;
                CompanyJobs.SetRange("Job ID", JobPosition);
                if CompanyJobs.FindFirst then begin
                    Employee."Job Title":=CompanyJobs.Name;
                    Employee.Modify;
                    Emp."Job Title":=CompanyJobs.Name;
                end end;
            Emp.Modify;
        end;
    end;
    procedure ProcessPromotion_Second(EmployeeNo: Code[20]; StartDate: Date; HrRemarks: Text; JobPosition: Code[20])
    begin
        ClosePreviousPosition(EmployeeNo, StartDate);
        PromotionRec.Init;
        PromotionRec."Employee No":=EmployeeNo;
        PromotionRec.Position:=JobPosition;
        PromotionRec.Validate(Position);
        PromotionRec."Start Date":=StartDate;
        PromotionRec."HR Remarks":=HrRemarks;
        PromotionRec."Last Modified":=Today;
        PromotionRec.Insert(true);
        if Emp.Get(EmployeeNo)then begin
            if Employee.Get(EmployeeNo)then begin
                CompanyJobs.Reset;
                CompanyJobs.SetRange("Job ID", JobPosition);
                if CompanyJobs.FindFirst then begin
                    Employee."Job Title":=CompanyJobs.Name;
                    Employee.Modify;
                    Emp."Job Title":=CompanyJobs.Name;
                end;
                Emp.Position:=JobPosition;
                Emp.Modify;
            end;
        end;
    end;
    local procedure ClosePreviousPosition(var EmployeeNo: Code[20]; var EndDate: Date)
    begin
        PromotionRec.Reset;
        PromotionRec.SetRange("Employee No", EmployeeNo);
        PromotionRec.SetRange("End Date", 0D);
        PromotionRec.SetRange("Position Closed", false);
        if PromotionRec.FindLast then begin
            PromotionRec."End Date":=EndDate;
            PromotionRec."Position Closed":=true;
            PromotionRec.Modify;
        end;
    end;
}
