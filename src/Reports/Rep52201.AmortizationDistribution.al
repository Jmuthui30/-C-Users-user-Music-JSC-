report 52201 "Amortization Distribution"
{
    // version BUDGET
    UsageCategory = Tasks;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Amortization Header"; "Amortization Header")
        {
            dataitem("Amortization Lines"; "Amortization Lines")
            {
                DataItemLink = No=FIELD(No);

                trigger OnAfterGetRecord()
                begin
                    NoOfEntities:=0;
                    if DeptFilters = '' then DeptFilters:='*';
                    if BranchFilters = '' then BranchFilters:='*';
                    if(DistributeByDept = true) and (DistributeByBranch = true)then begin
                        //Get Total No of Employees
                        Employee.Reset;
                        Employee.SetRange(Status, Employee.Status::Active);
                        if DeptFilters = '*' then Employee.SetFilter("Global Dimension 1 Code", '<>%1', '')
                        else
                            Employee.SetFilter("Global Dimension 1 Code", DeptFilters);
                        if BranchFilters = '*' then Employee.SetFilter("Global Dimension 2 Code", '<>%1', '')
                        else
                            Employee.SetFilter("Global Dimension 2 Code", BranchFilters);
                        TotalEmployees:=Employee.Count;
                        //
                        if DistributionMethod = DistributionMethod::"No. of Staff" then begin
                            Departments.Reset;
                            Departments.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                            Departments.SetFilter(Code, DeptFilters);
                            Departments.SetRange(Blocked, false);
                            if Departments.FindFirst then begin
                                repeat Branches.Reset;
                                    Branches.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                                    Branches.SetFilter(Code, BranchFilters);
                                    Branches.SetRange(Blocked, false);
                                    if Branches.FindFirst then begin
                                        repeat DistributeOnNoOfEmployees(Departments.Code, Branches.Code, "Amortization Lines", TotalEmployees);
                                        until Branches.Next = 0;
                                    end;
                                until Departments.Next = 0;
                            end;
                        end
                        else if DistributionMethod = DistributionMethod::"Equally Distributed" then begin
                                Departments.Reset;
                                Departments.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                                Departments.SetFilter(Code, DeptFilters);
                                Departments.SetRange(Blocked, false);
                                NoOfEntities:=Departments.Count;
                                Branches.Reset;
                                Branches.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                                Branches.SetFilter(Code, BranchFilters);
                                Branches.SetRange(Blocked, false);
                                NoOfEntities:=NoOfEntities * Branches.Count;
                                Departments.Reset;
                                Departments.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                                Departments.SetFilter(Code, DeptFilters);
                                Departments.SetRange(Blocked, false);
                                if Departments.FindFirst then begin
                                    repeat Branches.Reset;
                                        Branches.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                                        Branches.SetFilter(Code, BranchFilters);
                                        Branches.SetRange(Blocked, false);
                                        if Branches.FindFirst then begin
                                            repeat DistributeEqually(Departments.Code, Branches.Code, "Amortization Lines", NoOfEntities, TotalEmployees);
                                            until Branches.Next = 0;
                                        end;
                                    until Departments.Next = 0;
                                end;
                            end
                            else
                                Error('Distribution Method No. of Computers is not enabled!');
                    end;
                    if(DistributeByDept = true) and (DistributeByBranch = false)then begin
                        //Get Total No of Employees
                        Employee.Reset;
                        Employee.SetRange(Status, Employee.Status::Active);
                        Employee.SetFilter("Global Dimension 1 Code", DeptFilters);
                        TotalEmployees:=Employee.Count;
                        //
                        if DistributionMethod = DistributionMethod::"No. of Staff" then begin
                            Departments.Reset;
                            Departments.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                            Departments.SetFilter(Code, DeptFilters);
                            Departments.SetRange(Blocked, false);
                            if Departments.FindFirst then begin
                                repeat DistributeOnNoOfEmployees(Departments.Code, BlankText, "Amortization Lines", TotalEmployees);
                                until Departments.Next = 0;
                            end;
                        end
                        else if DistributionMethod = DistributionMethod::"Equally Distributed" then begin
                                Departments.Reset;
                                Departments.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                                Departments.SetFilter(Code, DeptFilters);
                                Departments.SetRange(Blocked, false);
                                NoOfEntities:=Departments.Count;
                                if Departments.FindFirst then begin
                                    repeat DistributeEqually(Departments.Code, BlankText, "Amortization Lines", NoOfEntities, TotalEmployees);
                                    until Departments.Next = 0;
                                end;
                            end
                            else
                                Error('Distribution Method No. of Computers is not enabled!');
                    end;
                    if(DistributeByDept = false) and (DistributeByBranch = true)then begin
                        //Get Total No of Employees
                        Employee.Reset;
                        Employee.SetRange(Status, Employee.Status::Active);
                        Employee.SetFilter("Global Dimension 2 Code", BranchFilters);
                        TotalEmployees:=Employee.Count;
                        //
                        if DistributionMethod = DistributionMethod::"No. of Staff" then begin
                            Branches.Reset;
                            Branches.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                            Branches.SetFilter(Code, BranchFilters);
                            Branches.SetRange(Blocked, false);
                            if Branches.FindFirst then begin
                                repeat DistributeOnNoOfEmployees(BlankText, Branches.Code, "Amortization Lines", TotalEmployees);
                                until Branches.Next = 0;
                            end;
                        end
                        else if DistributionMethod = DistributionMethod::"Equally Distributed" then begin
                                Branches.Reset;
                                Branches.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                                Branches.SetFilter(Code, BranchFilters);
                                Branches.SetRange(Blocked, false);
                                NoOfEntities:=Branches.Count;
                                if Branches.FindFirst then begin
                                    repeat DistributeEqually(BlankText, Branches.Code, "Amortization Lines", NoOfEntities, TotalEmployees);
                                    until Branches.Next = 0;
                                end;
                            end
                            else
                                Error('Distribution Method No. of Computers is not enabled!');
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Distribution.Reset;
                Distribution.SetRange(No, "Amortization Header".No);
                Distribution.DeleteAll;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(DistributeByDept; DistributeByDept)
                {
                    ApplicationArea = All;
                    Caption = 'Distribute By Department?';
                }
                field(DeptFilters; DeptFilters)
                {
                    ApplicationArea = All;
                    Caption = 'Department Filters';

                    trigger OnLookup(var Text: Text): Boolean begin
                        GLSetup.Get;
                        Departments.Reset;
                        Departments.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                        if PAGE.RunModal(537, Departments) = ACTION::LookupOK then begin
                            if DeptFilters = '' then DeptFilters:=Departments.Code
                            else
                                DeptFilters:=DeptFilters + '|' + Departments.Code;
                        end;
                    end;
                }
                field(DistributeByBranch; DistributeByBranch)
                {
                    ApplicationArea = All;
                    Caption = 'Distribute By Branch?';
                }
                field(BranchFilters; BranchFilters)
                {
                    ApplicationArea = All;
                    Caption = 'Branch Filters';

                    trigger OnLookup(var Text: Text): Boolean begin
                        GLSetup.Get;
                        Departments.Reset;
                        Departments.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                        if PAGE.RunModal(537, Departments) = ACTION::LookupOK then begin
                            if BranchFilters = '' then BranchFilters:=Departments.Code
                            else
                                BranchFilters:=BranchFilters + '|' + Departments.Code;
                        end;
                    end;
                }
                field(DistributionMethod; DistributionMethod)
                {
                    ApplicationArea = All;
                    Caption = 'Distribution Method';
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
    trigger OnPostReport()
    begin
        Message('Complete');
    end;
    trigger OnPreReport()
    begin
        if not DistributeByBranch and not DistributeByDept then Error('You must choose to distribute by either Branch or Department');
        if "Amortization Header".GetFilter(No) = '' then Error('Prepayment Number or Accrued Expense Number is Mandatory before distribution.');
        GLSetup.Get;
        BlankText:='';
    end;
    var ExpenseCode: Code[20];
    Type: Option " ", "G/L Account", Item, , "Fixed Asset";
    AccountNo: Code[10];
    Desc: Text;
    AmountToShare: Decimal;
    DistributeByDept: Boolean;
    DistributeByBranch: Boolean;
    DistributionMethod: Option "Equally Distributed", "No. of Staff", "No of Computers";
    GLAcc: Record "G/L Account";
    FA: Record "Fixed Asset";
    Items: Record Item;
    Lines: Record "Amortization Distribution";
    GLSetup: Record "General Ledger Setup";
    Departments: Record "Dimension Value";
    Branches: Record "Dimension Value";
    NoOfEmployees: Integer;
    TotalEmployees: Integer;
    Employee: Record Employee;
    Distribution: Record "Amortization Distribution";
    LineNumber: Integer;
    BlankText: Code[10];
    NoOfEntities: Decimal;
    ExpenseCodes: Record "Expense Codes";
    DeptFilters: Text;
    BranchFilters: Text;
    Header: Record "Amortization Header";
    procedure DistributeOnNoOfEmployees(var Dept: Code[20]; var Branch: Code[20]; var Amortization: Record "Amortization Lines"; var AllEmployees: Integer)
    begin
        Employee.Reset;
        Employee.SetRange(Status, Employee.Status::Active);
        if Dept <> '' then Employee.SetRange("Global Dimension 1 Code", Dept);
        if Branch <> '' then Employee.SetRange("Global Dimension 2 Code", Branch);
        NoOfEmployees:=Employee.Count;
        if(AllEmployees <> 0) and (NoOfEmployees <> 0)then begin
            Lines.Init;
            Lines.No:=Amortization.No;
            Lines.Period:=Amortization.Period;
            Lines."Global Dimension 1 Code":=Dept;
            Lines."Global Dimension 2 Code":=Branch;
            if Header.Get(Amortization.No)then Lines."Global Dimension 3 Code":=Header."Shortcut Dimension 3 Code";
            Lines.Amount:=NoOfEmployees / TotalEmployees * Amortization.Amount;
            Lines."Distribution Share":=NoOfEmployees;
            if NoOfEmployees / AllEmployees * Amortization.Amount <> 0 then Lines.Insert;
        end;
    end;
    procedure DistributeEqually(var Dept: Code[20]; var Branch: Code[20]; var Amortization: Record "Amortization Lines"; var Divisor: Decimal; var AllEmployees: Integer)
    begin
        Employee.Reset;
        Employee.SetRange(Status, Employee.Status::Active);
        if Dept <> '' then Employee.SetRange("Global Dimension 1 Code", Dept);
        if Branch <> '' then Employee.SetRange("Global Dimension 2 Code", Branch);
        NoOfEmployees:=Employee.Count;
        //IF (AllEmployees <> 0) AND (NoOfEmployees <> 0) THEN BEGIN
        Lines.Init;
        Lines.No:=Amortization.No;
        Lines.Period:=Amortization.Period;
        Lines."Global Dimension 1 Code":=Dept;
        Lines."Global Dimension 2 Code":=Branch;
        if Header.Get(Amortization.No)then Lines."Global Dimension 3 Code":=Header."Shortcut Dimension 3 Code";
        Lines.Amount:=Amortization.Amount / Divisor;
        Lines."Distribution Share":=1;
        if Amortization.Amount / Divisor <> 0 then Lines.Insert;
    //END;
    end;
}
