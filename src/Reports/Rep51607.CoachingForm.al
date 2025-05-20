report 51607 "Coaching Form"
{
    // version THL- HRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Coaching Form.rdlc';

    dataset
    {
        dataitem("Staff Coaching Header"; "Staff Coaching Header")
        {
            column(Logo; CompInfo.Picture)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(DateOfCounsel; "Staff Coaching Header".Date)
            {
            }
            column(CounsellorName; "Staff Coaching Header"."Counsellor Name")
            {
            }
            column(CounselleeName; "Staff Coaching Header"."Counsellee's Name")
            {
            }
            column(GradeLevelOfCounsellee; GradeLevel)
            {
            }
            column(ReasonForCoaching; "Staff Coaching Header"."Reason for Coaching")
            {
            }
            column(FreeToexpressSelf; "Staff Coaching Header"."Staff Free to Express Self")
            {
            }
            column(Comfortable; "Staff Coaching Header"."Staff Comfortable")
            {
            }
            column(MoreNotes; "Staff Coaching Header"."More Notes")
            {
            }
            column(IssuesCanAffectPerformance; "Staff Coaching Header"."Issues Affect Performance")
            {
            }
            column(Date; "Staff Coaching Header".Date)
            {
            }
            dataitem(IssueLines; "Coaching Performance Lines")
            {
                DataItemLink = "No." = FIELD("No.");

                column(IssueDescription; IssueLines.Description)
                {
                }
            }
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        GradeLevel: Text;
}
