page 52100 "Advanced Finance Setup"
{
    // version THL- ADV.FIN 1.0
    DeleteAllowed = false;
    InsertAllowed = true;
    Editable = true;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Advanced Finance Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Emp Travels Cust Posting Group"; Rec."Emp Travels Cust Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Emp Travel Receivables Account"; Rec."Emp Travel Receivables Account")
                {
                    ApplicationArea = All;
                }
                field("Emp Advance Cust Posting Group"; Rec."Emp Advance Cust Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Emp Advance Receivable Account"; Rec."Emp Advance Receivable Account")
                {
                    ApplicationArea = All;
                }
                field("Employee Bus Posting Group"; Rec."Employee Bus Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Employee Payment Terms"; Rec."Employee Payment Terms")
                {
                    ApplicationArea = All;
                }
                field("Imprest Template"; Rec."Imprest Template")
                {
                    ApplicationArea = All;
                }
                field("Imprest Payroll Deduction Code"; Rec."Imprest Payroll Deduction Code")
                {
                    ApplicationArea = All;
                }
                field("Imprest Payroll Earning Code"; Rec."Imprest Payroll Earning Code")
                {
                    ApplicationArea = All;
                }
                field("Petty Cash Template"; Rec."Petty Cash Template")
                {
                    ApplicationArea = All;
                }
                field("Watermark Portrait"; Rec."Watermark Portrait")
                {
                    ApplicationArea = All;
                }
                field("Email Pattern"; Rec."Email Pattern")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                        PatRec: Record "RegEx Pattern";
                    begin
                        if page.RunModal(Page::Patterns, PatRec) = action::LookupOK then Rec."Email Pattern" := PatRec.RegEx;
                    end;
                }
                field("Narration Pattern"; Rec."Narration Pattern")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                        PatRec: Record "RegEx Pattern";
                    begin
                        if page.RunModal(Page::Patterns, PatRec) = action::LookupOK then Rec."Narration Pattern" := PatRec.RegEx;
                    end;
                }
            }
            group(Numbering)
            {
                field("Emp Travel Cust No. Series"; Rec."Emp Travel Cust No. Series")
                {
                    ApplicationArea = All;
                }
                field("Emp Advances Cust No. Series"; Rec."Emp Advances Cust No. Series")
                {
                    ApplicationArea = All;
                }
                field("Request for Payment Nos."; Rec."Request for Payment Nos.")
                {
                    ApplicationArea = All;
                }
                field("Imprest Nos"; Rec."Imprest Nos")
                {
                    ApplicationArea = All;
                }
                field("Staff Claim Nos"; Rec."Staff Claim Nos")
                {
                    ApplicationArea = All;
                }
                field("Contract Commitment Nos."; Rec."Contract Commitment Nos.")
                {
                    ApplicationArea = All;
                }
                field("Petty Cash Nos"; Rec."Petty Cash Nos")
                {
                    ApplicationArea = All;
                }
                field("Commitment Nos."; Rec."Commitment Nos.")
                {
                    ApplicationArea = All;
                }
                field("Suppl. Budget Request Nos"; Rec."Suppl. Budget Request Nos")
                {
                    ApplicationArea = All;
                }
                field("Staff Based Budget"; Rec."Staff Based Budget")
                {
                    ApplicationArea = All;
                }
                field("Imprest Memo Nos"; Rec."Imprest Memo Nos")
                {
                }
                field("Imprest Payroll Claim Nos"; Rec."Imprest Payroll Claim Nos")
                {
                }
            }
            group("Imprest Expense Codes")
            {
                field("DSA Expense Code"; Rec."DSA Expense Code")
                {
                }
                field("Air Ticket Expense Code"; Rec."Air Ticket Expense Code")
                {
                }
                field("Conference Expense Code"; Rec."Conference Expense Code")
                {
                }
                field("G.Transport Expense Code"; Rec."G.Transport Expense Code")
                {
                }
                field("Cord. Allow Expense Code"; Rec."Cord. Allow Expense Code")
                {
                }
                field("Facilitator Allow Expense Code"; Rec."Facilitator Allow Expense Code")
                {
                }
                field("Secretariat Allow Expense Code"; Rec."Secretariat Allow Expense Code")
                {
                }
                field("Out of Pocket Expense Code"; Rec."Out of Pocket Expense Code")
                {
                }
                field("Rapporteur Allow Expense Code"; Rec."Rapporteur Allow Expense Code")
                {
                }
                field("Driver Allow Expense Code"; Rec."Driver Allow Expense Code")
                {
                }
                field("Retreat Allow Expense Code"; Rec."Retreat Allow Expense Code")
                {
                }
                field("Expert Allow Expense Code"; Rec."Expert Allow Expense Code")
                {
                }
                field("Accomodation Expense Code"; Rec."Accomodation Expense Code")
                {
                }
                field("Tuition Expense Code"; Rec."Tuition Expense Code")
                {
                }
                field("Mileage Expense Code"; Rec."Mileage Expense Code")
                {
                }
                field("Qtr. Per Diem Expense Code"; Rec."Qtr. Per Diem Expense Code")
                {
                }
            }
            group("Imprest Allowances")
            {
                field("Cordination Allowance"; Rec."Cordination Allowance")
                {
                }
                field("Max. No. of Cordinators"; Rec."Max. No. of Cordinators")
                {
                }
                field("Secretariat Allowance"; Rec."Secretariat Allowance")
                {
                }
                field("Max. No. of Secretaries"; Rec."Max. No. of Secretaries")
                {
                }
                field("Out of Pocket Allowance"; Rec."Out of Pocket Allowance")
                {
                }
                field("Rapporteur Allowance"; Rec."Rapporteur Allowance")
                {
                }
                field("Max. No. of Rapporteurs"; Rec."Max. No. of Rapporteurs")
                {
                }
                field("Driver Allowance"; Rec."Driver Allowance")
                {
                }
                field("Max. No. of Drivers"; Rec."Max. No. of Drivers")
                {
                }
                field("Retreat Allowance"; Rec."Retreat Allowance")
                {
                }
                field("Max. No. of Retreaters"; Rec."Max. No. of Retreaters")
                {
                }
                field("Max. No. of Retreat Days"; Rec."Max. No. of Retreat Days")
                {
                }
                field("Expert Allowance"; Rec."Expert Allowance")
                {
                }
                field("Facilitator Allowance"; Rec."Facilitator Allowance")
                {
                }
                field("Max. No. of Facilitators"; Rec."Max. No. of Facilitators")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control22; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control23; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Control24; Links)
            {
                ApplicationArea = All;
            }
        }
    }
}
