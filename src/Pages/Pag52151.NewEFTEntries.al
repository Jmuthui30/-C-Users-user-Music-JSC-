page 52151 "New EFT Entries"
{
    // version THL- ADV.FIN 1.0
    Caption = 'EFT Payment';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = "EFT Entries";
    SourceTableView = WHERE("File Generated"=CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Receiving Account"; Rec."Receiving Account")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field(Reference; Rec.Reference)
                {
                    ApplicationArea = All;
                }
                field("Bank Swift"; Rec."Bank Swift")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control18; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Generate EFT File")
            {
                ApplicationArea = All;
                Image = Suggest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CashMgt.GenerateEFTFile;
                end;
            }
        }
    }
    var CashMgt: Codeunit "Cash Management";
}
