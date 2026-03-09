page 51125 AllPaymentsPage
{
    ApplicationArea = All;
    Caption = 'All Payments';
    PageType = List;
    SourceTable = Payments;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }

                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }

                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                }

                field("Cheque No"; Rec."Cheque No")
                {
                    ApplicationArea = All;
                }

                field("Cheque Date"; Rec."Cheque Date")
                {
                    ApplicationArea = All;
                }

                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }

                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                }

                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }

                field("Payment Type"; Rec."Payment Type")
                {
                    ApplicationArea = All;
                }

                field("Petty Cash Amount"; Rec."Petty Cash Amount")
                {
                    ApplicationArea = All;
                }

                field("Payment Narration"; Rec."Payment Narration")
                {
                    ApplicationArea = All;
                }

                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }

                field("Petty Cash Amount (LCY)"; Rec."Petty Cash Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ToolTip = 'Specifies the value of the Staff No. field';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                }
                field("Date of Project"; Rec."Date of Project")
                {
                    ToolTip = 'Specifies the value of the Date of Project field';
                }
                field("Date of Completion"; Rec."Date of Completion")
                {
                    ToolTip = 'Specifies the value of the Date of Completion field';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field';
                }
                field(Destination; Rec.Destination)
                {
                    ToolTip = 'Specifies the value of the Destination field';
                }
            }
        }
    }
}