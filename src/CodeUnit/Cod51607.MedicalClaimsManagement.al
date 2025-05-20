codeunit 51607 "Medical Claims Management"
{
    // version THL- HRM 1.0
    // Author     : Vincent Okoth
    // Upgraded By : Henry Ngari
    // Year: 2021
    // 
    // THL OBJECT RANGES:
    // ***********************
    // Basic Finance: 50000 - 50010 (Bundled with Starter Pack)
    // QuantumJumps Payroll:  51423 - 51499 = 76
    // Advanced Finance: 52100 - 52199 = 99
    // QuantumJumps HR: 51600 - 51799 = 199
    // QuantumJumps Procumement: 51800 - 51899 = 99
    // ***********************
    // EasyPFA: 51900 - 52099 = 199
    // Investment: 52100 - 52199 = 99
    // DynamicsHMIS: 52200 - 52299 = 99
    // EasyProperty: 52300 - 52399 = 99
    // Insurance: 61423 - 61622 = 199
    // Sacco:   61623 - 62422 = ***
    // ***********************
    trigger OnRun()
    begin
    end;
    var ImprestDetails: Record "Imprest Details";
    EmployeeCustomerMapping: Record "Employee Customer Mapping";
    ClaimSetup: Record "Medical Covers Setup";
    CMSetup: Record "Cash Management Setup";
    GenJnLine: Record "Gen. Journal Line";
    Batch: Record "Gen. Journal Batch";
    LineNo: Integer;
    GLEntry: Record "G/L Entry";
    GLSetup: Record "General Ledger Setup";
    ClaimSelectionString: Label 'Pay Now,Pay from Payroll';
    Text012: Label 'You should receive a refund of %1 from %2. Kindly choose the desired option.';
    Selection: Integer;
    Text013: Label 'You should pay a claim of %1 to %2. Kindly choose the desired option.';
    PayrollCalc: Codeunit "Payroll Calculator";
    PolicyRec: Record "Medical Schemes";
    MedicalCovers: Record "Employee Medical Cover";
    Text000: Label 'Expense Account for %1 cannot be %2';
    Text008: Label 'Are you sure you want to post the Claim Settlement?';
    Text009: Label 'The Medical Claim No %1 has not been fully approved.';
    Text002: Label 'The customer account number for %1 has not been created.';
    Text010: Label 'The claim amount cannot be zero.';
    Text011: Label 'The medical claim %1 has been settled.';
    procedure PostEmployeeClaim(var Claim: Record "Medical Claim")
    var
        Type: Option Payment, Deduction, "Saving Scheme", Loan, Informational;
    begin
        //
        Message(Text013, Claim."Claim Amount", Claim."Employee Name");
        Selection:=StrMenu(ClaimSelectionString, 1);
        if Selection = 1 then begin //Pay Now
            //
            Commit;
            if PAGE.RunModal(PAGE::"Pay Medical Claim", Claim) = ACTION::LookupOK then begin
                Claim.TestField(Claim."Settled Date");
                Claim.TestField(Claim."Claim Pay Mode");
                Claim.TestField(Claim."Claim Paying Account");
            end;
            Commit;
            //***********************
            if Claim.Status = Claim.Status::Open then Error(Text009, Claim."No.");
            Claim.TestField(Claim."Employee No.");
            Claim.TestField(Claim."Employee Name");
            if EmployeeCustomerMapping.Get(Claim."Employee No.")then begin
                if EmployeeCustomerMapping."Customer AC" = '' then Error(Text002, Claim."Employee Name")end
            else
                Error(Text002, Claim."Employee Name");
            //Check if the  Lines have been populated
            if Claim."Claim Amount" = 0 then Error(Text010);
            if Claim.Settled then Error(Text011, Claim."No.");
            GLSetup.Get;
            CMSetup.Get;
            ClaimSetup.Get;
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", ClaimSetup."Claims Gen. Journal Template");
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", Claim."No.");
            GenJnLine.DeleteAll;
            Batch.Init;
            Batch."Journal Template Name":=ClaimSetup."Claims Gen. Journal Template";
            Batch.Name:=Claim."No.";
            if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
            //***********************
            ClaimSetup.Get;
            GLSetup.Get;
            GenJnLine.Init;
            GenJnLine."Journal Template Name":=ClaimSetup."Claims Gen. Journal Template";
            GenJnLine."Journal Batch Name":=Claim."No.";
            GenJnLine."Line No.":=10000;
            if MedicalCovers.Get(Claim.Policy)then begin
                if PolicyRec.Get(MedicalCovers.Cover)then begin
                    PolicyRec.TestField("Account No");
                    if PolicyRec."Account Type" = PolicyRec."Account Type"::"G/L Account" then GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account"
                    else
                        Error(Text000, PolicyRec.Description, Format(PolicyRec."Account Type"));
                    GenJnLine."Account No.":=PolicyRec."Account No";
                end;
            end;
            GenJnLine."Posting Date":=Claim."Settled Date";
            GenJnLine."Document No.":=Claim."No.";
            GenJnLine."External Document No.":=Claim."Payment Tx. No. (Cheque No.)";
            GenJnLine.Description:=CopyStr('Medical Claim-' + Claim."Employee Name", 1, 50);
            GenJnLine.Amount:=Abs(Claim."Claim Amount");
            GenJnLine.Validate(Amount);
            GenJnLine."Shortcut Dimension 1 Code":=Claim."Global Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code":=Claim."Global Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            GenJnLine."Bal. Account Type":=GenJnLine."Bal. Account Type"::Customer;
            if EmployeeCustomerMapping.Get(Claim."Employee No.")then GenJnLine."Bal. Account No.":=EmployeeCustomerMapping."Customer AC";
            GenJnLine.Validate("Bal. Account No.");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            GenJnLine.Init;
            GenJnLine."Journal Template Name":=ClaimSetup."Claims Gen. Journal Template";
            GenJnLine."Journal Batch Name":=Claim."No.";
            GenJnLine."Line No.":=11000;
            GenJnLine."Account Type":=GenJnLine."Account Type"::Customer;
            if EmployeeCustomerMapping.Get(Claim."Employee No.")then GenJnLine."Account No.":=EmployeeCustomerMapping."Customer AC";
            GenJnLine."Posting Date":=Claim."Settled Date";
            GenJnLine."Document No.":=Claim."No.";
            GenJnLine."External Document No.":=Claim."Payment Tx. No. (Cheque No.)";
            GenJnLine.Description:=CopyStr('Medical Claim-' + Claim."Employee Name", 1, 50);
            GenJnLine.Amount:=Abs(Claim."Claim Amount");
            GenJnLine.Validate(Amount);
            GenJnLine."Shortcut Dimension 1 Code":=Claim."Global Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code":=Claim."Global Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            GenJnLine."Bal. Account Type":=GenJnLine."Bal. Account Type"::"Bank Account";
            GenJnLine."Bal. Account No.":=Claim."Claim Paying Account";
            GenJnLine.Validate("Bal. Account No.");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", Claim."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            GLEntry.SetRange("Posting Date", Claim."Settled Date");
            if GLEntry.FindFirst then begin
                Claim.Settled:=true;
                Claim.Modify;
            end;
        end
        else
        begin //Pay from Payroll
            PayrollCalc.InsertEarningPayrollEntry(Claim."Employee No.", ClaimSetup."Claims Payroll Code", Claim."Claim Amount");
        end;
    end;
}
