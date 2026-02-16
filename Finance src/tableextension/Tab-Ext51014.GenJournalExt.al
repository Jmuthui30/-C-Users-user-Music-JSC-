tableextension 51014 "Gen_JournalExt" extends "Gen. Journal Line"
{
    fields
    {
        field(51000; "EFT Reference"; Code[50])
        {
            Caption = 'EFT Reference';
            DataClassification = CustomerContent;
        }
        field(51001; Apportioned; Boolean)
        {
            Caption = 'Apportioned';
            DataClassification = CustomerContent;
        }
        field(51002; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = CustomerContent;
        }
        field(51003; Payee; Text[250])
        {
            Caption = 'Payee';
            DataClassification = CustomerContent;
        }
        field(51004; "Payroll Loan Transaction Type"; Enum PayrollLoanTransactionTypes)
        {
            Caption = 'Loan Transaction Type';
            DataClassification = CustomerContent;
        }
        field(51005; "Payroll Loan No."; Code[50])
        {
            Caption = 'Loan No';
            DataClassification = CustomerContent;
        }
        field(51006; "Emp Payroll Period"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Emp Payroll Period';
        }
        field(51007; "Emp Payroll Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Emp Payroll Code';
        }
        field(51009; "Employee Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Code';
        }
        field(51010; "Period Reference"; Date)
        {
            DataClassification = CustomerContent;
            TableRelation = "Accounting Period"."Starting Date";
            Caption = 'Period Reference';

            trigger OnValidate()
            begin
            end;
        }
    }

    trigger OnAfterInsert()
    begin
        "User ID" := CopyStr(UserId(), 1, MaxStrLen("User ID"));
    end;
}
