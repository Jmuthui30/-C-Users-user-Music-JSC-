page 52167 "EFT List"
{
    CardPageID = "EFT Payment Card";
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "EFT Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Select; Rec.Selected)
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Account';
                }
                field("Process Module"; Rec."Process Module")
                {
                    ApplicationArea = All;
                }
                field("No of Record Processed"; Rec."No of Record Processed")
                {
                    ApplicationArea = All;
                }
                field("No of Record Failed"; Rec."No of Record Failed")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("EFT Posted"; Rec."EFT Posted")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
    /*IF (Status=Status::"Processed by Bank") AND "EFT Posted"= FALSE THEN BEGIN
          EFTPaymentCard.AutoPost(Rec.No);
        END;
        */
    end;
    var EFTPaymentCard: Page "EFT Payment Card";
}
