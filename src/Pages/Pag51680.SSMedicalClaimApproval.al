page 51680 "SS Medical Claim - Approval"
{
    // version THL- HRM 1.0
    Caption = 'Medical Claim Pending Approval';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Medical Claim";
    SourceTableView = WHERE(Status=CONST("Pending Approval"));

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
                Editable = false;

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
                Editable = false;

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
            part(Control12; "Claim Document Subpage")
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
            action("Cancel Approval Request")
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ApprovalsMgt.OnCancelClaimApprovalRequest(Rec);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec."Self Created":=true;
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange("Created By", UserId);
    end;
    var ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
}
