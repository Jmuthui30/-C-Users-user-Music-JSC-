page 50029 "Beneficiary Bank Details"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Payee Bank Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("BEN ID"; Rec."BEN ID")
                {
                    ApplicationArea = All;
                }
                field("BENEFICIARY NAME"; Rec."BENEFICIARY NAME")
                {
                    ApplicationArea = All;
                }
                field("FULL BEN NAME"; Rec."FULL BEN NAME")
                {
                    ApplicationArea = All;
                }
                field("BEN ACCT NO"; Rec."BEN ACCT NO")
                {
                    ApplicationArea = All;
                }
                field("BANK CODE"; Rec."BANK CODE")
                {
                    ApplicationArea = All;
                }
                field(BANKNAME; Rec.BANKNAME)
                {
                    ApplicationArea = All;
                }
                field("BRANCH CODE"; Rec."BRANCH CODE")
                {
                    ApplicationArea = All;
                }
                field("BRANCH NAME"; Rec."BRANCH NAME")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
