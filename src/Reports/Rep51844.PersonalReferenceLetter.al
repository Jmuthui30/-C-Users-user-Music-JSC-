report 51844 "Personal Reference Letter"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Personal Reference Letter.rdlc';

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
                QualificationsRec.SetCurrentKey(No, Names);
                QualificationsRec.SetRange(No, Employee."No.");
                QualificationsRec.SetRange(Select, true);
                if QualificationsRec.FindFirst then begin
                    UNIVERSITY:=UpperCase(QualificationsRec.Names);
                    DEGREE:=UpperCase(QualificationsRec.Company);
                    REFDATE:=Today;
                    INSTITUTIONADDRESS:=QualificationsRec.Address;
                    INSTITUTIONCITY:=QualificationsRec."Telephone No";
                    INSTITUTIONZIPCODE:=QualificationsRec."E-Mail";
                end
                else
                begin
                    //Then the last
                    QualificationsRec.Reset;
                    QualificationsRec.SetCurrentKey(No, Names);
                    QualificationsRec.SetRange(No, Employee."No.");
                    if QualificationsRec.FindLast then begin
                        UNIVERSITY:=UpperCase(QualificationsRec.Names);
                        DEGREE:=UpperCase(QualificationsRec.Company);
                        REFDATE:=Today;
                        INSTITUTIONADDRESS:=QualificationsRec.Address;
                        INSTITUTIONCITY:=QualificationsRec."Telephone No";
                        INSTITUTIONZIPCODE:=QualificationsRec."E-Mail";
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
    var QualificationsRec: Record Referees;
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
