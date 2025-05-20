table 50021 "Leave Reimbursement"
{
    Caption = 'Leave Reimbursement';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
        }
        field(3; "Name`"; Text[150])
        {
            Caption = 'Name`';
            DataClassification = CustomerContent;
        }
        field(4; "Dimension 1"; Code[20])
        {
            Caption = 'Dimension 1';
            DataClassification = CustomerContent;
        }
        field(5; "Dimension 2"; Code[20])
        {
            Caption = 'Dimension 2';
            DataClassification = CustomerContent;
        }
        field(6; "Leave Code"; Code[20])
        {
            Caption = 'Leave Code';
            DataClassification = CustomerContent;
        }
        field(7; "No of Days to Reimburse"; Decimal)
        {
            Caption = 'No of Days to Reimburse';
            DataClassification = CustomerContent;
        }
        field(8; "Reimbursement Option"; Option)
        {
            Caption = 'Reimbursement Option';
            OptionCaption = 'Add to Leave Balance,Convert to Cash';
            OptionMembers = "Add to Leave Balance", "Convert to Cash";
        }
        field(9; "Conversion Rate"; Decimal)
        {
            Caption = 'Conversion Rate';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Rec.Amount:=Rec."No of Days to Reimburse" * Rec."Conversion Rate";
            end;
        }
        field(10; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(11; Status;Enum "Sales Document Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(12; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(13; "Date"; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
        // if LoanType.Get("Loan Product Type") then begin
        //     LoanType.TestField(LoanType."Loan No Series");
        //     NoSeriesMgt.InitSeries(LoanType."Loan No Series", xRec."No Series", 0D, "Loan No", "No Series");
        // end;
        end;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
}
