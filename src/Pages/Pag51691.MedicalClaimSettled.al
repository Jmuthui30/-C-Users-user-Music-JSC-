page 51691 "Medical Claim - Settled"
{
    // version THL- HRM 1.0
    Caption = 'Settled Employee Medical Claim';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Medical Claim";
    SourceTableView = WHERE(Status=CONST(Released), Settled=CONST(true));

    layout
    {
        area(content)
        {
            group("Employee Details")
            {
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
            }
            group("Cover Details")
            {
                field("Service Provider"; Rec."Service Provider")
                {
                    ApplicationArea = All;
                }
                field("Service Provider Name"; Rec."Service Provider Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Policy; Rec.Policy)
                {
                    ApplicationArea = All;
                }
                field("Policy Name"; Rec."Policy Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Cover Amount"; Rec."Cover Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Expenditure To Date"; Rec."Expenditure To Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Claim Details")
            {
                field("Claim Date"; Rec."Claim Date")
                {
                    ApplicationArea = All;
                }
                field("Pay Claim To"; Rec."Pay Claim To")
                {
                    ApplicationArea = All;
                }
                field("Visit Date"; Rec."Visit Date")
                {
                    ApplicationArea = All;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    ApplicationArea = All;
                }
                field("Hospital/Specialist"; Rec."Hospital/Specialist")
                {
                    ApplicationArea = All;
                }
                field("Claim Amount"; Rec."Claim Amount")
                {
                    ApplicationArea = All;
                }
                field("Invoice No."; Rec."Invoice No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group("Payment Details")
            {
                Editable = false;

                field("Settled Date"; Rec."Settled Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Tx. No. (Cheque No.)"; Rec."Payment Tx. No. (Cheque No.)")
                {
                    ApplicationArea = All;
                }
                field("Claim Paying Account"; Rec."Claim Paying Account")
                {
                    ApplicationArea = All;
                }
                field("Claim Pay Mode"; Rec."Claim Pay Mode")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control28; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec."Self Created":=true;
    end;
}
