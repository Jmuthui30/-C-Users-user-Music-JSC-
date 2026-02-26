page 58047 "Appointment List"
{
    CardPageID = "Commitee Creation";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Tender Commitee Appointment";

    layout
    {
        area(content)
        {
            repeater(Control10)
            {
                ShowCaption = false;

                field("Tender/Quotation No"; Rec."Tender/Quotation No")
                {
                    ApplicationArea = All;
                }
                field("Committee ID"; Rec."Committee ID")
                {
                    ApplicationArea = All;
                }
                field("Committee Name"; Rec."Committee Name")
                {
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field("Appointment No"; Rec."Appointment No")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
