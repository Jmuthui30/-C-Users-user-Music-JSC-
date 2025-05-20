codeunit 50006 "Commitment Management"
{
    // version THL-Basic Fin 1.0
    trigger OnRun()
    begin
    end;
    procedure POCommitment(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLines: Record "Purchase Line";
        Committments: Record "Commitment Entries";
        Item: Record Item;
        GLAccount: Record "G/L Account";
        FixedAsset: Record "Fixed Asset";
        EntryNo: Integer;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        FixedAssetPG: Record "FA Posting Group";
        GenLedSetup: Record "Cash Management Setup";
        InventoryAccount: Code[20];
        AcquisitionAccount: Code[20];
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        CommittedAmount: Decimal;
        Vendor: Record Vendor;
    begin
        if PurchaseHeader."Document Type" = PurchaseHeader."Document Type"::Order then begin
            PurchaseLines.Reset;
            PurchaseLines.SetRange(PurchaseLines."Document No.", PurchaseHeader."No.");
            PurchaseLines.SetRange(PurchaseLines."Document Type", PurchaseLines."Document Type"::Order);
            if PurchaseLines.FindFirst then begin
                if Committments.FindLast then EntryNo:=Committments."Entry No";
                repeat Committments.Init;
                    Committments."Commitment No":=PurchaseHeader."No.";
                    Committments."Commitment Type":=Committments."Commitment Type"::Committed;
                    // PurchaseHeader.VALIDATE("Order Date");
                    if PurchaseHeader."Order Date" = 0D then Error('Please enter the order date');
                    Committments."Commitment Date":=PurchaseHeader."Order Date";
                    Committments."Global Dimension 1":=PurchaseLines."Shortcut Dimension 1 Code";
                    Committments."Global Dimension 2":=PurchaseLines."Shortcut Dimension 2 Code";
                    //Case of G/L Account,Item,Fixed Asset
                    case PurchaseLines.Type of PurchaseLines.Type::Item: begin
                        Item.Reset;
                        if Item.Get(PurchaseLines."No.")then if Item."Inventory Posting Group" = '' then Error('Assign Posting Group to Item No %1', Item."No.");
                        InventoryPostingSetup.Get(PurchaseLines."Location Code", Item."Inventory Posting Group");
                        InventoryAccount:=InventoryPostingSetup."Inventory Account";
                        Committments.Account:=InventoryAccount;
                    end;
                    PurchaseLines.Type::"G/L Account": begin
                        Committments.Account:=PurchaseLines."No.";
                    end;
                    PurchaseLines.Type::"Fixed Asset": begin
                        if FixedAssetPG.Get(PurchaseLines."Posting Group")then begin
                            FixedAssetPG.TestField("Acquisition Cost Account");
                            AcquisitionAccount:=FixedAssetPG."Acquisition Cost Account";
                            Committments.Account:=AcquisitionAccount;
                        end;
                    end;
                    end;
                    Committments."Committed Amount":=PurchaseLines."Line Amount";
                    //Confirm the Amount to be issued does not exceed the budget and amount Committed
                    //Get Budget for the G/L
                    GenLedSetup.Get;
                    GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                    case PurchaseLines.Type of PurchaseLines.Type::Item: begin
                        GLAccount.SetRange(GLAccount."No.", InventoryAccount);
                    end;
                    PurchaseLines.Type::"G/L Account": begin
                        GLAccount.SetRange(GLAccount."No.", PurchaseLines."No.");
                    end;
                    PurchaseLines.Type::"Fixed Asset": GLAccount.SetRange(GLAccount."No.", AcquisitionAccount);
                    end;
                    GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                    //Get budget amount avaliable
                    GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", GenLedSetup."Current Budget End Date");
                    if GLAccount.Find('-')then begin
                        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
                        BudgetAmount:=GLAccount."Budgeted Amount";
                        Expenses:=GLAccount."Net Change";
                        BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
                    end;
                    //Get committed Amount
                    CommittedAmount:=0;
                    CommitmentEntries.Reset;
                    CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
                    if PurchaseLines.Type = PurchaseLines.Type::Item then CommitmentEntries.SetRange(CommitmentEntries.Account, InventoryAccount);
                    if PurchaseLines.Type = PurchaseLines.Type::"G/L Account" then CommitmentEntries.SetRange(CommitmentEntries.Account, PurchaseLines."No.");
                    if PurchaseLines.Type = PurchaseLines.Type::"Fixed Asset" then CommitmentEntries.SetRange(CommitmentEntries.Account, AcquisitionAccount);
                    CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date", PurchaseHeader."Order Date");
                    CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
                    CommittedAmount:=CommitmentEntries."Committed Amount";
                    if LineCommitted(PurchaseHeader."No.", PurchaseLines."No.", PurchaseLines."Line No.")then Message('Line No %1 has been commited', PurchaseLines."Line No.")
                    else
                        /*IF CommittedAmount+PurchaseLines."Line Amount">BudgetAvailable THEN
                          IF (BudgetAvailable < 0) OR (BudgetAvailable = 0) THEN
                            ERROR('There is no budget available for %1',PurchaseLines.Description)
                           ELSE
                           ERROR('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3 CommittedAmount %4'
                           ,Committments.Account,
                           ABS(BudgetAvailable-(CommittedAmount+PurchaseLines."Line Amount")),BudgetAvailable,CommittedAmount);*/
                        Committments.User:=UserId;
                    Committments."Document No":=PurchaseHeader."No.";
                    Committments."No.":=PurchaseLines."No.";
                    Committments."Line No.":=PurchaseLines."Line No.";
                    Committments."Account Type":=Committments."Account Type"::Vendor;
                    Committments."Account No.":=PurchaseLines."Buy-from Vendor No.";
                    if Vendor.Get(PurchaseLines."Buy-from Vendor No.")then Committments."Account Name":=Vendor.Name;
                    Committments.Description:=PurchaseLines.Description;
                    //Check whether line is committed.
                    if not LineCommitted(PurchaseHeader."No.", PurchaseLines."No.", PurchaseLines."Line No.")then begin
                        EntryNo:=EntryNo + 1;
                        Committments."Entry No":=EntryNo;
                        Committments.Insert;
                        PurchaseLines.Status:=PurchaseLines.Status::Committed;
                        PurchaseLines.Modify;
                    end;
                until PurchaseLines.Next = 0;
            end;
        //MESSAGE('Items Committed Successfully');
        end;
    end;
    procedure LineCommitted(var CommittmentNo: Code[20]; var No: Code[20]; var LineNo: Integer)Exists: Boolean var
        Committed: Record "Commitment Entries";
    begin
        Exists:=false;
        Committed.Reset;
        Committed.SetRange(Committed."Commitment No", CommittmentNo);
        Committed.SetRange(Committed."No.", No);
        Committed.SetRange(Committed."Line No.", LineNo);
        if Committed.Find('-')then Exists:=true;
    end;
    procedure ReversePOCommittmentOnPosting(var PurchHeader: Record "Purchase Header")
    var
        Committment: Record "Commitment Entries";
        PurchLine: Record "Purchase Line";
        EntryNo: Integer;
        Item: Record Item;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        FixedAssetPG: Record "FA Posting Group";
        GenLedSetup: Record "General Ledger Setup";
        InventoryAccount: Code[20];
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        AcquisitionAccount: Code[20];
    begin
        if Confirm('Are you sure you want to reverse the committed entries for Order no ' + PurchHeader."No." + '?', false) = true then begin
            Committment.Reset;
            Committment.SetRange(Committment."Commitment No", PurchHeader."No.");
            if Committment.Find('-')then begin
                Committment.DeleteAll;
            end;
            PurchLine.Reset;
            PurchLine.SetRange(PurchLine."Document Type", PurchLine."Document Type"::Order);
            PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
            if PurchLine.FindFirst then begin
                repeat //Insert Reversal entries in the committment entries table
                    if Committment.Find('+')then EntryNo:=Committment."Entry No";
                    EntryNo:=EntryNo + 1;
                    if LineCommitted(PurchHeader."No.", PurchLine."No.", PurchLine."Line No.")then begin
                        Committment.Init;
                        Committment."Entry No":=EntryNo;
                        Committment."Commitment No":=PurchHeader."No.";
                        Committment."Commitment Type":=Committment."Commitment Type"::Reversal;
                        Committment."Commitment Date":=PurchLine."Order Date";
                        //Dimensions
                        Committment."Global Dimension 1":=PurchLine."Shortcut Dimension 1 Code";
                        Committment."Global Dimension 2":=PurchLine."Shortcut Dimension 2 Code";
                        //Dimensions
                        //Case of G/L Account,Item,Fixed Asset
                        case PurchLine.Type of PurchLine.Type::Item: begin
                            Item.Reset;
                            if Item.Get(PurchLine."No.")then if Item."Inventory Posting Group" = '' then Error('Assign Posting Group to Item No %1', Item."No.");
                            InventoryPostingSetup.Get(PurchLine."Location Code", Item."Inventory Posting Group");
                            InventoryAccount:=InventoryPostingSetup."Inventory Account";
                            Committment.Account:=InventoryAccount;
                        end;
                        PurchLine.Type::"G/L Account": begin
                            Committment.Account:=PurchLine."No.";
                        end;
                        PurchLine.Type::"Fixed Asset": begin
                            FixedAsset.Reset;
                            FixedAsset.Get(PurchLine."No.");
                            FixedAssetPG.Get(FixedAsset."FA Posting Group");
                            AcquisitionAccount:=FixedAssetPG."Acquisition Cost Account";
                            Committment.Account:=AcquisitionAccount;
                        end;
                        end;
                        Committment."Committed Amount":=-PurchLine."Line Amount";
                        Committment.User:=UserId;
                        Committment."Document No":=PurchHeader."No.";
                        Committment."No.":=PurchLine."No.";
                        Committment."Account Type":=Committment."Account Type"::Vendor;
                        Committment."Account No.":=PurchLine."Buy-from Vendor No.";
                        if Vendor.Get(PurchLine."Buy-from Vendor No.")then Committment."Account Name":=Vendor.Name;
                        Committment.Description:=PurchLine.Description;
                        Committment.Insert;
                    //Mark entries as uncommited
                    //vooPurchLine.Committed:=FALSE;
                    //vooPurchLine.MODIFY;
                    end;
                until PurchLine.Next = 0;
            end;
        //MESSAGE('Committed entries for Order No %1 Have been reversed Successfully',PurchHeader."No.");
        end;
    end;
    procedure ReversePOCommittmentOnReopenDocument(var PurchHeader: Record "Purchase Header")
    var
        Committment: Record "Commitment Entries";
        PurchLine: Record "Purchase Line";
        EntryNo: Integer;
        Item: Record Item;
        InventoryPostingSetup: Record "Inventory Posting Setup";
        FixedAssetPG: Record "FA Posting Group";
        GenLedSetup: Record "General Ledger Setup";
        InventoryAccount: Code[20];
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        AcquisitionAccount: Code[20];
    begin
        Committment.Reset;
        Committment.SetRange(Committment."Commitment No", PurchHeader."No.");
        if Committment.Find('-')then begin
            Committment.DeleteAll;
        end;
        PurchLine.Reset;
        PurchLine.SetRange(PurchLine."Document Type", PurchLine."Document Type"::Order);
        PurchLine.SetRange(PurchLine."Document No.", PurchHeader."No.");
        if PurchLine.FindFirst then begin
            repeat //Insert Reversal entries in the committment entries table
                if Committment.Find('+')then EntryNo:=Committment."Entry No";
                EntryNo:=EntryNo + 1;
                if LineCommitted(PurchHeader."No.", PurchLine."No.", PurchLine."Line No.")then begin
                    Committment.Init;
                    Committment."Entry No":=EntryNo;
                    Committment."Commitment No":=PurchHeader."No.";
                    Committment."Commitment Type":=Committment."Commitment Type"::Reversal;
                    Committment."Commitment Date":=PurchLine."Order Date";
                    //Dimensions
                    Committment."Global Dimension 1":=PurchLine."Shortcut Dimension 1 Code";
                    Committment."Global Dimension 2":=PurchLine."Shortcut Dimension 2 Code";
                    //Dimensions
                    //Case of G/L Account,Item,Fixed Asset
                    case PurchLine.Type of PurchLine.Type::Item: begin
                        Item.Reset;
                        if Item.Get(PurchLine."No.")then if Item."Inventory Posting Group" = '' then Error('Assign Posting Group to Item No %1', Item."No.");
                        InventoryPostingSetup.Get(PurchLine."Location Code", Item."Inventory Posting Group");
                        InventoryAccount:=InventoryPostingSetup."Inventory Account";
                        Committment.Account:=InventoryAccount;
                    end;
                    PurchLine.Type::"G/L Account": begin
                        Committment.Account:=PurchLine."No.";
                    end;
                    PurchLine.Type::"Fixed Asset": begin
                        FixedAsset.Reset;
                        FixedAsset.Get(PurchLine."No.");
                        FixedAssetPG.Get(FixedAsset."FA Posting Group");
                        AcquisitionAccount:=FixedAssetPG."Acquisition Cost Account";
                        Committment.Account:=AcquisitionAccount;
                    end;
                    end;
                    Committment."Committed Amount":=-PurchLine."Line Amount";
                    Committment.User:=UserId;
                    Committment."Document No":=PurchHeader."No.";
                    Committment."No.":=PurchLine."No.";
                    Committment."Account Type":=Committment."Account Type"::Vendor;
                    Committment."Account No.":=PurchLine."Buy-from Vendor No.";
                    if Vendor.Get(PurchLine."Buy-from Vendor No.")then Committment."Account Name":=Vendor.Name;
                    Committment.Description:=PurchLine.Description;
                    Committment.Insert;
                //Mark entries as uncommited
                //vooPurchLine.Committed:=FALSE;
                //vooPurchLine.MODIFY;
                end;
            until PurchLine.Next = 0;
        end;
    end;
    procedure GetAvailableBudget(BudgetLine: Code[20]; RefDate: Date; var DimensionOne: Code[20]; var DimensionTwo: Code[20]): Decimal var
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        CommittedAmount: Decimal;
        GLAccount: Record "G/L Account";
        Committments: Record "Commitment Entries";
        GenLedSetup: Record "Cash Management Setup";
    begin
        BudgetAvailable:=0;
        GenLedSetup.Get;
        GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
        GLAccount.SetRange(GLAccount."No.", BudgetLine);
        if DimensionOne <> '' then GLAccount.SetFilter(GLAccount."Global Dimension 1 Filter", DimensionOne);
        if DimensionTwo <> '' then GLAccount.SetFilter(GLAccount."Global Dimension 2 Filter", DimensionTwo);
        GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
        //Get budget amount avaliable
        GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", GenLedSetup."Current Budget End Date");
        if GLAccount.Find('-')then begin
            GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
            BudgetAmount:=GLAccount."Budgeted Amount";
            Expenses:=GLAccount."Net Change";
            BudgetAvailable:=GLAccount."Budgeted Amount" - GLAccount."Net Change";
        end;
        //Get committed Amount
        CommittedAmount:=0;
        CommitmentEntries.Reset;
        CommitmentEntries.SetCurrentKey(Account);
        CommitmentEntries.SetRange(Account, BudgetLine);
        CommitmentEntries.SetRange("Commitment Date", GenLedSetup."Current Budget Start Date", RefDate);
        if DimensionOne <> '' then CommitmentEntries.SetRange("Global Dimension 1", DimensionOne);
        if DimensionTwo <> '' then CommitmentEntries.SetRange("Global Dimension 2", DimensionTwo);
        CommitmentEntries.CalcSums("Committed Amount");
        CommittedAmount:=CommitmentEntries."Committed Amount";
        BudgetAvailable:=BudgetAvailable - CommittedAmount;
        exit(BudgetAvailable);
    end;
    // procedure ImprestMemoCommitment(var Header: Record "Imprest Memo Header")
    // var
    //     Committments: Record "Commitment Entries";
    //     Item: Record Item;
    //     GLAccount: Record "G/L Account";
    //     FixedAsset: Record "Fixed Asset";
    //     EntryNo: Integer;
    //     InventoryPostingSetup: Record "Inventory Posting Setup";
    //     FixedAssetPG: Record "FA Posting Group";
    //     GenLedSetup: Record "Cash Management Setup";
    //     InventoryAccount: Code[20];
    //     AcquisitionAccount: Code[20];
    //     BudgetAmount: Decimal;
    //     Expenses: Decimal;
    //     BudgetAvailable: Decimal;
    //     CommitmentEntries: Record "Commitment Entries";
    //     CommittedAmount: Decimal;
    //     Vendor: Record Vendor;
    // begin
    //     PurchaseLines.Reset;
    //     PurchaseLines.SetRange(PurchaseLines."Document No.", PurchaseHeader."No.");
    //     PurchaseLines.SetRange(PurchaseLines."Document Type", PurchaseLines."Document Type"::Order);
    //     if PurchaseLines.FindFirst then begin
    //         if Committments.FindLast then
    //             EntryNo := Committments."Entry No";
    //         repeat
    //             Committments.Init;
    //             Committments."Commitment No" := PurchaseHeader."No.";
    //             Committments."Commitment Type" := Committments."Commitment Type"::Committed;
    //             // PurchaseHeader.VALIDATE("Order Date");
    //             if PurchaseHeader."Order Date" = 0D then
    //                 Error('Please enter the order date');
    //             Committments."Commitment Date" := PurchaseHeader."Order Date";
    //             Committments."Global Dimension 1" := PurchaseLines."Shortcut Dimension 1 Code";
    //             Committments."Global Dimension 2" := PurchaseLines."Shortcut Dimension 2 Code";
    //             //Case of G/L Account,Item,Fixed Asset
    //             case PurchaseLines.Type of
    //                 PurchaseLines.Type::Item:
    //                     begin
    //                         Item.Reset;
    //                         if Item.Get(PurchaseLines."No.") then
    //                             if Item."Inventory Posting Group" = '' then
    //                                 Error('Assign Posting Group to Item No %1', Item."No.");
    //                         InventoryPostingSetup.Get(PurchaseLines."Location Code", Item."Inventory Posting Group");
    //                         InventoryAccount := InventoryPostingSetup."Inventory Account";
    //                         Committments.Account := InventoryAccount;
    //                     end;
    //                 PurchaseLines.Type::"G/L Account":
    //                     begin
    //                         Committments.Account := PurchaseLines."No.";
    //                     end;
    //                 PurchaseLines.Type::"Fixed Asset":
    //                     begin
    //                         if FixedAssetPG.Get(PurchaseLines."Posting Group") then begin
    //                             FixedAssetPG.TestField("Acquisition Cost Account");
    //                             AcquisitionAccount := FixedAssetPG."Acquisition Cost Account";
    //                             Committments.Account := AcquisitionAccount;
    //                         end;
    //                     end;
    //             end;
    //             Committments."Committed Amount" := PurchaseLines."Line Amount";
    //             //Confirm the Amount to be issued does not exceed the budget and amount Committed
    //             //Get Budget for the G/L
    //             GenLedSetup.Get;
    //             GLAccount.SetFilter(GLAccount."Budget Filter", GenLedSetup."Current Budget");
    //             case PurchaseLines.Type of
    //                 PurchaseLines.Type::Item:
    //                     begin
    //                         GLAccount.SetRange(GLAccount."No.", InventoryAccount);
    //                     end;
    //                 PurchaseLines.Type::"G/L Account":
    //                     begin
    //                         GLAccount.SetRange(GLAccount."No.", PurchaseLines."No.");
    //                     end;
    //                 PurchaseLines.Type::"Fixed Asset":
    //                     GLAccount.SetRange(GLAccount."No.", AcquisitionAccount);
    //             end;
    //             GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
    //             //Get budget amount avaliable
    //             GLAccount.SetRange(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", GenLedSetup."Current Budget End Date");
    //             if GLAccount.Find('-') then begin
    //                 GLAccount.CalcFields(GLAccount."Budgeted Amount", GLAccount."Net Change");
    //                 BudgetAmount := GLAccount."Budgeted Amount";
    //                 Expenses := GLAccount."Net Change";
    //                 BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
    //             end;
    //             //Get committed Amount
    //             CommittedAmount := 0;
    //             CommitmentEntries.Reset;
    //             CommitmentEntries.SetCurrentKey(CommitmentEntries.Account);
    //             if PurchaseLines.Type = PurchaseLines.Type::Item then
    //                 CommitmentEntries.SetRange(CommitmentEntries.Account, InventoryAccount);
    //             if PurchaseLines.Type = PurchaseLines.Type::"G/L Account" then
    //                 CommitmentEntries.SetRange(CommitmentEntries.Account, PurchaseLines."No.");
    //             if PurchaseLines.Type = PurchaseLines.Type::"Fixed Asset" then
    //                 CommitmentEntries.SetRange(CommitmentEntries.Account, AcquisitionAccount);
    //             CommitmentEntries.SetRange(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
    //                                        PurchaseHeader."Order Date");
    //             CommitmentEntries.CalcSums(CommitmentEntries."Committed Amount");
    //             CommittedAmount := CommitmentEntries."Committed Amount";
    //             if LineCommitted(PurchaseHeader."No.", PurchaseLines."No.", PurchaseLines."Line No.") then
    //                 Message('Line No %1 has been commited', PurchaseLines."Line No.")
    //             else
    //                 /*IF CommittedAmount+PurchaseLines."Line Amount">BudgetAvailable THEN
    //                   IF (BudgetAvailable < 0) OR (BudgetAvailable = 0) THEN
    //                     ERROR('There is no budget available for %1',PurchaseLines.Description)
    //                    ELSE
    //                    ERROR('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3 CommittedAmount %4'
    //                    ,Committments.Account,
    //                    ABS(BudgetAvailable-(CommittedAmount+PurchaseLines."Line Amount")),BudgetAvailable,CommittedAmount);*/
    //            Committments.User := UserId;
    //             Committments."Document No" := PurchaseHeader."No.";
    //             Committments."No." := PurchaseLines."No.";
    //             Committments."Line No." := PurchaseLines."Line No.";
    //             Committments."Account Type" := Committments."Account Type"::Vendor;
    //             Committments."Account No." := PurchaseLines."Buy-from Vendor No.";
    //             if Vendor.Get(PurchaseLines."Buy-from Vendor No.") then
    //                 Committments."Account Name" := Vendor.Name;
    //             Committments.Description := PurchaseLines.Description;
    //             //Check whether line is committed.
    //             if not LineCommitted(PurchaseHeader."No.", PurchaseLines."No.", PurchaseLines."Line No.") then begin
    //                 EntryNo := EntryNo + 1;
    //                 Committments."Entry No" := EntryNo;
    //                 Committments.Insert;
    //                 PurchaseLines.Status := PurchaseLines.Status::Committed;
    //                 PurchaseLines.Modify;
    //             end;
    //         until PurchaseLines.Next = 0;
    //     end;
    // end;
    procedure InsertImprestBudgetAnalysis(var Memo: Record "Imprest Memo Header")
    var
        BudgetAnalysis: Record "Imprest Budget Analysis";
        BudgetAnalysis2: Record "Imprest Budget Analysis";
        ImprestSetup: Record "Advanced Finance Setup";
        ExpenseCodes: Record "Expense Codes";
        CMSetup: Record "Cash Management Setup";
    begin
        if(Memo.Status <> Memo.Status::Open) and (Memo.Status <> Memo.Status::"Pending Approval")then exit;
        CMSetup.Get();
        CMSetup.TestField("Current Budget");
        CMSetup.TestField("Current Budget Start Date");
        CMSetup.TestField("Current Budget End Date");
        ImprestSetup.Get();
        ImprestSetup.TestField("DSA Expense Code");
        if ExpenseCodes.Get(ImprestSetup."DSA Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Air Ticket Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Air Ticket Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Conference Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Conference Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("G.Transport Expense Code");
        if ExpenseCodes.Get(ImprestSetup."G.Transport Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Cord. Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Cord. Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Facilitator Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Facilitator Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Secretariat Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Secretariat Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Out of Pocket Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Out of Pocket Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Rapporteur Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Rapporteur Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Driver Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Driver Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Retreat Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Retreat Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Expert Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Expert Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Accomodation Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Accomodation Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Tuition Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Tuition Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Mileage Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Mileage Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        ImprestSetup.TestField("Qtr. Per Diem Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Qtr. Per Diem Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not BudgetAnalysis2.Get(Memo."No.", ExpenseCodes."Account No")then begin
                BudgetAnalysis.Init();
                BudgetAnalysis."Memo No.":=Memo."No.";
                BudgetAnalysis."Budget Line":=ExpenseCodes."Account No";
                BudgetAnalysis.Description:=ExpenseCodes."Account Name";
                BudgetAnalysis."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis.Insert();
            end
            else
            begin
                BudgetAnalysis2."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                BudgetAnalysis2."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                BudgetAnalysis2."Budget Code":=CMSetup."Current Budget";
                BudgetAnalysis2."Budget Period Start":=CMSetup."Current Budget Start Date";
                BudgetAnalysis2."Budget Period End":=CMSetup."Current Budget End Date";
                BudgetAnalysis2."Budget Date Filter":=Format(CMSetup."Current Budget Start Date") + '..' + Format(CMSetup."Current Budget End Date");
                BudgetAnalysis2.Modify();
            end;
        end;
        InsertImprestExpenses(Memo);
    end;
    procedure ImprestMemoBudgetCheck(var Memo: Record "Imprest Memo Header")
    var
        BudgetAnalysis: Record "Imprest Budget Analysis";
        BudgetAnalysis2: Record "Imprest Budget Analysis";
        ImprestSetup: Record "Advanced Finance Setup";
        ExpenseCodes: Record "Expense Codes";
        CMSetup: Record "Cash Management Setup";
        GLAccount: Record "G/L Account";
        TotalBudget: Decimal;
        InsufficientExists: Boolean;
        Commitments: Record "Commitment Entries";
        CommittedAmount: Decimal;
    begin
        ImprestSetup.Get();
        CMSetup.Get();
        InsufficientExists:=false;
        Memo.CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount", "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount", "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount", "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount", "Quarter Per Diem Amount", "Other Costs Amount", "Total Amount");
        TotalBudget:=0;
        BudgetAnalysis.Reset();
        BudgetAnalysis.SetRange("Memo No.", Memo."No.");
        if BudgetAnalysis.FindFirst()then begin
            repeat CommittedAmount:=0;
                Clear(GLAccount);
                Clear(Commitments);
                Commitments.Reset();
                Commitments.SetFilter("Commitment No", '<>%1', Memo."No.");
                Commitments.SetRange("Commitment Date", CMSetup."Current Budget Start Date", CMSetup."Current Budget End Date");
                Commitments.SetRange("Account No.", BudgetAnalysis."Budget Line");
                if BudgetAnalysis."Global Dimension 1 Code" <> '' then Commitments.SetRange("Global Dimension 1", BudgetAnalysis."Global Dimension 1 Code");
                if BudgetAnalysis."Global Dimension 2 Code" <> '' then Commitments.SetRange("Global Dimension 2", BudgetAnalysis."Global Dimension 2 Code");
                if Commitments.FindSet()then begin
                    Commitments.CalcSums("Committed Amount");
                    CommittedAmount:=Commitments."Committed Amount";
                end;
                GLAccount.Get(BudgetAnalysis."Budget Line");
                GLAccount.SetFilter("Budget Filter", BudgetAnalysis."Budget Code");
                GLAccount.SetFilter("Date Filter", BudgetAnalysis."Budget Date Filter");
                GLAccount.SetFilter("Global Dimension 1 Filter", BudgetAnalysis."Global Dimension 1 Code");
                GLAccount.SetFilter("Global Dimension 2 Filter", BudgetAnalysis."Global Dimension 2 Code");
                GLAccount.CalcFields(Balance, "Budgeted Amount");
                BudgetAnalysis.CalcFields("Amount on Budget");
                BudgetAnalysis."Available Balance":=GLAccount."Budgeted Amount" - CommittedAmount - GLAccount.Balance;
                BudgetAnalysis."Amount Required":=0;
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."DSA Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."DSA Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Air Ticket Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Air Ticket Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Conference Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Conference Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."G.Transport Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Ground Transport Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Accomodation Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Accomodation Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Cord. Allow Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Cordination Allowance Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Facilitator Allow Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Facilitator Allowance Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Secretariat Allow Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Secretariat Allowance Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Out of Pocket Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Out ofPocket Allowance Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Rapporteur Allow Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Rapporteur Allowance Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Driver Allow Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Driver Allowance Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Retreat Allow Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Retreat Allowance Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Expert Allow Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Expert Allowance Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Tuition Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Tuition Fee Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Mileage Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Mileage Allowance Amount";
                if BudgetAnalysis."Budget Line" = GetExpenseCodeAccount(ImprestSetup."Qtr. Per Diem Expense Code")then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Quarter Per Diem Amount";
                if BudgetAnalysis."Budget Line" = Memo."Budget Line" then BudgetAnalysis."Amount Required":=BudgetAnalysis."Amount Required" + Memo."Other Costs Amount";
                if BudgetAnalysis."Amount Required" > BudgetAnalysis."Available Balance" then begin
                    BudgetAnalysis."Budget Availability":=BudgetAnalysis."Budget Availability"::Insufficient;
                    InsufficientExists:=true;
                end
                else
                    BudgetAnalysis."Budget Availability":=BudgetAnalysis."Budget Availability"::Sufficient;
                BudgetAnalysis.Modify();
                TotalBudget:=TotalBudget + BudgetAnalysis."Available Balance";
                Commit();
            until BudgetAnalysis.Next() = 0;
        end;
        Memo."Amount on Budget":=TotalBudget;
        if InsufficientExists then Memo."Budget Available":=false
        else
            Memo."Budget Available":=true;
        Memo.Modify();
        ImprestMemoExpenseCheck(Memo);
    end;
    local procedure GetExpenseCodeAccount(var ExpenseCode: Code[20]): Code[20]var
        ExpenseCodes: Record "Expense Codes";
    begin
        if ExpenseCodes.Get(ExpenseCode)then exit(ExpenseCodes."Account No")
        else
            exit('');
    end;
    procedure ImprestMemoCommitment(var Memo: Record "Imprest Memo Header")
    var
        MemoLines: Record "Imprest Budget Analysis";
        Committments: Record "Commitment Entries";
        GLAccount: Record "G/L Account";
        EntryNo: Integer;
        GenLedSetup: Record "Cash Management Setup";
        BudgetAmount: Decimal;
        Expenses: Decimal;
        BudgetAvailable: Decimal;
        CommitmentEntries: Record "Commitment Entries";
        CommittedAmount: Decimal;
        LineNo: Integer;
    begin
        if not Memo."Budget Available" then Error('Do a Budget Check to confirm availability of Budget!');
        if not Memo.Committed then begin
            MemoLines.Reset;
            MemoLines.SetRange("Memo No.", Memo."No.");
            if MemoLines.FindFirst then begin
                if Committments.FindLast then EntryNo:=Committments."Entry No";
                repeat if MemoLines."Amount Required" <> 0 then begin
                        Evaluate(LineNo, MemoLines."Budget Line");
                        Committments.Init;
                        Committments."Commitment No":=Memo."No.";
                        Committments."Commitment Type":=Committments."Commitment Type"::Imprest;
                        if Memo.Date = 0D then Error('Please enter the memo date');
                        Committments."Commitment Date":=Memo.Date;
                        Committments."Global Dimension 1":=MemoLines."Global Dimension 1 Code";
                        Committments."Global Dimension 2":=MemoLines."Global Dimension 2 Code";
                        Committments.Account:=MemoLines."Budget Line";
                        Committments."Committed Amount":=MemoLines."Amount Required";
                        Committments.User:=UserId;
                        Committments."Document No":=Memo."No.";
                        Committments."No.":=MemoLines."Memo No.";
                        Committments."Line No.":=LineNo;
                        Committments."Account Type":=Committments."Account Type"::"G/L Account";
                        Committments."Account No.":=MemoLines."Budget Line";
                        Committments."Account Name":=MemoLines.Description;
                        Committments.Description:=Memo.Justification;
                        //Check whether line is committed.
                        if not LineCommitted(Memo."No.", MemoLines."Budget Line", LineNo)then begin
                            EntryNo:=EntryNo + 1;
                            Committments."Entry No":=EntryNo;
                            Committments.Insert;
                        end;
                    end;
                until MemoLines.Next = 0;
                Memo.Committed:=true;
                Memo.Modify();
            end;
        end;
    end;
    procedure UndoImprestMemoCommitment(var Memo: Record "Imprest Memo Header")
    var
        Committments: Record "Commitment Entries";
    begin
        if Memo.Committed then begin
            Committments.Reset;
            Committments.SetRange("Commitment No", Memo."No.");
            if Committments.FindSet()then Committments.DeleteAll;
            Memo.Committed:=false;
            Memo.Modify();
        end;
    end;
    procedure InsertImprestExpenses(var Memo: Record "Imprest Memo Header")
    var
        ImprestExpenses: Record "Imprest Procurement Decision";
        ImprestExpenses2: Record "Imprest Procurement Decision";
        ImprestSetup: Record "Advanced Finance Setup";
        ExpenseCodes: Record "Expense Codes";
        CMSetup: Record "Cash Management Setup";
    begin
        if(Memo.Status <> Memo.Status::Open) and (Memo.Status <> Memo.Status::"Pending Approval")then exit;
        ImprestSetup.Get();
        ImprestSetup.TestField("DSA Expense Code");
        if ExpenseCodes.Get(ImprestSetup."DSA Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."DSA Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."DSA Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Air Ticket Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Air Ticket Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Air Ticket Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Air Ticket Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Conference Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Conference Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Conference Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Conference Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("G.Transport Expense Code");
        if ExpenseCodes.Get(ImprestSetup."G.Transport Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."G.Transport Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."G.Transport Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Cord. Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Cord. Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Cord. Allow Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Cord. Allow Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Facilitator Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Facilitator Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Facilitator Allow Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Facilitator Allow Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Secretariat Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Secretariat Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Secretariat Allow Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Secretariat Allow Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Out of Pocket Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Out of Pocket Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Out of Pocket Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Out of Pocket Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Rapporteur Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Rapporteur Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Rapporteur Allow Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Rapporteur Allow Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Driver Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Driver Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Driver Allow Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Driver Allow Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Retreat Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Retreat Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Retreat Allow Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Retreat Allow Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Expert Allow Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Expert Allow Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Expert Allow Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Expert Allow Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Accomodation Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Accomodation Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Accomodation Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Accomodation Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Tuition Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Tuition Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Tuition Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Tuition Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Mileage Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Mileage Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Mileage Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Mileage Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
        ImprestSetup.TestField("Qtr. Per Diem Expense Code");
        if ExpenseCodes.Get(ImprestSetup."Qtr. Per Diem Expense Code")then begin
            ExpenseCodes.TestField("Account No");
            if not ImprestExpenses2.Get(Memo."No.", ImprestSetup."Qtr. Per Diem Expense Code")then begin
                ImprestExpenses.Init();
                ImprestExpenses."Memo No.":=Memo."No.";
                ImprestExpenses."Expense Code":=ImprestSetup."Qtr. Per Diem Expense Code";
                ImprestExpenses.Description:=ExpenseCodes.Description;
                ImprestExpenses."Global Dimension 1 Code":=Memo."Global Dimension 1 Code";
                ImprestExpenses."Global Dimension 2 Code":=Memo."Global Dimension 2 Code";
                ImprestExpenses.Decision:=ExpenseCodes."Treatment On Imprest";
                ImprestExpenses.Insert();
            end;
        end;
    end;
    procedure ImprestMemoExpenseCheck(var Memo: Record "Imprest Memo Header")
    var
        ImprestExpenses: Record "Imprest Procurement Decision";
        ImprestExpenses2: Record "Imprest Procurement Decision";
        ImprestSetup: Record "Advanced Finance Setup";
        ExpenseCodes: Record "Expense Codes";
    begin
        ImprestSetup.Get();
        Memo.CalcFields("DSA Amount", "Air Ticket Amount", "Conference Amount", "Ground Transport Amount", "Accomodation Amount", "Cordination Allowance Amount", "Facilitator Allowance Amount", "Secretariat Allowance Amount", "Out ofPocket Allowance Amount", "Rapporteur Allowance Amount", "Driver Allowance Amount", "Retreat Allowance Amount", "Expert Allowance Amount", "Tuition Fee Amount", "Mileage Allowance Amount", "Quarter Per Diem Amount", "Other Costs Amount", "Total Amount");
        ImprestExpenses.Reset();
        ImprestExpenses.SetRange("Memo No.", Memo."No.");
        if ImprestExpenses.FindFirst()then begin
            repeat ImprestExpenses.Amount:=0;
                if ImprestExpenses."Expense Code" = ImprestSetup."DSA Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."DSA Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Air Ticket Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Air Ticket Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Conference Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Conference Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."G.Transport Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Ground Transport Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Accomodation Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Accomodation Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Cord. Allow Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Cordination Allowance Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Facilitator Allow Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Facilitator Allowance Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Secretariat Allow Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Secretariat Allowance Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Out of Pocket Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Out ofPocket Allowance Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Rapporteur Allow Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Rapporteur Allowance Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Driver Allow Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Driver Allowance Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Retreat Allow Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Retreat Allowance Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Expert Allow Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Expert Allowance Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Tuition Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Tuition Fee Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Mileage Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Mileage Allowance Amount";
                if ImprestExpenses."Expense Code" = ImprestSetup."Qtr. Per Diem Expense Code" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Quarter Per Diem Amount";
                if ImprestExpenses."Expense Code" = Memo."Budget Line" then ImprestExpenses.Amount:=ImprestExpenses.Amount + Memo."Other Costs Amount";
                ImprestExpenses.Modify();
                Commit();
            until ImprestExpenses.Next() = 0;
        end;
    end;
}
