table 51861 "HR Company or Other Training"
{
    fields
    {
        field(1; "Employee No."; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Employee."No.";
        }
        field(2; "Course Title"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Training Needs".Code;

            trigger OnValidate()
            begin
                if TrainingNeeds.Get("Course Title")then Description:=TrainingNeeds.Description;
            end;
        }
        field(3; "Cost Incurred By Employee"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Posted then begin
                    if Results <> xRec.Results then begin
                        Message('%1', 'You cannot change the costs after posting');
                        Results:=xRec.Results;
                    end end end;
        }
        field(4; "Educaion Credits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Training Credits"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Certificate Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Results; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Competency; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Competent, "Not yet competent";

            trigger OnValidate()
            begin
                if Competency <> xRec.Competency then begin
                    if Competency = Competency::Competent then begin
                        if TrainingNeeds.Get("Course Title")then begin
                            if Qualifications.Get(TrainingNeeds.Qualification)then begin
                                EmpQualifications.Init;
                                EmpQualifications."Employee No.":="Employee No.";
                                EmpQualifications."Qualification Type":=Qualifications.Type;
                                EmpQualifications."Qualification Code":=Qualifications.Code;
                                EmpQualifications.Validate(EmpQualifications."Qualification Code");
                                EmpQualifications."From Date":=TrainingNeeds."Start Date";
                                EmpQualifications."To Date":=TrainingNeeds."End Date";
                                EmpQualifications.Type:=EmpQualifications.Type::Internal;
                                EmpQualifications."Institution/Company":=TrainingNeeds.Provider;
                                EmpQualifications.Insert;
                            end;
                        end;
                    end;
                end;
                if Competency <> xRec.Competency then begin
                    if Competency <> Competency::Competent then begin
                        if xRec.Competency = Competency::Competent then begin
                            if TrainingNeeds.Get("Course Title")then begin
                                if EmpQualifications.Get("Employee No.", TrainingNeeds.Qualification)then EmpQualifications.Delete;
                            end;
                        end;
                    end;
                end;
            end;
        }
        field(9; "Date of re-assessment"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Post; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(12; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Need Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Appraisal,Succesion,Training,Employee,Employee Skill Plan';
            OptionMembers = Appraisal, Succesion, Training, Employee, "Employee Skill Plan";
        }
        field(14; Approved; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; fsdf; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Training Evaluation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Request No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Request No", "Course Title")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if TrainingReq.Get("Request No")then "Employee No.":=TrainingReq."Employee No";
    end;
    var TrainingNeeds: Record "Training Needs";
    Qualifications: Record HR_Qualifications;
    EmpQualifications: Record "HR_Employee Qualifications";
    Employee: Record Employee;
    OK: Boolean;
    TrainingReq: Record "Staff Training Header";
}
