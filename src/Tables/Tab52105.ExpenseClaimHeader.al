table 52105 "Expense Claim Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Employee No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if EmpRec.Get("Employee No.")then begin
                    EmpRec.TestField("Global Dimension 2 Code");
                    "Global Dimension 1 Code":=EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code":=EmpRec."Global Dimension 3 Code";
                    BankAccount.Reset();
                    BankAccount.SetRange("Account type", BankAccount."Account type"::Cash);
                    //BankAccount.SetRange("Global Dimension 2 Code", EmpRec."Global Dimension 2 Code");
                    if BankAccount.FindFirst()then begin
                        "Pay Mode":='CASH';
                        Validate("Paying Account Code", BankAccount."No.");
                        "Payment Tx No.(Cheque No.)":="No.";
                    end
                    else
                        Error(Text000);
                end;
                if NAVEmp.Get("Employee No.")then begin
                    "Job Title":=NAVEmp."Job Title";
                    "Employee Name":=NAVEmp."First Name" + ' ' + NAVEmp."Last Name";
                    "Payment To":=NAVEmp."First Name" + ' ' + NAVEmp."Last Name";
                    "On Behalf of":=NAVEmp.FullName();
                end;
            end;
        }
        field(3; "Employee Name"; Text[100])
        {
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(6; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(7; Date; Date)
        {
            Editable = false;
        }
        field(8; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(9; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(10; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(11; "Paying Account Code"; Code[20])
        {
            TableRelation = "Bank Account";
            Editable = false;

            trigger OnValidate()
            begin
                if BankAccount.Get("Paying Account Code")then "Account Name":=BankAccount.Name;
            end;
        }
        field(12; "Account Name"; Text[30])
        {
        }
        field(13; "Payment To"; Text[30])
        {
        }
        field(14; "On Behalf of"; Text[30])
        {
            Editable = false;
        }
        field(15; "Payment Narration"; Text[50])
        {
            trigger OnValidate()
            begin
                FinanceMgnt.TextRegExChecker("Payment Narration");
            end;
        }
        field(16; "Payment Date"; Date)
        {
        }
        field(17; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Expense Claim Details".Amount WHERE(No=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(18; Posted; Boolean)
        {
            Editable = false;
        }
        field(19; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(20; "Posted Date"; Date)
        {
            Editable = false;
        }
        field(21; "Job Title"; Text[50])
        {
        }
        field(22; "Pay Mode"; Code[10])
        {
            TableRelation = "Pay Mode";
            Editable = false;
        }
        field(23; "Payment Tx No.(Cheque No.)"; Code[10])
        {
            Editable = false;

            trigger OnValidate()
            begin
                FinanceMgnt.CodeRegExChecker("Payment Tx No.(Cheque No.)");
            end;
        }
        field(24; "Cheque Date"; Date)
        {
        }
        field(25; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(26; "Created for Staff"; Boolean)
        {
        }
        field(27; "SharePoint Link"; Text[250])
        {
        }
        field(28; Approvers; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(52105), "Document No."=FIELD("No."), Status=FILTER(Approved)));
            FieldClass = FlowField;
            Caption = 'Approvers';
            Editable = false;
        }
        field(29; "Pending Approvals Ext"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(52105), "Document No."=FIELD("No."), Status=FILTER(Open|Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        TestField(Status, Status::Open);
    end;
    trigger OnInsert()
    begin
        if "No." = '' then begin
            AdvancedFinanceSetup.Get;
            AdvancedFinanceSetup.TestField("Petty Cash Nos");
            NoSeriesMgt.InitSeries(AdvancedFinanceSetup."Petty Cash Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Date:=Today;
        "Created By":=UserId;
        if not "Created for Staff" then begin
            if UserSetup.Get(UserId)then begin
                "Employee No.":=UserSetup."Employee No.";
                Validate("Employee No.");
            end;
        end;
    end;
    var EmpRec: Record "Employee Master";
    NAVEmp: Record Employee;
    AdvancedFinanceSetup: Record "Advanced Finance Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    BankAccount: Record "Bank Account";
    FinanceMgnt: Codeunit "Finance Management";
    Text000: Label 'Please Contact Admin for Petty Cash Account to be Set';
}
