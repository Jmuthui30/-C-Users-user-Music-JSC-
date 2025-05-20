page 50067 "Imprest Payroll Claims List"
{
    ApplicationArea = All;
    Caption = 'Imprest Payroll Claims List';
    PageType = List;
    SourceTable = "Imprest Payroll Claims Header";
    UsageCategory = Lists;
    CardPageId = "Imprest Payroll Claim Header";

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
                field(Subject; Rec.Subject)
                {
                }
                field("Activity Location"; Rec."Activity Location")
                {
                }
                field("Departure Location"; Rec."Departure Location")
                {
                }
                field("Departure Date"; Rec."Departure Date")
                {
                }
                field("Return Location"; Rec."Return Location")
                {
                }
                field("Return Date"; Rec."Return Date")
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
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
}
