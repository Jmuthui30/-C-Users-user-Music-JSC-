codeunit 52396 "Appraisal Related HR Mgt."
{
    procedure OpenRelatedGrievances(var EmployeeAppraisal: Record "Employee Appraisal")
    var
        UserGrievance: Record "User Grievances";
        ReviewFrom: Date;
        ReviewTo: Date;
    begin
        EmployeeAppraisal.TestField("Employee No");
        GetReviewDateRange(EmployeeAppraisal, ReviewFrom, ReviewTo);

        UserGrievance.SetRange("Employee No", EmployeeAppraisal."Employee No");
        ApplyDateFilter(UserGrievance, ReviewFrom, ReviewTo);
        Page.RunModal(Page::"Incidences/Grievances", UserGrievance);
    end;

    procedure OpenRelatedDisciplinaryCases(var EmployeeAppraisal: Record "Employee Appraisal")
    var
        StaffDisciplinary: Record "Staff Disciplinary";
        ReviewFrom: Date;
        ReviewTo: Date;
    begin
        EmployeeAppraisal.TestField("Employee No");
        GetReviewDateRange(EmployeeAppraisal, ReviewFrom, ReviewTo);

        StaffDisciplinary.SetRange("Employee No", EmployeeAppraisal."Employee No");
        ApplyDateFilter(StaffDisciplinary, ReviewFrom, ReviewTo);
        Page.RunModal(Page::"Staff Displinary Cases", StaffDisciplinary);
    end;

    local procedure GetReviewDateRange(var EmployeeAppraisal: Record "Employee Appraisal"; var ReviewFrom: Date; var ReviewTo: Date)
    begin
        EmployeeAppraisal.CalcFields("Review Start Date", "Review End Date");
        ReviewFrom := EmployeeAppraisal."Review Start Date";
        ReviewTo := EmployeeAppraisal."Review End Date";

        if ReviewFrom = 0D then
            ReviewFrom := EmployeeAppraisal."Period Start";
        if ReviewTo = 0D then
            ReviewTo := EmployeeAppraisal."Period End";
    end;

    local procedure ApplyDateFilter(var UserGrievance: Record "User Grievances"; ReviewFrom: Date; ReviewTo: Date)
    begin
        if (ReviewFrom <> 0D) and (ReviewTo <> 0D) then
            UserGrievance.SetRange(Date, ReviewFrom, ReviewTo)
        else
            if ReviewFrom <> 0D then
                UserGrievance.SetFilter(Date, '>=%1', ReviewFrom)
            else
                if ReviewTo <> 0D then
                    UserGrievance.SetFilter(Date, '<=%1', ReviewTo);
    end;

    local procedure ApplyDateFilter(var StaffDisciplinary: Record "Staff Disciplinary"; ReviewFrom: Date; ReviewTo: Date)
    begin
        if (ReviewFrom <> 0D) and (ReviewTo <> 0D) then
            StaffDisciplinary.SetRange(Date, ReviewFrom, ReviewTo)
        else
            if ReviewFrom <> 0D then
                StaffDisciplinary.SetFilter(Date, '>=%1', ReviewFrom)
            else
                if ReviewTo <> 0D then
                    StaffDisciplinary.SetFilter(Date, '<=%1', ReviewTo);
    end;
}
