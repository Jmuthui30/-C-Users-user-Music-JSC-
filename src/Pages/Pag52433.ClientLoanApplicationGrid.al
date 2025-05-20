page 52433 "Client Loan Application Grid"
{
    PageType = List;
    SourceTable = "Client Loan Application";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if EmpRec.Get(Rec."Employee No")then begin
                            Rec."Employee Name":=EmpRec."Last Name" + ' ' + EmpRec."First Name";
                            Rec."Payroll Group":=EmpRec."Employee Posting Group";
                        end;
                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Client Loan Product Type"; Rec."Client Loan Product Type")
                {
                    ApplicationArea = All;
                }
                field(Instalment; Rec.Instalment)
                {
                    ApplicationArea = All;
                }
                field("Amount Requested"; Rec."Amount Requested")
                {
                    ApplicationArea = All;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = All;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = All;
                }
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = All;
                }
                field("Flat Rate Principal"; Rec."Flat Rate Principal")
                {
                    ApplicationArea = All;
                }
                field("Flat Rate Interest"; Rec."Flat Rate Interest")
                {
                    ApplicationArea = All;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                }
                field("No Series"; Rec."No Series")
                {
                    ApplicationArea = All;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = All;
                }
                field("Payroll Group"; Rec."Payroll Group")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Opening Loan"; Rec."Opening Loan")
                {
                    ApplicationArea = All;
                }
                field("Total Repayment"; Rec."Total Repayment")
                {
                    ApplicationArea = All;
                }
                // field("Date filter";"Date filter")
                //{
                //}
                field("Period Repayment"; Rec."Period Repayment")
                {
                    ApplicationArea = All;
                }
                field(Interest; Rec.Interest)
                {
                    ApplicationArea = All;
                }
                field("Interest Imported"; Rec."Interest Imported")
                {
                    ApplicationArea = All;
                }
                field("principal imported"; Rec."principal imported")
                {
                    ApplicationArea = All;
                }
                field("Interest Rate Per"; Rec."Interest Rate Per")
                {
                    ApplicationArea = All;
                }
                field("Reference No"; Rec."Reference No")
                {
                    ApplicationArea = All;
                }
                field("Interest Deduction Code"; Rec."Interest Deduction Code")
                {
                    ApplicationArea = All;
                }
                field("Deduction Code"; Rec."Deduction Code")
                {
                    ApplicationArea = All;
                }
                field("Debtors Code"; Rec."Debtors Code")
                {
                    ApplicationArea = All;
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    ApplicationArea = All;
                }
                field("External Document No"; Rec."External Document No")
                {
                    ApplicationArea = All;
                }
                field(Receipts; Rec.Receipts)
                {
                    ApplicationArea = All;
                }
                field("HELB No."; Rec."HELB No.")
                {
                    ApplicationArea = All;
                }
                field("University Name"; Rec."University Name")
                {
                    ApplicationArea = All;
                }
            /* field("Stop Loan";"Stop Loan")
                 {
                 }*/
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Issue)
            {
                Caption = 'Issue';

                action("Create Schedule")
                {
                    ApplicationArea = All;
                    Caption = 'Create Schedule';

                    trigger OnAction()
                    begin
                        if Rec."Opening Loan" = false then begin
                            //if loan has already been issued don't create new schedule
                            PreviewShedule.SetRange(PreviewShedule."Employee No", Rec."Employee No");
                            PreviewShedule.SetRange("Loan Category", Rec."Client Loan Product Type");
                            PreviewShedule.DeleteAll;
                            if Rec."Issued Date" = 0D then Error('You must Issue date');
                            if Rec."Loan Status" = Rec."Loan Status"::Issued then RunningDate:=Rec."Issued Date";
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Reducing Balance" then Rec.CreateAnnuityLoan;
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::"Flat Rate" then Rec.CreateFlatRateSchedule;
                        end;
                    end;
                }
                separator(Separator1000000080)
                {
                }
                action("Preview Schedule")
                {
                    ApplicationArea = All;
                    Caption = 'Preview Schedule';

                    trigger OnAction()
                    begin
                        if Rec."Opening Loan" = false then begin
                            PreviewShedule.SetRange(PreviewShedule."Employee No", Rec."Employee No");
                            PreviewShedule.SetRange(PreviewShedule."Loan Category", Rec."Client Loan Product Type");
                            PreviewShedule.SetRange(PreviewShedule."Loan No", Rec."Loan No");
                            REPORT.Run(51511138, true, false, PreviewShedule);
                        end
                        else
                            Error('Loan is Part of opening balance no schedule');
                    end;
                }
                separator(Separator1000000082)
                {
                }
                action("Issue Loan")
                {
                    ApplicationArea = All;
                    Caption = 'Issue Loan';

                    trigger OnAction()
                    begin
                    /*// DELETE ANY LINE ITEM THAT MAY BE PRESENT
                        IF NOT JnlBatch.GET('GENERAL','STAFFLOAN') THEN
                        BEGIN
                        JnlBatch.INIT;
                        JnlBatch."Journal Template Name":='GENERAL';
                        JnlBatch.Name:='STAFFLOAN';
                        JnlBatch.INSERT;
                        END
                        ELSE
                        JnlBatch.GET('GENERAL','STAFFLOAN');
                        
                        GenJnlLine.RESET;
                        GenJnlLine.SETRANGE(GenJnlLine."Journal Template Name",'GENERAL');
                        GenJnlLine.SETRANGE(GenJnlLine."Journal Batch Name",'STAFFLOAN');
                        GenJnlLine.DELETEALL;
                        
                        IF FIND('-') THEN
                        REPEAT
                        IF Select=TRUE THEN BEGIN
                        
                        IF "Loan Status"="Loan Status"::"4" THEN
                         ERROR('Loan Already Issued');
                        
                        IF "Issued Date"=0D THEN
                        ERROR('You must specify the issue date before issuing the loan');
                        
                        IF "Approved Amount"=0 THEN
                        ERROR('You must specify the Approved amount before issuing the loan');
                        
                        
                        
                        IF "Opening Loan"=FALSE THEN BEGIN
                        Schedule.RESET;
                        Schedule.SETRANGE("Loan No","Loan No");
                        Schedule.SETRANGE(Schedule."Employee No","Employee No");
                        IF NOT Schedule.FIND('-') THEN
                          ERROR('No schedule created yet');
                        Emp.GET("Employee No");
                        AssMatrix.INIT;
                        AssMatrix."Employee No":="Employee No";
                        AssMatrix.Type:=AssMatrix.Type::"1";
                        AssMatrix."Reference No":="Loan No";
                        IF "Deduction Code"='' THEN
                        ERROR('Loan %1 must be associated with a deduction',"Client Loan Product Type")
                        ELSE
                        AssMatrix.Code:="Deduction Code";
                        AssMatrix."Payroll Period":="Issued Date";
                        
                        AssMatrix.Description:=Description;
                        AssMatrix."Payroll Group":=Emp."Employee Posting Group";
                        AssMatrix."Global Dimension 1 code" :=Emp."Global Dimension 1 Code";
                        AssMatrix.Amount:=Repayment-Schedule."Monthly Interest";
                        AssMatrix."Next Period Entry":=TRUE;
                        AssMatrix.VALIDATE(AssMatrix.Amount);
                        AssMatrix.INSERT;
                        //
                        IF LoanProduct.GET("Client Loan Product Type") THEN BEGIN
                        IF LoanProduct."Issuing Account Type" = LoanProduct."Issuing Account Type"::"3" THEN BEGIN
                        //Create PV
                        PVHeader.INIT;
                        PVHeader.Date := "Application Date";
                        PVHeader."Pay Mode" := 'EFT';
                        PVHeader.Payee := "Employee Name";
                        PVHeader."Global Dimension 1 Code" := Emp."Global Dimension 1 Code";
                        PVHeader."PO/INV No" := "Loan No";
                        PVHeader."Global Dimension 2 Code" := Emp."Global Dimension 2 Code";
                        PVHeader.INSERT(TRUE);
                        
                        PVLines.INIT;
                        PVLines."PV No" := PVHeader.No;
                        PVLines."Line No" := 10000;
                        PVLines."Account Type" := PVLines."Account Type"::"1";
                        PVLines."Account No." := "Employee No";
                        PVLines.VALIDATE("Account No.");
                        PVLines.Description := Description;
                        PVLines.Amount := "Approved Amount";
                        PVLines.VALIDATE(Amount);
                        PVLines."Shortcut Dimension 1 Code" := Emp."Global Dimension 1 Code";
                        PVLines."Shortcut Dimension 2 Code" := Emp."Global Dimension 2 Code";
                        PVLines.INSERT;
                        END ELSE IF LoanProduct."Issuing Account Type" = LoanProduct."Issuing Account Type"::"0" THEN BEGIN
                        //Create Journal
                        IF "Approved Amount" <> 0 THEN BEGIN
                        LineNo:=LineNo+1000;
                        GenJnlLine.INIT;
                        GenJnlLine."Journal Template Name":='GENERAL';
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Template Name");
                        GenJnlLine."Journal Batch Name":='STAFFLOAN';
                        GenJnlLine.VALIDATE(GenJnlLine."Journal Batch Name");
                        GenJnlLine."Line No.":=LineNo;
                        GenJnlLine."Account Type":=GenJnlLine."Account Type"::Customer;
                        GenJnlLine."Account No.":="Employee No";
                        GenJnlLine.VALIDATE(GenJnlLine."Account No.");
                        GenJnlLine."Posting Date":="Application Date";
                        GenJnlLine."Document No.":="Loan No";
                        GenJnlLine.Amount:="Approved Amount";
                        GenJnlLine.VALIDATE(GenJnlLine.Amount);
                        GenJnlLine.Description:=Description;
                        GenJnlLine."Bal. Account Type":=LoanProduct."Issuing Account Type";
                        GenJnlLine."Bal. Account No.":=LoanProduct."Issuing Account No.";
                        GenJnlLine."Shortcut Dimension 1 Code":=Emp."Global Dimension 1 Code";
                        GenJnlLine."Shortcut Dimension 2 Code":=Emp."Global Dimension 2 Code";
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 1 Code");
                        GenJnlLine.VALIDATE(GenJnlLine."Shortcut Dimension 2 Code");
                        IF GenJnlLine.Amount<>0 THEN
                        GenJnlLine.INSERT;
                        END;
                        END;
                        //END;
                        
                        //
                        //********INTEREST******************
                        IF "Interest Deduction Code"<>''THEN BEGIN
                        AssMatrix.INIT;
                        AssMatrix."Employee No":="Employee No";
                        AssMatrix.Type:=AssMatrix.Type::"1";
                        AssMatrix."Reference No":="Loan No";
                        IF "Interest Deduction Code"='' THEN
                        ERROR('Loan %1 must be associated with a deduction',"Client Loan Product Type")
                        ELSE
                        AssMatrix.Code:="Interest Deduction Code";
                        AssMatrix.VALIDATE(AssMatrix.Code);
                        AssMatrix."Payroll Period":="Issued Date";
                        AssMatrix."Payroll Group":=Emp."Posting Group";
                        AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                        AssMatrix.Amount:=Schedule."Monthly Interest";
                        AssMatrix."Next Period Entry":=TRUE;
                        AssMatrix.VALIDATE(AssMatrix.Amount);
                        AssMatrix.INSERT;
                        END;
                        //********END OF INTEREST***********
                        
                        "Loan Status":="Loan Status"::"4";
                         MODIFY;
                         MESSAGE('Loan Issued');
                         END ELSE BEGIN
                        
                        Emp.GET("Employee No");
                        AssMatrix.INIT;
                        AssMatrix."Employee No":="Employee No";
                        AssMatrix.Type:=AssMatrix.Type::"1";
                        AssMatrix.Code:="Deduction Code";
                        AssMatrix."Payroll Period":="Issued Date";
                        AssMatrix."Reference No":="Loan No";
                        AssMatrix.Description:=Description;
                        AssMatrix."Payroll Group":=Emp."Posting Group";
                        AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                        AssMatrix.Amount:=Repayment;
                        AssMatrix.VALIDATE(AssMatrix.Amount);
                        AssMatrix."Next Period Entry":=TRUE;
                        AssMatrix.INSERT;
                        
                        "Loan Status":="Loan Status"::"4";
                         MODIFY;
                         MESSAGE('Loan Issued');
                        
                         END;
                        END;
                          UNTIL NEXT=0;
                        */
                    end;
                }
                action("Stop Loan")
                {
                    ApplicationArea = All;
                    Caption = 'Stop Loan';

                    trigger OnAction()
                    begin
                        if Rec."Stop Loan" then Error('The Loan has already been stopped');
                        if Confirm('Do you really want to stop the loan', false)then begin
                            Rec."Stop Loan":=true;
                            Rec.Modify;
                        end;
                    end;
                }
                action("Non Payroll Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Non Payroll Receipts';
                // RunObject = Page Page51511268;
                //RunPageLink = Field1=FIELD("Loan No");
                }
            }
        }
    }
    var LoanProduct: Record "Loan Product";
    EmpRec: Record Employee;
    PreviewShedule: Record "Loan Schedule";
    RunningDate: Date;
    AssMatrix: Record "Payroll Matrix";
    Schedule: Record "Loan Schedule";
    Emp: Record "Employee Master";
    GetGroup: Codeunit "Payroll Management";
    GroupCode: Code[20];
    CUser: Code[50];
    PayPeriod: Record "Payroll Period";
    PayPeriodtext: Text[30];
    BeginDate: Date;
    Value1: Boolean;
    PVHeader: Record "PV Header";
    PVLines: Record "PV Lines";
    JnlBatch: Record "Gen. Journal Batch";
    GenJnlLine: Record "Gen. Journal Line";
    LineNo: Integer;
    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-')then begin
            PayPeriodtext:=PayPeriod.Name;
            BeginDate:=PayPeriod."Starting Date";
        end;
    end;
}
