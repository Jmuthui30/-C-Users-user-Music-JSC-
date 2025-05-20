page 52128 "Request for Payment Lines"
{
    // version THL- ADV.FIN 1.0
    PageType = ListPart;
    SourceTable = "Request for Payment Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Source Document"; Rec."Source Document")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Being Payment for"; Rec."Being Payment for")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("View Source Document")
            {
                ApplicationArea = All;
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec."Source Document No." = '' then Error('There is no Source Document No. This is mandatory.')
                    else
                        Rec.ViewSourceDocument;
                end;
            }
        }
    }
}
