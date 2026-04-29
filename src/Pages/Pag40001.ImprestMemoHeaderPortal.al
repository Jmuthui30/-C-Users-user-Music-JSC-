page 40001 ImprestMemoHeaderPortal
{
    ApplicationArea = All;
    Caption = 'ImprestMemoHeaderPortal';
    PageType = List;
    SourceTable = "Imprest Memo Header";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Date"; Rec.Date) { ApplicationArea = All; }
                field("From"; Rec."From") { ApplicationArea = All; }
                field(To; Rec."To") { ApplicationArea = All; }
                field("Subject"; Rec.Subject) { ApplicationArea = All; }
                field("Message body"; Rec."Message body") { ApplicationArea = All; }
                field("Message body 1"; Rec."Message body 1") { ApplicationArea = All; }

                field("Employee No."; Rec."Employee No.") { ApplicationArea = All; }
                field("Purpose"; Rec.Purpose) { ApplicationArea = All; }
                field("Activity Location"; Rec."Activity Location") { ApplicationArea = All; }
                field("Created By"; Rec."Created By") { ApplicationArea = All; }

                field("Departure Location"; Rec."Departure Location") { ApplicationArea = All; }
                field("Return Location"; Rec."Return Location") { ApplicationArea = All; }

                field("Departure Date"; Rec."Departure Date") { ApplicationArea = All; }
                field("Start Date"; Rec."Start Date") { ApplicationArea = All; }
                field("Return Date"; Rec."Return Date") { ApplicationArea = All; }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the End Date field.', Comment = '%';
                }

                field("Total Days in the Field"; Rec."Total Days in the Field") { ApplicationArea = All; }

                field("International"; Rec.International) { ApplicationArea = All; }
                field("DSA"; Rec.DSA) { ApplicationArea = All; }

                field("Cordination Allowance"; Rec."Cordination Allowance") { ApplicationArea = All; }
                field("Facilitator Allowance"; Rec."Facilitator Allowance") { ApplicationArea = All; }
                field("Secretariat Allowance"; Rec."Secretariat Allowance") { ApplicationArea = All; }
                field("Rapporteur Allowance"; Rec."Rapporteur Allowance") { ApplicationArea = All; }
                field("Driver Allowance"; Rec."Driver Allowance") { ApplicationArea = All; }
                field("Retreat Allowance"; Rec."Retreat Allowance") { ApplicationArea = All; }
                field("Expert Allowance"; Rec."Expert Allowance") { ApplicationArea = All; }

                field("Air Ticket"; Rec."Air Ticket") { ApplicationArea = All; }
                field("Conference"; Rec.Conference) { ApplicationArea = All; }
                field("Ground Transport"; Rec."Ground Transport") { ApplicationArea = All; }
                field("Accomodation"; Rec.Accomodation) { ApplicationArea = All; }
                field("Out of Pocket Allowance"; Rec."Out of Pocket Allowance") { ApplicationArea = All; }

                field("Tuition Fee"; Rec."Tuition Fee") { ApplicationArea = All; }
                field("Mileage Allowance"; Rec."Mileage Allowance") { ApplicationArea = All; }
                field("Quarter Per Diem"; Rec."Quarter Per Diem") { ApplicationArea = All; }

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code") { ApplicationArea = All; }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code") { ApplicationArea = All; }

                field("Status"; Rec.Status) { ApplicationArea = All; }
            }
        }
    }
}
