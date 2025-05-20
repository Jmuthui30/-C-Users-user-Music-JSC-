pageextension 51802 "ExtItem Journal" extends "Item Journal"
{
    layout
    {
        // Add changes to page layout here
        modify("Document No.")
        {
            Importance = Standard;
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter("E&xplode BOM")
        {
            action("Import Bulk Items")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Import;

                trigger OnAction()
                begin
                    ItemTemp.get(Rec."Journal Template Name");
                    ItemBatch.Reset();
                    ItemBatch.SetRange("Journal Template Name", Rec."Journal Template Name");
                    ItemBatch.SetRange(Name, Rec."Journal Batch Name");
                    Clear(ItemImp);
                    ItemImp.GetHeader(ItemTemp);
                    ItemImp.run;
                end;
            }
            action("Clear Details")
            {
                ApplicationArea = All;
                Caption = 'Clear Details';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ClearLog;

                trigger OnAction()
                begin
                    ItemJournal.Reset();
                    ItemJournal.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    ItemJournal.DeleteAll;
                    Message('Details Cleared');
                end;
            }
        }
    }
    var myInt: Integer;
    ItemImp: XmlPort "Import Item Journal";
    ItemJournal: Record "Item Journal Line";
    ItemTemp: Record "Item Journal Template";
    ItemBatch: Record "Item Journal Batch";
}
