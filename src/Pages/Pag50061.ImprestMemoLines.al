page 50061 "Imprest Memo Lines"
{
    ApplicationArea = All;
    Caption = 'Imprest Memo Lines';
    PageType = ListPart;
    SourceTable = "Imprest Memo Lines";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                }
                field("Account No."; Rec."Account No.")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field(Title; Rec.Title)
                {
                }
                field(Email; Rec.Email)
                {
                }
                field("Pay DSA"; Rec."Pay DSA")
                {
                }
                field(Cordinator; Rec.Cordinator)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Facilitator; Rec.Facilitator)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Secretary; Rec.Secretary)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Rapporteur; Rec.Rapporteur)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Driver; Rec.Driver)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Expert; Rec.Expert)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Job Group"; Rec."Job Group")
                {
                }
                field(Location; Rec.Location)
                {
                }
                field(International; Rec.International)
                {
                }
                field(DSA; Rec.DSA)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Air Ticket"; Rec."Air Ticket")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Conference; Rec.Conference)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Ground Transport"; Rec."Ground Transport")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Cordination Allowance"; Rec."Cordination Allowance")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Facilitator Allowance"; Rec."Facilitator Allowance")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Secretariat Allowance"; Rec."Secretariat Allowance")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Out of Pocket Allowance"; Rec."Out of Pocket Allowance")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Rapporteur Allowance"; Rec."Rapporteur Allowance")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Driver Allowance"; Rec."Driver Allowance")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Retreat Allowance"; Rec."Retreat Allowance")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Expert Allowance"; Rec."Expert Allowance")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Accomodation; Rec.Accomodation)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Tuition Fee"; Rec."Tuition Fee")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Mileage Allowance"; Rec."Mileage Allowance")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Quarter Per Diem"; Rec."Quarter Per Diem")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Other Costs"; Rec."Other Costs")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Currency; Rec.Currency)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Amount; Rec.Amount)
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Exchange Rate"; Rec."Exchange Rate")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Amount LCY"; Rec."Amount LCY")
                {
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
            }
        }
    }
}
