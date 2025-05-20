codeunit 52110 "Budget Management"
{
    trigger OnRun()
    begin
    end;
    procedure PostSupplementaryBudget(var Header: Record "Supplementary Budget Request")
    begin
        if Confirm(StrSubstNo(Text001, Header."No."), false) = true then begin
            Lines.Reset();
            Lines.SetRange("Document No", Header."No.");
            if Lines.FindSet()then begin
                repeat //Reverse Budget Entry
                    BudgetEnries.Init();
                    BudgetEnries."Budget Name":=Lines."Budget Name";
                    BudgetEnries.Date:=Header."Document Date";
                    BudgetEnries."G/L Account No.":=Lines."Transfer From";
                    BudgetEnries.Description:=Lines.Description;
                    BudgetEnries.Amount:=-Lines.Amount;
                    BudgetEnries.Insert(true);
                    //Create New Budget Entry
                    BudgetEnries2.Init();
                    BudgetEnries2."Budget Name":=Lines."Budget Name";
                    BudgetEnries2.Date:=Header."Document Date";
                    BudgetEnries2."G/L Account No.":=Lines."Transfer To";
                    BudgetEnries2."Global Dimension 1 Code":=Lines."Global Dimension 1 Code";
                    BudgetEnries2."Global Dimension 2 Code":=Lines."Global Dimension 2 Code";
                    BudgetEnries2."Budget Dimension 1 Code":=Header."Budget Dimension 1 Code";
                    BudgetEnries2."Budget Dimension 2 Code":=Header."Budget Dimension 2 Code";
                    BudgetEnries2."Budget Dimension 3 Code":=Header."Budget Dimension 3 Code";
                    BudgetEnries2."Budget Dimension 4 Code":=Header."Budget Dimension 4 Code";
                    BudgetEnries2.Description:=Lines.Description;
                    BudgetEnries2.Amount:=Lines.Amount;
                    BudgetEnries2.Insert(true);
                until Lines.Next = 0;
                Header.Effected:=true;
                Header."Effected By":=UserId;
                Header."Effected Date":=Today;
                Message(Text002);
            end;
        end
        else
        begin
            exit;
        end;
    end;
    procedure SugestBudgetCategoryDistributionLines(var DistributionHeader: Record "Budget Category Dist. Header")
    var
        Lines: Record "Budget Category Dist. Lines";
    begin
        if Confirm('Are you sure you want to suggest Budget Categories? This will CLEAR any existing categories already captured on this page.', false) = true then begin
            if DistributionHeader.Status <> DistributionHeader.Status::Draft then Error('You can only suggest lines in a draft.');
            ClearBudgetCategoriesOnDistributionLines(DistributionHeader.Budget, DistributionHeader."Business Unit");
            Categories.Reset;
            Categories.SetRange("Business Unit", DistributionHeader."Business Unit");
            Categories.SetRange(Inactive, false);
            if Categories.Find('-')then begin
                repeat //Get Units
                    GLSetup.Get;
                    DimValue.Reset;
                    DimValue.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                    DimValue.SetRange(Blocked, false);
                    if DimValue.Find('-')then begin
                        repeat //Insert
                            InsertBudgetCategoriesOnDistributionLines(DistributionHeader.Budget, Categories.No, DimValue.Code, DistributionHeader."Business Unit");
                        until DimValue.Next = 0;
                    end;
                until Categories.Next = 0;
            end;
        end;
    end;
    local procedure InsertBudgetCategoriesOnDistributionLines(var Budget: Code[10]; var Category: Code[10]; var Dept: Code[10]; var BusinessUnit: Option IT, ADMIN)
    var
        Lines: Record "Budget Category Dist. Lines";
    begin
        Lines.Init;
        Lines.Budget:=Budget;
        Lines."Category Code":=Category;
        Lines."Global Dimension 1 Code":=Dept;
        Lines."Business Unit":=BusinessUnit;
        Lines.Validate("Category Code");
        Lines.Validate("Global Dimension 1 Code");
        Lines.Insert;
    end;
    local procedure ClearBudgetCategoriesOnDistributionLines(var Budget: Code[10]; var BusinessUnit: Option IT, ADMIN)
    var
        Lines: Record "Budget Category Dist. Lines";
    begin
        Lines.Reset;
        Lines.SetRange(Budget, Budget);
        Lines.SetRange("Business Unit", BusinessUnit);
        Lines.DeleteAll;
    end;
    procedure CopyBudgetCategoryDistributionLines(var DistributionHeader: Record "Budget Category Dist. Header")
    var
        Lines: Record "Budget Category Dist. Lines";
    begin
        Error('Coming Soon');
        if Confirm('Are you sure you want to copy Budget Category Distributions from Previous Ones? This will CLEAR any existing categories already captured on this page.', false) = true then begin
            if DistributionHeader.Status <> DistributionHeader.Status::Draft then Error('You can only suggest lines in a draft.');
            ClearBudgetCategoriesOnDistributionLines(DistributionHeader.Budget, DistributionHeader."Business Unit");
        end;
    end;
    procedure DistributeStaffBasedBudget(var StaffBasedBudgetHeader: Record "Staff Based Budget Header")
    begin
        if Confirm(StrSubstNo(Text004, StaffBasedBudgetHeader."No."), false) = true then begin
            StaffBasedBudgetLines.Reset();
            StaffBasedBudgetLines.SetRange(Budget, StaffBasedBudgetHeader.Budget);
            StaffBasedBudgetLines.SetRange(Department, StaffBasedBudgetHeader."Global Dimension 1 Code");
            StaffBasedBudgetLines.SetRange(Status, StaffBasedBudgetHeader.Status);
            StaffBasedBudgetLines.SetFilter(Amount, '<>%1', 0);
            if StaffBasedBudgetLines.FindSet()then begin
                repeat BudgetDistribution.Init;
                    BudgetDistribution.Validate("GL Account", StaffBasedBudgetLines."Budget Line Account");
                    BudgetDistribution.Validate(Department, StaffBasedBudgetLines.Department);
                    BudgetDistribution.Validate(Branch, StaffBasedBudgetLines.Branch);
                    BudgetDistribution.Validate("SI Code", StaffBasedBudgetLines."SI Code");
                    BudgetDistribution.Budget:=StaffBasedBudgetLines.Budget;
                    BudgetDistribution.Date:=StaffBasedBudgetHeader."Reference Date";
                    BudgetDistribution.Amount:=Round(StaffBasedBudgetLines.Amount, 0.01);
                    if not BudgetDistributionCopy.Get(StaffBasedBudgetLines."Budget Line Account", StaffBasedBudgetLines.Department, StaffBasedBudgetLines.Branch, StaffBasedBudgetLines."SI Code", StaffBasedBudgetLines.Budget, StaffBasedBudgetHeader."Reference Date")then BudgetDistribution.Insert
                    else
                    begin
                        BudgetDistributionCopy.Amount:=BudgetDistributionCopy.Amount + BudgetDistribution.Amount;
                        BudgetDistributionCopy.Modify;
                    end;
                until StaffBasedBudgetLines.Next() = 0;
            end;
        end
        else
        begin
            exit;
        end;
    end;
    var BudgetEnries: Record "G/L Budget Entry";
    BudgetEnries2: Record "G/L Budget Entry";
    Lines: Record "Suppl. Budget Request Lines";
    GLSetup: Record "General Ledger Setup";
    GLAcc: Record "G/L Account";
    Committments: Record "Commitment Entries";
    DimValue: Record "Dimension Value";
    Categories: Record "Budget Category";
    Item: Record Item;
    InventoryPostingSetup: Record "Inventory Posting Setup";
    FixedAssetPG: Record "FA Posting Group";
    BudgetDistribution: Record "Budget Distribution";
    StaffBasedBudgetLines: Record "Staff Based Budget";
    Counter: Integer;
    BudgetDistributionCopy: Record "Budget Distribution";
    StaffBudget: Record "Staff Based Budget";
    BudgetCategoryDistributionLines: Record "Budget Category Dist. Lines";
    POLine: Record "Purchase Line";
    "*******************************FA*******************": Text;
    FAInsertGLAccount: Codeunit "FA Insert G/L Account";
    TempFAGLPostBuf: Record "FA G/L Posting Buffer" temporary;
    FAGLPostBuf: Record "FA G/L Posting Buffer";
    FAAlloc: Record "FA Allocation";
    FAPostingGr: Record "FA Posting Group";
    FAPostingGr2: Record "FA Posting Group";
    FADeprBook: Record "FA Depreciation Book";
    FADimMgt: Codeunit FADimensionManagement;
    FAGetGLAcc: Codeunit "FA Get G/L Account No.";
    DepreciationCalc: Codeunit "Depreciation Calculation";
    NextEntryNo: Integer;
    GLEntryNo: Integer;
    TotalAllocAmount: Decimal;
    NewAmount: Decimal;
    TotalPercent: Decimal;
    NumberOfEntries: Integer;
    NextLineNo: Integer;
    NoOfEmptyLines: Integer;
    NoOfEmptyLines2: Integer;
    OrgGenJnlLine: Boolean;
    DisposalEntryNo: Integer;
    GainLossAmount: Decimal;
    DisposalAmount: Decimal;
    BookValueEntry: Boolean;
    NetDisp: Boolean;
    Text000: Label 'must not be more than 100';
    Text001: Label 'There is not enough space to insert the balance accounts.';
    Text002: Label 'Supplimentary Budget Request have been Posted Successifully';
    Text003: Label 'You are about to Post a Supplimentary Budget Request %1, Do you wish to continue?';
    Text004: Label 'You are about to Distribute Staff Based Budget for %1, Do you wish to continue?';
}
