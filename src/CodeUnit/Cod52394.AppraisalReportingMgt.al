codeunit 52394 "Appraisal Reporting Mgt."
{
    procedure GetDirectorateDimensionCode(): Code[20]
    var
        HRSetup: Record "QuantumJumps HR Setup";
    begin
        HRSetup.Get();
        HRSetup.TestField("Directorate Dimension Code");
        exit(HRSetup."Directorate Dimension Code");
    end;

    procedure GetDirectorateCode(EmployeeNo: Code[20]): Code[20]
    var
        DefaultDimension: Record "Default Dimension";
        Employee: Record Employee;
        GeneralLedgerSetup: Record "General Ledger Setup";
        HRSetup: Record "QuantumJumps HR Setup";
    begin
        HRSetup.Get();
        HRSetup.TestField("Directorate Dimension Code");

        DefaultDimension.Reset();
        DefaultDimension.SetRange("Table ID", Database::Employee);
        DefaultDimension.SetRange("No.", EmployeeNo);
        DefaultDimension.SetRange("Dimension Code", HRSetup."Directorate Dimension Code");
        if DefaultDimension.FindFirst() then
            exit(DefaultDimension."Dimension Value Code");

        if Employee.Get(EmployeeNo) then begin
            GeneralLedgerSetup.Get();
            if HRSetup."Directorate Dimension Code" = GeneralLedgerSetup."Global Dimension 1 Code" then
                exit(Employee."Global Dimension 1 Code");
            if HRSetup."Directorate Dimension Code" = GeneralLedgerSetup."Global Dimension 2 Code" then
                exit(Employee."Global Dimension 2 Code");
        end;

        exit('');
    end;

    procedure GetDirectorateName(EmployeeNo: Code[20]): Text[100]
    var
        DimensionValue: Record "Dimension Value";
        HRSetup: Record "QuantumJumps HR Setup";
        DirectorateCode: Code[20];
    begin
        DirectorateCode := GetDirectorateCode(EmployeeNo);
        if DirectorateCode = '' then
            exit('');

        HRSetup.Get();
        if DimensionValue.Get(HRSetup."Directorate Dimension Code", DirectorateCode) then
            exit(DimensionValue.Name);

        exit(DirectorateCode);
    end;
}
