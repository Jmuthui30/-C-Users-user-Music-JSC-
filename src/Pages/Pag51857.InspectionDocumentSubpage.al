page 51857 "Inspection Document Subpage"
{
    // version THL- HRM 1.0
    Caption = 'Documents';
    DelayedInsert = true;
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

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Prepared; Rec.Prepared)
                {
                    ApplicationArea = All;
                    Caption = 'Prepared';
                }
                field("Prepared mark By"; Rec."Prepared mark By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Prepared mark DateTime"; Rec."Prepared mark DateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Signed; Rec.Signed)
                {
                    ApplicationArea = All;
                    Caption = 'Signed';
                }
                field("Signed mark By"; Rec."Signed mark By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Signed mark DateTime"; Rec."Signed mark DateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Checked; Rec.Checked)
                {
                    ApplicationArea = All;
                    Caption = 'Checked';
                }
                field("Checked mark By"; Rec."Checked mark By")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Checked mark DateTime"; Rec."Checked mark DateTime")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Attachment No."; Rec."Attachment No.")
                {
                    ApplicationArea = All;
                }
                field("Cross-ref to Document"; Rec."Cross-ref to Document")
                {
                    ApplicationArea = All;
                    Visible = false;
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
                Image = Open;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                ShortCutKey = 'F9';

                trigger OnAction()
                begin
                    Rec.OpenAttachment;
                end;
            }
            action("Open by Ref.")
            {
                ApplicationArea = All;
                Caption = 'Open by Ref.';
                Image = ReopenPeriod;
                Promoted = true;
                PromotedCategory = Category5;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.OpenAttachmentWithLink;
                end;
            }
            action(Import)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                Promoted = true;
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                //Rec.ImportAttachment;
                end;
            }
            action(Export)
            {
                ApplicationArea = All;
                Caption = 'Export';
                Image = Export;
                Promoted = true;
                PromotedCategory = Category5;

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
                PromotedCategory = Category5;

                trigger OnAction()
                begin
                    Rec.RemoveAttachment(false);
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Table ID":=DATABASE::"Employee Master";
    end;
    var ContractVersionNo: Integer;
    procedure SetContractVersionNo(VersionNo: Integer)
    begin
        ContractVersionNo:=VersionNo;
    end;
}
