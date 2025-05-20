report 51600 "Leave Application"
{
    // version THL- HRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Leave Application.rdl';

    dataset
    {
        dataitem("Employee Leave Application"; "Employee Leave Application")
        {
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(CompName; CompanyInfo.Name)
            {
            }
            column(DeptName; "Employee Leave Application"."Global Dimension 1 Code")
            {
            }
            column(Grade; Grade)
            {
            }
            column(Annual; Annual)
            {
            }
            column(Casual; Casual)
            {
            }
            column(Examination; Examination)
            {
            }
            column(Absent; Absent)
            {
            }
            column(Maternity; Maternity)
            {
            }
            column(CompAddress; StrSubstNo(TXT002, CompanyInfo.Address, CompanyInfo."Post Code", CompanyInfo.City))
            {
            }
            column(AppNo; "Application No")
            {
            }
            column(AppDate; "Application Date")
            {
            }
            column(EmpNo; "Employee No")
            {
            }
            column(EmpName; UpperCase(Name))
            {
            }
            column(LeaveCode; "Leave Code")
            {
            }
            column(StartDate; "Start Date")
            {
            }
            column(EndDate; "End Date")
            {
            }
            column(ResumptionDate; "Resumption Date")
            {
            }
            column(DaysApplied; "Days Applied")
            {
            }
            column(Entitlement; "Leave Entitlment")
            {
            }
            column(DaysTakenToDate; "Total Leave Days Taken")
            {
            }
            column(LeaveBalance; "Leave balance" - "Days Applied")
            {
            }
            column(AllowancePayable; "Employee Leave Application"."Leave Allowance Payable")
            {
            }
            column(Approver1; "1stApproverName")
            {
            }
            column(Approver1Sign; UserRecApp1.Signature)
            {
            }
            column(Approver2; "2ndApproverName")
            {
            }
            column(Approver2Sign; UserRecApp2.Signature)
            {
            }
            column(Approver3; "3rdApproverName")
            {
            }
            column(Approver3Sign; UserRecApp3.Signature)
            {
            }
            column(Approver1Date; "1stapproverdate")
            {
            }
            column(Approver2Date; "2ndapproverdate")
            {
            }
            column(Approver3Date; "3rdapproverdate")
            {
            }
            column(BalanceBF; "Employee Leave Application"."Balance brought forward")
            {
            }
            column(LeaveEarnedToDate; "Employee Leave Application"."Leave Earned to Date")
            {
            }
            column(NoDaysApplied; "Employee Leave Application"."Days Applied")
            {
            }
            column(DutiesTakenBy; UpperCase("Employee Leave Application"."Reliever Name"))
            {
            }
            column(PhoneNo; "Employee Leave Application"."Mobile No")
            {
            }
            column(Address; "Employee Leave Application".Comments)
            {
            }
            column(Year; Date2DMY("Employee Leave Application"."Maturity Date", 3))
            {
            }
            trigger OnAfterGetRecord()
            begin
                if EmpRec.Get("Employee Leave Application"."Employee No")then Grade:=EmpRec.Scale;
                if "Employee Leave Application"."Leave Code" = 'ANNUAL' then Annual:=false;
                if "Employee Leave Application"."Leave Code" = 'CASUAL' then Casual:=false;
                if "Employee Leave Application"."Leave Code" = 'EXAMINATION' then Examination:=false;
                if "Employee Leave Application"."Leave Code" = 'ABSENT' then Absent:=false;
                if "Employee Leave Application"."Leave Code" = 'MATERNITY' then Maternity:=false;
                ApprovalEntries.Reset;
                ApprovalEntries.SetRange(ApprovalEntries."Table ID", 51602);
                ApprovalEntries.SetRange(ApprovalEntries."Document No.", "Employee Leave Application"."Application No");
                ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-')then begin
                    i:=0;
                    repeat i:=i + 1;
                        if i = 1 then begin
                            "1stapprover":=ApprovalEntries."Approver ID";
                            "1stapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp1.Get("1stapprover")then UserRecApp1.CalcFields(UserRecApp1.Signature);
                        end;
                        if i = 2 then begin
                            "2ndapprover":=ApprovalEntries."Approver ID";
                            "2ndapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp2.Get("2ndapprover")then UserRecApp2.CalcFields(UserRecApp2.Signature);
                        end;
                        if i = 3 then begin
                            "3rdapprover":=ApprovalEntries."Approver ID";
                            "3rdapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp3.Get("3rdapprover")then UserRecApp3.CalcFields(UserRecApp3.Signature);
                        end;
                    until ApprovalEntries.Next = 0;
                end;
                //Get names
                UsersRec.Reset;
                UsersRec.SetCurrentKey("User Name");
                UsersRec.SetRange("User Name", "1stapprover");
                if UsersRec.FindLast then "1stApproverName":=UsersRec."Full Name";
                UsersRec.Reset;
                UsersRec.SetCurrentKey("User Name");
                UsersRec.SetRange("User Name", "2ndapprover");
                if UsersRec.FindLast then "2ndApproverName":=UsersRec."Full Name";
                UsersRec.Reset;
                UsersRec.SetCurrentKey("User Name");
                UsersRec.SetRange("User Name", "3rdapprover");
                if UsersRec.FindLast then "3rdApproverName":=UsersRec."Full Name";
            end;
            trigger OnPreDataItem()
            begin
                CompanyInfo.CalcFields(CompanyInfo.Picture);
            end;
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
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
        Annual:=true;
        Casual:=true;
        Examination:=true;
        Absent:=true;
        Maternity:=true;
    end;
    var CompanyInfo: Record "Company Information";
    DeptName: Text;
    Grade: Text;
    Annual: Boolean;
    Casual: Boolean;
    Examination: Boolean;
    Absent: Boolean;
    Maternity: Boolean;
    TXT001: Label '%1 %2';
    TXT002: Label '%1, %2  %3';
    LEAVE_APPLICATION_FORMCaptionLbl: Label 'LEAVE APPLICATION FORM';
    Less___Days_Taken_To_DateCaptionLbl: Label 'Less : Days Taken To Date';
    Annual_Leave_Entitlement_BalanceCaptionLbl: Label 'Annual Leave Entitlement Balance';
    APPROVALCaptionLbl: Label 'APPROVAL';
    APPLICANTCaptionLbl: Label 'APPLICANT';
    SIGNATURECaptionLbl: Label 'SIGNATURE';
    IMMEDIATE_SUPERVISORCaptionLbl: Label 'IMMEDIATE SUPERVISOR';
    SIGNATURECaption_Control1000000021Lbl: Label 'SIGNATURE';
    DATE__________________________________________________CaptionLbl: Label 'DATE _________________________________________________';
    DATE__________________________________________________Caption_Control1000000055Lbl: Label 'DATE _________________________________________________';
    DG_HODCaptionLbl: Label 'DG/HOD';
    SIGNATURE_CaptionLbl: Label 'SIGNATURE ';
    DATE__________________________________________________Caption_Control1000000060Lbl: Label 'DATE _________________________________________________';
    Balance_Brought_ForwardCaptionLbl: Label 'Balance Brought Forward';
    Leave_Earned_to_DateCaptionLbl: Label 'Leave Earned to Date';
    Less___Leave_Now_Applied_ForCaptionLbl: Label 'Less : Leave Now Applied For';
    ApprovalEntries: Record "Approval Entry";
    "1stapprover": Text[30];
    "2ndapprover": Text[30];
    i: Integer;
    "1stapproverdate": DateTime;
    "2ndapproverdate": DateTime;
    UserRec: Record "User Setup";
    UserRecApp1: Record "User Setup";
    UserRecApp2: Record "User Setup";
    UserRecApp3: Record "User Setup";
    "3rdapprover": Text[30];
    "3rdapproverdate": DateTime;
    "1stApproverName": Text;
    "2ndApproverName": Text;
    "3rdApproverName": Text;
    UsersRec: Record User;
    EmpRec: Record "Employee Master";
}
