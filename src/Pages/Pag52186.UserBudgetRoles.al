page 52186 "User Budget Roles"
{
    // version BUDGET
    DeleteAllowed = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "User Budget Roles";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Department Codes"; Rec."Department Codes")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean begin
                        GLSetup.Get;
                        DimValues.Reset;
                        DimValues.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                        DimValues.SetRange(Blocked, false);
                        if PAGE.RunModal(537, DimValues) = ACTION::LookupOK then begin
                            if DimValues."Dimension Value Type" <> DimValues."Dimension Value Type"::Standard then exit;
                            if Rec."Department Codes" = '' then Rec."Department Codes":=DimValues.Code
                            else
                                Rec."Department Codes":=Rec."Department Codes" + '|' + DimValues.Code;
                        end;
                    end;
                }
                field("Branch Codes"; Rec."Branch Codes")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean begin
                        GLSetup.Get;
                        DimValues.Reset;
                        DimValues.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                        DimValues.SetRange(Blocked, false);
                        if PAGE.RunModal(537, DimValues) = ACTION::LookupOK then begin
                            if DimValues."Dimension Value Type" <> DimValues."Dimension Value Type"::Standard then exit;
                            if Rec."Branch Codes" = '' then Rec."Branch Codes":=DimValues.Code
                            else
                                Rec."Branch Codes":=Rec."Branch Codes" + '|' + DimValues.Code;
                        end;
                    end;
                }
                field("SI Codes"; Rec."SI Codes")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean begin
                        GLSetup.Get;
                        DimValues.Reset;
                        DimValues.SetRange("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                        DimValues.SetRange(Blocked, false);
                        if PAGE.RunModal(537, DimValues) = ACTION::LookupOK then begin
                            if DimValues."Dimension Value Type" <> DimValues."Dimension Value Type"::Standard then exit;
                            if Rec."SI Codes" = '' then Rec."SI Codes":=DimValues.Code
                            else
                                Rec."SI Codes":=Rec."SI Codes" + '|' + DimValues.Code;
                        end;
                    end;
                }
                field("Budget Acounts Range"; Rec."Budget Acounts Range")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean begin
                        GLAcc.Reset;
                        GLAcc.SetRange("Account Type", GLAcc."Account Type"::Posting);
                        GLAcc.SetRange(Blocked, false);
                        if PAGE.RunModal(16, GLAcc) = ACTION::LookupOK then begin
                            if GLAcc."Account Type" <> GLAcc."Account Type"::Posting then exit;
                            if Rec."Budget Acounts Range" = '' then Rec."Budget Acounts Range":=GLAcc."No."
                            else
                                Rec."Budget Acounts Range":=Rec."Budget Acounts Range" + '..' + GLAcc."No.";
                        end;
                    end;
                }
            }
        }
    }
    actions
    {
    }
    var DimValues: Record "Dimension Value";
    GLSetup: Record "General Ledger Setup";
    GLAcc: Record "G/L Account";
}
