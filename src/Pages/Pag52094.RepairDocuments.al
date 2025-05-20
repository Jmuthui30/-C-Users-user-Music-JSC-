page 52094 "Repair Documents"
{
    //Ibrahim Wasiu
    Caption = 'Documents';
    DelayedInsert = true;
    DeleteAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
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
                    Editable = false;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Import)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                //Rec.ImportAttachment;
                end;
            }
            action(Open)
            {
                ApplicationArea = All;
                Caption = 'Open';
                Image = Export;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //ExportAttachment;
                    Rec.OpenAttachment();
                end;
            }
            action(Remove)
            {
                ApplicationArea = All;
                Caption = 'Remove';
                Image = Delete;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.RemoveAttachment(false);
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Table ID":=DATABASE::"Repair Header";
    end;
    var ContractVersionNo: Integer;
    procedure SetContractVersionNo(VersionNo: Integer)
    begin
        ContractVersionNo:=VersionNo;
    end;
}
