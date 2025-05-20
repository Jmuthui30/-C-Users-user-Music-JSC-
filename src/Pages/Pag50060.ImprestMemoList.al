page 50060 "Imprest Memo List"
{
    ApplicationArea = All;
    Caption = 'Imprest Memo List';
    PageType = List;
    SourceTable = "Imprest Memo Header";
    UsageCategory = Lists;
    CardPageId = "Imprest Memo Header";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Date"; Rec."Date")
                {
                }
                field(From; Rec.From)
                {
                }
                field("To"; Rec."To")
                {
                }
                field(Subject; Rec.Subject)
                {
                }
                field("Sender Name"; Rec."Sender Name")
                {
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                }
                field("Activity Location"; Rec."Activity Location")
                {
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("Total Days in the Field"; Rec."Total Days in the Field")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(International; Rec.International)
                {
                }
                field(DSA; Rec.DSA)
                {
                }
                field("Air Ticket"; Rec."Air Ticket")
                {
                }
                field(Conference; Rec.Conference)
                {
                }
                field("Ground Transport"; Rec."Ground Transport")
                {
                }
                field(Accomodation; Rec.Accomodation)
                {
                }
                field("Cordination Allowance"; Rec."Cordination Allowance")
                {
                }
                field("Facilitator Allowance"; Rec."Facilitator Allowance")
                {
                }
                field("Secretariat Allowance"; Rec."Secretariat Allowance")
                {
                }
                field("Out of Pocket Allowance"; Rec."Out of Pocket Allowance")
                {
                }
                field("Rapporteur Allowance"; Rec."Rapporteur Allowance")
                {
                }
                field("Driver Allowance"; Rec."Driver Allowance")
                {
                }
                field("Retreat Allowance"; Rec."Retreat Allowance")
                {
                }
                field("Expert Allowance"; Rec."Expert Allowance")
                {
                }
                field("Tuition Fee"; Rec."Tuition Fee")
                {
                }
                field("Mileage Allowance"; Rec."Mileage Allowance")
                {
                }
                field("Quarter Per Diem"; Rec."Quarter Per Diem")
                {
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Budget Available"; Rec."Budget Available")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
    // if GeneralSettings.IsSelfService() then
    //     Rec.SetRange("Created By", UserId);
    end;
    var GeneralSettings: Codeunit GeneralSettings;
}
