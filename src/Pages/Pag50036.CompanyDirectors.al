page 50036 "Company Directors"
{
    ApplicationArea = All;
    Caption = 'Company Directors';
    PageType = ListPart;
    SourceTable = "Company Director";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("KRA PIN"; Rec."KRA PIN")
                {
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = All;
                }
                field("Nationality Code"; Rec."Nationality Code")
                {
                    ApplicationArea = All;
                }
                field("Nationality Name"; Rec."Nationality Name")
                {
                    ApplicationArea = All;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                }
                field("Share Percentage"; Rec."Share Percentage")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
