page 52432 "Client Loan Application Form"
{
    PageType = Card;
    SourceTable = "Client Loan Application";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Client Loan Product Type"; Rec."Client Loan Product Type")
                {
                    ApplicationArea = All;
                }
                field("Loan No"; Rec."Loan No")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if EmpRec.Get(Rec."Employee No")then Rec."Employee Name":=EmpRec."Last Name" + ' ' + EmpRec."First Name";
                        if Emp.Get(Rec."Employee No")then Rec."Payroll Group":=Emp."Employee Group";
                    /*  if LoanProduct.Get(Rec."Client Loan Product Type") then begin
                             if LoanProduct."Loan Category" = LoanProduct."Loan Category"::Advance then
                                 Rec."Debtors Code" := Emp."Advancess Customer Account";
                         end; */
                    end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Company Code"; Rec."Company Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = All;
                }
                field("Interest Calculation Method"; Rec."Interest Calculation Method")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Interest Rate"; Rec."Interest Rate")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field(Repayment; Rec.Repayment)
                {
                    ApplicationArea = All;
                    Editable = SEditable;
                }
                /*
                field("Stop Loan";"Stop Loan")
                {

                    trigger OnValidate()
                    begin
                          if "Stop Loan"=true then begin
                           AssMatrix.SetRange(AssMatrix."Employee No","Employee No");
                           AssMatrix.SetRange(Type,AssMatrix.Type::Deduction);
                           AssMatrix.SetRange("Reference No","Loan No");
                           AssMatrix.SetRange(AssMatrix.Closed,false);
                           AssMatrix.DeleteAll;
                           Message('Loan Stopped');
                          end;
                        
                        /*IF xRec."Stop Loan" THEN
                        BEGIN
                        GetPayPeriod;
                        IF  "Stop Loan"=FALSE THEN
                        BEGIN
                        AssMatrix.INIT;
                        AssMatrix."Employee No":="Employee No";
                        AssMatrix.Type:=AssMatrix.Type::Deduction;
                        AssMatrix."Reference No":="Loan No";
                        IF "Deduction Code"='' THEN
                        ERROR('Loan %1 must be associated with a deduction',"Client Loan Product Type")
                        ELSE
                        AssMatrix.Code:="Deduction Code";
                        AssMatrix."Payroll Period":=BeginDate;
                        
                        AssMatrix.Description:=Description;
                        AssMatrix."Payroll Group":=Emp."Posting Group";
                        AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                        AssMatrix.Amount:=Repayment;
                        AssMatrix."Next Period Entry":=TRUE;
                        AssMatrix.VALIDATE(AssMatrix.Amount);
                        AssMatrix.INSERT;
                        
                        
                        
                         MESSAGE('Loan Reactivated');
                         END ELSE BEGIN
                        
                        Emp.GET("Employee No");
                        AssMatrix.INIT;
                        AssMatrix."Employee No":="Employee No";
                        AssMatrix.Type:=AssMatrix.Type::Deduction;
                        AssMatrix.Code:="Deduction Code";
                        AssMatrix."Payroll Period":=BeginDate;
                        AssMatrix."Reference No":="Loan No";
                        AssMatrix.Description:=Description;
                        AssMatrix."Payroll Group":=Emp."Posting Group";
                        AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                        AssMatrix.Amount:=Repayment;
                        AssMatrix.VALIDATE(AssMatrix.Amount);
                        AssMatrix."Next Period Entry":=TRUE;
                        AssMatrix.INSERT;
                        
                        
                         MODIFY;
                         MESSAGE('Loan re-activated');
                        
                         END;
                        
                        
                        
                        END; 

                    end;
                }
                */
                field("Payroll Group"; Rec."Payroll Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Opening Loan"; Rec."Opening Loan")
                {
                    ApplicationArea = All;
                }
                field("Total Repayment"; Rec."Total Repayment")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Period Repayment"; Rec."Period Repayment")
                {
                    ApplicationArea = All;
                }
                field("Debtors Code"; Rec."Debtors Code")
                {
                    ApplicationArea = All;
                }
                field(Receipts; Rec.Receipts)
                {
                    ApplicationArea = All;
                }
                field("External Document No"; Rec."External Document No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Deduction Code"; Rec."Deduction Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Interest Deduction Code"; Rec."Interest Deduction Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Interest Amount"; Rec."Interest Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Flat Rate Principal"; Rec."Flat Rate Principal")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Flat Rate Interest"; Rec."Flat Rate Interest")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
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
                    Image = CreateMovement;
                    Promoted = true;
                    PromotedIsBig = true;

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
                            if Rec."Interest Calculation Method" = Rec."Interest Calculation Method"::" " then Rec.CreateFlatRateSchedule;
                        end;
                    end;
                }
                separator(Separator1000000028)
                {
                }
                action("Preview Schedule")
                {
                    ApplicationArea = All;
                    Caption = 'Preview Schedule';
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Rec."Opening Loan" = false then begin
                            PreviewShedule.SetRange(PreviewShedule."Employee No", Rec."Employee No");
                            PreviewShedule.SetRange(PreviewShedule."Loan Category", Rec."Client Loan Product Type");
                            PreviewShedule.SetRange(PreviewShedule."Loan No", Rec."Loan No");
                            REPORT.Run(51860, true, false, PreviewShedule);
                        end
                        else
                            Error('Loan is Part of opening balance no schedule');
                    end;
                }
                separator(Separator1000000036)
                {
                }
                action("Issue Loan")
                {
                    ApplicationArea = All;
                    Caption = 'Issue Loan';
                    Image = InsertAccount;
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        if Rec."Loan Status" = Rec."Loan Status"::Issued then Error('Loan Already Issued');
                        if Rec."Issued Date" = 0D then Error('You must specify the issue date before issuing the loan');
                        if Rec."Approved Amount" = 0 then Error('You must specify the Approved amount before issuing the loan');
                        if Rec."Opening Loan" = false then begin
                            Schedule.Reset;
                            Schedule.SetRange("Loan No", Rec."Loan No");
                            Schedule.SetRange(Schedule."Employee No", Rec."Employee No");
                            Schedule.CalcSums(Schedule."Monthly Interest", Schedule."Principal Repayment");
                            if not Schedule.Find('-')then Error('No schedule created yet');
                            Emp.Get(Rec."Employee No");
                            AssMatrix.Init;
                            AssMatrix."Employee No":=Rec."Employee No";
                            AssMatrix.Type:=AssMatrix.Type::Deduction;
                            AssMatrix."Reference No":=Rec."Loan No";
                            AssMatrix.Description:=Rec.Description;
                            //AssMatrix."Not for CRA Computation" := TRUE;
                            if Rec."Deduction Code" = '' then Error('Loan %1 must be associated with a deduction', Rec."Client Loan Product Type")
                            else
                                AssMatrix.Code:=Rec."Deduction Code";
                            AssMatrix.Validate(AssMatrix.Code);
                            AssMatrix."Payroll Period":=Rec."Issued Date";
                            //AssMatrix.Description:=Description;
                            AssMatrix.Company:=Rec."Company Code";
                            AssMatrix."Payroll Group":=Emp."Employee Group";
                            AssMatrix."Global Dimension 1 code":=Emp."Global Dimension 1 Code";
                            //AssMatrix.Amount := Schedule."Principal Repayment" - Schedule."Monthly Interest";
                            AssMatrix.Amount:=Schedule."Monthly Repayment";
                            AssMatrix."Next Period Entry":=true;
                            AssMatrix.Validate(AssMatrix.Amount);
                            AssMatrix.Insert;
                            /*
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
                            // DELETE ANY LINE ITEM THAT MAY BE PRESENT
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

                            //NO EXPENSES
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
                            END;

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

                            //AssMatrix.Description:=Description;
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
                            //AssMatrix."Not for CRA Computation" := TRUE;
                            AssMatrix.Code:="Deduction Code";
                            AssMatrix.VALIDATE(AssMatrix.Code);
                            AssMatrix."Payroll Period":="Issued Date";
                            AssMatrix."Reference No":="Loan No";
                            AssMatrix.Description:=Description;
                            AssMatrix."Payroll Group":=Emp."Posting Group";
                            AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                            AssMatrix.Amount:=Schedule."Principal Repayment";
                            AssMatrix.VALIDATE(AssMatrix.Amount);
                            AssMatrix."Next Period Entry":=TRUE;
                            AssMatrix.INSERT;
                            //**********INTEREST****************
                            Emp.GET("Employee No");
                            AssMatrix.INIT;
                            AssMatrix."Employee No":="Employee No";
                            AssMatrix.Type:=AssMatrix.Type::"1";
                            AssMatrix.Code:="Interest Deduction Code";
                            AssMatrix.VALIDATE(AssMatrix.Code);
                            AssMatrix."Payroll Period":="Issued Date";
                            AssMatrix."Reference No":="Loan No";
                            AssMatrix.Description:=Description;
                            AssMatrix."Payroll Group":=Emp."Posting Group";
                            AssMatrix."Department Code":=Emp."Global Dimension 1 Code";
                            AssMatrix.Amount:=Schedule."Monthly Interest";
                            AssMatrix.VALIDATE(AssMatrix.Amount);
                            AssMatrix."Next Period Entry":=TRUE;
                            AssMatrix.INSERT;

                            //**********************************
                            */
                            Rec."Loan Status":=Rec."Loan Status"::Issued;
                            Rec.Modify;
                            Message('Loan Issued');
                        end;
                    end;
                }
                action("Stop Loan")
                {
                    ApplicationArea = All;
                    Caption = 'Stop Loan';
                    Image = StopPayment;
                    Promoted = true;
                    PromotedIsBig = true;

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
                    Image = Receipt;
                    Promoted = true;
                    PromotedIsBig = true;
                //RunObject = Page Page51511268;
                //RunPageLink = Field1=FIELD("Loan No");
                }
                separator(Separator1000000063)
                {
                }
                action("Bulk Issue")
                {
                    ApplicationArea = All;
                    Caption = 'Bulk Issue';
                    Enabled = false;
                    Image = InsertAccount;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Client Loan Application Grid";
                    RunPageLink = Description=FIELD(Description), "Loan Status"=FILTER(<>Issued), "Client Loan Product Type"=FIELD("Client Loan Product Type");

                    trigger OnAction()
                    begin
                        if Rec."Loan Status" = Rec."Loan Status"::Issued then Error('Loan Already Issued');
                        if Rec."Issued Date" = 0D then Error('You must specify the issue date before issuing the loan');
                        if Rec."Approved Amount" = 0 then Error('You must specify the Approved amount before issuing the loan');
                        if Rec."Opening Loan" = false then begin
                            Schedule.Reset;
                            Schedule.SetRange("Loan No", Rec."Loan No");
                            Schedule.SetRange(Schedule."Employee No", Rec."Employee No");
                            Schedule.CalcSums(Schedule."Monthly Interest", Schedule."Principal Repayment");
                            if not Schedule.Find('-')then Error('No schedule created yet');
                            Emp.Get(Rec."Employee No");
                            AssMatrix.Init;
                            AssMatrix."Employee No":=Rec."Employee No";
                            AssMatrix.Type:=AssMatrix.Type::Deduction;
                            AssMatrix."Reference No":=Rec."Loan No";
                            if Rec."Deduction Code" = '' then Error('Loan %1 must be associated with a deduction', Rec."Client Loan Product Type")
                            else
                                AssMatrix.Code:=Rec."Deduction Code";
                            AssMatrix.Validate(AssMatrix.Code);
                            AssMatrix."Payroll Period":=Rec."Issued Date";
                            //AssMatrix.Description:=Description;
                            AssMatrix."Payroll Group":=Emp."Employee Group";
                            AssMatrix."Global Dimension 1 code":=Emp."Global Dimension 1 Code";
                            AssMatrix.Amount:=Schedule."Principal Repayment";
                            AssMatrix."Next Period Entry":=true;
                            AssMatrix.Validate(AssMatrix.Amount);
                            AssMatrix.Insert;
                            //********INTEREST******************
                            AssMatrix.Init;
                            AssMatrix."Employee No":=Rec."Employee No";
                            AssMatrix.Type:=AssMatrix.Type::Deduction;
                            AssMatrix."Reference No":=Rec."Loan No";
                            if Rec."Interest Deduction Code" = '' then Error('Loan %1 must be associated with a deduction', Rec."Client Loan Product Type")
                            else
                                AssMatrix.Code:=Rec."Interest Deduction Code";
                            AssMatrix.Validate(AssMatrix.Code);
                            AssMatrix."Payroll Period":=Rec."Issued Date";
                            //AssMatrix.Description:=Description;
                            AssMatrix."Payroll Group":=Emp."Employee Group";
                            AssMatrix."Global Dimension 1 code":=Emp."Global Dimension 1 Code";
                            AssMatrix.Amount:=Schedule."Monthly Interest";
                            AssMatrix."Next Period Entry":=true;
                            AssMatrix.Validate(AssMatrix.Amount);
                            AssMatrix.Insert;
                            //********END OF INTEREST***********
                            Rec."Loan Status":=Rec."Loan Status"::Issued;
                            Rec.Modify;
                            Message('Loan Issued');
                        end
                        else
                        begin
                            Emp.Get(Rec."Employee No");
                            AssMatrix.Init;
                            AssMatrix."Employee No":=Rec."Employee No";
                            AssMatrix.Type:=AssMatrix.Type::Deduction;
                            AssMatrix.Code:=Rec."Deduction Code";
                            AssMatrix.Validate(AssMatrix.Code);
                            AssMatrix."Payroll Period":=Rec."Issued Date";
                            AssMatrix."Reference No":=Rec."Loan No";
                            AssMatrix.Description:=Rec.Description;
                            AssMatrix."Payroll Group":=Emp."Employee Group";
                            AssMatrix."Global Dimension 1 code":=Emp."Global Dimension 1 Code";
                            AssMatrix.Amount:=Schedule."Principal Repayment";
                            AssMatrix.Validate(AssMatrix.Amount);
                            AssMatrix."Next Period Entry":=true;
                            AssMatrix.Insert;
                            //**********INTEREST****************
                            Emp.Get(Rec."Employee No");
                            AssMatrix.Init;
                            AssMatrix."Employee No":=Rec."Employee No";
                            AssMatrix.Type:=AssMatrix.Type::Deduction;
                            AssMatrix.Code:=Rec."Interest Deduction Code";
                            AssMatrix.Validate(AssMatrix.Code);
                            AssMatrix."Payroll Period":=Rec."Issued Date";
                            AssMatrix."Reference No":=Rec."Loan No";
                            AssMatrix.Description:=Rec.Description;
                            AssMatrix."Payroll Group":=Emp."Employee Group";
                            AssMatrix."Global Dimension 1 code":=Emp."Global Dimension 1 Code";
                            AssMatrix.Amount:=Schedule."Monthly Interest";
                            AssMatrix.Validate(AssMatrix.Amount);
                            AssMatrix."Next Period Entry":=true;
                            AssMatrix.Insert;
                            //**********************************
                            Rec."Loan Status":=Rec."Loan Status"::Issued;
                            Rec.Modify;
                            Message('Loan Issued');
                        end;
                    end;
                }
                action("Client Loan Statement")
                {
                    ApplicationArea = All;
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        Rec.SetRange("Loan No", Rec."Loan No");
                        REPORT.Run(51861, true, false, Rec);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Editable:=true;
        if Rec."Loan Category" = Rec."Loan Category"::Advance then Editable:=false;
    end;
    trigger OnClosePage()
    begin
    //if "Loan Status"<>"Loan Status"::Issued then
    // if Confirm('You are about to close the loan application No ' +"Loan No"+ ' without issuing the loan, Do you want to proceed?',false) then
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        if LoanProduct.Get(Rec."Client Loan Product Type")then begin
            Rec.Instalment:=LoanProduct."No of Instalment";
            Rec."Interest Rate":=LoanProduct."Interest Rate";
            Rec."Interest Calculation Method":=LoanProduct."Interest Calculation Method";
            Rec.Description:=LoanProduct.Description;
        end;
    end;
    trigger OnOpenPage()
    begin
        Editable:=true;
        if Rec."Loan Category" = Rec."Loan Category"::Advance then Editable:=false;
    end;
    var LoanProduct: Record "Client Loan Product";
    EmpRec: Record Employee;
    PreviewShedule: Record "Client Loan Schedule";
    RunningDate: Date;
    AssMatrix: Record "Client Payroll Matrix";
    Schedule: Record "Client Loan Schedule";
    Emp: Record "Client Employee Master";
    GetGroup: Codeunit "Payroll Management";
    GroupCode: Code[20];
    CUser: Code[50];
    PayPeriod: Record "Client Payroll Period";
    PayPeriodtext: Text[30];
    BeginDate: Date;
    Value1: Boolean;
    PVHeader: Record "PV Header";
    PVLines: Record "PV Lines";
    JnlBatch: Record "Gen. Journal Batch";
    GenJnlLine: Record "Gen. Journal Line";
    LineNo: Integer;
    SEditable: Boolean;
    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-')then begin
            PayPeriodtext:=PayPeriod.Name;
            BeginDate:=PayPeriod."Starting Date";
        end;
    end;
}
