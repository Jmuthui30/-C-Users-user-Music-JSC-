page 50020 "Document List"
{
    // version THL
    Caption = 'Document List';
    DelayedInsert = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    PopulateAllFields = true;
    PromotedActionCategories = 'New,Process,Report,Document,Attachment';
    SourceTable = Document;

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
                    Visible = true;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Document Type Code"; Rec."Document Type Code")
                {
                    ApplicationArea = All;
                }
                field("Template Code"; Rec."Template Code")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field("Document Currency"; Rec."Document Currency")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
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

                trigger OnAction()
                begin
                    Rec.OpenAttachmentWithLink;
                end;
            }
        }
    }
}
