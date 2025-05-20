table 52145 "Amortization Header"
{
    fields
    {
        field(1; No; Code[20])
        {
            Editable = false;
        }
        field(2; "Prepayment Amount"; Decimal)
        {
            trigger OnValidate()
            begin
                CalcFields("Expensed Amount");
                if "Expensed Amount" <> 0 then Error('The schedule has been expensed before, you can only make additions.');
                AmortizePrepayment(No);
            end;
        }
        field(3; "No of Periods"; Decimal)
        {
            DecimalPlaces = 4: 12;

            trigger OnValidate()
            begin
                if "Starting Period" <> 0D then Validate("Starting Period");
            end;
        }
        field(4; "Vendor No"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Supplier.Get("Vendor No")then "Vendor Name":=Supplier.Name;
            end;
        }
        field(5; "Vendor Name"; Text[50])
        {
            Editable = false;
        }
        field(6; "Paying Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(7; "Prepayment Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8; "Expense Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(9; "Invoiced Amount"; Decimal)
        {
        }
        field(10; "Expensed Amount"; Decimal)
        {
            CalcFormula = Sum("Amortization Lines".Amount WHERE(No=FIELD(No), Expensed=CONST(true)));
            FieldClass = FlowField;
        }
        field(11; "Outstanding Amount"; Decimal)
        {
            CalcFormula = Sum("Amortization Lines".Amount WHERE(No=FIELD(No), Expensed=CONST(false)));
            FieldClass = FlowField;
        }
        field(12; "Periods Invoiced"; Integer)
        {
        }
        field(13; "Periods Expensed"; Integer)
        {
            CalcFormula = Count("Amortization Lines" WHERE(No=FIELD(No), Expensed=CONST(true)));
            FieldClass = FlowField;
        }
        field(14; "Outstanding Perods"; Integer)
        {
            CalcFormula = Count("Amortization Lines" WHERE(No=FIELD(No), Expensed=CONST(false)));
            FieldClass = FlowField;
        }
        field(15; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(16; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(17; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "General Ledger Setup"."Shortcut Dimension 3 Code";
        }
        field(18; "Shortcut Dimension 4 Code"; Code[20])
        {
            TableRelation = "General Ledger Setup"."Shortcut Dimension 4 Code";
        }
        field(19; "Starting Period"; Date)
        {
            TableRelation = "Accounting Period";

            trigger OnValidate()
            begin
                if "Starting Period" <> 0D then begin
                    if "No of Periods" = 0 then Error('No. of Periods cannot be zero!');
                    if "Period Length" = "Period Length"::Monthly then "Ending Period":=CalcDate(Format(Round("No of Periods", 1)) + 'M', "Starting Period")
                    else if "Period Length" = "Period Length"::Quarterly then "Ending Period":=CalcDate(Format(Round("No of Periods", 1)) + 'Q', "Starting Period")
                        else if "Period Length" = "Period Length"::"Semi-Annually" then "Ending Period":=CalcDate(Format(Round("No of Periods", 1) * 6) + 'M', "Starting Period")
                            else if "Period Length" = "Period Length"::Annually then "Ending Period":=CalcDate(Format(Round("No of Periods", 1)) + 'Y', "Starting Period");
                end;
            end;
        }
        field(20; "Ending Period"; Date)
        {
            trigger OnValidate()
            begin
                Error('You cannot put the ending period manually!');
            end;
        }
        field(21; Status; Option)
        {
            OptionCaption = 'Open,Prepaid,Running,Fully Utilized';
            OptionMembers = Open, Prepaid, Running, "Fully Utilized";
        }
        field(22; "User ID"; Code[50])
        {
        }
        field(23; "Created Date"; Date)
        {
        }
        field(24; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(25; Description; Text[50])
        {
        }
        field(26; "Period Length"; Option)
        {
            OptionCaption = 'Monthly,Quarterly,Semi-Annually,Annually';
            OptionMembers = Monthly, Quarterly, "Semi-Annually", Annually;

            trigger OnValidate()
            begin
                if "Starting Period" <> 0D then Validate("Starting Period");
            end;
        }
        field(27; Addition; Decimal)
        {
            trigger OnValidate()
            begin
                AmortizeAdditions(No);
            end;
        }
        field(28; "Total Addition"; Decimal)
        {
            CalcFormula = Sum("Amortization Lines"."Total Adition" WHERE(No=FIELD(No)));
            FieldClass = FlowField;
        }
        field(50000; Type; Option)
        {
            OptionCaption = 'Prepayment,Accrued Expenses';
            OptionMembers = Prepayment, "Accrued Expenses";
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
    trigger OnInsert()
    begin
        if(No = '')then begin
            PurchaseSetup.Get;
            PurchaseSetup.TestField("Posted Prepmt. Inv. Nos.");
            NoSeriesMgt.InitSeries(PurchaseSetup."Posted Prepmt. Inv. Nos.", xRec.No, 0D, No, "No. Series");
        end;
        "User ID":=UserId;
        "Created Date":=Today;
    end;
    var PurchaseSetup: Record "Purchases & Payables Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Supplier: Record Vendor;
    Lines: Record "Amortization Lines";
    GenJnlLine: Record "Gen. Journal Line";
    JnlBatch: Record "Gen. Journal Batch";
    GLRegisters: Record "G/L Register";
    Header: Record "Amortization Header";
    Lines2: Record "Amortization Lines";
    ValueDate: Date;
    DimMgt: Codeunit DimensionManagement;
    Distribution: Record "Amortization Distribution";
    Counter: Integer;
    Window: Dialog;
    Names: Text;
    procedure AmortizePrepayment(var PrepNo: Code[20])
    var
        PrepLines: Record "Amortization Lines";
        PeriodicAmount: Decimal;
        PeriodValue: Date;
        NoOfPeriods: Integer;
        CurrentPeriod: Date;
        PeriodName: Text;
        PrepLines2: Record "Amortization Lines";
        DF: Text;
    begin
        if Status <> Status::Open then Error('You can only amortize an open schedule!');
        CalcFields("Expensed Amount");
        if "Expensed Amount" <> 0 then Error('You can only amortize a schedule that has not been expensed. If you have a change, kindly use the Additions field');
        //Get Periodic Amount
        //Delete Previous Lines
        PrepLines2.Reset;
        PrepLines2.SetRange(No, No);
        PrepLines2.DeleteAll;
        PeriodicAmount:=0;
        NoOfPeriods:=0;
        if Round("No of Periods", 1) <> 0 then PeriodicAmount:=Round("Prepayment Amount" / "No of Periods", 0.01)
        else
            Error('No. of Periods Cannot be zero!');
        CurrentPeriod:="Starting Period";
        while NoOfPeriods < Round("No of Periods", 1)do begin
            //Get Period Value
            if NoOfPeriods = 0 then PeriodValue:=CurrentPeriod
            else
            begin
                if "Period Length" = "Period Length"::Monthly then begin
                    PeriodValue:=CalcDate('1M', CurrentPeriod);
                    DF:='1M';
                end
                else if "Period Length" = "Period Length"::Quarterly then begin
                        PeriodValue:=CalcDate('1Q', CurrentPeriod);
                        DF:='1Q';
                    end
                    else if "Period Length" = "Period Length"::"Semi-Annually" then begin
                            PeriodValue:=CalcDate('6M', CurrentPeriod);
                            DF:='6M';
                        end
                        else if "Period Length" = "Period Length"::Annually then begin
                                PeriodValue:=CalcDate('1Y', CurrentPeriod);
                                DF:='1Y';
                            end;
            end;
            //Get Period Name
            PeriodName:=Format(PeriodValue, 0, '<Month Text,3>-<Year4>');
            //MESSAGE('No. of Periods: %1, Period: %2',NoOfPeriods,CurrentPeriod);
            //Insert Lines
            PrepLines.Init;
            PrepLines.No:=No;
            PrepLines.Period:=PeriodValue;
            PrepLines."Period Name":=PeriodName;
            PrepLines.Amount:=PeriodicAmount;
            PrepLines.Insert;
            //Reset Values
            NoOfPeriods:=NoOfPeriods + 1;
            CurrentPeriod:=PeriodValue;
        end;
        Message('Complete');
    end;
    procedure GenerateCurrentMonthJournal(var DocNo: Code[20])
    begin
        if Header.Get(DocNo)then begin
            Header.TestField("Expense Account");
            Header.TestField("Prepayment Account");
            Lines.Reset;
            Lines.SetCurrentKey(No, Period);
            Lines.SetRange(No, DocNo);
            Lines.SetRange(Expensed, false);
            if Lines.FindFirst then begin
                if Lines.Period > DMY2Date(1, Date2DMY(Today, 2), Date2DMY(Today, 3))then Error('%1 is still ahead!', Lines."Period Name");
                if Confirm('You are about to generate the prepayment journal for ' + Lines."Period Name" + '. Do you want to continue?', false) = true then begin
                    if Confirm('A general journal that will debit expense Account ' + Header."Expense Account" + ' and credit prepayment Account ' + Header."Prepayment Account" + ' with ' + Format(Lines.Amount) + ' will be generated. Do you want to continue?', false) = true then begin
                        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                        if not JnlBatch.Get('GENERAL', 'PREPAYMENT')then begin
                            JnlBatch.Init;
                            JnlBatch."Journal Template Name":='GENERAL';
                            JnlBatch.Name:='PREPAYMENT';
                            JnlBatch.Insert;
                        end
                        else
                            JnlBatch.Get('GENERAL', 'PREPAYMENT');
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
                        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PREPAYMENT');
                        GenJnlLine.DeleteAll;
                        Lines.CalcFields("Amount Distributed");
                        if Lines."Amount Distributed" = 0 then begin // Non Distributed Lines
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name":='GENERAL';
                            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                            GenJnlLine."Journal Batch Name":='PREPAYMENT';
                            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                            GenJnlLine."Line No.":=10000;
                            GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine."Account No.":=Header."Expense Account";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine."Posting Date":=CalcDate('CM', Lines.Period);
                            GenJnlLine."Document No.":='PPM' + Format(Header."Expense Account") + '-' + Format(Date2DMY(Lines.Period, 2)) + Format(Date2DMY(Lines.Period, 3));
                            GenJnlLine.Amount:=Lines.Amount;
                            GenJnlLine.Validate(GenJnlLine.Amount);
                            GenJnlLine.Description:=CopyStr(Header.Description, 1, 40) + '-' + Lines."Period Name";
                            GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                            GenJnlLine."Bal. Account No.":=Header."Prepayment Account";
                            GenJnlLine."Shortcut Dimension 1 Code":=Header."Global Dimension 1 Code";
                            GenJnlLine."Shortcut Dimension 2 Code":=Header."Global Dimension 2 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                            if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                        end
                        else
                        begin //Distributed Lines
                            Window.Open('Posting Prepayments for #####1 and #####2', Counter, Names);
                            Counter:=0;
                            Distribution.Reset;
                            Distribution.SetRange(No, Lines.No);
                            Distribution.SetRange(Period, Lines.Period);
                            if Distribution.FindSet then begin
                                repeat Counter:=Counter + 1000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name":='GENERAL';
                                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                                    GenJnlLine."Journal Batch Name":='PREPAYMENT';
                                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                                    GenJnlLine."Line No.":=Counter;
                                    GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                    GenJnlLine."Account No.":=Header."Expense Account";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine."Posting Date":=CalcDate('CM', Lines.Period);
                                    GenJnlLine."Document No.":='PPM' + Format(Header."Expense Account") + '-' + Format(Date2DMY(Lines.Period, 2)) + Format(Date2DMY(Lines.Period, 3));
                                    GenJnlLine.Amount:=Distribution.Amount;
                                    GenJnlLine.Validate(GenJnlLine.Amount);
                                    GenJnlLine.Description:=CopyStr(Header.Description, 1, 40) + '-' + Lines."Period Name";
                                    GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                                    GenJnlLine."Bal. Account No.":=Header."Prepayment Account";
                                    GenJnlLine."Shortcut Dimension 1 Code":=Distribution."Global Dimension 1 Code";
                                    GenJnlLine."Shortcut Dimension 2 Code":=Distribution."Global Dimension 2 Code";
                                    //GenJnlLine."Shortcut Dimension 3 Code" := Distribution."Global Dimension 3 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    //GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 3 Code");
                                    Window.Update(1, Counter);
                                    Window.Update(2, Distribution.Period);
                                    if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                                until Distribution.Next = 0;
                            end;
                            Window.Close;
                        end;
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
                        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PREPAYMENT');
                        GenJnlLine.SetRange(GenJnlLine."Document No.", 'PPM' + Format(Header."Expense Account") + '-' + Format(Date2DMY(Lines.Period, 2)) + Format(Date2DMY(Lines.Period, 3)));
                        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
                        Lines.Expensed:=true;
                        Lines.Validate(Expensed);
                        Lines.Modify;
                    end
                    else
                        Message('Prepayment Journal Aborted.');
                end;
            end
            else
                Message('All the periods in this prepayment have been expensed.');
        end;
    end;
    procedure AmortizeAdditions(var PrepNo: Code[20])
    var
        PrepLines: Record "Amortization Lines";
        PeriodicAmount: Decimal;
        PeriodValue: Date;
        NoOfPeriods: Integer;
        CurrentPeriod: Date;
        PeriodName: Text;
        PrepLines2: Record "Amortization Lines";
        DF: Text;
    begin
        if "Prepayment Amount" = 0 then Error('You can only make additions on an existing schedule!');
        PeriodicAmount:=0;
        if "No of Periods" <> 0 then PeriodicAmount:=Round(Addition / "No of Periods", 0.01)
        else
            Error('No. of Periods Cannot be zero!');
        PrepLines.Reset;
        PrepLines.SetCurrentKey(No, Period);
        PrepLines.SetRange(No, PrepNo);
        if PrepLines.Find('-')then begin
            repeat PrepLines.Addition:=PeriodicAmount;
                PrepLines.Modify;
                //Distribute Additions
                PrepLines.CalcFields("Amount Distributed", "Distribution Base");
                if(PrepLines."Amount Distributed" <> 0) and (PrepLines."Distribution Base" <> 0)then begin
                    Distribution.Reset;
                    Distribution.SetRange(No, PrepLines.No);
                    Distribution.SetRange(Period, PrepLines.Period);
                    if Distribution.FindSet then begin
                        repeat Distribution.Addition:=PeriodicAmount * (Distribution."Distribution Share" / PrepLines."Distribution Base");
                            Distribution.Modify;
                        until Distribution.Next = 0;
                    end;
                end;
            //
            until PrepLines.Next = 0;
        end;
        Message('Complete');
    end;
    procedure GenerateAdditionsJournal(var DocNo: Code[20])
    begin
        if Header.Get(DocNo)then begin //1
            Header.TestField("Expense Account");
            Header.TestField("Prepayment Account");
            Lines2.Reset;
            Lines2.SetCurrentKey(No, Period);
            Lines2.SetRange(No, DocNo);
            Lines2.SetRange(Expensed, false);
            if Lines2.FindFirst then ValueDate:=CalcDate('CM', Lines2.Period)
            else
                ValueDate:=Today;
            Lines.Reset;
            Lines.SetCurrentKey(No, Period);
            Lines.SetRange(No, DocNo);
            Lines.SetFilter(Addition, '<>%1', 0);
            if Lines.Find('-')then begin
                repeat //2
 if Lines.Expensed = true then begin
                        if Confirm('You are about to post the additions for ' + Lines."Period Name" + '. Do you want to continue?', false) = true then begin
                            if Confirm('A general journal that will debit expense Account ' + Header."Expense Account" + ' and credit prepayment Account ' + Header."Prepayment Account" + ' with ' + Format(Lines.Addition) + ' will be generated. Do you want to continue?', false) = true then begin
                                // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                                if not JnlBatch.Get('GENERAL', 'PREPAYMENT')then begin
                                    JnlBatch.Init;
                                    JnlBatch."Journal Template Name":='GENERAL';
                                    JnlBatch.Name:='PREPAYMENT';
                                    JnlBatch.Insert;
                                end
                                else
                                    JnlBatch.Get('GENERAL', 'PREPAYMENT');
                                GenJnlLine.Reset;
                                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
                                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PREPAYMENT');
                                GenJnlLine.DeleteAll;
                                Lines.CalcFields("Addition Distributed");
                                if Lines."Addition Distributed" = 0 then begin //Non Distributed Addition
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name":='GENERAL';
                                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                                    GenJnlLine."Journal Batch Name":='PREPAYMENT';
                                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                                    GenJnlLine."Line No.":=10000;
                                    GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                    GenJnlLine."Account No.":=Header."Expense Account";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine."Posting Date":=ValueDate;
                                    GenJnlLine."Document No.":='ADT' + Format(Header."Expense Account") + '-' + Format(Date2DMY(Lines.Period, 2)) + Format(Date2DMY(Lines.Period, 3));
                                    GenJnlLine.Amount:=Lines.Addition;
                                    GenJnlLine.Validate(GenJnlLine.Amount);
                                    GenJnlLine.Description:=CopyStr(Header.Description, 1, 40) + '-' + Lines."Period Name";
                                    GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                                    GenJnlLine."Bal. Account No.":=Header."Prepayment Account";
                                    GenJnlLine."Shortcut Dimension 1 Code":=Header."Global Dimension 1 Code";
                                    GenJnlLine."Shortcut Dimension 2 Code":=Header."Global Dimension 2 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                                end
                                else
                                begin //Distributed Addition
                                    Counter:=0;
                                    Distribution.Reset;
                                    Distribution.SetRange(No, Lines.No);
                                    Distribution.SetRange(Period, Lines.Period);
                                    if Distribution.FindSet then begin
                                        repeat Counter:=Counter + 1000;
                                            GenJnlLine.Init;
                                            GenJnlLine."Journal Template Name":='GENERAL';
                                            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                                            GenJnlLine."Journal Batch Name":='PREPAYMENT';
                                            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                                            GenJnlLine."Line No.":=Counter;
                                            GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                            GenJnlLine."Account No.":=Header."Expense Account";
                                            GenJnlLine.Validate(GenJnlLine."Account No.");
                                            GenJnlLine."Posting Date":=ValueDate;
                                            GenJnlLine."Document No.":='ADT' + Format(Header."Expense Account") + '-' + Format(Date2DMY(Lines.Period, 2)) + Format(Date2DMY(Lines.Period, 3));
                                            GenJnlLine.Amount:=Distribution.Addition;
                                            GenJnlLine.Validate(GenJnlLine.Amount);
                                            GenJnlLine.Description:=CopyStr(Header.Description, 1, 40) + '-' + Lines."Period Name";
                                            GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::"G/L Account";
                                            GenJnlLine."Bal. Account No.":=Header."Prepayment Account";
                                            GenJnlLine."Shortcut Dimension 1 Code":=Distribution."Global Dimension 1 Code";
                                            GenJnlLine."Shortcut Dimension 2 Code":=Distribution."Global Dimension 2 Code";
                                            //GenJnlLine."Shortcut Dimension 3 Code" := Distribution."Global Dimension 3 Code";
                                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                            //GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 3 Code");
                                            if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                                            Distribution.Amount:=Distribution.Amount + Distribution.Addition;
                                            Distribution."Total Addition":=Distribution.Addition;
                                            Distribution.Addition:=0;
                                            Distribution.Modify;
                                        until Distribution.Next = 0;
                                    end;
                                end;
                                GenJnlLine.Reset;
                                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
                                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'PREPAYMENT');
                                GenJnlLine.SetRange(GenJnlLine."Document No.", 'ADT' + Format(Header."Expense Account") + '-' + Format(Date2DMY(Lines.Period, 2)) + Format(Date2DMY(Lines.Period, 3)));
                                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
                                Lines.Amount:=Lines.Amount + Lines.Addition;
                                Lines."Total Adition":=Lines.Addition;
                                Lines.Addition:=0;
                                Lines.Modify;
                            end
                            else
                                Message('Prepayment Journal Aborted.');
                        end;
                    end;
                    if Lines.Expensed = false then begin
                        //Put the lines ahead here
                        Lines.Amount:=Lines.Amount + Lines.Addition;
                        Lines."Total Adition":=Lines.Addition;
                        Lines.Addition:=0;
                        Lines.Modify;
                    end;
                until Lines.Next = 0;
            end;
        end;
    end;
    procedure GenerateCurrentMonthExpenseJournal(var DocNo: Code[20])
    begin
        if Header.Get(DocNo)then begin
            Header.TestField("Expense Account");
            Header.TestField("Vendor No");
            Lines.Reset;
            Lines.SetCurrentKey(No, Period);
            Lines.SetRange(No, DocNo);
            Lines.SetRange(Expensed, false);
            if Lines.FindFirst then begin
                if Lines.Period > DMY2Date(1, Date2DMY(Today, 2), Date2DMY(Today, 3))then Error('%1 is still ahead!', Lines."Period Name");
                if Confirm('You are about to generate the expenses journal for ' + Lines."Period Name" + '. Do you want to continue?', false) = true then begin
                    if Confirm('A general journal that will debit expense Account ' + Header."Expense Account" + ' and credit Vendor Account ' + Header."Vendor No" + ' with ' + Format(Lines.Amount) + ' will be generated. Do you want to continue?', false) = true then begin
                        // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                        if not JnlBatch.Get('GENERAL', 'EXPENSES')then begin
                            JnlBatch.Init;
                            JnlBatch."Journal Template Name":='GENERAL';
                            JnlBatch.Name:='EXPENSES';
                            JnlBatch.Insert;
                        end
                        else
                            JnlBatch.Get('GENERAL', 'EXPENSES');
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
                        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'EXPENSES');
                        GenJnlLine.DeleteAll;
                        Lines.CalcFields("Amount Distributed");
                        if Lines."Amount Distributed" = 0 then begin //Non Distributed Lines
                            GenJnlLine.Init;
                            GenJnlLine."Journal Template Name":='GENERAL';
                            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                            GenJnlLine."Journal Batch Name":='EXPENSES';
                            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                            GenJnlLine."Line No.":=10000;
                            GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                            GenJnlLine."Account No.":=Header."Expense Account";
                            GenJnlLine.Validate(GenJnlLine."Account No.");
                            GenJnlLine."Posting Date":=CalcDate('CM', Lines.Period);
                            GenJnlLine."Document No.":='ACE' + Format(Header."Expense Account") + '-' + Format(Date2DMY(Lines.Period, 2)) + Format(Date2DMY(Lines.Period, 3));
                            GenJnlLine.Amount:=Lines.Amount;
                            GenJnlLine.Validate(GenJnlLine.Amount);
                            GenJnlLine.Description:=CopyStr(Header.Description, 1, 40) + '-' + Lines."Period Name";
                            GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::Vendor;
                            GenJnlLine."Bal. Account No.":=Header."Vendor No";
                            GenJnlLine."Shortcut Dimension 1 Code":=Header."Global Dimension 1 Code";
                            GenJnlLine."Shortcut Dimension 2 Code":=Header."Global Dimension 2 Code";
                            //GenJnlLine."Shortcut Dimension 3 Code" := Header."Shortcut Dimension 3 Code";
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                            //GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 3 Code");
                            if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                        end
                        else
                        begin //Distributed Lines
                            Counter:=0;
                            Distribution.Reset;
                            Distribution.SetRange(No, Lines.No);
                            Distribution.SetRange(Period, Lines.Period);
                            if Distribution.FindSet then begin
                                repeat Counter:=Counter + 1000;
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name":='GENERAL';
                                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                                    GenJnlLine."Journal Batch Name":='EXPENSES';
                                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                                    GenJnlLine."Line No.":=Counter;
                                    GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                    GenJnlLine."Account No.":=Header."Expense Account";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine."Posting Date":=CalcDate('CM', Lines.Period);
                                    GenJnlLine."Document No.":='ACE' + Format(Header."Expense Account") + '-' + Format(Date2DMY(Lines.Period, 2)) + Format(Date2DMY(Lines.Period, 3));
                                    GenJnlLine.Amount:=Distribution.Amount;
                                    GenJnlLine.Validate(GenJnlLine.Amount);
                                    GenJnlLine.Description:=CopyStr(Header.Description, 1, 40) + '-' + Lines."Period Name";
                                    GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::Vendor;
                                    GenJnlLine."Bal. Account No.":=Header."Vendor No";
                                    GenJnlLine."Shortcut Dimension 1 Code":=Distribution."Global Dimension 1 Code";
                                    GenJnlLine."Shortcut Dimension 2 Code":=Distribution."Global Dimension 2 Code";
                                    //GenJnlLine."Shortcut Dimension 3 Code" := Distribution."Global Dimension 3 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    //GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 3 Code");
                                    if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                                until Distribution.Next = 0;
                            end;
                        end;
                        GenJnlLine.Reset;
                        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
                        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'EXPENSES');
                        GenJnlLine.SetRange(GenJnlLine."Document No.", 'ACE' + Format(Header."Expense Account") + '-' + Format(Date2DMY(Lines.Period, 2)) + Format(Date2DMY(Lines.Period, 3)));
                        CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
                        Lines.Expensed:=true;
                        Lines.Validate(Expensed);
                        Lines.Modify;
                    end
                    else
                        Message('Accrued expenses Journal Aborted.');
                end;
            end
            else
                Message('All the periods in this schedule have been expensed.');
        end;
    end;
    procedure GenerateExpenseAdditionsJournal(var DocNo: Code[20])
    begin
        if Header.Get(DocNo)then begin //1
            Header.TestField("Expense Account");
            Header.TestField("Vendor No");
            Lines2.Reset;
            Lines2.SetCurrentKey(No, Period);
            Lines2.SetRange(No, DocNo);
            Lines2.SetRange(Expensed, false);
            if Lines2.FindFirst then ValueDate:=CalcDate('CM', Lines2.Period)
            else
                ValueDate:=Today;
            Lines.Reset;
            Lines.SetCurrentKey(No, Period);
            Lines.SetRange(No, DocNo);
            Lines.SetFilter(Addition, '<>%1', 0);
            if Lines.Find('-')then begin
                repeat //2
 if Lines.Expensed = true then begin
                        if Confirm('You are about to post the additions for ' + Lines."Period Name" + '. Do you want to continue?', false) = true then begin
                            if Confirm('A general journal that will debit expense Account ' + Header."Expense Account" + ' and credit Vendor Account ' + Header."Vendor No" + ' with ' + Format(Lines.Addition) + ' will be generated. Do you want to continue?', false) = true then begin
                                // DELETE ANY LINE ITEM THAT MAY BE PRESENT
                                if not JnlBatch.Get('GENERAL', 'EXPENSES')then begin
                                    JnlBatch.Init;
                                    JnlBatch."Journal Template Name":='GENERAL';
                                    JnlBatch.Name:='EXPENSES';
                                    JnlBatch.Insert;
                                end
                                else
                                    JnlBatch.Get('GENERAL', 'EXPENSES');
                                GenJnlLine.Reset;
                                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
                                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'EXPENSES');
                                GenJnlLine.DeleteAll;
                                Lines.CalcFields("Addition Distributed");
                                if Lines."Addition Distributed" = 0 then begin //Non Distributed Addition
                                    GenJnlLine.Init;
                                    GenJnlLine."Journal Template Name":='GENERAL';
                                    GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                                    GenJnlLine."Journal Batch Name":='EXPENSES';
                                    GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                                    GenJnlLine."Line No.":=10000;
                                    GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                    GenJnlLine."Account No.":=Header."Expense Account";
                                    GenJnlLine.Validate(GenJnlLine."Account No.");
                                    GenJnlLine."Posting Date":=ValueDate;
                                    GenJnlLine."Document No.":='AAE' + Format(Header."Expense Account") + '-' + Format(Date2DMY(Lines.Period, 2)) + Format(Date2DMY(Lines.Period, 3));
                                    GenJnlLine.Amount:=Lines.Addition;
                                    GenJnlLine.Validate(GenJnlLine.Amount);
                                    GenJnlLine.Description:=CopyStr(Header.Description, 1, 40) + '-' + Lines."Period Name";
                                    GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::Vendor;
                                    GenJnlLine."Bal. Account No.":=Header."Vendor No";
                                    GenJnlLine."Shortcut Dimension 1 Code":=Header."Global Dimension 1 Code";
                                    GenJnlLine."Shortcut Dimension 2 Code":=Header."Global Dimension 2 Code";
                                    //GenJnlLine."Shortcut Dimension 3 Code" := Header."Shortcut Dimension 3 Code";
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                    GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                    //GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 3 Code");
                                    if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                                end
                                else
                                begin
                                    Counter:=0;
                                    Distribution.Reset;
                                    Distribution.SetRange(No, Lines.No);
                                    Distribution.SetRange(Period, Lines.Period);
                                    if Distribution.FindSet then begin
                                        repeat Counter:=Counter + 1000;
                                            GenJnlLine.Init;
                                            GenJnlLine."Journal Template Name":='GENERAL';
                                            GenJnlLine.Validate(GenJnlLine."Journal Template Name");
                                            GenJnlLine."Journal Batch Name":='EXPENSES';
                                            GenJnlLine.Validate(GenJnlLine."Journal Batch Name");
                                            GenJnlLine."Line No.":=Counter;
                                            GenJnlLine."Account Type":=GenJnlLine."Account Type"::"G/L Account";
                                            GenJnlLine."Account No.":=Header."Expense Account";
                                            GenJnlLine.Validate(GenJnlLine."Account No.");
                                            GenJnlLine."Posting Date":=ValueDate;
                                            GenJnlLine."Document No.":='AAE' + Format(Header."Expense Account") + '-' + Format(Date2DMY(Lines.Period, 2)) + Format(Date2DMY(Lines.Period, 3));
                                            GenJnlLine.Amount:=Distribution.Addition;
                                            GenJnlLine.Validate(GenJnlLine.Amount);
                                            GenJnlLine.Description:=CopyStr(Header.Description, 1, 40) + '-' + Lines."Period Name";
                                            GenJnlLine."Bal. Account Type":=GenJnlLine."Bal. Account Type"::Vendor;
                                            GenJnlLine."Bal. Account No.":=Header."Vendor No";
                                            GenJnlLine."Shortcut Dimension 1 Code":=Distribution."Global Dimension 1 Code";
                                            GenJnlLine."Shortcut Dimension 2 Code":=Distribution."Global Dimension 2 Code";
                                            //GenJnlLine."Shortcut Dimension 3 Code" := Distribution."Global Dimension 3 Code";
                                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 1 Code");
                                            GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 2 Code");
                                            //GenJnlLine.Validate(GenJnlLine."Shortcut Dimension 3 Code");
                                            if GenJnlLine.Amount <> 0 then GenJnlLine.Insert;
                                            Distribution.Amount:=Distribution.Amount + Distribution.Addition;
                                            Distribution."Total Addition":=Distribution.Addition;
                                            Distribution.Addition:=0;
                                            Distribution.Modify;
                                        until Distribution.Next = 0;
                                    end;
                                end;
                                GenJnlLine.Reset;
                                GenJnlLine.SetRange(GenJnlLine."Journal Template Name", 'GENERAL');
                                GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", 'EXPENSES');
                                GenJnlLine.SetRange(GenJnlLine."Document No.", 'AAE' + Format(Header."Expense Account") + '-' + Format(Date2DMY(Lines.Period, 2)) + Format(Date2DMY(Lines.Period, 3)));
                                CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnlLine);
                                Lines.Amount:=Lines.Amount + Lines.Addition;
                                Lines."Total Adition":=Lines.Addition;
                                Lines.Addition:=0;
                                Lines.Modify;
                            end
                            else
                                Message('Journal Aborted.');
                        end;
                    end;
                    if Lines.Expensed = false then begin
                        //Put the lines ahead here
                        Lines.Amount:=Lines.Amount + Lines.Addition;
                        Lines."Total Adition":=Lines.Addition;
                        Lines.Addition:=0;
                        Lines.Modify;
                    end;
                until Lines.Next = 0;
            end;
        end;
    end;
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
    //DimMgt.ValidateShortcutDimValues(FieldNumber,ShortcutDimCode,"Dimension Set ID");
    end;
}
