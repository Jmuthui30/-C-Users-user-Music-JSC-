report 51841 "Education Verification Letter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Education Verification Letter.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.";

            column(UNIVERSITY; UNIVERSITY)
            {
            }
            column(DEGREE; DEGREE)
            {
            }
            column(STARTDATE; STARTDATE)
            {
            }
            column(ENDDATE; ENDDATE)
            {
            }
            column(HRMNAME; HRMNAME)
            {
            }
            column(HRMTITLE; HRMTITLE)
            {
            }
            column(HRMPHONE; HRMPHONE)
            {
            }
            column(HRMEMAIL; HRMEMAIL)
            {
            }
            column(REFDATE; REFDATE)
            {
            }
            column(INSTITUTIONADDRESS; INSTITUTIONADDRESS)
            {
            }
            column(INSTITUTIONCITY; INSTITUTIONCITY)
            {
            }
            column(INSTITUTIONZIPCODE; INSTITUTIONZIPCODE)
            {
            }
            column(FNAME; Employee."First Name")
            {
            }
            column(FULLNAME; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
            {
            }
            column(REFERENCE; REFERENCE)
            {
            }
            trigger OnAfterGetRecord()
            begin
                REFERENCE:=UpperCase(StrSubstNo(Text000, Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name"));
                //Priority to the selected
                QualificationsRec.Reset;
                QualificationsRec.SetCurrentKey("Employee No.", "Line No.");
                QualificationsRec.SetRange("Employee No.", Employee."No.");
                QualificationsRec.SetRange(Select, true);
                if QualificationsRec.FindFirst then begin
                    UNIVERSITY:=UpperCase(QualificationsRec."Institution/Company");
                    DEGREE:=UpperCase(QualificationsRec.Description);
                    STARTDATE:=QualificationsRec."From Date";
                    ENDDATE:=QualificationsRec."To Date";
                    REFDATE:=Today;
                    INSTITUTIONADDRESS:=QualificationsRec.Address;
                    INSTITUTIONCITY:=QualificationsRec."City/State";
                    INSTITUTIONZIPCODE:=QualificationsRec."Zip/Postal Code";
                end
                else
                begin
                    //Then the last
                    QualificationsRec.Reset;
                    QualificationsRec.SetCurrentKey("Employee No.", "Line No.");
                    QualificationsRec.SetRange("Employee No.", Employee."No.");
                    if QualificationsRec.FindLast then begin
                        UNIVERSITY:=UpperCase(QualificationsRec."Institution/Company");
                        DEGREE:=UpperCase(QualificationsRec.Description);
                        STARTDATE:=QualificationsRec."From Date";
                        ENDDATE:=QualificationsRec."To Date";
                        REFDATE:=Today;
                        INSTITUTIONADDRESS:=QualificationsRec.Address;
                        INSTITUTIONCITY:=QualificationsRec."City/State";
                        INSTITUTIONZIPCODE:=QualificationsRec."Zip/Postal Code";
                    end;
                end;
                HRSetup.Get;
                HRSetup.TestField("HR Manager");
                if EmpRec.Get(HRSetup."HR Manager")then begin
                    HRMNAME:=EmpRec."Last Name" + ' ' + EmpRec."First Name" + ' ' + EmpRec."Middle Name";
                    HRMTITLE:=EmpRec."Job Title";
                    HRMPHONE:=EmpRec."Phone No.";
                    HRMEMAIL:=EmpRec."Company E-Mail";
                end;
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
    var QualificationsRec: Record "HR_Employee Qualifications";
    UNIVERSITY: Text;
    DEGREE: Text;
    STARTDATE: Date;
    ENDDATE: Date;
    HRMNAME: Text;
    HRMTITLE: Text;
    HRMPHONE: Text;
    HRMEMAIL: Text;
    HRSetup: Record "QuantumJumps HR Setup";
    EmpRec: Record Employee;
    REFDATE: Date;
    INSTITUTIONADDRESS: Text;
    INSTITUTIONCITY: Text;
    INSTITUTIONZIPCODE: Text;
    REFERENCE: Text;
    Text000: Label 'RE: REFERENCE FOR %1';
}
