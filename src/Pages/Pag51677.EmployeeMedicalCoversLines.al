page 51677 "Employee Medical Covers Lines"
{
    // version THL- HRM 1.0
    Caption = 'Active Employee Medical Covers';
    PageType = ListPart;
    SourceTable = "Employee Medical Cover";
    SourceTableView = WHERE("Cover Status"=CONST(Active));

    layout
    {
        area(content)
        {
            repeater("Employee Medical Cover")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Policy Start Date"; Rec."Policy Start Date")
                {
                    ApplicationArea = All;
                }
                field("Policy End Date"; Rec."Policy End Date")
                {
                    ApplicationArea = All;
                }
                field("Cover Status"; Rec."Cover Status")
                {
                    ApplicationArea = All;
                }
                field("Cover Amount"; Rec."Cover Amount")
                {
                    ApplicationArea = All;
                }
                field(Expenditure; Rec.Expenditure)
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
