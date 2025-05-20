page 51665 "Medical Schemes"
{
    // version THL- HRM 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Medical Schemes";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Settled By"; Rec."Settled By")
                {
                    ApplicationArea = All;
                }
                field(Provider; Rec.Provider)
                {
                    ApplicationArea = All;
                }
                field("Provider Name"; Rec."Provider Name")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Change Expense Code")
            {
                ApplicationArea = All;
                Image = Change;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Scheme Expense Code";
                RunPageLink = Code=FIELD(Code);
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Settled By" = Rec."Settled By"::"Our Organization" then if Rec."Expense Code" = '' then begin
                Rec.Reset;
                Rec.SetRange(Rec.Code, Rec.Code);
                if PAGE.RunModal(PAGE::"Scheme Expense Code", Rec) = ACTION::LookupOK then begin
                    Rec."Settled By":=Rec."Settled By"::"Our Organization";
                    Rec.TestField("Expense Code");
                    Rec.Validate(Rec."Expense Code", Rec."Expense Code");
                end;
            end;
    end;
}
