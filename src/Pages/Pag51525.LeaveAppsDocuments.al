page 51525 "Leave Apps Documents"
{
    // version THL- HRM 1.0
    Caption = 'Documents';
    DeleteAllowed = false;
    PageType = ListPart;
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
                PromotedCategory = Process;

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
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.ExportAttachment;
                end;
            }
            action(Remove)
            {
                ApplicationArea = All;
                Caption = 'Remove';
                Image = Delete;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.RemoveAttachment(false);
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Table ID":=DATABASE::"Employee Leave Application";
    end;
    var ContractVersionNo: Integer;
    /// <summary>
    /// SetContractVersionNo.
    /// </summary>
    /// <param name="VersionNo">Integer.</param>
    procedure SetContractVersionNo(VersionNo: Integer)
    begin
        ContractVersionNo:=VersionNo;
    end;
}
