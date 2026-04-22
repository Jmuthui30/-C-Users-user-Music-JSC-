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
                    //Visible = "Type" = "Type"::Staff;
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
                    // Visible = VarDSA;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Air Ticket"; Rec."Air Ticket")
                {
                    // Visible = VarAirTicket;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Conference; Rec.Conference)
                {
                    // Visible = VarConference;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Ground Transport"; Rec."Ground Transport")
                {
                    // Visible = VarGroundTransport;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Cordination Allowance"; Rec."Cordination Allowance")
                {
                    // Visible = VarCordinationAllowance;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Facilitator Allowance"; Rec."Facilitator Allowance")
                {
                    // Visible = VarFacilitatorAllowance;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Secretariat Allowance"; Rec."Secretariat Allowance")
                {
                    // Visible = VarSecretariatAllowance;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Out of Pocket Allowance"; Rec."Out of Pocket Allowance")
                {
                    // Visible = VarOutofPocketAllowance;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Rapporteur Allowance"; Rec."Rapporteur Allowance")
                {
                    // Visible = VarRapporteurAllowance;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Driver Allowance"; Rec."Driver Allowance")
                {
                    // Visible = VarDriverAllowance;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Retreat Allowance"; Rec."Retreat Allowance")
                {
                    // Visible = VarRetreatAllowance;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Expert Allowance"; Rec."Expert Allowance")
                {
                    // Visible = VarExpertAllowance;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field(Accomodation; Rec.Accomodation)
                {
                    // Visible = VarAccomodation;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Tuition Fee"; Rec."Tuition Fee")
                {
                    // Visible = VarTuitionFee;
                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Mileage Allowance"; Rec."Mileage Allowance")
                {
                    Visible = VarMileageAllowance;
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
    trigger OnAfterGetCurrRecord()
    begin
        ImprestMemoHeader.Reset();
        if ImprestMemoHeader.Get(Rec."No.") then begin
            VarVisibility := TRUE;
            VarDSA := true;
            VarAirTicket := true;
            VarCordinationAllowance := true;
            VarFacilitatorAllowance := true;
            VarSecretariatAllowance := true;
            VarRapporteurAllowance := true;
            VarDriverAllowance := true;
            VarRetreatAllowance := true;
            VarExpertAllowance := true;
            VarOutofPocketAllowance := true;
            VarAccomodation := true;
            VarTuitionFee := true;
            VarConference := true;
            VarGroundTransport := true;
            VarMileageAllowance := true;

            IF ImprestMemoHeader.DSA = TRUE THEN BEGIN
                VarDSA := FALSE;
            END;
            IF ImprestMemoHeader."Air Ticket" = TRUE THEN BEGIN
                VarAirTicket := FALSE;
            END;
            IF ImprestMemoHeader."Cordination Allowance" = TRUE THEN BEGIN
                VarCordinationAllowance := FALSE;
            END;
            IF ImprestMemoHeader."Facilitator Allowance" = TRUE THEN BEGIN
                VarFacilitatorAllowance := FALSE;
            END;
            IF ImprestMemoHeader."Secretariat Allowance" = TRUE THEN BEGIN
                VarSecretariatAllowance := FALSE;
            END;
            IF ImprestMemoHeader."Rapporteur Allowance" = TRUE THEN BEGIN
                VarRapporteurAllowance := FALSE;
            END;
            IF ImprestMemoHeader."Driver Allowance" = TRUE THEN BEGIN
                VarDriverAllowance := FALSE;
            END;
            IF ImprestMemoHeader."Retreat Allowance" = TRUE THEN BEGIN
                VarRetreatAllowance := FALSE;
            END;
            IF ImprestMemoHeader."Expert Allowance" = TRUE THEN BEGIN
                VarExpertAllowance := FALSE;
            end;
            IF ImprestMemoHeader."Out of Pocket Allowance" = TRUE THEN BEGIN
                VarOutofPocketAllowance := FALSE;
            END;
            IF ImprestMemoHeader.Accomodation = TRUE THEN BEGIN
                VarAccomodation := FALSE;
            END;
            IF ImprestMemoHeader."Tuition Fee" = TRUE THEN BEGIN
                VarTuitionFee := FALSE;
            END;
            IF ImprestMemoHeader.Conference = TRUE THEN BEGIN
                VarConference := FALSE;
            END;
            IF ImprestMemoHeader."Ground Transport" = TRUE THEN BEGIN
                VarGroundTransport := FALSE;
            END;
            IF ImprestMemoHeader."Mileage Allowance" = TRUE THEN BEGIN
                VarMileageAllowance := FALSE;
            end;


        end;






        CurrPage.Update(false);
    end;

    var

        VarVisibility: Boolean;
        ImprestMemoHeader: Record "Imprest Memo Header";
        VarDSA: boolean;
        VarAirTicket: boolean;
        VarCordinationAllowance: boolean;
        VarFacilitatorAllowance: boolean;
        VarSecretariatAllowance: boolean;
        VarRapporteurAllowance: boolean;
        VarDriverAllowance: boolean;

        VarOutofPocketAllowance: boolean;
        VarRetreatAllowance: boolean;
        VarExpertAllowance: boolean;
        VarAccomodation: boolean;
        VarTuitionFee: boolean;
        VarConference: boolean;
        VarGroundTransport: boolean;
        VarMileageAllowance: boolean;



}
