page 50008 "Receipt Lines"
{
    // version THL-Basic Fin 1.0
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Receipt Lines";
    SourceTableView = SORTING("Receipt No.", "Line No");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if Rec."Account Type" = Rec."Account Type"::Customer then Editable:=true
                        else
                        begin
                            Editable:=false;
                            Rec."Advance Loan No.":='';
                        end end;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
        Editable:=false;
        if Rec."Account Type" = Rec."Account Type"::Customer then Editable:=true;
    end;
    trigger OnOpenPage()
    begin
        Editable:=false;
        if Rec."Account Type" = Rec."Account Type"::Customer then Editable:=true;
    end;
    var SEditable: Boolean;
}
