pageextension 51438 "ExtVendor Card" extends "Vendor Card"
{
    layout
    {
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }
        modify(GLN)
        {
            Visible = false;
        }
        modify("Cash Flow Payment Terms Code")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify(Receiving)
        {
            Visible = false;
        }
        addafter("Responsibility Center")
        {
            field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter("No.")
        {
            field("Vendor App. No."; Rec."Vendor Application No.")
            {
                ApplicationArea = All;
                Editable = false;
            //Lookup = "Vendor No" = FIELD("No.");        
            }
        }
        //Ibrahim Wasiu
        addafter(Receiving)
        {
            group("Vendor Evaluation Details")
            {
                field(Competency; Rec.Competency)
                {
                    ApplicationArea = All;
                }
                field(Capacity; Rec.Capacity)
                {
                    ApplicationArea = All;
                }
                field(Commitment; Rec.Commitment)
                {
                    ApplicationArea = All;
                }
                field(Control; Rec.Control)
                {
                    ApplicationArea = All;
                }
                field("Cash Resources"; Rec."Cash Resources")
                {
                    ApplicationArea = All;
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;
                }
                field(Consistency; Rec.Consistency)
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Vendor Evaluation Details")
        {
            part("Supplier Catalogue"; "Supplier Catalogue")
            {
                ApplicationArea = All;
                SubPageLink = "Supplier ID"=field("No.");
            }
        }
        addafter(Blocked)
        {
            field("Blocked Reason"; Rec."Blocked Reason")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter(SendToIncomingDocuments)
        {
            action("Company Information")
            {
                ApplicationArea = All;
                Image = Info;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = Page "Vendor Reg Request";
                RunPageLink = "Vendor No"=FIELD("No.");
            }
        }
        addafter(ApplyTemplate)
        {
            action("View SharePoint Documents")
            {
                ApplicationArea = All;
                PromotedCategory = New;
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."SharePoint Link" = '' then Error('There is no link to documents uploaded in SharePoint. Please contact the SharePoint Administrator.')
                    else
                        HyperLink(Rec."SharePoint Link");
                end;
            }
        }
        //Ibrahim Wasiu
        addafter("View SharePoint Documents")
        {
            action("Import Supplier Catalogue")
            {
                ApplicationArea = All;
                Caption = 'Supplier Catalogue';
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                Image = Import;

                trigger OnAction()
                begin
                    clear(SupplierCatImp);
                    SupplierCatImp.GetHeader(Rec);
                    SupplierCatImp.Run;
                end;
            }
            action("Clear Details")
            {
                ApplicationArea = All;
                Caption = 'Clear Details';
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                Image = ClearLog;

                trigger OnAction()
                begin
                    SupplierCatRec.Reset();
                    SupplierCatRec.SetRange("Supplier ID", Rec."No.");
                    SupplierCatRec.DeleteAll;
                    Message('Details Cleared');
                end;
            }
        }
        modify(SendApprovalRequest)
        {
            trigger OnBeforeAction()
            begin
                if(Rec.Blocked = Rec.Blocked::Payment) or (Rec.Blocked = Rec.Blocked::All)then Rec.TestField("Blocked Reason");
            end;
        }
        addafter("Bank Accounts")
        {
            action("Update Approval Entry")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    ApprovalEntry: Record "Approval Entry";
                    Employee: Record Employee;
                    CLientEMpMaster: Record "Client Employee Master";
                begin
                    ApprovalEntry.Reset();
                    ApprovalEntry.SetFilter("Document No.", '%1|%2', 'LV-0000073', 'LV-0000074');
                    ApprovalEntry.SetFilter("Sequence No.", '%1', 2);
                    if ApprovalEntry.findset then begin
                        ApprovalEntry.Status:=ApprovalEntry.Status::Open;
                        ApprovalEntry.Modify();
                        Commit();
                    end;
                end;
            }
        }
    }
    var SupplierCatImp: XmlPort "Import Supplier Catalogue";
    SupplierCatRec: Record "Supplier Catalogue";
    VendCOD: Codeunit "Vendor Onboarding Mgnt";
    LeaveBalance: Record Employee;
    Registration: Record "Vendor Reg. Request";
}
