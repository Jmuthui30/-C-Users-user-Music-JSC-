codeunit 50007 "HR Functions"
{
    procedure fn_GetStaffName(PARAM_StaffNo: Code[20]): Text var
        HREmp: Record Employee;
    begin
        HREmp.Reset();
        if HREmp.Get(PARAM_StaffNo)then exit(HREmp."Search Name")
        else
            exit('');
    end;
    procedure fn_HRChangeLog(FieldName: Text; StaffNo: Code[20]; OldValue: Text; NewValue: Text; PayrollPeirod: Date)
    var
        Reason1: Text;
    begin
    end;
    procedure fn_StyleText(Status: Text): Text begin
        case Status of 'Approved': exit('StandardAccent');
        'Pending Approval': exit('Attention');
        end;
    end;
}
