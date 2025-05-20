page 51783 "Medical Claim for Staff"
{
    // version THL- HRM 1.0
    Caption = 'Record Staff Medical Expense';
    PageType = Card;
    SourceTable = "Medical Claim";
    SourceTableView = WHERE(Status=CONST(Open), "Self Created"=CONST(false));

    layout
    {
        area(content)
        {
            group("Employee Details")
            {
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
                field("Settled By"; Rec."Settled By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pay Claim To"; Rec."Pay Claim To")
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
            part(Control11; "Claim Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51629);
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
        area(processing)
        {
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMgt.OnSendClaimForApproval(Rec);
                end;
            }
        }
    }
    var ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
}
