codeunit 52393 "Appraisal Outcome Mgt."
{
    procedure CreateOutcome(EmployeeAppraisal: Record "Employee Appraisal"; OutcomeType: Enum "Appraisal Outcome Type"): Record "Appraisal Outcome"
    var
        LastOutcome: Record "Appraisal Outcome";
        NoSeriesMgt: Codeunit "No. Series";
        Outcome: Record "Appraisal Outcome";
        NextLineNo: Integer;
        OutcomeNoSeries: Code[20];
    begin
        EmployeeAppraisal.TestField("Appraisal No");
        EmployeeAppraisal.TestField("Employee No");
        EmployeeAppraisal.TestField("Appraisal Period");
        if OutcomeType = OutcomeType::" " then
            Error('Select an appraisal outcome type.');

        if GetExistingOutcome(EmployeeAppraisal, OutcomeType, Outcome) then
            exit(Outcome);

        OutcomeNoSeries := GetAppraisalOutcomeNoSeries();

        LastOutcome.Reset();
        LastOutcome.SetRange("Appraisal No.", EmployeeAppraisal."Appraisal No");
        if LastOutcome.FindLast() then
            NextLineNo := LastOutcome."Line No." + 10000
        else
            NextLineNo := 10000;

        Outcome.Init();
        Outcome."Outcome No." := NoSeriesMgt.GetNextNo(OutcomeNoSeries, WorkDate());
        Outcome."Appraisal No." := EmployeeAppraisal."Appraisal No";
        Outcome."Outcome Type" := OutcomeType;
        Outcome."Line No." := NextLineNo;
        Outcome.Subject := GetSubject(OutcomeType);
        Outcome."Letter Body" := GetLetterBody(EmployeeAppraisal, OutcomeType);
        Outcome.Insert(true);
        exit(Outcome);
    end;

    local procedure GetExistingOutcome(EmployeeAppraisal: Record "Employee Appraisal"; OutcomeType: Enum "Appraisal Outcome Type"; var Outcome: Record "Appraisal Outcome"): Boolean
    begin
        Outcome.Reset();
        Outcome.SetRange("Appraisal No.", EmployeeAppraisal."Appraisal No");
        Outcome.SetRange("Outcome Type", OutcomeType);
        Outcome.SetFilter(Status, '<>%1', Outcome.Status::Archived);
        exit(Outcome.FindLast());
    end;

    local procedure GetAppraisalOutcomeNoSeries(): Code[20]
    var
        HumanResourcesSetup: Record "Human Resources Setup";
        QuantumJumpsHRSetup: Record "QuantumJumps HR Setup";
    begin
        if HumanResourcesSetup.Get() then
            if HumanResourcesSetup."Appraisal Outcome Nos" <> '' then
                exit(HumanResourcesSetup."Appraisal Outcome Nos");

        if QuantumJumpsHRSetup.Get() then
            if QuantumJumpsHRSetup."Appraisal Outcome Nos" <> '' then
                exit(QuantumJumpsHRSetup."Appraisal Outcome Nos");

        Error('Set up Appraisal Outcome Nos in Human Resources Setup.');
    end;

    local procedure GetSubject(OutcomeType: Enum "Appraisal Outcome Type"): Text[100]
    begin
        case OutcomeType of
            OutcomeType::Commendation:
                exit('Commendation for Exemplary Performance');
            OutcomeType::Warning:
                exit('Warning on Performance Improvement');
            OutcomeType::Memo:
                exit('Performance Appraisal Outcome Memo');
        end;
        exit('Performance Appraisal Outcome');
    end;

    local procedure GetLetterBody(EmployeeAppraisal: Record "Employee Appraisal"; OutcomeType: Enum "Appraisal Outcome Type"): Text[2048]
    var
        Builder: TextBuilder;
    begin
        case OutcomeType of
            OutcomeType::Commendation:
                begin
                    Builder.AppendLine(StrSubstNo('The Judicial Service Commission notes with appreciation your performance during the %1 appraisal period.', EmployeeAppraisal."Appraisal Period"));
                    Builder.AppendLine('Your contribution demonstrates commitment to efficient, impartial, and accountable administration of justice, and reflects positively on the standards expected of officers serving the Judiciary.');
                    Builder.AppendLine('This commendation is placed on your performance record in recognition of the results achieved and the professional conduct demonstrated during the period under review.');
                    Builder.AppendLine('You are encouraged to sustain these standards and continue supporting the Commission in the delivery of its mandate.');
                end;
            OutcomeType::Warning:
                begin
                    Builder.AppendLine(StrSubstNo('Following the performance appraisal for the %1 period, areas requiring improvement were identified and discussed through the appraisal process.', EmployeeAppraisal."Appraisal Period"));
                    Builder.AppendLine('You are required to address the noted performance gaps, comply with the agreed performance improvement actions, and work with your supervisor to demonstrate measurable improvement within the review timelines set by Human Resource Management.');
                    Builder.AppendLine('This warning is corrective in nature and is intended to support improvement. Continued underperformance or failure to act on agreed interventions may lead to further administrative action in line with the Commission''s Human Resource policies and applicable procedures.');
                end;
            OutcomeType::Memo:
                begin
                    Builder.AppendLine(StrSubstNo('This memo records the outcome of the performance appraisal for the %1 period.', EmployeeAppraisal."Appraisal Period"));
                    Builder.AppendLine('The appraisal outcome, agreed interventions, training needs, and follow-up actions should be reviewed by the appraisee, supervisor, and Human Resource Management for monitoring and closure.');
                    Builder.AppendLine('All parties are expected to maintain the appraisal record and support implementation of the agreed actions within the approved review timelines.');
                end;
        end;
        exit(CopyStr(Builder.ToText(), 1, 2048));
    end;
}
