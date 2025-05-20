page 52135 "Cash & Claim Document Subpage"
{
    // version THL- HRM 1.0
    Caption = 'Attached Documents';
    DelayedInsert = true;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    PopulateAllFields = true;
    PromotedActionCategories = 'New,Process,Report,Document,Attachment';
    SourceTable = Document;
    SourceTableView = SORTING("Document No.");

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Attachment No."; Rec."Attachment No.")
                {
                    ApplicationArea = All;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Open)
            {
                ApplicationArea = All;
                Caption = 'Open';
                Image = Export;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                    //ExportAttachment;
                    Rec.OpenAttachment();
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Table ID":=DATABASE::"Imprest Header";
    end;
    var ContractVersionNo: Integer;
    procedure SetContractVersionNo(VersionNo: Integer)
    begin
        ContractVersionNo:=VersionNo;
    end;
}
