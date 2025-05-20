page 51784 "Medical Claims for Staff"
{
    // version THL- HRM 1.0
    Caption = 'Record Staff Medical Expense';
    CardPageID = "Medical Claim for Staff";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Medical Claim";
    SourceTableView = WHERE(Status=CONST(Open), "Self Created"=CONST(false));

    layout
    {
        area(content)
        {
            repeater("Employee Details")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Policy; Rec.Policy)
                {
                    ApplicationArea = All;
                }
                field("Policy Name"; Rec."Policy Name")
                {
                    ApplicationArea = All;
                }
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
        Rec.Status:=Rec.Status::Released;
    end;
}
