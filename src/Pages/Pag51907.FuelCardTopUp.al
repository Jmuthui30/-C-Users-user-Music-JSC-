page 51907 "Fuel Card Top Up"
{
    // version THL- PRM 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Fuel Card Top Up";

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Card Details';

                field("Card No."; Rec."Card No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Card Name"; Rec."Card Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Top Up Details")
            {
                Caption = 'Top Up Details';

                field("Top Up Date"; Rec."Top Up Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Capture the date of top up here';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Capture the amount of toped up here';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Submit)
            {
                ApplicationArea = All;
                Image = ExecuteBatch;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Top Up Date");
                    if Rec.Amount = 0 then Error('Top up amount cannot be zero.');
                    OldEntries.Reset;
                    if OldEntries.FindLast then EntryNo:=OldEntries."Entry No." + 1
                    else
                        EntryNo:=1;
                    Entries.Init;
                    Entries."Entry No.":=EntryNo;
                    Entries."Card No":=Rec."Card No.";
                    Entries.Date:=Rec."Top Up Date";
                    Entries."Transaction Type":=Entries."Transaction Type"::"Top-up";
                    Entries.Amount:=Rec.Amount;
                    Entries.USERID:=UserId;
                    if Rec.Amount <> 0 then Entries.Insert;
                    Message('Records submitted.');
                    CurrPage.Close;
                end;
            }
        }
    }
    var Entries: Record "Fuel Card Entries";
    OldEntries: Record "Fuel Card Entries";
    EntryNo: Integer;
}
