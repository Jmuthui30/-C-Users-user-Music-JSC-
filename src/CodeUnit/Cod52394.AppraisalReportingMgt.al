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

    procedure TryGetDirectorateDimensionCode(var DirectorateDimensionCode: Code[20]): Boolean
    var
        HRSetup: Record "QuantumJumps HR Setup";
    begin
        Clear(DirectorateDimensionCode);

        if not HRSetup.Get() then
            exit(false);

        DirectorateDimensionCode := HRSetup."Directorate Dimension Code";
        exit(DirectorateDimensionCode <> '');
    end;

    procedure GetDirectorateCode(EmployeeNo: Code[20]): Code[20]
    var
        HRSetup: Record "QuantumJumps HR Setup";
    begin
        HRSetup.Get();
        HRSetup.TestField("Directorate Dimension Code");

        exit(ResolveDirectorateCode(EmployeeNo, HRSetup."Directorate Dimension Code"));
    end;

    procedure GetDirectorateName(EmployeeNo: Code[20]): Text[100]
    var
        DirectorateCode: Code[20];
        DirectorateDimensionCode: Code[20];
    begin
        DirectorateDimensionCode := GetDirectorateDimensionCode();
        DirectorateCode := ResolveDirectorateCode(EmployeeNo, DirectorateDimensionCode);
        exit(ResolveDirectorateName(DirectorateDimensionCode, DirectorateCode));
    end;

    procedure GetDirectorateCodeForAppraisal(EmployeeAppraisal: Record "Employee Appraisal"): Code[20]
    begin
        if EmployeeAppraisal."Directorate Code" <> '' then
            exit(EmployeeAppraisal."Directorate Code");

        exit(GetDirectorateCode(EmployeeAppraisal."Employee No"));
    end;

    procedure GetDirectorateNameForAppraisal(EmployeeAppraisal: Record "Employee Appraisal"): Text[100]
    begin
        if EmployeeAppraisal."Directorate Name" <> '' then
            exit(EmployeeAppraisal."Directorate Name");

        exit(GetDirectorateName(EmployeeAppraisal."Employee No"));
    end;

    procedure TryGetDirectorateSnapshot(EmployeeNo: Code[20]; var DirectorateDimensionCode: Code[20]; var DirectorateCode: Code[20]; var DirectorateName: Text[100]): Boolean
    begin
        Clear(DirectorateDimensionCode);
        Clear(DirectorateCode);
        Clear(DirectorateName);

        if EmployeeNo = '' then
            exit(false);

        if not TryGetDirectorateDimensionCode(DirectorateDimensionCode) then
            exit(false);

        DirectorateCode := ResolveDirectorateCode(EmployeeNo, DirectorateDimensionCode);
        DirectorateName := ResolveDirectorateName(DirectorateDimensionCode, DirectorateCode);
        exit(DirectorateCode <> '');
    end;

    local procedure ResolveDirectorateCode(EmployeeNo: Code[20]; DirectorateDimensionCode: Code[20]): Code[20]
    var
        DefaultDimension: Record "Default Dimension";
        Employee: Record Employee;
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        if (EmployeeNo = '') or (DirectorateDimensionCode = '') then
            exit('');

        DefaultDimension.Reset();
        DefaultDimension.SetRange("Table ID", Database::Employee);
        DefaultDimension.SetRange("No.", EmployeeNo);
        DefaultDimension.SetRange("Dimension Code", DirectorateDimensionCode);
        if DefaultDimension.FindFirst() then
            exit(DefaultDimension."Dimension Value Code");

        if Employee.Get(EmployeeNo) then begin
            GeneralLedgerSetup.Get();
            if DirectorateDimensionCode = GeneralLedgerSetup."Global Dimension 1 Code" then
                exit(Employee."Global Dimension 1 Code");
            if DirectorateDimensionCode = GeneralLedgerSetup."Global Dimension 2 Code" then
                exit(Employee."Global Dimension 2 Code");
        end;

        exit('');
    end;

    local procedure ResolveDirectorateName(DirectorateDimensionCode: Code[20]; DirectorateCode: Code[20]): Text[100]
    var
        DimensionValue: Record "Dimension Value";
    begin
        if (DirectorateDimensionCode = '') or (DirectorateCode = '') then
            exit('');

        if DimensionValue.Get(DirectorateDimensionCode, DirectorateCode) then
            exit(DimensionValue.Name);

        exit(DirectorateCode);
    end;
}
