report 51604 "Activate Medical Covers"
{
    // version THL- HRM 1.0
    ProcessingOnly = true;

    dataset
    {
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(Scheme; SchemeFilter)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean begin
                        Schemes.Reset;
                        if PAGE.RunModal(51665, Schemes) = ACTION::LookupOK then SchemeFilter:=Schemes.Code;
                    end;
                }
                field("Policy Start Date"; StartDate)
                {
                    ApplicationArea = All;
                }
                field("Policy Expiry Date"; EndDate)
                {
                    ApplicationArea = All;
                }
                field(Employee; EmployeeFilter)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean begin
                        NAVEmp.Reset;
                        if PAGE.RunModal(51674, NAVEmp) = ACTION::LookupOK then EmployeeFilter:=NAVEmp."No.";
                    end;
                }
            }
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
        if StartDate = 0D then Error(Text000);
        if EndDate = 0D then Error(Text001);
        if SchemeFilter = '' then Error(Text002);
        Schemes.Reset;
        Schemes.SetRange(Code, SchemeFilter);
        if Schemes.FindFirst then begin
            Window.Open(WindowText, Policy, Names);
            NAVEmp.Reset;
            NAVEmp.SetRange(Status, NAVEmp.Status::Active);
            if EmployeeFilter <> '' then NAVEmp.SetRange("No.", EmployeeFilter);
            if NAVEmp.Find('-')then begin
                repeat //Deactivate Old Scheme
                    ExistingMedicalCovers2.Reset;
                    ExistingMedicalCovers2.SetCurrentKey("Employee No.", Cover, "Policy Start Date", "Policy End Date");
                    ExistingMedicalCovers2.SetRange(ExistingMedicalCovers2."Employee No.", NAVEmp."No.");
                    ExistingMedicalCovers2.SetRange(ExistingMedicalCovers2.Cover, SchemeFilter);
                    ExistingMedicalCovers2.SetFilter("Policy Start Date", '<>%1', StartDate);
                    ExistingMedicalCovers2.SetFilter("Policy End Date", '<>%1', EndDate);
                    if ExistingMedicalCovers2.Find('-')then begin
                        repeat if ExistingMedicalCovers2."Cover Status" = ExistingMedicalCovers2."Cover Status"::Active then begin
                                ExistingMedicalCovers2."Cover Status":=ExistingMedicalCovers2."Cover Status"::Inactive;
                                ExistingMedicalCovers2.Modify;
                            end;
                        until ExistingMedicalCovers2.Next = 0;
                    end;
                    //
                    //Insert Cover
                    CoverSetup.Get;
                    MedicalCovers.Init;
                    MedicalCovers."No.":=NoSeriesMgt.GetNextNo(CoverSetup."Cover Nos.", Today, true);
                    MedicalCovers.Validate("Employee No.", NAVEmp."No.");
                    MedicalCovers."Cover Type":=Schemes.Type;
                    MedicalCovers.Validate(Cover, Schemes.Code);
                    MedicalCovers."Policy Start Date":=StartDate;
                    MedicalCovers.Validate("Policy End Date", EndDate);
                    MedicalCovers."Settled By":=Schemes."Settled By";
                    ExistingMedicalCovers.Reset;
                    ExistingMedicalCovers.SetCurrentKey("Employee No.", Cover, "Policy Start Date", "Policy End Date");
                    ExistingMedicalCovers.SetRange("Employee No.", NAVEmp."No.");
                    ExistingMedicalCovers.SetRange(Cover, SchemeFilter);
                    ExistingMedicalCovers.SetRange("Policy Start Date", StartDate);
                    ExistingMedicalCovers.SetRange("Policy End Date", EndDate);
                    ExistingMedicalCovers.SetRange("Cover Status", ExistingMedicalCovers."Cover Status"::Active);
                    if not ExistingMedicalCovers.FindFirst then MedicalCovers.Insert
                    else
                    begin
                        ExistingMedicalCovers."Cover Status":=ExistingMedicalCovers."Cover Status"::Active;
                        ExistingMedicalCovers."Settled By":=Schemes."Settled By";
                        ExistingMedicalCovers.Modify;
                    end;
                    Window.Update(1, Schemes.Description);
                    Window.Update(2, NAVEmp.FullName);
                until NAVEmp.Next = 0;
            end;
            Window.Close;
        end;
    end;
    var StartDate: Date;
    EndDate: Date;
    MedicalCovers: Record "Employee Medical Cover";
    EmployeeFilter: Code[20];
    NAVEmp: Record Employee;
    ExistingMedicalCovers: Record "Employee Medical Cover";
    Window: Dialog;
    Policy: Text;
    Names: Text;
    ExistingMedicalCovers2: Record "Employee Medical Cover";
    Text000: Label 'You must specify Policy Start Date';
    Text001: Label 'You must specify Policy Expiry Date';
    WindowText: Label 'Activating #####1 for #####2';
    SchemeFilter: Code[10];
    Schemes: Record "Medical Schemes";
    Text002: Label 'You must specify Medical Scheme';
    NoSeriesMgt: Codeunit NoSeriesManagement;
    CoverSetup: Record "Medical Covers Setup";
}
