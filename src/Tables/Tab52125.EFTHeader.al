table 52125 "EFT Header"
{
    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Transaction Date"; Date)
        {
        }
        field(3; "Paying Bank Account"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            begin
                if BankAcc.Get("Paying Bank Account")then begin
                    "Paying Bank Name":=BankAcc.Name;
                end;
            end;
        }
        field(4; "Paying Bank Name"; Text[50])
        {
            Editable = false;
        }
        field(5; Selected; Boolean)
        {
        }
        field(6; "Selected By"; Text[50])
        {
        }
        field(7; "EFT Generated"; Boolean)
        {
        }
        field(8; "Date Generated"; DateTime)
        {
        }
        field(10; Status; Option)
        {
            OptionMembers = Logged, Approved, Rejected, "Processed by Bank", "Returned from Bank";
            Editable = false;
        }
        field(11; "No of Record Processed"; Integer)
        {
            CalcFormula = Count("EFT Lines" WHERE(Status=CONST(Processed), "EFT No"=FIELD(No)));
            FieldClass = FlowField;
        }
        field(12; "No of Record Failed"; Integer)
        {
            CalcFormula = Count("EFT Lines" WHERE(Status=CONST(Failed), "EFT No"=FIELD(No)));
            FieldClass = FlowField;
        }
        field(13; "EFT Posted"; Boolean)
        {
            Editable = false;
        }
        field(14; "Process Module"; Option)
        {
            OptionCaption = ',PVs,Staff Claim,Imprest,Surrender,Adhoc';
            OptionMembers = , PVs, "Staff Claim", "Imprest", Surrender, Adhoc;
            Editable = false;
        }
        field(15; "No. Series"; Code[10])
        {
        }
    }
    keys
    {
        key(Key1; No)
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        eftlines.Reset;
        eftlines.SetRange("EFT No", Rec.No);
        if eftlines.Count <> 0 then Error('You can only delete an header without a line');
    end;
    trigger OnInsert()
    begin
    // EFT.Reset;
    // if EFT.FindLast then begin
    //     Evaluate(Counters, ConvertStr(EFT.No, 'EFT-', '0'))
    // end;
    // Counters := Counters + 1;
    // reccode := (PadStr('', 4 - StrLen(Format(Counters)), '0') + Format(Counters));
    // No := 'EFT-' + reccode;
    // AdvanceFinSetup.Get();
    // AdvanceFinSetup.TestField(AdvanceFinSetup."EFT Nos");
    // if No = '' then
    //     NoSeriesMgt.InitSeries(AdvanceFinSetup."EFT Nos", xRec."No. Series", 0D, No, "No. Series");
    // Status := Status::Logged;
    // "Paying Bank Account" := '111001'
    end;
    trigger OnModify()
    begin
    //IF Rec.Status= Rec.Status::"Processed by Bank" THEN ERROR ('You cannot modif');
    end;
    var EFT: Record "EFT Header";
    Counters: Integer;
    reccode: Text;
    BankAcc: Record "Bank Account";
    eftlines: Record "EFT Lines";
    AdvanceFinSetup: Record "Advanced Finance Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
