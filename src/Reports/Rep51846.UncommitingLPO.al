report 51846 "Uncommiting LPO"
{
    ProcessingOnly = true;

    dataset
    {
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(General)
                {
                    field("PV No."; PVNo)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Vendor No."; VendorNo)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("Vendor Name."; VendorName)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                    field("LPO No."; LPO)
                    {
                        ApplicationArea = All;
                        NotBlank = true;
                        TableRelation = "Purchase Header"."No." WHERE(Committed=CONST(true), Uncommitted=CONST(false));

                        trigger OnLookup(var Text: Text): Boolean begin
                            PurchaseHeader.Reset;
                            PurchaseHeader.SetRange("Buy-from Vendor No.", VendorNo);
                            PurchaseHeader.SetRange(Committed, true);
                            PurchaseHeader.SetRange(Uncommitted, false);
                            PurchaseHeader.SetRange(Uncommitted, false);
                            if PAGE.RunModal(0, PurchaseHeader) = ACTION::LookupOK then begin
                                LPO:=PurchaseHeader."No.";
                                Amount:=0;
                                PurchaseLine.Reset;
                                PurchaseLine.SetRange("Document No.", LPO);
                                if PurchaseLine.FindSet then begin
                                    PurchaseLine.CalcSums("Amount Including VAT");
                                    Amount:=PurchaseLine."Amount Including VAT";
                                end;
                            end;
                        end;
                        trigger OnValidate()
                        begin
                            Amount:=0;
                            PurchaseLine.Reset;
                            PurchaseLine.SetRange("Document No.", LPO);
                            if PurchaseLine.FindSet then begin
                                PurchaseLine.CalcSums("Amount Including VAT");
                                Amount:=PurchaseLine."Amount Including VAT";
                            end;
                        end;
                    }
                    field("Amount To Uncommit."; Amount)
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        if LPO = '' then Error('LPO Must Not Be Empty');
        Commitments."Process UnCommitment Entry"(PVNo, 'MYLPO', LPO);
    end;
    var LPO: Code[20];
    PVNo: Code[20];
    VendorNo: Code[20];
    VendorName: Text[50];
    PVHeader: Record "PV Header";
    PVLines: Record "PV Lines";
    PurchaseHeader: Record "Purchase Header";
    Commitments: Codeunit Commitments;
    Amount: Decimal;
    PurchaseLine: Record "Purchase Line";
    procedure "Get InvoiceNo"(PVHeader: Record "PV Header")
    begin
        PVNo:=PVHeader."No.";
        PVLines.Reset;
        PVLines.SetRange(No, PVHeader."No.");
        PVLines.SetRange(Uncommitted, false);
        if PVLines.FindFirst then begin
            VendorNo:=PVLines."Account No";
            VendorName:=PVLines."Account Name";
        end;
    end;
}
